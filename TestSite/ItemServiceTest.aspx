<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemServiceTest.aspx.cs"
    Inherits="unittests_ItemServiceTest" MasterPageFile="~/MasterPage.master" %>

<asp:Content runat="server" ContentPlaceHolderID="ContentPlaceHolder1">

    <script type="text/javascript" language="javascript">
        function getAllItems() 
        {
            Demigod.Services.IItemService.GetAllItems(onMethodCompleted);
        }
         
        function onMethodCompleted(results)
        {
            var nodeId = 1;
            for (var i=0;i<results.length;i++)  
            {
                var row = document.createElement('tr');
                var cell = document.createElement('td');
                cell.innerHTML = results[i].DisplayName;
                row.id = "node-" + nodeId++;
                row.appendChild(cell);
                var table = document.getElementById('itemTable');
                table.appendChild(row);
                
                for (var y=0;y<results[i].BonusDescriptions.length;y++) 
                {
                    var row2 = document.createElement('tr');
                    var cell2 = document.createElement('td');
                    cell2.innerHTML = results[i].BonusDescriptions[y];
                    
                    row2.setAttribute("class", "child-of-" + row.id);
                    row2.setAttribute("id", row.id + "-" + (y + 1));
                    row2.appendChild(cell2);
                    table.appendChild(row2);
                }
            }
        }
        
        $(document).ready(function() 
        { 
            getAllItems();
            
        });
    </script>
    <table class="tbl" id="itemTable">
    </table>
</asp:Content>
