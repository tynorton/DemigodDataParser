using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DemigodDataParser
{
    public class BlueprintDeclaration
    {
        public List<BlueprintDeclaration> NestedDeclarations { get; set; }
        public List<KeyValuePair<string,string>> KeyValuePairs { get; set; }
        public List<string> Strings = new List<string>();
        public string Name { get; set; }

        public BlueprintDeclaration()
        {
            this.KeyValuePairs = new List<KeyValuePair<string, string>>();
            this.NestedDeclarations = new List<BlueprintDeclaration>();
            this.Strings = new List<string>();
        }
    }
}
