using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml;
using System.Xml.XPath;
using System.Runtime.Serialization;
using Demigod;

namespace Demigod
{
    /// <summary>
    /// Summary description for ItemGroup
    /// </summary>
    [DataContractAttribute]
    public class EquipmentItemGroup
    {
        internal EquipmentItemGroup(string groupName, string inheritGroupName, List<string> dataFilePaths, List<string> excludeItems, List<string> includedShopNames, List<string> tags)
        {
            this.Name = groupName;
            this.InheritedGroupName = inheritGroupName;
            this.m_localDataPaths = dataFilePaths;
            this.m_excludeItems = excludeItems;
            this.m_includedShopNames = includedShopNames;
            this.m_tags = tags;
        }

        private void ProcessItemBlueprints()
        {
            this.m_equipmentItems = new List<EquipmentItem>();
            foreach (string filePath in this.DataFilePaths)
            {
                XPathDocument xpathDoc = new XPathDocument(filePath);
                XPathNavigator nav = xpathDoc.CreateNavigator();
                XPathNodeIterator xpathNodeIt = nav.Select("/DemigodBlueprints/ItemBlueprints/*");
                while (xpathNodeIt.MoveNext())
                {
                    string itemName = xpathNodeIt.Current.SelectSingleNode("DisplayName").InnerXml;

                    if (!this.m_excludeItems.Contains(itemName))
                    {
                        EquipmentItem equipmentItem = new EquipmentItem(xpathNodeIt.Current, nav);
                        equipmentItem.ProcessItemBlueprint();

                        if (this.Tags.Contains("Favor"))
                        {
                            equipmentItem.ItemType = EquipmentItemType.Favor;
                        }

                        foreach (string shopName in this.m_includedShopNames)
                        {
                            Shop shop = ItemMappingManager.CurrentInstance.FindShop(shopName);
                            foreach (KeyValuePair<string, int> itemCostKvp in shop.ItemCostDictionary)
                            {
                                if (equipmentItem.ID.Equals(itemCostKvp.Key))
                                {
                                    equipmentItem.Cost = itemCostKvp.Value;
                                    break;
                                }
                            }
                        }

                        this.m_equipmentItems.Add(equipmentItem);
                    }
                }
            }
        }

        private List<string> GetCompleteDataFilePathList()
        {
            List<string> dataFilePaths = new List<string>();

            EquipmentItemGroup currentItemGroup = ItemMappingManager.CurrentInstance.FindItemGroup(this.Name);
            while (null != currentItemGroup)
            {
                foreach (string dataFilePath in currentItemGroup.m_localDataPaths)
                {
                    dataFilePaths.Add(dataFilePath);
                }

                currentItemGroup = ItemMappingManager.CurrentInstance.FindItemGroup(currentItemGroup.InheritedGroupName);
            }

            return dataFilePaths;
        }

        [DataMemberAttribute]
        public List<EquipmentItem> Items
        {
            get
            {
                if (null == this.m_equipmentItems)
                {
                    this.ProcessItemBlueprints();
                }

                return this.m_equipmentItems;
            }
        }

        [DataMemberAttribute]
        public List<string> Tags
        {
            get
            {
                return this.m_tags;
            }
        }

        [DataMemberAttribute]
        public string Name { get; set; }

        [DataMemberAttribute]
        public string InheritedGroupName { get; set; }

        public List<string> DataFilePaths
        {
            get
            {
                return this.GetCompleteDataFilePathList();
            }
        }

        // Member Variables
        private List<string> m_localDataPaths;
        private List<string> m_excludeItems;
        private List<string> m_includedShopNames;
        private List<string> m_tags;
        private List<EquipmentItem> m_equipmentItems;
    }
}