<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ItemGrid.ascx.cs" Inherits="controls_ItemGrid" %>
<div id="loadingDataDiv">
    Loading Data...
</div>
<asp:GridView runat="server" ID="c_itemGrid" CssClass="itemGrid" AllowSorting="true" Visible="false"
    OnSorting="ItemGrid_Sorting" OnRowDataBound="ItemGrid_RowDataBound" OnPreRender="ItemGrid_OnPreRender">
    <Columns>
        <asp:TemplateField HeaderText="Equip">
            <ItemTemplate>
                <asp:CheckBox ID="c_equipItemCheckBox" runat="server" Enabled="true" CssClass="rowCheckBox" />
                <asp:HiddenField ID="c_equipItemId" runat="server" />
                <br />
                <asp:HyperLink runat="server" ID="c_itemDetails" Text="Item Summary" CssClass="itemSummaryLink" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

<asp:Literal runat="server" ID="c_checkBoxItemMappingsLiteral" />