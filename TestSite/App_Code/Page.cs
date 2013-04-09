using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;

/// <summary>
/// HeadFirst Page base class
/// </summary>
public class Page : System.Web.UI.Page
{
    protected override void OnPreRender(EventArgs e)
    {
        base.OnPreRender(e);

        // Find <head> and add stylesheet/js references
        Control header = this.FindFirstControlRecursive(this.LowestParent, typeof (HtmlHead));
        if (null == header)
        {
            return;
        }

        foreach (string cssFile in this.CssFiles)
        {
            HtmlGenericControl linkTag = new HtmlGenericControl("link");
            linkTag.Attributes.Add("rel", "stylesheet");
            linkTag.Attributes.Add("type", "text/css");
            linkTag.Attributes.Add("href", cssFile);
            header.Controls.Add(linkTag);
            header.Controls.Add(new LiteralControl("\n"));
        }

        foreach (string jsFile in this.JsFiles)
        {
            HtmlGenericControl scriptTag = new HtmlGenericControl("script");
            scriptTag.Attributes.Add("language", "javascript");
            scriptTag.Attributes.Add("type", "text/javascript");
            scriptTag.Attributes.Add("src", jsFile);
            header.Controls.Add(scriptTag);
            header.Controls.Add(new LiteralControl("\n"));
        }

        this.RenderClientVariables(header);
    }

    ///<summary>
    ///</summary>
    ///<param name="root"></param>
    ///<param name="id"></param>
    ///<returns></returns>
    public Control FindControlRecursive(Control root, string id)
    {
        if (root.ID == id)
        {
            return root;
        }

        return (from Control c in root.Controls select FindControlRecursive(c, id)).FirstOrDefault(t => t != null);
    }

    ///<summary>
    ///</summary>
    ///<param name="root"></param>
    ///<param name="t"></param>
    ///<returns></returns>
    public Control FindFirstControlRecursive(Control root, Type t)
    {
        if (root.GetType() == t)
        {
            return root;
        }

        return (from Control c in root.Controls select FindFirstControlRecursive(c, t)).FirstOrDefault(c2 => c2 != null);
    }

    private Control FindLowestParent()
    {
        Control lowestParent = this;
        while (true)
        {
            if (null == lowestParent.Parent)
            {
                break;
            }

            lowestParent = lowestParent.Parent;
        }

        return lowestParent;
    }

    protected Control LowestParent
    {
        get { return this.FindLowestParent(); }
    }

    private void RenderClientVariables(Control header)
    {
        if (this.ClientVariables.Count > 0)
        {
            HtmlGenericControl clientVarScriptTag = new HtmlGenericControl("script");
            clientVarScriptTag.Attributes.Add("language", "javascript");
            clientVarScriptTag.Attributes.Add("type", "text/javascript");
            clientVarScriptTag.Controls.Add(new LiteralControl("\n"));
            foreach (KeyValuePair<string, string> kvp in this.ClientVariables)
            {
                string varTxt = string.Format("var {0} = '{1}';\n", kvp.Key, kvp.Value);
                clientVarScriptTag.Controls.Add(new LiteralControl(varTxt));
            }
            foreach (string js in this.ClientScriptBlock)
            {
                clientVarScriptTag.Controls.Add(new LiteralControl(js));
            }
            header.Controls.Add(clientVarScriptTag);
            header.Controls.Add(new LiteralControl("\n"));
        }
    }

    ///<summary>
    ///</summary>
    ///<param name="variableName"></param>
    ///<param name="value"></param>
    public void AddClientScriptVariable(string variableName, string value)
    {
        this.ClientVariables.Add(variableName, value);
    }

    ///<summary>
    ///</summary>
    ///<param name="js"></param>
    public void AddClientScript(string js)
    {
        this.ClientScriptBlock.Add(js);
    }

    #region CSS Methods

    ///<summary>
    ///</summary>
    ///<param name="fileName"></param>
    public void AddCssFile(string fileName)
    {
        this.CssFiles.Add(fileName);
    }

    #endregion

    #region JS Methods

    ///<summary>
    ///</summary>
    ///<param name="fileName"></param>
    public void AddJsFile(string fileName)
    {
        this.JsFiles.Add(fileName);
    }

    #endregion

    protected List<string> CssFiles
    {
        get { return m_cssFiles ?? (m_cssFiles = new List<string>()); }
    }

    protected List<string> JsFiles
    {
        get { return m_jsFiles ?? (m_jsFiles = new List<string>()); }
    }

    protected Dictionary<string, string> ClientVariables
    {
        get { return this.m_clientVariables ?? (this.m_clientVariables = new Dictionary<string, string>()); }
    }

    protected List<string> ClientScriptBlock
    {
        get { return this.m_clientScript ?? (this.m_clientScript = new List<string>()); }
    }

    private List<string> m_cssFiles;
    private List<string> m_jsFiles;
    private Dictionary<string, string> m_clientVariables;
    private List<string> m_clientScript;
}