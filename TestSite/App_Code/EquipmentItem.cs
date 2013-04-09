using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Xml;
using System.Xml.XPath;

namespace Demigod
{
    [DataContractAttribute]
    public class EquipmentItem
    {
        internal EquipmentItem(XPathNavigator itemBlueprintNav, XPathNavigator fullDocNav)
        {
            this.BonusDescriptions = new List<string>();
            this.Tooltips = new List<string>();

            this.m_itemBlueprintNav = itemBlueprintNav;
            this.m_fullDocNav = fullDocNav;
        }

        public void ProcessItemBlueprint()
        {
            if (null == this.m_itemBlueprintNav)
            {
                throw new Exception("this.m_itemBlueprintNav cannot be null");
            }

            this.PopulateProperties();
            this.CreateAffectValues();
            this.FindAllReplacementTokens();
            this.ReplaceAllTokens();
        }

        #region Replacement Terms/Tokens
        private void ReplaceAllTokens()
        {
            this.Description = this.ReplaceTokens(this.Description);
            for (int i = 0; i < this.BonusDescriptions.Count; i++)
            {
                this.BonusDescriptions[i] = this.ReplaceTokens(this.BonusDescriptions[i]);
            }

            for (int i = 0; i < this.Tooltips.Count; i++)
            {
                this.Tooltips[i] = this.ReplaceTokens(this.Tooltips[i]);
            }
        }

        private string ReplaceTokens(string input)
        {
            if (string.IsNullOrEmpty(input))
            {
                return input;
            }

            foreach (string replacementToken in this.m_replacementTokens)
            {
                ReplacementTerm term = this.ReplacementTerms.Find(delegate(ReplacementTerm t) { return replacementToken.Equals(t.Name, StringComparison.OrdinalIgnoreCase); });
                if (null != term)
                {
                    string stringToReplace = string.Format("[{0}]", term.Name);
                    string newValue = stringToReplace;

                    AffectValue affectValue = this.m_affects.Find(delegate(AffectValue av) { return av.ReplacementTermModifierKey.Equals(term.ModifierKey, StringComparison.OrdinalIgnoreCase); });
                    
                    // We have a custom ReplacementType that has no matching AffectValue.
                    // Let's see if we can find it, and make it now.
                    if (null == affectValue)
                    {
                        // Try AbilityBlueprint node first
                        XPathNavigator valueNav = this.m_itemBlueprintNav.SelectSingleNode("//AbilityBlueprint[Name=\"" + term.BlueprintName + "\"]/" + term.ReplacementType);

                        // Do we need to try BuffBlueprint?
                        if (null == valueNav)
                        {
                            XPathNavigator nav = this.FindBuffBlueprint(term.BlueprintName);
                            if (null != nav)
                            {
                                valueNav = nav.SelectSingleNode(term.ReplacementType);
                            }
                        }

                        if (null != valueNav)
                        {
                            newValue = valueNav.InnerXml;
                            affectValue = new AffectValue(term.ModifierKey, term.ReplacementType, newValue);
                        }
                    }

                    // This is bad, means we have ReplacementTokens on the page
                    if (null == affectValue)
                    {
                        throw new Exception("Couldn't find matching AffectValue for Replacement");
                    }

                    if (term.Multiplier != 0)
                    {
                        if (affectValue.IsInt)
                        {
                            newValue = (affectValue.IntValue * term.Multiplier).ToString();
                        }
                        else if (affectValue.IsDecimal)
                        {
                            newValue = Convert.ToInt32(affectValue.DecimalValue * term.Multiplier).ToString();
                        }
                    }
                    else
                    {
                        newValue = affectValue.StringValue;
                    }

                    input = input.Replace(stringToReplace, newValue);
                }
            }

            return input;
        }

        private void FindAllReplacementTokens()
        {
            this.m_replacementTokens = new List<string>();

            this.ParseOutReplacementTokens(this.m_itemBlueprintNav.InnerXml, ref this.m_replacementTokens);
        }

        private List<ReplacementTerm> LoadReplacementTerms()
        {
            List<ReplacementTerm> replacementTerms = new List<ReplacementTerm>();
            foreach (string replacementToken in this.m_replacementTokens)
            {
                string functionText = this.m_itemBlueprintNav.SelectSingleNode(replacementToken).InnerXml;
                ReplacementTerm term = this.CreateReplacementTerm(replacementToken, functionText);

                if (null != term)
                {
                    replacementTerms.Add(term);
                }
            }

            return replacementTerms;
        }

