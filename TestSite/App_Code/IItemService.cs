using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using Demigod;

// NOTE: If you change the interface name "IItemService" here, you must also update the reference to "IItemService" in Web.config.
[ServiceContract(Namespace = "Demigod.Services")]
public interface IItemService
{
    [OperationContract]
    CharacterStats GetLevelUpBuffs(int level, string characterBlueprintKey, string levelUpKey);

    [OperationContract]
    List<Character> GetAllCharacters();

    [OperationContract]
    List<EquipmentItemAffects> GetAllItemsForCharacter(string characterName);

    [OperationContract]
    EquipmentItem GetItemByID(string id);

    [OperationContract]
    List<EquipmentItemGroup> GetAllItemGroups();

    [OperationContract]
    List<EquipmentItem> GetAllItems();
}