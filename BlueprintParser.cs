using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace DemigodDataParser
{
    public class BlueprintParser
    {
        public static Dictionary<string, List<BlueprintDeclaration>> ProcessItemBlueprintDirectory(string itemLuaPath)
        {
            Dictionary<string, string[]> fileContentsDictionary = FilesystemIOManager.GetLUAContentsDictionary(itemLuaPath);
            Dictionary<string, List<BlueprintDeclaration>> blueprintDictionary = CreateBlueprintDictionary(fileContentsDictionary);

            return blueprintDictionary;
        }

        private static Dictionary<string, List<BlueprintDeclaration>> CreateBlueprintDictionary(Dictionary<string, string[]> fileContentsDictionary)
        {
            Dictionary<string, List<BlueprintDeclaration>> blueprintDictionary = new Dictionary<string, List<BlueprintDeclaration>>();
            foreach (KeyValuePair<string, string[]> fileKvp in fileContentsDictionary)
            {
                List<string[]> declarations = ParseOutDeclarations(fileKvp.Value);
                List<BlueprintDeclaration> blueprintDecs = new List<BlueprintDeclaration>();
                foreach (string[] declaration in declarations)
                {
                    BlueprintDeclaration bpDec = ParseBlueprintDeclaration(declaration);
                    blueprintDecs.Add(bpDec);
                }

                blueprintDictionary.Add(fileKvp.Key, blueprintDecs);
            }

            return blueprintDictionary;
        }

        private static BlueprintDeclaration ParseBlueprintDeclaration(string[] blueprintLines)
        {
            BlueprintDeclaration bpDec = new BlueprintDeclaration();
            bpDec.Name = ParseOutBlueprintIdentifier(blueprintLines);

            for (int i = 1; i < blueprintLines.Length - 1; i++)
            {
                if (blueprintLines[i].Contains("function") && !blueprintLines[i].Contains("end"))
                {
                    i = FindMatchingEndFunctionIndex(i, blueprintLines);
                }
                else if (blueprintLines[i].Contains("{") && !blueprintLines[i].Contains("}"))
                {
                    ParseMultiLineTableDeclaration(blueprintLines, ref i, ref bpDec);
                }
                else if (blueprintLines[i].EndsWith(",") || blueprintLines[i].EndsWith("}"))
                {
                    ParseSingleLineVariables(blueprintLines[i], ref bpDec);
                }
                else if (blueprintLines[i].Contains("local "))
                {
                    continue; // Skip local variables
                }
            }

            return bpDec;
        }

        /// <summary>
        /// Parse out "ItemBluePrint" from "ItemBluePrint {" text for our blueprint name
        /// </summary>
        /// <param name="blueprintLines"></param>
        /// <returns></returns>
        private static string ParseOutBlueprintIdentifier(string[] blueprintLines)
        {
            string name = blueprintLines[0].Substring(0, blueprintLines[0].IndexOf("{"));
            int equalsIndex = name.IndexOf("=");
            if (equalsIndex >= 0)
            {
                name = name.Remove(equalsIndex, 1);
            }

            return name.Trim();
        }

        private static void ParseMultiLineTableDeclaration(string[] blueprintLines, ref int index, ref BlueprintDeclaration bpDec)
        {
            int startBraceIndex = index;
            int endBraceIndex = FindMatchingEndBraceIndex(startBraceIndex, blueprintLines);
            string[] singleDeclaration = ParseOutMatchingBraces(blueprintLines, startBraceIndex, endBraceIndex);
            bpDec.NestedDeclarations.Add(ParseBlueprintDeclaration(singleDeclaration));
            index = endBraceIndex;
        }

        private static void ParseSingleLineVariables(string blueprintLine, ref BlueprintDeclaration bpDec)
        {
            string trimmedLine = blueprintLine;

            if (blueprintLine.EndsWith(","))
            {
                trimmedLine = blueprintLine.Remove(blueprintLine.Length - 1, 1);
            }

            if (trimmedLine.Contains("="))
            {
                string[] split = trimmedLine.Split(new char[] { '=' }, 2); // split on the first '=' incase we have a nested table declaration
                string key = split[0].Trim();
                string value = split[1].Trim();

                value = TrimLeadingAndTrailingSingleQuotes(value);
                value = TrimLocItemText(value);

                if (value.Contains("{") && value.Contains("}"))
                {
                    value = value.Replace("{", "");
                    value = value.Replace("}", "");
                    string[] multiValues = value.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                    foreach (string val in multiValues)
                    {
                        if (val.Contains('='))
                        {
                            string[] split2 = val.Split('=');
                            string originalKey = key;
                            string originalValue = value;
                            key = split2[0].Trim();
                            value = split2[1].Trim();
                            value = TrimLeadingAndTrailingSingleQuotes(value);
                            BlueprintDeclaration nestedBpDec = new BlueprintDeclaration();
                            nestedBpDec.Name = originalKey;
                            nestedBpDec.KeyValuePairs.Add(new KeyValuePair<string, string>(key, value));
                            bpDec.NestedDeclarations.Add(nestedBpDec);
                        }
                        else
                        {
                            // TODO: Deal with multi value keyValuePairs
                            // i.e. Key = { Value1, Value2, Value3 }
                        }
                    }
                }
                else
                {
                    bpDec.KeyValuePairs.Add(new KeyValuePair<string, string>(key, value));
                }
            }
            else
            {
                string value = trimmedLine;
                value = TrimLeadingAndTrailingSingleQuotes(value);
                value = TrimLocItemText(value);
                bpDec.Strings.Add(value);
            }
        }

        private static string TrimLeadingAndTrailingSingleQuotes(string value)
        {
            if (value.StartsWith("'"))
            {
                value = value.Remove(0, 1);
            }

            if (value.EndsWith("'"))
            {
                value = value.Remove(value.Length - 1, 1);
            }

            return value;
        }

        private static string TrimLocItemText(string value)
        {
            string newString = "";
            int startIndex = value.IndexOf("<");
            int endIndex = value.IndexOf(">");

            if (startIndex == -1 || endIndex == -1)
            {
                return value;
            }

            for (int i = 0; i < value.Length; i++)
            {
                if (i >= startIndex && i <= endIndex)
                {
                    continue;
                }

                newString += value[i];
            }

            return newString;
        }

        private static List<string[]> ParseOutDeclarations(string[] fileContents)
        {
            List<string[]> declarations = new List<string[]>();

            int startBraceIndex = 0;
            int endBraceIndex = 0;
            while (true)
            {
                while (!fileContents[startBraceIndex].Contains("{") && !fileContents[startBraceIndex].Contains("function"))
                {
                    if (startBraceIndex == fileContents.Length - 1)
                        break;

                    startBraceIndex++;
                }

                // Skip over function declarations
                if (fileContents[startBraceIndex].Contains("function"))
                {
                    startBraceIndex = FindMatchingEndFunctionIndex(startBraceIndex, fileContents);
                    startBraceIndex++;
                }

                if (fileContents[startBraceIndex].Contains("{"))
                {
                    endBraceIndex = FindMatchingEndBraceIndex(startBraceIndex, fileContents);

                    string[] singleDeclaration = ParseOutMatchingBraces(fileContents, startBraceIndex, endBraceIndex);

                    declarations.Add(singleDeclaration);
                    startBraceIndex = endBraceIndex + 1; // start over on the line after the brace
                }

                if (startBraceIndex == fileContents.Length)
                    break;
            }

            return declarations;
        }

        private static string[] ParseOutMatchingBraces(string[] fileContents, int startBraceIndex, int endBraceIndex)
        {
            string[] singleDeclaration = new string[(endBraceIndex + 1) - startBraceIndex];

            int i = 0;
            for (int y = startBraceIndex; y <= endBraceIndex; y++)
            {
                singleDeclaration[i] = fileContents[y];
                i++;
            }

            return singleDeclaration;
        }

        private static int FindMatchingEndFunctionIndex(int startBraceIndex, string[] lines)
        {
            int endBraceIndex = -1;
            int levelsDeep = 0;
            for (int i = startBraceIndex; i < lines.Length; i++)
            {
                if (lines[i].Contains("if(") ||
                    lines[i].Contains("if ") ||
                    lines[i].Contains("for ") ||
                    lines[i].Contains("function ") ||
                    lines[i].Contains("function("))
                {
                    // Don't go deeper on elseifs
                    if (!lines[i].Contains("elseif"))
                    {
                        levelsDeep++;
                    }
                }

                // Make sure when we find the function "end" string we aren't matching variable names
                // this code makes sure the characters before and after "end" are not alpha chars
                // NOTE: ASCII 65-122 is a-z & A-Z
                int endIndex = lines[i].IndexOf("end");
                bool hasValidAfterChar = ((endIndex == 0 && lines[i].Length == 3) || (lines[i].Length > endIndex + 3 && (lines[i][endIndex + 3] < 65 || lines[i][endIndex + 3] > 122)));
                bool hasValidBeforeChar = (endIndex == 0 || endIndex > 1 && (lines[i][endIndex - 1] < 65 || lines[i][endIndex - 1] > 122));
                if (lines[i].Equals("end", StringComparison.OrdinalIgnoreCase) || (lines[i].Contains("end") && hasValidAfterChar && hasValidBeforeChar))
                {
                    levelsDeep--;
                }

                if (levelsDeep == 0)
                {
                    endBraceIndex = i;
                    break;
                }
            }

            if (endBraceIndex == -1)
                throw new Exception("Could not find the matching end of function");

            return endBraceIndex;
        }

        private static int FindMatchingEndBraceIndex(int startBraceIndex, string[] lines)
        {
            int endBraceIndex = -1;
            int levelsDeep = 0;
            for (int i = startBraceIndex; i < lines.Length; i++)
            {
                // walk through each char to find the beginning and end of each brace
                foreach (char c in lines[i])
                {
                    if (c == '{')
                    {
                        levelsDeep++;
                    }

                    if (c == '}')
                    {
                        levelsDeep--;
                    }
                }

                // Have we found the closing brace yet?
                if (levelsDeep == 0)
                {
                    endBraceIndex = i;
                    break;
                }
            }

            if (endBraceIndex == -1)
                throw new Exception("Could not find the matching end brace");

            return endBraceIndex;
        }
    }
}
