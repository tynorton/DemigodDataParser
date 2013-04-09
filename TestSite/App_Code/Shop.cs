using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Shop
/// </summary>
public class Shop
{
    internal Shop(string name)
    {
        this.Name = name;
    }

    public void AddItem(string itemId, int cost)
    {
        if (null == this.ItemCostDictionary)
        {
            this.ItemCostDictionary = new Dictionary<string, int>();
        }

        if (!this.ItemCostDictionary.ContainsKey(itemId))
        {
            this.ItemCostDictionary.Add(itemId, cost);
        }
    }

    public string Name { get; set; }
    public Dictionary<string, int> ItemCostDictionary { get; set; }
}
