namespace Demigod
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Linq;
    using System.Reflection;
    using System.Web;

    /// <summary>
    /// Summary description for EquipmentItemAffects
    /// </summary>
    public class EquipmentItemAffects
    {
        public EquipmentItemAffects() { }
        public EquipmentItemAffects(EquipmentItem ei)
        {
            this.m_equipmentItem = ei;
        }

        public void ProcessStats()
        {
            this.DisplayName = this.m_equipmentItem.DisplayName;
            this.Cost = this.m_equipmentItem.Cost;

            Assembly assembly = Assembly.GetCallingAssembly();
            Type reflectionObject = assembly.GetType("Demigod.EquipmentItemAffects");
            object classObject = Activator.CreateInstance(reflectionObject);
            foreach (AffectValue affectValue in this.m_equipmentItem.Affects)
            {
                PropertyInfo pi = reflectionObject.GetProperty(affectValue.ReplacementTermModifierKey);
                if (null != pi)
                {
                    switch (pi.PropertyType.Name)
                    {
                        case "String":
                            pi.SetValue(this, affectValue.StringValue, null);
                            break;
                        case "Int32":
                            pi.SetValue(this, affectValue.IntValue, null);
                            break;
                        case "Decimal":
                            pi.SetValue(this, affectValue.DecimalValue, null);
                            break;
                        default:
                            break;
                    }
                }
            }
        }

        public string DisplayName { get; set; }
        public int Cost { get; set; }
        public int MaxHealth { get; set; }
        public int Armor { get; set; }
        public int MaxEnergy { get; set; }
        public decimal RateOfFire { get; set; }
        public int DamageRating { get; set; }
        public decimal Regen { get; set; }
        public decimal EnergyRegen { get; set; }
        public decimal MoveMult { get; set; }
        public decimal LifeSteal { get; set; }
        public decimal MoveSlowCap { get; set; }
        public decimal Cooldown { get; set; }
        public string ItemType
        {
            get
            {
                return this.m_equipmentItem.ItemType.ToString();
            }
        }

        private EquipmentItem m_equipmentItem;
    }
}