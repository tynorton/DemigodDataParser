/* 
jquery.demigod.js - (c) 2009 Ty Norton - dgstats@bsd.bz
Do not redistribute without permission from Ty Norton.
---------------------------------------------------------------------
Design Requirements
% Interact with web services
  - Cache results on client
% Render page elements
% Calculate stats
---------------------------------------------------------------------
Dependencies
% DGStats Web Services  - http://demigod.bsd.bz
% ASP.NET 3.5           - http://www.asp.net
  - Proxy classes/methods generated from 'Demigod.Services' namespace
% JQuery Core           - http://www.jquery.org
% JQuery DataTables     - http://www.datatables.net
---------------------------------------------------------------------
*/

// Constants
var MAX_EQUIPPED_ITEMS = 6;

// Member Variables
var allItems;                   // EquipmentItem[]  -- All equippable items
var allCharacters;              // Character[]      -- All Characters
var allItemsForChar;            // EquipmentItem[]  -- All items for a given char
var itemAffectsPropertyNames;   // string[]         -- Names of all properties on the EquipmentItemAffects obj
var currentCharacterStats;      // CharacterStats   -- Calculated stats for the current char (Base + (LevelUp*level))
var activeCharacter;            // Character        -- Current character in dropdown
var equippedItemsArr;           // EquipmentItem[]  -- Selected items to add to total stats
var equippedItemCount = 0;
var allDataLoaded = false;

// CSS Selectors
var gridCheckBoxesSelector = "span.rowCheckBox INPUT[type='checkbox']";
var btSelector = "a.itemSummaryLink";
var gridSelector = "table#itemGrid";
var loadingDivSelector = "div.loadingDataDiv";
var mainDivSelector = "div#main";


// This method is called when the DOM is ready
$(function() {
    // Load the data from the web service
    loadData();
});

// This method chains callbacks.
// It starts by loading Characters, then Items.
// The last callback in the chain will call OnAllDataLoaded() to display stuff.
function loadData() {
    // Begin loading Characters
    Demigod.Services.IItemService.GetAllCharacters(OnCharactersCompleted);
}

function OnCharactersCompleted(results) {
    allCharacters = results;

    findActiveCharacter();

    // Next, we begin loading Items
    Demigod.Services.IItemService.GetAllItems(OnItemsCompleted);
}

function OnItemsCompleted(results) {
    allItems = results;

    var levelDropDown = document.getElementById(levelDropDownId);

    // Next, we begin loading Items
    Demigod.Services.IItemService.GetLevelUpBuffs(levelDropDown.value, activeCharacter.BlueprintKey, activeCharacter.LevelUpBlueprintKey, OnCharacterStatsCompleted);
}

function OnCharacterStatsCompleted(results) {
    currentCharacterStats = results;

    // Next, we begin loading Items for character
    Demigod.Services.IItemService.GetAllItemsForCharacter(activeCharacter.Name, OnItemsForCharCompleted);
}

function OnItemsForCharCompleted(results) {
    allItemsForChar = results;

    itemAffectsPropertyNames = new Array();

    // Manually force the column ordering here
    itemAffectsPropertyNames[0] = "DisplayName";
    itemAffectsPropertyNames[1] = "Cost";

    var count = itemAffectsPropertyNames.length;
    for (var propertyName in allItemsForChar[0]) {
        
        var alreadyHas = false;
        for (var i in itemAffectsPropertyNames) {
            var checkPropName = itemAffectsPropertyNames[i];
            if (checkPropName == propertyName) {
                alreadyHas = true;
                break;
            }
        }

        if (propertyName != '__type' && !alreadyHas) {
            itemAffectsPropertyNames[count] = propertyName;
            alreadyHas = false;
            count++;
        }
    }

    renderCharacterStats();

    // Finally, we enable elements reliant on our newly loaded data
    OnAllDataLoaded();
}

function findActiveCharacter() {
    var characterDropDown = document.getElementById(characterDropDownId);
    for (var i in allCharacters) {
        if (allCharacters[i].Name == characterDropDown.value) {
            activeCharacter = allCharacters[i];
            break;
        }
    }
}

function renderCharacterStats() {
    $("#characterName").html(activeCharacter.Name);
}

function createBindableItemData() {
    var data = new Array();
    for (var i in allItemsForChar) {
        var singleItemArr = new Array();
        for (var y in itemAffectsPropertyNames) {
            var propertyName = itemAffectsPropertyNames[y];
            singleItemArr[y] = allItemsForChar[i][propertyName];
        }
        data[i] = singleItemArr;
    }

    return data;
}
function OnAllDataLoaded() {
    // Hide loading text
    $("#" + loadingDivSelector).hide();

    // Remove old dataTables container if it exists
    $(".dataTables_wrapper").remove();

    // Create the grid again
    bindGrid();
}

