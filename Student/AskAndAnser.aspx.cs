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
using System.Data.SqlClient;
using System.Collections.Specialized;

public partial class AskAndAnser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!UserIdentity.IsInRole(UserIdentity.Role.Student) && !UserIdentity.IsInRole(UserIdentity.Role.Teacher)&&!UserIdentity.IsInRole(UserIdentity.Role.Admin))
            eMessage.Message("您未登录，不能使用此功能，页面将转到首页！", "../Default.aspx");
        if (!IsPostBack)
        {
            DropDownList1.SelectedValue = "view";
            PanelView.Visible = true;
            PanelAdd.Visible = false;
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
        this.Title = "答疑讨论 － 网络信息安全精品课程";
        if (!IsPostBack)
        {
            if(UserIdentity.IsInRole(UserIdentity.Role.Student)||UserIdentity.IsInRole(UserIdentity.Role.Teacher))
                UserIdentity.UpdateTimeStamp(UserIdentity.TimeStamp.Topic);
        }

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedValue == "view")
        {
            PanelView.Visible = true;
            PanelAdd.Visible = false;
        }
        else
        {
            PanelAdd.Visible = true;
            PanelView.Visible = false;
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(DealData.constring);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "insert into Topic(UserName,Title,CreateTime,Content) values(@username,@title,@creattime,@content)";
        cmd.Parameters.Add(new SqlParameter("@title", SqlDbType.NVarChar)).Value = HttpUtility.HtmlEncode(txtTitle.Text);
        cmd.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar)).Value = Session["UserName"].ToString();
        cmd.Parameters.Add(new SqlParameter("@content", SqlDbType.NText)).Value =HttpUtility.HtmlEncode(TextBox1.Text).Replace("\r", "<br>").Replace(" ","&nbsp;"); 
        cmd.Parameters.Add(new SqlParameter("@creattime", SqlDbType.DateTime)).Value = DateTime.Now;
        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            ScriptManager.RegisterClientScriptBlock(PanelAdd, typeof(Panel), "test", "alert('保存成功！');window.location='" + "AskAndAnser.aspx" + "'", true);
        }
        catch (Exception err)
        {
            eMessage.Message(err);
            string temp = "提交过程中发生错误，请稍候重试或联系管理员" + err.Message;
            eMessage.rMessage(temp);
        }
        finally
        {
            if (con.State != ConnectionState.Closed)
                con.Close();
        }
    }
    protected void GridView1_Init(object sender, EventArgs e)
    {
        if (!UserIdentity.IsInRole(UserIdentity.Role.Teacher))
            GridView1.Columns[3].Visible = false;
    }
}
