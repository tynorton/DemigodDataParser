namespace Demigod
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Runtime.Serialization;
    using System.Web;
    using System.Xml;
    using System.Xml.XPath;

    /// <summary>
    /// Summary description for CharacterClass
    /// </summary>
    [DataContractAttribute]
    public class CharacterClass
    {
        internal CharacterClass(string className, string inherit, List<string> itemGroupNames)
        {
            this.m_className = className;
            this.m_inherit = inherit;
            this.m_localItemGroupNames = itemGroupNames;
        }

        private List<string> LoadCompleteGroupNamesList()
        {
            List<string> groupNames = new List<string>();

            CharacterClass currentClass = ItemMappingManager.CurrentInstance.FindCharacterClass(this.ClassName);
            while (null != currentClass)
            {
                foreach (string groupName in currentClass.m_localItemGroupNames)
                {
                    groupNames.Add(groupName);
                }

                currentClass = ItemMappingManager.CurrentInstance.FindCharacterClass(currentClass.InheritedClassName);
            }

            return groupNames;
        }

        private List<EquipmentItemGroup> LoadItemGroups()
        {
            List<EquipmentItemGroup> itemGroups = new List<EquipmentItemGroup>();
            List<string> itemGroupNames = this.LoadCompleteGroupNamesList();
            foreach (string groupName in itemGroupNames)
            {
                EquipmentItemGroup itemGroup = ItemMappingManager.CurrentInstance.FindItemGroup(groupName);
                itemGroups.Add(itemGroup);
            }

            return itemGroups;
        }

        [DataMemberAttribute]
        public List<EquipmentItemGroup> ItemGroups
        {
            get
            {
                if (null == this.m_itemGroups)
                {
                    this.m_itemGroups = this.LoadItemGroups();
                }

                return this.m_itemGroups;
            }
        }

        [DataMemberAttribute]
        public string ClassName
        {
            get
            {
                return this.m_className;
            }
            set
            {
                this.m_className = value;
            }
        }

        [DataMemberAttribute]
        public string InheritedClassName
        {
            get
            {
                return this.m_inherit;
            }
            set
            {
                this.m_inherit = value;
            }
        }

        private string m_className;
        private string m_inherit;
        private List<EquipmentItemGroup> m_itemGroups;
        private List<string> m_localItemGroupNames;
    }
}