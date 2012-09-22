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

public partial class ExamManage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!UserIdentity.IsInRole(UserIdentity.Role.Teacher) && !UserIdentity.IsInRole(UserIdentity.Role.Admin))
            eMessage.Message("您的权限不匹配此功能，页面将转到首页！", "../Default.aspx");
        this.Title = "考试管理 － 网络信息安全精品课程";
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
            PnVistor.Visible = true; ;
        }
    }
}