namespace Demigod
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Runtime.Serialization;
    using System.Web;

    /// <summary>
    /// Summary description for BuffAffectValue
    /// </summary>
    [DataContractAttribute]
    public class BuffValue
    {
        [DataMemberAttribute]
        public bool IsBool { get; set; }

        [DataMemberAttribute]
        public bool IsInt { get; set; }

        [DataMemberAttribute]
        public bool IsDecimal { get; set; }

        [DataMemberAttribute]
        public bool BoolValue { get { return this.GetBoolValue(); } private set { this.m_boolValue = value; } }

        [DataMemberAttribute]
        public int IntValue { get { return this.GetIntValue(); } private set { this.m_intValue = value; } }

        [DataMemberAttribute]
        public decimal DecimalValue { get { return this.GetDecimalValue(); } private set { this.m_decimalValue = value; } }

        [DataMemberAttribute]
        public string StringValue { get { return this.GetStringValue(); } private set { this.m_stringValue = value; } }

        public BuffValue(string valueToParse)
        {
            this.ParseAndTryToAdd(valueToParse, 1);
        }

        public void ParseAndTryToAdd(string valueToParse, int level)
        {
            bool boolVal;
            int intVal;
            decimal decVal;

            if (bool.TryParse(valueToParse, out boolVal))
            {
                this.m_boolValue = boolVal;
                this.IsBool = true;
            }
            else if (valueToParse.Contains(".") && decimal.TryParse(valueToParse, out decVal))
            {
                for (int i = 1; i <= level; i++)
                {
                    this.m_decimalValue += decVal;
                }
                this.IsDecimal = true;
            }
            else if (int.TryParse(valueToParse, out intVal))
            {
                for (int i = 1; i <= level; i++)
                {
                    this.m_intValue += intVal;
                }
                this.IsInt = true;
            }
            else
            {
                this.m_stringValue = valueToParse;
            }
        }

        public bool GetBoolValue()
        {
            if (this.IsBool)
                return this.m_boolValue;

            return false;
        }

        public int GetIntValue()
        {
            if (this.IsInt)
                return this.m_intValue;

            if (this.IsDecimal)
                return Convert.ToInt32(this.m_decimalValue);

            return DEFAULT_NUM_VALUE;
        }

        public decimal GetDecimalValue()
        {
            if (this.IsDecimal)
                return this.m_decimalValue;

            if (this.IsInt)
                return this.m_intValue;

            return DEFAULT_NUM_VALUE;
        }

        public string GetStringValue()
        {
            if (this.IsBool) return this.BoolValue.ToString();
            if (this.IsInt) return this.IntValue.ToString();
            if (this.IsDecimal) return this.DecimalValue.ToString();

            return string.Empty;
        }

        // need a unique non-valid value since -1 means unlimited in demigod
        private const int DEFAULT_NUM_VALUE = -99;

        private bool m_boolValue { get; set; }
        private int m_intValue { get; set; }
        private decimal m_decimalValue { get; set; }
        private string m_stringValue { get; set; }
    }
}