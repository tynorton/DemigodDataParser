using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Demigod;

public partial class controls_CharacterStats : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (null != this.ActiveCharacter)
        {
            CharacterStats stats = CharacterStatsManager.CurrentInstance.GetLevelUpBuffs(this.Level, this.ActiveCharacter.BlueprintKey, this.ActiveCharacter.LevelUpBlueprintKey);

            foreach (KeyValuePair<string, BuffValue> kvp in stats.Buffs)
            {
                LiteralControl lc = new LiteralControl(kvp.Key + " - <span id=\"" + kvp.Key + "_span\">" + kvp.Value.StringValue + "</span><br />");
                this.Controls.Add(lc);
            }

            this.c_characterBlueprintId.Value = this.ActiveCharacter.BlueprintKey;
            this.c_levelUpBlueprintId.Value = this.ActiveCharacter.LevelUpBlueprintKey;
        }
    }

    public Character ActiveCharacter { get; set; }
    public int Level { get; set; }
}
