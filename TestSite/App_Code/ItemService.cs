using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using Demigod;

// NOTE: If you change the class name "ItemService" here, you must also update the reference to "ItemService" in Web.config.
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Required)]
public class ItemService : IItemService
{
    public CharacterStats GetLevelUpBuffs(int level, string characterBlueprintKey, string levelUpKey)
    {
        return CharacterStatsManager.CurrentInstance.GetLevelUpBuffs(level, characterBlueprintKey, levelUpKey);
    }

    public List<Character> GetAllCharacters() 
    {
        return ItemMappingManager.CurrentInstance.Characters;
    }

    public List<EquipmentItemAffects> GetAllItemsForCharacter(string characterName)
    {
        Character character = ItemMappingManager.CurrentInstance.FindCharacter(characterName);

        if (null == character)
        {
            return null;
        }

        return character.GetAllEquipableItemsForDisplay();
    }

    public EquipmentItem GetItemByID(string id)
    {
        return ItemMappingManager.CurrentInstance.FindItemByID(id);
    }

    public List<EquipmentItemGroup> GetAllItemGroups()
    {
        return ItemMappingManager.CurrentInstance.ItemGroups;
    }

    public List<EquipmentItem> GetAllItems()
    {
        List<EquipmentItem> allItems = new List<EquipmentItem>();
        foreach (EquipmentItemGroup ig in ItemMappingManager.CurrentInstance.ItemGroups)
        {
            foreach (EquipmentItem item in ig.Items)
            {
                EquipmentItem existingItem = allItems.Find(delegate(EquipmentItem ei) { return ei.DisplayName.Equals(item.DisplayName); });
                if (null == existingItem)
                {
                    allItems.Add(item);
                }
            }
        }

        return allItems;
    }
}