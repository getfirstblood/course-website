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

public partial class NewsDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["id"] == null)
            Response.Redirect("~/Inform.aspx");
        PnVistor.Visible = false;
        PnStudent.Visible = false;
        PnTeacher.Visible = false;
        PnAdmin.Visible = false;
        if (UserIdentity.IsInRole(UserIdentity.Role.Admin))
        {
            PnAdmin.Visible = true;
        }
        else if (UserIdentity.IsInRole(UserIdentity.Role.Student))
        {
            PnStudent.Visible = true;
        }
        else if (UserIdentity.IsInRole(UserIdentity.Role.Teacher))
        {
            PnTeacher.Visible = true;
        }
        else
        {
            PnVistor.Visible = true;
        }
    }
}