function createItemTable() {
    var data = createBindableItemData();
    var newTable = document.createElement('table');
    newTable.id = 'itemGrid';
    var thead = document.createElement('thead');
    var tbody = document.createElement('tbody');

    var headRow = document.createElement('tr');

    for (var i in itemAffectsPropertyNames) {
        var cell = document.createElement('th');
        cell.innerHTML = itemAffectsPropertyNames[i];
        headRow.appendChild(cell);
    }
    thead.appendChild(headRow);
    newTable.appendChild(thead);

    for (var i = 0; i < data.length; i++) {
        var dataRow = document.createElement('tr');
        var singleRowArr = data[i];
        for (var y = 0; y < singleRowArr.length; y++) {
            var cell = document.createElement('td');
            cell.innerHTML = singleRowArr[y];
            dataRow.appendChild(cell);
        }
        tbody.appendChild(dataRow);
    }
    newTable.appendChild(tbody);
    return newTable;
}

function bindGrid() {
    var table = createItemTable();
    $(mainDivSelector).append(table);
    
    $(gridSelector).dataTable({
        "bPaginate": false,
        "bAutoWidth": true
    });
}

function OnCharacterChange() {
    var proceed = confirm("If you change your character, your selections will be reset\n\nAre you sure you want proceed?");

    if (proceed) {
        findActiveCharacter();

        // Next, we begin loading Items
        Demigod.Services.IItemService.GetAllItemsForCharacter(activeCharacter.Name, OnItemsForCharCompleted);
    }
    else {
        var characterDropDown = document.getElementById(characterDropDownId);
        characterDropDown.value = activeCharacter.Name;
    }
}

function doGridRowMouseOver(sender, itemId) {
    $(sender).bt(getItemTooltipHtml(itemId), {
        padding: 20,
        width: '300px',
        spikeLength: 40,
        spikeGirth: 40,
        cornerRadius: 40,
        fill: 'rgba(0, 0, 0, .8)',
        strokeWidth: 2,
        strokeStyle: '#CC0',
        cssStyles: { color: '#FFF' }
    });
}

function doGridRowCheckBoxClick(sender, itemId) {
    var item = findItem(itemId);

    if (item) {
        if (!sender.checked) {
            equippedItemCount--;
            rebuildEquippedItemsArray();

            // Re-enable all disable checkboxes if we uncheck one after being maxed
            if (equippedItemCount == MAX_EQUIPPED_ITEMS - 1) {
                $(gridCheckBoxesSelector).each(function() {
                    $(this).removeAttr('disabled');
                });
            }
        }
        else {
            if (equippedItemCount < MAX_EQUIPPED_ITEMS) {
                equippedItemCount++;
                rebuildEquippedItemsArray();

                // Disable all uncheck checkboxes since we've reached our maximum
                if (equippedItemCount == MAX_EQUIPPED_ITEMS) {
                    $(gridCheckBoxesSelector).each(function() {
                        if (!$(this).attr('checked')) {
                            $(this).attr('disabled', true);
                        }
                    });
                }
            }
            else {
                sender.checked = false;
            }
        }
    }

    var itemsList = document.getElementById('itemsList');
    removeChildNodes(itemsList);
    for (var i in equippedItemsArr) {
        var listItem = document.createElement('li');
        listItem.innerHTML = equippedItemsArr[i].DisplayName;
        itemsList.appendChild(listItem);
    }
}

function rebuildEquippedItemsArray() {
    var itemIds = "";
    $(gridCheckBoxesSelector).each(function() {
        if ($(this).attr('checked')) {
            var itemId = o[$(this).attr('id')];
            var item = findItem(itemId);

            if (item) {
                if (itemIds.length == 0) {
                    itemIds += item.ID;
                }
                else {
                    itemIds += "|" + item.ID;
                }
            }
        }
    });

    var itemIdArr = itemIds.split('|');
    equippedItemsArr = new Array(itemIds.length);
    for (var i = 0; i < itemIdArr.length; i++) {
        equippedItemsArr[i] = findItem(itemIdArr[i]);
    }
}

function getItemTooltipHtml(itemId) {
    var item = findItem(itemId);

    if (item) {
        var returnHTML = "<h3 class=\"ttDisplayName\">" + item.DisplayName + "</h3>";

        if (item.Description) {
            var description = item.Description.replace(/\\n/g, '<br />');
            description = description.replace("Use:", '<b>Use:</b>');
            returnHTML += "<div class=\"ttDescription\">" + description + "</div>"
        }

        returnHTML += "<div class=\"ttBonusDesc\">";
        for (var y = 0; y < item.BonusDescriptions.length; y++) {
            returnHTML += "<p>" + item.BonusDescriptions[y] + "</p>";
        }
        returnHTML += "</div>";

        returnHTML += "<div class=\"ttTooltips\">";
        for (var y = 0; y < item.Tooltips.length; y++) {
            returnHTML += "<p>" + item.Tooltips[y] + "</p>";
        }
        returnHTML += "</div>";

        return returnHTML;
    }

    return null;
}

function findCharacter(characterId) {
    if (allCharacters) {
        for (var i in allCharacters) {
            if (allCharacters[i].BlueprintKey == characterId) {
                return allCharacters[i];
            }
        }
    }

    return null;
}

function findItem(itemId) {
    if (allItems) {
        for (var i in allItems) {
            if (allItems[i].ID == itemId) {
                return allItems[i];
            }
        }
    }

    return null;
}

function removeChildNodes(ctrl) {
    while (ctrl.childNodes[0]) {
        ctrl.removeChild(ctrl.childNodes[0]);
    }
}