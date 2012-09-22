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

public partial class ChangeKey : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         this.Title = "密码更改 － 网络信息安全精品课程";
         if (!UserIdentity.IsInRole(UserIdentity.Role.Student) && !UserIdentity.IsInRole(UserIdentity.Role.Teacher) && !UserIdentity.IsInRole(UserIdentity.Role.Admin))
             eMessage.Message("您未登录，不能使用此功能，页面将转到首页！", "../Default.aspx");
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
    protected void btchange_Click(object sender, EventArgs e)
    {
        Validate("changp");
        if (CompareValidator1.IsValid && RequiredFieldValidator1.IsValid && RequiredFieldValidator2.IsValid && RequiredFieldValidator3.IsValid)
        {
            bool temp = false;
            SqlConnection con = new SqlConnection(DealData.constring);
            SqlCommand cmd = new SqlCommand("usp_ChangePassW", con);
            cmd.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar, 50)).Value = Session["UserName"].ToString();
            cmd.Parameters.Add(new SqlParameter("@prpassword", SqlDbType.NVarChar, 50)).Value = PrPaWord.Text;
            cmd.Parameters.Add(new SqlParameter("@newpassword", SqlDbType.NVarChar, 50)).Value = VaNewPa.Text;
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                con.Open();
                if (cmd.ExecuteNonQuery() > 0)
                    temp = true;
            }
            catch (Exception err)
            {
                eMessage.Message(err);
                eMessage.rMessage("数据库连接发生错误");
            }
            finally
            {
                con.Close();
            }
            if (temp)
                eMessage.rMessage("密码更改成功");
            else
                eMessage.rMessage("密码更改失败，可能是原密码错误！");
        }
    }
}