        private ReplacementTerm CreateReplacementTerm(string replacementToken, string functionText)
        {
            string replacementType = "";
            string modifierKey = "";
            string itemPrefix = "']";
            int bpNameStartIndex = functionText.IndexOf("['") + 2;
            int bpNameEndIndex = functionText.IndexOf("']");
            int bpNameLength = bpNameEndIndex - bpNameStartIndex;
            string blueprintName = functionText.Substring(bpNameStartIndex, bpNameLength);
            string[] functionParts = functionText.Split(new string[] { itemPrefix }, StringSplitOptions.None);

            string modifierString = (functionParts.Length > 1) ? functionParts[1] : string.Empty;

            if (modifierString.StartsWith(".Affects."))
            {
                modifierString = modifierString.Remove(0, (".Affects.").Length);
                if (modifierString.Contains(".Add"))
                {
                    replacementType = "Add";
                }
                else if (modifierString.Contains(".Mult"))
                {
                    replacementType = "Mult";
                }
            }
            else
            {
                foreach (char c in modifierString)
                {
                    if (c == ' ' || c == ')')
                    {
                        break;
                    }
                    replacementType += c;
                }

                replacementType = replacementType.Replace(".", "");
            }

            string[] modifierParts = modifierString.Split(new string[] { "." + replacementType }, StringSplitOptions.None);
            modifierKey = modifierParts[0];
            string[] operatorParts = modifierParts[1].Split(new string[] { "end" }, StringSplitOptions.None);
            int intMultiplier = 0;

            if (operatorParts[0].Contains('*'))
            {
                string multiplier = operatorParts[0].Replace("*", "");
                multiplier = multiplier.Replace(")", "");
                multiplier = multiplier.Trim();
                try
                {
                    intMultiplier = int.Parse(multiplier);
                }
                catch { }
            }
            return new ReplacementTerm(replacementToken, replacementType, modifierKey, blueprintName, intMultiplier);
        }

        private void ParseOutReplacementTokens(string input, ref List<string> tokenList)
        {
            if (input.Contains("["))
            {
                int startIndex = 0;
                int endIndex = 0;
                for (int i = 0; i < input.Length; i++)
                {
                    if (input[i] == '[' && input[i + 1] != '\'')
                    {
                        startIndex = i;
                    }
                    else if (input[i] == ']' && input[i - 1] != '\'')
                    {
                        endIndex = i;
                        string replacementToken = input.Substring(startIndex + 1, (endIndex - startIndex) - 1);

                        if (!tokenList.Contains(replacementToken))
                        {
                            tokenList.Add(replacementToken);
                        }
                    }
                }
            }
        }
        #endregion

        #region Ability/Buffs
        private void ParseOutBuffBlueprintNames()
        {
            this.m_buffBlueprintNames = new List<string>();
            string fullXml = this.m_itemBlueprintNav.InnerXml;
            if (fullXml.Contains("["))
            {
                int startIndex = 0;
                int endIndex = 0;

                while (true)
                {
                    startIndex = fullXml.IndexOf("Buffs['", endIndex);
                    if (startIndex == -1)
                    {
                        break;
                    }

                    for (int i = startIndex; i < fullXml.Length; i++)
                    {
                        if (fullXml[i] == ']' && fullXml[i - 1] == '\'')
                        {
                            endIndex = i - 1;
                            int length = (endIndex - startIndex) - 7;
                            string blueprintName = fullXml.Substring(startIndex + 7, length);

                            if (!this.m_buffBlueprintNames.Contains(blueprintName))
                            {
                                this.m_buffBlueprintNames.Add(blueprintName);
                            }
                            break;
                        }
                    }
                }
            }
        }

        private void ParseOutAbilityBlueprintNames()
        {
            this.m_abilityBlueprintNames = new List<string>();
            string fullXml = this.m_itemBlueprintNav.InnerXml;
            if (fullXml.Contains("["))
            {
                int startIndex = 0;
                int endIndex = 0;

                while (true)
                {
                    startIndex = fullXml.IndexOf("Ability['", endIndex);
                    if (startIndex == -1)
                    {
                        break;
                    }

                    for (int i = startIndex; i < fullXml.Length; i++)
                    {
                        if (fullXml[i] == ']' && fullXml[i - 1] == '\'')
                        {
                            endIndex = i - 1;
                            int bpNameStartIndex = startIndex + 9;
                            int bpNameLength = endIndex - bpNameStartIndex;
                            string blueprintName = fullXml.Substring(bpNameStartIndex, bpNameLength);

                            if (!this.m_abilityBlueprintNames.Contains(blueprintName))
                            {
                                this.m_abilityBlueprintNames.Add(blueprintName);
                            }
                            break;
                        }
                    }
                }
            }
        }

