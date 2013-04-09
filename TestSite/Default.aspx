<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default"
    MasterPageFile="~/MasterPage.master" %>

<%@ Register TagPrefix="dg" TagName="DetailedItemDescription" Src="~/controls/DetailedEquipmentItemDescription.ascx" %>
<%@ Register TagPrefix="dg" TagName="CharacterStats" Src="~/controls/CharacterStats.ascx" %>
<%@ Register TagPrefix="dg" TagName="ItemGrid" Src="~/controls/ItemGrid.ascx" %>
<asp:Content runat="server" ContentPlaceHolderID="c_bodyContent">
    <div id="statsContainer">
        <div style="width: 100px;">
            <asp:DropDownList runat="server" ID="c_characterDropDown" onchange="OnCharacterChange()" />
            <b>Level</b>: <asp:DropDownList runat="server" ID="c_levelDropDown" />
        </div>
        <div id="characterStatsContainer">
            <h2 id="characterName"></h2>
        </div>
        <div id="equippedDetailsContainer">
            <ul id="itemsList">
            </ul>
        </div>
    </div>
    <div id="main">
        
    </div>
</asp:Content>
