namespace Demigod
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Runtime.Serialization;
    using System.Web;
    using System.Xml;
    using System.Xml.XPath;
    using System.Reflection;

    /// <summary>
    /// Summary description for CharacterStats
    /// </summary>
    [DataContractAttribute]
    public class CharacterStats
    {
        internal CharacterStats(string characterBlueprintKey)
        {
            this.m_characterBlueprintKey = characterBlueprintKey;
        }

        public void Load()
        {
            this.m_buffs = null;
            this.m_level = BASE_LEVEL;

            XPathDocument doc = CharacterStatsManager.CurrentInstance.CharacterBlueprintDictionary[this.m_characterBlueprintKey];
            XPathNavigator nav = doc.CreateNavigator();

            XPathNodeIterator statsIt = nav.Select("//UnitBlueprint/Stats/*");
            while (statsIt.MoveNext())
            {
                string name = statsIt.Current.Name;
                string value = statsIt.Current.InnerXml;

                this.AddBuff(name, value);
            }
        }

        public void AddBuff(string key, string value, int level)
        {
            if (this.Buffs.ContainsKey(key))
            {
                this.Buffs[key].ParseAndTryToAdd(value, level);
            }
            else
            {
                this.Buffs.Add(key, new BuffValue(value));
            }
        }

        public void AddBuff(string key, string value)
        {
            this.AddBuff(key, value, BASE_LEVEL);
        }

        [DataMemberAttribute]
        public Dictionary<string, BuffValue> Buffs
        {
            get
            {
                if (null == this.m_buffs)
                {
                    this.m_buffs = new Dictionary<string, BuffValue>();
                }

                return this.m_buffs;
            }
        }

        [DataMemberAttribute]
        public int Level
        {
            get
            {
                return this.m_level;
            }

            set
            {
                this.m_level = Level;
            }
        }

        private string m_characterBlueprintKey;
        private int m_level;
        private Dictionary<string, BuffValue> m_buffs;

        private const int BASE_LEVEL = 1;
    }
}