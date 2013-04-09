<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DetailedEquipmentItemDescription.ascx.cs"
    Inherits="controls_DetailedItemDescription" %>
<div class="detailedItemInfoContainer">
    <div class="headerContainer">
        <h3 class="displayNameHeader">
            <asp:Literal runat="server" ID="c_displayName" />
        </h3>
        <asp:Panel runat="server" ID="c_descriptionsPanel" CssClass="itemDescriptionContainer">
            <asp:Literal runat="server" ID="c_description" />
        </asp:Panel>
    </div>
    <asp:Panel runat="server" ID="c_bonusPanel">
        <b>Bonuses</b>:
        <asp:Repeater runat="server" ID="c_bonusRptr">
            <HeaderTemplate>
                <ul>
            </HeaderTemplate>
            <ItemTemplate>
                <li>
                    <%#Container.DataItem %>
                </li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
    </asp:Panel>
    <asp:Panel runat="server" ID="c_minionBonusPanel">
        <b>Minion Bonuses</b>:
        <asp:Repeater runat="server" ID="c_minionBonusesRptr">
            <HeaderTemplate>
                <ul>
            </HeaderTemplate>
            <ItemTemplate>
                <li>
                    <%#Container.DataItem %></li>
            </ItemTemplate>
            <FooterTemplate>
                </ul>
            </FooterTemplate>
        </asp:Repeater>
    </asp:Panel>
</div>