        private void CreateAffectValues()
        {
            this.ParseOutBuffBlueprintNames();
            this.ParseOutAbilityBlueprintNames();

            XPathNodeIterator affectsIt = this.m_itemBlueprintNav.Select("Abilities/AbilityBlueprint/Buffs/BuffBlueprint/Affects/*");

            this.m_affects = new List<AffectValue>();
            while (affectsIt.MoveNext())
            {
                string key = affectsIt.Current.Name;
                XPathNodeIterator modifiers = affectsIt.Current.Select("*");

                while (modifiers.MoveNext())
                {
                    string modifierType = modifiers.Current.Name;
                    AffectValue affectValue = new AffectValue(key, modifierType, modifiers.Current.InnerXml);
                    this.m_affects.Add(affectValue);
                }
            }

            foreach (string bpName in this.m_buffBlueprintNames)
            {
                XPathNavigator nav = this.FindBuffBlueprint(bpName);

                XPathNodeIterator buffsIt = nav.Select("Affects/*");
                while (buffsIt.MoveNext())
                {
                    string key = buffsIt.Current.Name;
                    XPathNodeIterator modifiers = buffsIt.Current.Select("*");

                    while (modifiers.MoveNext())
                    {
                        string modifierType = modifiers.Current.Name;

                        AffectValue existing = this.m_affects.Find(delegate(AffectValue av) { return av.ReplacementType.Equals(modifierType) && av.ReplacementTermModifierKey.Equals(key); });

                        if (null == existing)
                        {
                            AffectValue affectValue = new AffectValue(key, modifierType, modifiers.Current.InnerXml);
                            this.m_affects.Add(affectValue);
                        }
                    }
                }
            }
        }
        #endregion

        #region Search Methods
        private XPathNavigator FindBuffBlueprint(string name)
        {
            XPathNavigator matchingBuffNode = this.m_fullDocNav.SelectSingleNode("//BuffBlueprint[Name=\"" + name + "\"]");

            return matchingBuffNode;
        }

        private XPathNavigator FindAbilityBlueprint(string name)
        {
            XPathNavigator matchingAbilityNode = this.m_fullDocNav.SelectSingleNode("//AbilityBlueprint[Name=\"" + name + "\"]");

            return matchingAbilityNode;
        }
        #endregion

        #region Populate Methods
        private void PopulateProperties()
        {
            XPathNavigator descriptionNav = this.m_itemBlueprintNav.SelectSingleNode("Description");
            if (null != descriptionNav)
            {
                this.Description = descriptionNav.InnerXml;
            }

            this.DisplayName = this.m_itemBlueprintNav.SelectSingleNode("DisplayName").InnerXml;
            this.ID = this.m_itemBlueprintNav.SelectSingleNode("Name").InnerXml;

            this.PopulateTooltips();
            this.PopulateBonusDescriptions();
        }

        private void PopulateTooltips()
        {
            XPathNodeIterator passivesIterator = this.m_itemBlueprintNav.Select("Tooltip/Passives");
            XPathNodeIterator chanceOnHitIterator = this.m_itemBlueprintNav.Select("Tooltip/ChanceOnHit");

            while (passivesIterator.MoveNext())
            {
                this.Tooltips.Add(passivesIterator.Current.InnerXml);
            }

            while (chanceOnHitIterator.MoveNext())
            {
                this.Tooltips.Add(chanceOnHitIterator.Current.InnerXml);
            }
        }

        private void PopulateBonusDescriptions()
        {
            XPathNodeIterator bonusIterator = this.m_itemBlueprintNav.Select("Tooltip/Bonuses");
            XPathNodeIterator minionBonusIterator = this.m_itemBlueprintNav.Select("Tooltip/MBonuses");

            while (bonusIterator.MoveNext())
            {
                XPathNodeIterator bonusValuesIterator = bonusIterator.Current.SelectChildren("Value", string.Empty);
                while (bonusValuesIterator.MoveNext())
                {
                    this.BonusDescriptions.Add(bonusValuesIterator.Current.InnerXml);
                }
            }

            while (minionBonusIterator.MoveNext())
            {
                XPathNodeIterator minionBonusValuesIterator = minionBonusIterator.Current.SelectChildren("Value", string.Empty);
                while (minionBonusValuesIterator.MoveNext())
                {
                    this.BonusDescriptions.Add(minionBonusValuesIterator.Current.InnerXml);
                }
            }
        }
        #endregion

        #region Private Variables
        private List<ReplacementTerm> ReplacementTerms
        {
            get
            {
                return this.LoadReplacementTerms();
            }
        }

        private XPathNavigator m_itemBlueprintNav;
        private XPathNavigator m_fullDocNav;
        private List<AffectValue> m_affects;
        private List<string> m_replacementTokens;
        private List<string> m_buffBlueprintNames;
        private List<string> m_abilityBlueprintNames;
        #endregion

        #region Public DataMembers
        [DataMemberAttribute]
        public string ID { get; set; }

        [DataMemberAttribute]
        public int Cost { get; set; }

        [DataMemberAttribute]
        public string Description { get; set; }

        [DataMemberAttribute]
        public string DisplayName { get; set; }

        [DataMemberAttribute]
        public List<string> BonusDescriptions { get; set; }

        [DataMemberAttribute]
        public List<string> Tooltips { get; set; }

        [DataMemberAttribute]
        public EquipmentItemType ItemType { get; set; }

        [DataMemberAttribute]
        public List<AffectValue> Affects
        {
            get
            {
                return this.m_affects;
            }
        }
        #endregion
    }

    public enum EquipmentItemType
    {
        Equippable = 0,
        Consumable = 1,
        Favor = 2,
        Other = 3
    }
}