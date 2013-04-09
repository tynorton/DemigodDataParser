namespace Demigod
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Web;
    using System.Xml;
    using System.Xml.XPath;

    /// <summary>
    /// Summary description for CharacterStatsManager
    /// </summary>
    public class CharacterStatsManager
    {
        private CharacterStatsManager() { }

        public CharacterStats GetBaseStats(string characterBlueprintKey)
        {
            CharacterStats stats = new CharacterStats(characterBlueprintKey);
            stats.Load();

            return stats;
        }

        public CharacterStats GetLevelUpBuffs(int level, string characterBlueprintKey, string levelUpKey)
        {
            string cacheKey = this.GetLevelUpBuffStatsCacheKey(characterBlueprintKey, level);
            string docCacheKey = this.GetLevelUpBuffDocCacheKey(characterBlueprintKey, level);
            string baseDirPath = HttpContext.Current.Server.MapPath(HEROES_DATA_DIR);
            string levelUpBuffsFilePath = Path.Combine(baseDirPath, LEVEL_UP_BLUEPRINT);

            // Check to see if we have a cached version
            CharacterStats stats = HttpContext.Current.Cache.Get(cacheKey) as CharacterStats;
            if (null == stats)
            {
                stats = this.GetBaseStats(characterBlueprintKey);
            }
            else
            {
                return stats;
            }

            // If we don't have a specific stats level cached, check to see if we've cached the doc before
            XPathDocument doc = HttpContext.Current.Cache.Get(docCacheKey) as XPathDocument;
            if (null == doc)
            {
                doc = new XPathDocument(levelUpBuffsFilePath);
            }

            // Cache miss, walk the doc tree and load up the stats collection
            if (null != doc)
            {
                HttpContext.Current.Cache.Insert(docCacheKey, doc, new System.Web.Caching.CacheDependency(levelUpBuffsFilePath));
                XPathNavigator nav = doc.CreateNavigator();

                XPathNodeIterator affectsIt = nav.Select("DemigodBlueprints/BuffBlueprints/BuffBlueprint[Name='" + levelUpKey + "']/Affects/*");
                while (affectsIt.MoveNext())
                {
                    string buffName = affectsIt.Current.Name;

                    if (stats.Buffs.ContainsKey(buffName))
                    {
                        string buffValue = affectsIt.Current.SelectSingleNode("Add").Value;
                        stats.AddBuff(buffName, buffValue, level);
                    }
                }
            }

            HttpContext.Current.Cache.Insert(cacheKey, stats, new System.Web.Caching.CacheDependency(levelUpBuffsFilePath));
            return stats;
        }

        private string GetLevelUpBuffStatsCacheKey(string characterKey, int level)
        {
            return string.Format("ObjCache-{0}-{1}", characterKey, level.ToString());
        }

        private string GetLevelUpBuffDocCacheKey(string characterKey, int level)
        {
            return string.Format("XmlDocCache-{0}-{1}", characterKey, level.ToString());
        }

        private Dictionary<string, XPathDocument> LoadCharacterBlueprintDictionary()
        {
            Dictionary<string, XPathDocument> characterBlueprintDictionary = new Dictionary<string, XPathDocument>();

            string baseDirPath = HttpContext.Current.Server.MapPath(HEROES_DATA_DIR);
            string[] heroDirs = Directory.GetDirectories(baseDirPath);
            foreach (string dir in heroDirs)
            {
                string[] dirParts = dir.Split(new string[] { baseDirPath }, StringSplitOptions.RemoveEmptyEntries);
                string heroKey = dirParts[dirParts.Length - 1];
                string[] files = Directory.GetFiles(dir);

                foreach (string f in files)
                {
                    // _uni.xml contains the hero stats
                    if (f.EndsWith("uni.xml", StringComparison.OrdinalIgnoreCase))
                    {
                        string cacheKey = this.GetXPathDocCacheKey(f);
                        XPathDocument doc = HttpContext.Current.Cache.Get(cacheKey) as XPathDocument;
                        if (null == doc)
                        {
                            doc = new XPathDocument(f);
                            if (null != doc)
                            {
                                HttpContext.Current.Cache.Insert(cacheKey, doc, new System.Web.Caching.CacheDependency(f));
                            }
                        }

                        characterBlueprintDictionary.Add(heroKey, doc);
                    }
                }
            }

            return characterBlueprintDictionary;
        }

        private string GetXPathDocCacheKey(string path)
        {
            return HERO_BLUEPRINT_XML_CACHE_KEY + ":" + path;
        }

        /// <summary>
        /// The only instance that should be used when accessing this class
        /// </summary>
        public static CharacterStatsManager CurrentInstance
        {
            get
            {
                return Singleton<CharacterStatsManager>.Instance;
            }
        }

        public Dictionary<string, XPathDocument> CharacterBlueprintDictionary
        {
            get
            {
                if (null == this.m_characterBlueprintDictionary)
                {
                    this.m_characterBlueprintDictionary = this.LoadCharacterBlueprintDictionary();
                }

                return this.m_characterBlueprintDictionary;
            }
        }

        private const string HEROES_DATA_DIR = "~/App_Data/Heroes/";
        private const string LEVEL_UP_BLUEPRINT = "BuffDefBaseStats.xml";
        private const string HERO_BLUEPRINT_XML_CACHE_KEY = "obj:heroBpXml";

        private Dictionary<string, XPathDocument> m_characterBlueprintDictionary;
    }
}