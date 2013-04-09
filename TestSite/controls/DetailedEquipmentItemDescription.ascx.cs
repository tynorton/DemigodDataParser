using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Demigod;

public partial class controls_DetailedItemDescription : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (null != this.Item)
        {
            this.c_displayName.Text = this.UnEscapeString(this.Item.DisplayName);

            if (this.Item.Tooltips.Count > 0)
            {
                this.c_descriptionsPanel.Visible = true;
                this.c_description.Text = this.UnEscapeString(this.Item.Tooltips[0]);

                if (this.Item.Tooltips.Count > 1)
                {
                    throw new Exception(string.Format("Found more than one description for '{0}'", this.Item.DisplayName));
                }
            }

            this.c_bonusPanel.Visible = this.Item.BonusDescriptions.Count > 0;
            this.c_bonusRptr.DataSource = this.Item.BonusDescriptions;
            this.c_bonusRptr.DataBind();
        }
    }

    private string UnEscapeString(string orig)
    {
        orig = orig.Replace(@"\n", "<br />");
        orig = orig.Replace(@"\'", "'");

        return orig;
    }

    public EquipmentItem Item { get; set; }
}
