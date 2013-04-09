using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;

namespace DemigodDataParser
{
    class Program
    {
        static void Main(string[] args)
        {
            CreateItemXML();
        }

        private static void CreateItemXML()
        {
            string dataDirBasePath = GetDataPath();
            foreach (string directory in FilesystemIOManager.GetDirectoriesRecursive(dataDirBasePath))
            {
                Dictionary<string, List<BlueprintDeclaration>> itemBlueprintDictionary = BlueprintParser.ProcessItemBlueprintDirectory(directory);

                foreach (KeyValuePair<string, List<BlueprintDeclaration>> blueprintKvp in itemBlueprintDictionary)
                {
                    XmlDocument xmlDoc = new XmlDocument();
                    Dictionary<string, XmlElement> elements = new Dictionary<string, XmlElement>();
                    // Create main elements
                    XmlElement demigodItemsElem = xmlDoc.CreateElement("", "DemigodBlueprints", "");

                    // Add attributes to root element
                    XmlAttribute rootIdAttribute = xmlDoc.CreateAttribute("id");
                    rootIdAttribute.InnerText = blueprintKvp.Key;
                    demigodItemsElem.Attributes.Append(rootIdAttribute);

                    foreach (BlueprintDeclaration blueprintDec in blueprintKvp.Value)
                    {
                        XmlElement blueprintElem = CreateXMLElementFromBlueprint(xmlDoc, blueprintDec);

                        string parentElementName = blueprintElem.Name + "s";

                        if (!elements.ContainsKey(parentElementName))
                        {
                            XmlElement elem = xmlDoc.CreateElement(parentElementName);
                            elements.Add(parentElementName, elem);
                        }

                        elements[parentElementName].AppendChild(blueprintElem);
                    }

                    // Add elements to document
                    foreach (KeyValuePair<string, XmlElement> kvp in elements)
                    {
                        demigodItemsElem.AppendChild(kvp.Value);
                    }
                    
                    xmlDoc.AppendChild(demigodItemsElem);

                    // Save the file
                    string[] dirParts = directory.Split(new string[] { dataDirBasePath + Path.DirectorySeparatorChar }, StringSplitOptions.None);
                    string dirName = dirParts[dirParts.Length - 1];
                    string outputDir = Path.Combine(XML_OUTPUT_DIR, DEMI_VERSION_STRING);
                    outputDir = Path.Combine(outputDir, dirName);
                    Directory.CreateDirectory(outputDir);
                    xmlDoc.Save(string.Format("{0}\\{1}.xml", outputDir, blueprintKvp.Key));
                }
            }
        }

        private static XmlElement CreateXMLElementFromBlueprint(XmlDocument xmlDoc, BlueprintDeclaration blueprintDec)
        {
            string name = string.IsNullOrEmpty(blueprintDec.Name) ? "Nested" : blueprintDec.Name;

            XmlElement baseElement = xmlDoc.CreateElement(name);

            foreach (string value in blueprintDec.Strings)
            {
                XmlElement stringElem = xmlDoc.CreateElement("Value");
                stringElem.InnerText = value;
                baseElement.AppendChild(stringElem);
            }

            foreach (KeyValuePair<string, string> kvp in blueprintDec.KeyValuePairs)
            {
                XmlElement kvpElem = xmlDoc.CreateElement(kvp.Key);
                kvpElem.InnerText = kvp.Value;
                baseElement.AppendChild(kvpElem);
            }

            foreach (BlueprintDeclaration nestedBlueprintDec in blueprintDec.NestedDeclarations)
            {
                XmlElement nestedElem = CreateXMLElementFromBlueprint(xmlDoc, nestedBlueprintDec);
                baseElement.AppendChild(nestedElem);
            }

            return baseElement;
        }

        public static string GetDataPath()
        {
            string basePath = "C:\\svn\\tools\\demigoddataparser";
            string dataDirPostfix = Path.Combine(DATA_DIR_NAME, DEMI_VERSION_STRING);

            string dataDir = dataDirPostfix;

            // Let's try going down a few directories trying to find our data
            for (int i = 0; i < 5; i++)
            {
                if (!Directory.Exists(dataDir))
                    dataDir = Path.Combine("..", dataDir);
                else
                    return dataDir;
            }

            return Path.Combine(basePath, dataDirPostfix);
        }

        // Data path values
        const string XML_OUTPUT_DIR = "OutputXML";
        const string DATA_DIR_NAME = "data";
        const string DEMI_VERSION_STRING = "1.19.130";
    }
}
