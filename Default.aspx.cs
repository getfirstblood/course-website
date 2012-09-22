using System;
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

public partial class _Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (RequiredFieldValidator1.IsValid && RequiredFieldValidator2.IsValid)
        {
            try
            {
                int i = UserIdentity.Login(txtUsr.Text, txtPaWord.Text);
                if (i == 1)
                {
                    if(UserIdentity.IsInRole(UserIdentity.Role.Admin))
                        eMessage.Message("登录成功，欢迎您回来！", "./Teacher/usermanage.aspx");
                    eMessage.Message("登录成功，欢迎您回来！", "./subjectdescribe.aspx");
                }
                else if (i == 0)
                {
                    eMessage.Message("您的帐号还未通过验证，请联系老师！", "Default.aspx");
                }
                else if (i == -1)
                {
                    eMessage.Message("用户名或密码错误，登录失败！", "Default.aspx");
                }
            }
            catch (Exception err)
            {
                eMessage.Message(err);
                eMessage.Message(err.Message, "Default.aspx");
            }
            finally
            { }
        }
        else
            return;

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/CreateUser.aspx");
    }
}

