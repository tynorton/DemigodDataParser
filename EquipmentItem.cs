using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DemigodDataParser
{
    public class EquipmentItem
    {
        public string Name { get; set; }
        public string DisplayName { get; set; }
        public string Description { get; set; }
        public string IconPath { get; set; }
        public string InventoryType { get; set; }
        public bool Usable { get; set; }
        public EquipmentItemAbility Abilities { get; set; }
    }
}
