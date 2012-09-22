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

public partial class inform : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            this.Title = "课程通知 - 网络信息安全课程";
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
                if(!IsPostBack)
                    UserIdentity.UpdateTimeStamp(UserIdentity.TimeStamp.Inform);
            }
            else if (UserIdentity.IsInRole(UserIdentity.Role.Teacher))
            {
                PnTeacher.Visible = true;
                if(!IsPostBack)
                    UserIdentity.UpdateTimeStamp(UserIdentity.TimeStamp.Inform);
            }
            else
            {
                PnVistor.Visible = true; ;
            }

    }


}
