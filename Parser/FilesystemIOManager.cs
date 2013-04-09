using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace DemigodDataParser
{
    /// <summary>
    /// Wraps the System.IO namespace into more specialized methods for .lua parsing
    /// </summary>
    public class FilesystemIOManager
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="filePath">Full path to the fil to open</param>
        /// <returns>Array of line by line file contents</returns>
        public static string[] GetAllLinesFromFile(string filePath)
        {
            if (!File.Exists(filePath))
                throw new Exception(string.Format("Could not file file {0}", filePath));

            return File.ReadAllLines(filePath, Encoding.UTF8);
        }

        /// <summary>
        /// Creates a dictionary containing line by line file contents
        /// </summary>
        /// <remarks>This will also strip our irrelevant lines like comments or includes</remarks>
        /// <param name="luaDataDirectory">Full path the the directory containing the lua files</param>
        /// <returns>Dictionary of file contents</returns>
        public static Dictionary<string, string[]> GetLUAContentsDictionary(string luaDataDirectory)
        {
            Dictionary<string, string[]> fileContentsDictionary = new Dictionary<string, string[]>();

            string[] luaFiles = Directory.GetFiles(luaDataDirectory);

            foreach (string luaFilePath in luaFiles)
            {
                if (luaFilePath.EndsWith("bp", StringComparison.OrdinalIgnoreCase) || luaFilePath.EndsWith("lua", StringComparison.OrdinalIgnoreCase))
                {
                    FileInfo fi = new FileInfo(luaFilePath);
                    string fileKey = GetFileKeyFromPath(luaFilePath);
                    string[] allLines = File.ReadAllLines(luaFilePath);
                    allLines = TrimIrrelevantLines(allLines);
                    allLines = UnEscape(allLines);
                    fileContentsDictionary.Add(fileKey, allLines);
                }
            }

            return fileContentsDictionary;
        }

        public static List<string> GetDirectoriesRecursive(string path)
        {
            List<string> directories = new List<string>();
            FilesystemIOManager.FindSubDirectories(path, ref directories);

            return directories;
        }

        private static void FindSubDirectories(string path, ref List<string> directories)
        {
            // Recurse into subdirectories of this directory
            string[] subdirectoryEntries = Directory.GetDirectories(path);
            foreach (string subdirectory in subdirectoryEntries)
            {
                directories.Add(subdirectory);
                FindSubDirectories(subdirectory, ref directories);
            }
        }

        #region Helper Methods
        /// <summary>
        /// Takes a full file path and strips directories and the extension
        /// leaving just "fileName"
        /// </summary>
        /// <param name="fullPath">Full path to the file</param>
        /// <returns>fileName string minus the extension</returns>
        private static string GetFileKeyFromPath(string fullPath)
        {
            FileInfo fi = new FileInfo(fullPath);

            return fi.Name.Remove(fi.Name.Length - 4, 4);
        }

        /// <summary>
        /// Remove everything except the "Blueprints"
        /// ie "ItemBlueprint", "ArmyBonusBlueprint", etc
        /// </summary>
        /// <param name="allLines">line by line contents of the .lua files</param>
        /// <returns>Scrubbed version of the input</returns>
        private static string[] TrimIrrelevantLines(string[] allLines)
        {
            List<string> scrubbedContents = new List<string>();
            string currentLine;
            for (int i = 0; i < allLines.Length; i++)
            {
                currentLine = allLines[i].Trim();

                // strip comments and lau includes
                if (currentLine.StartsWith("#") ||
                    currentLine.StartsWith("__moduleinfo.auto_reload = true"))
                {
                    continue;
                }

                bool allWhitespace = true;
                foreach (char c in currentLine) // Check each char to see if there's anything but whitespace
                {
                    if (c != ' ')
                        allWhitespace = false;
                }

                if (allWhitespace)
                    continue;

                // This is a line we care about, add it to the new array
                scrubbedContents.Add(currentLine.Trim());
            }

            return scrubbedContents.ToArray();
        }

        private static string[] UnEscape(string[] allLines)
        {
            for (int i = 0; i < allLines.Length; i++)
            {
                allLines[i] = allLines[i].Replace("\\'", "\'");
            }

            return allLines;
        }
        #endregion
    }
}