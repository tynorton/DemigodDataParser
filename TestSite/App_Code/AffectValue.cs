namespace Demigod 
{
    using System;
    using System.Data;
    using System.Configuration;
    using System.Linq;
    using System.Runtime.Serialization;
    using System.Web;
    using System.Web.Security;
    using System.Web.UI;
    using System.Web.UI.HtmlControls;
    using System.Web.UI.WebControls;
    using System.Web.UI.WebControls.WebParts;
    using System.Xml.Linq;

    /// <summary>
    /// Class to determine what values should be substituted for the replacement tokens in some strings.
    /// Example replacement token: "[GetSomething]"
    /// </summary>
    [DataContractAttribute]
    public class AffectValue : BuffValue
    {
        public AffectValue(string replacementTermKey, string replacementTermType, string valueToParse)
            : base(valueToParse)
        {
            this.m_replacementTermKey = replacementTermKey;
            this.m_replacementTermType = replacementTermType;
        }

        /// <summary>
        /// The term name to be replaced
        /// </summary>
        [DataMemberAttribute]
        public string ReplacementTermModifierKey
        {
            get
            {
                return this.m_replacementTermKey;
            }

            set
            {
                this.m_replacementTermKey = value;
            }
        }

        /// <summary>
        /// This is the replacement type, examples include Add/Mult
        /// </summary>
        [DataMemberAttribute]
        public string ReplacementType
        {
            get
            {
                return this.m_replacementTermType;
            }

            set
            {
                this.m_replacementTermType = value;
            }
        }

        private string m_replacementTermType;
        private string m_replacementTermKey;
    }
}