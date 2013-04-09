namespace Demigod
{
    using System;
    using System.Data;
    using System.Configuration;
    using System.Linq;
    using System.Web;
    using System.Web.Security;
    using System.Web.UI;
    using System.Web.UI.HtmlControls;
    using System.Web.UI.WebControls;
    using System.Web.UI.WebControls.WebParts;
    using System.Xml.Linq;

    /// <summary>
    /// Summary description for ReplacementTerm
    /// </summary>
    public class ReplacementTerm
    {
        public ReplacementTerm(string name, string replacementType, string modifierKey, string blueprintName, int multiplier) : this(name, replacementType, modifierKey, blueprintName)
        {
            this.m_multiplier = multiplier;
        }

        public ReplacementTerm(string name, string replacementType, string modifierKey, string blueprintName)
        {
            this.m_name = name;
            this.m_replacementType = replacementType;
            this.m_modifierKey = modifierKey;
            this.m_blueprintName = blueprintName;
        }

        public string Name
        {
            get
            {
                return this.m_name;
            }
        }

        public string ModifierKey
        {
            get
            {
                return this.m_modifierKey;
            }
        }

        public string ReplacementType
        {
            get
            {
                return this.m_replacementType;
            }
        }

        public string BlueprintName
        {
            get
            {
                return this.m_blueprintName;
            }
        }

        public int Multiplier
        {
            get
            {
                return this.m_multiplier;
            }
        }

        private string m_replacementType;
        private string m_name;
        private string m_modifierKey;
        private string m_blueprintName;
        private int m_multiplier;
    }
}