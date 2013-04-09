namespace Demigod
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using System.Web;
    using System.Web.Caching;
    using System.Xml;
    using System.Xml.XPath;

    /// <summary>
    /// Single point of reference for data configured in ItemMappings.xml
    /// </summary>
    public class ItemMappingManager
    {
        private ItemMappingManager() { }

        private void EnsureGroupMappingsDocLoaded()
        {
            this.m_itemGroupMappingsDoc = this.TryLoadDocumentFromCache(ITEM_MAPPING_CONFIG_PATH);
        }

        private XPathDocument TryLoadDocumentFromCache(string virtualPath)
        {
            string cacheKey = this.GetXPathCacheKey(virtualPath);
            XPathDocument doc = null;

            if (USE_MEMORY_CACHING)
            {
                doc = HttpContext.Current.Cache.Get(cacheKey) as XPathDocument;
            }

            if (null == doc)
            {
                string physicalPath = HttpContext.Current.Server.MapPath(virtualPath);
                if (!File.Exists(physicalPath))
                {
                    throw new Exception(string.Format("Couldn't file file: '{0}'", physicalPath));
                }

                doc = new XPathDocument(physicalPath);
                HttpContext.Current.Cache.Insert(cacheKey, doc, new CacheDependency(physicalPath));
            }

            return doc;
        }

        private string GetXPathCacheKey(string xmlFilePath)
        {
            return "XPathCache:" + xmlFilePath;
        }

        public Shop FindShop(string shopName)
        {
            return this.Shops.Find(delegate(Shop shop) { return shop.Name.Equals(shopName, StringComparison.OrdinalIgnoreCase); });
        }

        public EquipmentItem FindItemByID(string itemId)
        {
            foreach (EquipmentItemGroup ig in ItemMappingManager.CurrentInstance.ItemGroups)
            {
                EquipmentItem existingItem = ig.Items.Find(delegate(EquipmentItem ei) { return ei.ID.Equals(itemId); });

                if (null != existingItem)
                {
                    return existingItem;
                }
            }

            return null;
        }

        public EquipmentItem FindItemByName(string itemName)
        {
            foreach (EquipmentItemGroup ig in ItemMappingManager.CurrentInstance.ItemGroups)
            {
                EquipmentItem existingItem = ig.Items.Find(delegate(EquipmentItem ei) { return ei.DisplayName.Equals(itemName); });

                if (null != existingItem)
                {
                    return existingItem;
                }
            }

            return null;
        }

        public EquipmentItemGroup FindItemGroup(string groupName)
        {
            return this.ItemGroups.Find(delegate(EquipmentItemGroup group) { return group.Name.Equals(groupName, StringComparison.OrdinalIgnoreCase); });
        }

        public Character FindCharacter(string characterName)
        {
            return this.Characters.Find(delegate(Character character) { return character.Name.Equals(characterName, StringComparison.OrdinalIgnoreCase); });
        }

        public CharacterClass FindCharacterClass(string className)
        {
            return this.CharacterClasses.Find(delegate(CharacterClass charClass) { return charClass.ClassName.Equals(className, StringComparison.OrdinalIgnoreCase); });
        }

        private List<Character> LoadCharacters()
        {
            List<Character> characters = new List<Character>();

            XPathNodeIterator characterNodes = this.GroupMappingsDoc.CreateNavigator().Select("/ItemMappingsConfig/Characters/CharacterMappings/CharacterMapping");
            while (characterNodes.MoveNext())
            {
                string characterName = characterNodes.Current.GetAttribute("name", string.Empty);
                string className = characterNodes.Current.GetAttribute("class", string.Empty);
                string key = characterNodes.Current.GetAttribute("key", string.Empty);
                string levelupkey = characterNodes.Current.GetAttribute("levelupkey", string.Empty);

                Character character = new Character(characterName, key, levelupkey, className);
                character.Load();
                characters.Add(character);
            }

            return characters;
        }

        private List<CharacterClass> LoadCharacterClasses()
        {
            List<CharacterClass> characterClasses = new List<CharacterClass>();

            XPathNodeIterator xpathNodeIt = this.GroupMappingsDoc.CreateNavigator().Select("/ItemMappingsConfig/Characters/ClassDefinitions/CharacterClass");
            while (xpathNodeIt.MoveNext())
            {
                string className = xpathNodeIt.Current.GetAttribute("name", string.Empty);
                string inheritClass = xpathNodeIt.Current.GetAttribute("inherit", string.Empty);

                XPathNodeIterator itemGroups = xpathNodeIt.Current.Select("ItemGroupNames/ItemGroupName");

                List<string> groupNames = new List<string>();
                while (itemGroups.MoveNext())
                {
                    string groupName = itemGroups.Current.InnerXml;
                    groupNames.Add(groupName);
                }

                CharacterClass charClass = new CharacterClass(className, inheritClass, groupNames);
                characterClasses.Add(charClass);
            }

            return characterClasses;
        }

        private List<Shop> LoadShops()
        {
            List<Shop> shops = null;

            if (USE_MEMORY_CACHING)
            {
                shops = HttpContext.Current.Cache.Get(ITEM_GROUPS_CACHE_KEY) as List<Shop>;
            }

            if (null == shops)
            {
                shops = new List<Shop>();

                XPathNodeIterator itemGroupNodes = this.GroupMappingsDoc.CreateNavigator().Select("/ItemMappingsConfig/ShopMappings/ShopMapping");
                while (itemGroupNodes.MoveNext())
                {
                    string name = itemGroupNodes.Current.GetAttribute("name", string.Empty);
                    string virtualPath = itemGroupNodes.Current.GetAttribute("virtualPath", string.Empty);
                    string physicalPath = HttpContext.Current.Server.MapPath(virtualPath);
                    XPathDocument doc = new XPathDocument(physicalPath);
                    XPathNodeIterator itemIt = doc.CreateNavigator().Select("//Tree/*");

                    Shop shop = new Shop(name);
                    while (itemIt.MoveNext())
                    {
                        string costString = itemIt.Current.SelectSingleNode("Cost").InnerXml;
                        int cost = int.Parse(costString);
                        shop.AddItem(itemIt.Current.Name, cost);
                    }

                    shops.Add(shop);
                }
            }

            return shops;
        }

        private List<EquipmentItemGroup> LoadItemGroups()
        {
            List<EquipmentItemGroup> itemGroups = null;

            if (USE_MEMORY_CACHING)
            {
                itemGroups = HttpContext.Current.Cache.Get(ITEM_GROUPS_CACHE_KEY) as List<EquipmentItemGroup>;
            }

            if (null == itemGroups)
            {
                itemGroups = new List<EquipmentItemGroup>();

                XPathNodeIterator itemGroupNodes = this.GroupMappingsDoc.CreateNavigator().Select("/ItemMappingsConfig/ItemGroups/ItemGroup");
                while (itemGroupNodes.MoveNext())
                {
                    string name = itemGroupNodes.Current.GetAttribute("name", string.Empty);
                    string inherit = itemGroupNodes.Current.GetAttribute("inherit", string.Empty);

                    List<string> dataFiles = new List<string>();
                    XPathNodeIterator virtualPaths = itemGroupNodes.Current.Select("VirtualPaths/VirtualPath");
                    while (virtualPaths.MoveNext())
                    {
                        string virtualPath = virtualPaths.Current.InnerXml;
                        string physicalPath = HttpContext.Current.Server.MapPath(virtualPath);
                        dataFiles.Add(physicalPath);
                    }

                    List<string> excludedItems = new List<string>();
                    XPathNodeIterator excludeItems = itemGroupNodes.Current.Select("ExcludeItems/ExcludeItem");
                    while (excludeItems.MoveNext())
                    {
                        string itemName = excludeItems.Current.InnerXml;
                        excludedItems.Add(itemName);
                    }

                    List<string> includedShops = new List<string>();
                    XPathNodeIterator includedShopsIt = itemGroupNodes.Current.Select("//IncludedShops/Shop");
                    while (includedShopsIt.MoveNext())
                    {
                        string shopName = includedShopsIt.Current.GetAttribute("name", "");
                        includedShops.Add(shopName);
                    }

                    List<string> tags = new List<string>();
                    XPathNodeIterator tagNodes = itemGroupNodes.Current.Select("Tags/Tag");
                    while (tagNodes.MoveNext())
                    {
                        string tag = tagNodes.Current.InnerXml;
                        tags.Add(tag);
                    }

                    EquipmentItemGroup itemGroup = new EquipmentItemGroup(name, inherit, dataFiles, excludedItems, includedShops, tags);
                    itemGroups.Add(itemGroup);
                }

                string mappingFilePath = HttpContext.Current.Server.MapPath(ITEM_MAPPING_CONFIG_PATH);
                HttpContext.Current.Cache.Insert(ITEM_GROUPS_CACHE_KEY, itemGroups, new CacheDependency(mappingFilePath));
            }

            return itemGroups;
        }

        /// <summary>
        /// Checks to see if the object is null, or the mappings file has changed
        /// </summary>
        /// <typeparam name="T">Type inside the collection</typeparam>
        /// <param name="obj">Collection</param>
        /// <returns></returns>
        private bool ShouldReloadData<T>(IEnumerable<T> obj)
        {
            // Make sure if the mappings file changes we invalidate all cached objects
            string cacheKey = "ReloadData::" + typeof(T).ToString();
            object typeCache = HttpContext.Current.Cache.Get(cacheKey);

            bool dataIsNull = (null == obj || obj.Count() == 0 || null == typeCache);
            bool reloadData = (dataIsNull) ? true : false;
            reloadData = (!USE_MEMORY_CACHING || reloadData) ? true : false;

            string phsyicalMappingsPath = HttpContext.Current.Server.MapPath(ITEM_MAPPING_CONFIG_PATH);
            HttpContext.Current.Cache.Insert(cacheKey, new object(), new CacheDependency(phsyicalMappingsPath));
            return reloadData;
        }

        /// <summary>
        /// The only instance that should be used when accessing this class
        /// </summary>
        public static ItemMappingManager CurrentInstance
        {
            get
            {
                return Singleton<ItemMappingManager>.Instance;
            }
        }

        public XPathDocument GroupMappingsDoc
        {
            get
            {
                this.EnsureGroupMappingsDocLoaded();
                return this.m_itemGroupMappingsDoc;
            }
        }

        public List<EquipmentItemGroup> ItemGroups
        {
            get
            {
                if (this.ShouldReloadData<EquipmentItemGroup>(this.m_itemGroups))
                {
                    this.m_itemGroups = this.LoadItemGroups();
                }

                return this.m_itemGroups;
            }
        }

        public List<Character> Characters
        {
            get
            {
                if (this.ShouldReloadData<Character>(this.m_characters))
                {
                    this.m_characters = this.LoadCharacters();
                }

                return this.m_characters;
            }
        }

        public List<CharacterClass> CharacterClasses
        {
            get
            {
                if (this.ShouldReloadData<CharacterClass>(this.m_characterClasses))
                {
                    this.m_characterClasses = this.LoadCharacterClasses();
                }

                return this.m_characterClasses;
            }
        }

        public List<Shop> Shops
        {
            get
            {
                if (this.ShouldReloadData<Shop>(this.m_shops))
                {
                    this.m_shops = this.LoadShops();
                }

                return this.m_shops;
            }
        }

        private const string ITEM_MAPPING_CONFIG_PATH = "~/App_Data/config/ItemMappings.xml";
        private const string ITEM_GROUPS_CACHE_KEY = "obj:itemGroups";
        private const bool USE_MEMORY_CACHING = true;

        private XPathDocument m_itemGroupMappingsDoc;
        private List<EquipmentItemGroup> m_itemGroups;
        private List<Character> m_characters;
        private List<CharacterClass> m_characterClasses;
        private List<Shop> m_shops;
    }
}