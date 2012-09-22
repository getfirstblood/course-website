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

public partial class SourceShare : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.Title = "资源共享 － 网络信息安全精品课程";
        DropDownList1.Visible = false;
        SourceDownload1.Visible = false;
        SourceManage1.Visible = false;
        ctUpLoad1.Visible = false;
        if(UserIdentity.IsInRole(UserIdentity.Role.Student))
        {
            DropDownList1.Items.Clear();
            DropDownList1.Items.Add(new ListItem("下载资源", "1"));
            DropDownList1.Items.Add(new ListItem("上传资源", "3"));
            DropDownList1.Visible=true;
            SourceManage1.Visible = false;
            if (DropDownList1.SelectedValue == "3")
            {
                ctUpLoad1.Visible = true;
            }
            else if (DropDownList1.SelectedValue == "1")
            {
                SourceDownload1.Visible = true;
            }

        }
        else if (UserIdentity.IsInRole(UserIdentity.Role.Teacher))
        {
            DropDownList1.Visible = true;
            if (DropDownList1.SelectedValue == "1")
                SourceDownload1.Visible = true;
            else if (DropDownList1.SelectedValue == "2")
                SourceManage1.Visible = true;
            else if (DropDownList1.SelectedValue == "3")
                ctUpLoad1.Visible = true;
        }
        else
        {
            Response.Redirect("~/Default.aspx");
        }
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
