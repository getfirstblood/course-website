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

public partial class Student_ViewScore : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!UserIdentity.IsInRole(UserIdentity.Role.Student))
            eMessage.Message("您未登录，或者您当前权限不能使用此功能！","../subjectdescribe.aspx");

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
