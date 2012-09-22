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
using System.Data.SqlClient;

public partial class Teacher_usermanage : System.Web.UI.Page
{
    public string role;
    public string isva;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!UserIdentity.IsInRole(UserIdentity.Role.Teacher) && !UserIdentity.IsInRole(UserIdentity.Role.Admin))
            eMessage.Message("您的权限不匹配此功能，页面将转到首页！", "../Default.aspx");
        if (UserIdentity.IsInRole(UserIdentity.Role.Teacher))
        {
            SqlDataSource1.SelectCommand = "usp_TShowUser";
            SqlDataSource1.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
            GridView1.Columns[6].Visible = false;
        }
        else
        {
            GridView1.Columns[5].Visible = false;
            SqlDataSource1.SelectCommand = "usp_AShowUser";
            SqlDataSource1.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
        }
        PnVistor.Visible = false;
        PnTeacher.Visible = false;
        PnAdmin.Visible = false;
        if (UserIdentity.IsInRole(UserIdentity.Role.Admin))
        {
            PnAdmin.Visible = true;
        }
        else if (UserIdentity.IsInRole(UserIdentity.Role.Teacher))
        {
            PnTeacher.Visible = true;
        }
        else
        {
            PnVistor.Visible = true; 
        }

        if (!IsPostBack)
            this.Title = "成员管理 - 网络信息安全精品课程";
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int index = GridView1.EditIndex;
        GridViewRow row = GridView1.Rows[index];
        DropDownList isva = (DropDownList)row.FindControl("DropDownList2");
        DropDownList role = (DropDownList)row.FindControl("DropDownList1");
        e.NewValues["IsVa"] = isva.SelectedValue;
        e.NewValues["Role"] = role.SelectedValue;
        eMessage.Message("修改成功！",UpdatePanel1,this);
    }
    protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
    }
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
        DropDownList drop1 = (DropDownList)sender;
        ListItem li1 = new ListItem("学生", "Student");
        if (role == "Student")
        {
            li1.Selected = true;
        }
        drop1.Items.Add(li1);
        ListItem li2 = new ListItem("老师", "Teacher");
        if (role == "Teacher")
        {
            li2.Selected = true;
        }
        drop1.Items.Add(li2);
        if (UserIdentity.IsInRole(UserIdentity.Role.Teacher))
        {
            drop1.Visible = false;
        }
    }
    protected void DropDownList2_DataBound(object sender, EventArgs e)
    {
        DropDownList drop2 = (DropDownList)sender;
        ListItem li4 = new ListItem("已审核", "已审核");
        if (isva == "已审核")
        {
            li4.Selected = true;
        }
        drop2.Items.Add(li4);
        ListItem li5 = new ListItem("未审核", "未审核");
        if (isva == "未审核")
        {
            li5.Selected = true;
        }
        drop2.Items.Add(li5);
    }
    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridViewRow row = GridView1.Rows[e.NewEditIndex];
        Label isvavalue = (Label)row.FindControl("Label3");
        Label rolevalue = (Label)row.FindControl("Label4");
        role = rolevalue.Text;
        isva = isvavalue.Text;
    }
}