using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;

namespace DemigodDataParser
{
    public class EquipmentItemBuff
    {
        public List<KeyValuePair<string, AffectValue>> Affects
        {
            get
            {
                return this.m_affects;
            }

            set
            {
                if (null == this.m_affects)
                {
                    this.m_affects = new List<KeyValuePair<string, AffectValue>>();
                }
            }
        }

        public void AddAffect(string key, string value)
        {
            KeyValuePair<string, AffectValue> kvp = new KeyValuePair<string,AffectValue>(key, new AffectValue(value));
            this.Affects.Add(kvp);
        }

        private List<KeyValuePair<string, AffectValue>> m_affects;
    }

    public class AffectValue
    {
        public bool IsBool { get; set; }
        public bool IsInt { get { return this.IntValue != DEFAULT_NUM_VALUE; } }
        public bool IsDecimal { get { return this.DecimalValue != DEFAULT_NUM_VALUE; } }

        public bool BoolValue { get; set; }
        public int IntValue { get; set; }
        public decimal DecimalValue { get; set; }
        public string StringValue { get; set; }

        public AffectValue(string valueToParse)
        {
            bool boolVal;
            int intVal;
            decimal decVal;

            if (bool.TryParse(valueToParse, out boolVal))
            {
                this.BoolValue = boolVal;
                this.IsBool = true;
            }
            else if (int.TryParse(valueToParse, out intVal))
            {
                this.IntValue = intVal;
            }
            else if (decimal.TryParse(valueToParse, out decVal))
            {
                this.DecimalValue = decVal;
            }
            else
            {
                this.StringValue = valueToParse;
            }
        }

        public bool GetBoolValue()
        {
            if (this.IsBool) 
                return this.BoolValue;

            return false;
        }

        public int GetIntValue()
        {
            if (this.IsInt) 
                return this.IntValue;

            return DEFAULT_NUM_VALUE;
        }

        public decimal GetDecimalValue()
        {
            if (this.IsDecimal) 
                return this.DecimalValue;

            return DEFAULT_NUM_VALUE;
        }

        public string GetStringValue()
        {
            if (this.IsBool) return this.BoolValue.ToString();
            if (this.IsInt) return this.IntValue.ToString();
            if (this.IsDecimal) return this.DecimalValue.ToString();

            return null;
        }

        // need a unique invalid value since -1 means unlimited in demigod
        private const int DEFAULT_NUM_VALUE = -99;
    }
}
