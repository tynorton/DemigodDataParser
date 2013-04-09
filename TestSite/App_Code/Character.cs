namespace Demigod
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Runtime.Serialization;
    using System.Web;
    using System.Xml;
    using System.Xml.XPath;

    /// <summary>
    /// Summary description for Character
    /// </summary>
    [DataContractAttribute]
    public class Character
    {
        internal Character(string name, string blueprintKey, string levelUpBlueprintKey, string className)
        {
            this.Name = name;
            this.BlueprintKey = blueprintKey;
            this.LevelUpBlueprintKey = levelUpBlueprintKey;
            this.ClassName = className;
        }

        public void Load()
        {
            // Find matching class
            this.CharacterClass = ItemMappingManager.CurrentInstance.FindCharacterClass(this.ClassName);

            // Load the base stats
            this.CharacterStats = CharacterStatsManager.CurrentInstance.GetBaseStats(this.BlueprintKey);
        }

        public List<EquipmentItemAffects> GetAllEquipableItemsForDisplay()
        {
            List<EquipmentItemAffects> allItems = new List<EquipmentItemAffects>();
            foreach (EquipmentItemGroup itemGroup in this.CharacterClass.ItemGroups)
            {
                foreach (EquipmentItem item in itemGroup.Items)
                {
                    if (
                        !itemGroup.Name.Equals("General's Minions", StringComparison.OrdinalIgnoreCase)
                        )
                    {
                        EquipmentItemAffects itemAffect = new EquipmentItemAffects(item);
                        itemAffect.ProcessStats();
                        allItems.Add(itemAffect);
                    }
                }
            }

            return allItems;
        }

        [DataMemberAttribute]
        public string Name { get; private set; }

        [DataMemberAttribute]
        public string BlueprintKey { get; private set; }

        [DataMemberAttribute]
        public string LevelUpBlueprintKey { get; private set; }

        [DataMemberAttribute]
        public string ClassName { get; private set; }

        [DataMemberAttribute]
        public CharacterClass CharacterClass { get; private set; }

        [DataMemberAttribute]
        public CharacterStats CharacterStats { get; private set; }
    }
}