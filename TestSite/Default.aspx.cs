using System;
using System.Web.UI.WebControls;
using Demigod;

public partial class _Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.AddCssFile("static/css/styles.css");

        this.AddJsFile("http://ajax.googleapis.com/ajax/libs/jquery/1.3.2/jquery.min.js");
        this.AddJsFile("static/js/jquery.demigod.js");
        this.AddJsFile("static/js/jquery.dataTables.min.js");

        this.AddClientScriptVariable("characterDropDownId", this.c_characterDropDown.ClientID);
        this.AddClientScriptVariable("levelDropDownId", this.c_levelDropDown.ClientID);

        if (!this.IsPostBack)
        {
            this.c_characterDropDown.DataSource = ItemMappingManager.CurrentInstance.Characters;
            this.c_characterDropDown.DataTextField = "Name";
            this.c_characterDropDown.DataBind();

            for (int i = 1; i <= 20; i++)
            {
                this.c_levelDropDown.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
            this.c_levelDropDown.DataBind();
        }
    }

    private Character m_activeCharacter;
}