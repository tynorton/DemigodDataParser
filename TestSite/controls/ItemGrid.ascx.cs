using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Demigod;

public partial class controls_ItemGrid : Headfirst.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (null == this.ActiveCharacter)
        {
            throw new Exception("this.ActiveCharacter cannot be null");
        }

        if (!this.IsPostBack)
        {
            this.BindGrid();
        }

        this.RenderCheckBoxItemMappingJs();
    }

    protected void RenderCheckBoxItemMappingJs()
    {
        this.Page.AddClientScriptVariable("gridId", this.c_itemGrid.ClientID);
        string js = string.Empty;
        js += "$('#' + gridId).hide();\n";
        js += "var o = new Object();\n";
        foreach (GridViewRow row in this.c_itemGrid.Rows)
        {
            CheckBox cb = row.FindControl("c_equipItemCheckBox") as CheckBox;
            HiddenField itemIdHiddenField = row.FindControl("c_equipItemId") as HiddenField;
            EquipmentItem item = ItemMappingManager.CurrentInstance.FindItemByID(itemIdHiddenField.Value);
            js += string.Format("o['{0}'] = '{1}';\n", cb.ClientID, item.ID);
        }
        this.Page.AddClientScript(js);
    }

    private void BindGrid()
    {
        DataView dv = new DataView(this.GetDataTable());
        dv.Sort = this.SortField + (!this.SortAscending ? " DESC" : string.Empty);

        this.c_itemGrid.DataSource = dv;
        this.c_itemGrid.DataBind();
    }

    protected DataTable GetDataTable()
    {
        return this.ListToDataTable<EquipmentItemAffects>(this.ActiveCharacter.GetAllEquipableItemsForDisplay());
    }

    protected void ItemGrid_Sorting(object source, System.Web.UI.WebControls.GridViewSortEventArgs e)
    {
        // Set the column name
        this.SortField = e.SortExpression;
        this.BindGrid();
    }

    protected void ItemGrid_OnPreRender(object sender, EventArgs e)
    {

    }

    protected void ItemGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex > -1)
        {
            DataView dv = this.c_itemGrid.DataSource as DataView;
            string itemName = dv.Table.Rows[e.Row.RowIndex].ItemArray[4].ToString();
            EquipmentItem item = ItemMappingManager.CurrentInstance.FindItemByName(itemName);
            HyperLink itemDetailsLink = e.Row.FindControl("c_itemDetails") as HyperLink;
            CheckBox cb = e.Row.FindControl("c_equipItemCheckBox") as CheckBox;
            HiddenField itemIdHiddenField = e.Row.FindControl("c_equipItemId") as HiddenField;

            if (null != itemIdHiddenField)
            {
                itemIdHiddenField.Value = item.ID;
            }

            string rowOnClick = string.Format("doGridRowClick(this, '{0}');", item.ID);
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onclick", rowOnClick);
            }

            string rowOnMouseOver = string.Format("doGridRowMouseOver(this, '{0}');", item.ID);
            string rowOnMouseOut = string.Format("doGridRowMouseOut(this, '{0}');", item.ID);
            if (null != itemDetailsLink)
            {
                itemDetailsLink.Attributes.Add("onmouseover", rowOnMouseOver);
                itemDetailsLink.Attributes.Add("onmouseout", rowOnMouseOut);
            }

            string checkBoxOnClick = string.Format("doGridRowCheckBoxClick(this, '{0}');", item.ID);
            if (null != cb)
            {
                cb.Attributes.Add("onclick", checkBoxOnClick);
            }
        }
    }

    private void AddCheckBoxItemMappings(CheckBox cb, EquipmentItem item)
    {
        if (null == this.m_checkBoxItemIdMappings)
        {
            this.m_checkBoxItemIdMappings = new Dictionary<string, string>();
        }

        this.m_checkBoxItemIdMappings.Add(cb.ClientID, item.ID);
    }

    private string EscapeJs(string input)
    {
        input = input.Replace("'", "\\'");

        return input;
    }

    private DataTable ListToDataTable<T>(List<T> list)
    {
        DataTable dt = new DataTable();

        // Sort the list of properties by name
        List<PropertyInfo> infoList = new List<PropertyInfo>();
        foreach (PropertyInfo info in typeof(T).GetProperties())
        {
            infoList.Add(info);
        }
        infoList.Sort((pi1, pi2) => string.Compare(pi1.Name, pi2.Name));

        // Add Cost as second column
        PropertyInfo costProperty = infoList.Find(delegate(PropertyInfo pi) { return pi.Name.Equals("Cost"); });
        dt.Columns.Add(new DataColumn(costProperty.Name, costProperty.PropertyType));

        // Add rest of columns
        foreach (PropertyInfo info in infoList)
        {
            if (!dt.Columns.Contains(info.Name))
            {
                dt.Columns.Add(new DataColumn(info.Name, info.PropertyType));
            }
        }

        // Add data
        foreach (T t in list)
        {
            DataRow row = dt.NewRow();
            foreach (PropertyInfo info in infoList)
            {
                row[info.Name] = info.GetValue(t, null);
            }
            dt.Rows.Add(row);
        }
        return dt;
    }

    private string SortField
    {
        get
        {
            object obj = base.ViewState["SortField"];
            if (obj == null)
            {
                return String.Empty;
            }
            return (string)obj;
        }
        set
        {
            if (value == SortField)
            {
                //if ascending change to descending or vice versa.

                this.SortAscending = !this.SortAscending;
            }
            base.ViewState["SortField"] = value;
        }
    }

    private bool SortAscending
    {
        get
        {
            object obj = base.ViewState["SortAscending"];
            if (obj == null)
            {
                return true;
            }
            return (bool)obj;
        }

        set
        {
            base.ViewState["SortAscending"] = value;
        }
    }

    public Character ActiveCharacter { get; set; }

    private Dictionary<string, string> m_checkBoxItemIdMappings;
}
