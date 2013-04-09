using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

public partial class unittests_ItemServiceTest : Headfirst.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.AddJsFile("http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js");
        this.AddJsFile("http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js");
    }
}
