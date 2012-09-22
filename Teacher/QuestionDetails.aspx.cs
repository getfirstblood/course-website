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

public partial class QuestionDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!UserIdentity.IsInRole(UserIdentity.Role.Teacher) && !UserIdentity.IsInRole(UserIdentity.Role.Admin))
            eMessage.Message("您的权限不匹配此功能，页面将转到首页！", "../Default.aspx");
        if (Request.QueryString["type"] == null)
            Response.Redirect("~/subjectdescribe.aspx");
        string type = Request.QueryString["type"].ToString();
        if (type == "select")
        {
            DetailsView1.Visible = true;
            DetailsView2.Visible = false;
        }
        else if (type == "ask")
        {
            DetailsView1.Visible = false;
            DetailsView2.Visible = true;
        }
    }
}
