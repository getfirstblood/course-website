using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

/// <summary>
///Level 的摘要说明
/// </summary>
public class Level
{
    public string _Value;
    public string _Text;
	public Level(int value,int text)
	{
        _Value = value.ToString();
        _Text = text.ToString();
	}
}
