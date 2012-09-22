using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            welAdm.Visible=false;
            welStu.Visible=false;
            welTea.Visible=false;
            after.Visible = false;
            before.Visible = false;
            if (UserIdentity.IsInRole(UserIdentity.Role.Admin))
            {
                welAdm.Visible = true;
                after.Visible = true;
                lbUser.Text = Session["UserName"].ToString();
            }
            else if (UserIdentity.IsInRole(UserIdentity.Role.Teacher))
            {
                welTea.Visible = true;
                after.Visible = true;
                lbUser.Text = Session["UserName"].ToString();

            }
            else if (UserIdentity.IsInRole(UserIdentity.Role.Student))
            {
                welStu.Visible = true;
                after.Visible = true;
                lbUser.Text = Session["UserName"].ToString();

            }
            else
            {
                before.Visible = true;
            }
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/Default.aspx");
    }
    protected void button2_click(object sender, EventArgs e)
    {
        RequiredFieldValidator1.Validate();
        RequiredFieldValidator2.Validate();
        if (!RequiredFieldValidator2.IsValid || !RequiredFieldValidator1.IsValid)
        {
            if (!RequiredFieldValidator1.IsValid)
                TextBox1.Text = "不能为空！";
            if (!RequiredFieldValidator2.IsValid)
                TextBox2.Text = "不能为空！";
        }
        else
        {
            try
            {
                int i = UserIdentity.Login(TextBox1.Text,TextBox2.Text);
                if (i == 1)
                {
                    if (UserIdentity.IsInRole(UserIdentity.Role.Admin))
                        eMessage.Message("登录成功，欢迎您回来！", "./Teacher/usermanage.aspx");
                    eMessage.Message("登录成功，欢迎您回来！", "./subjectdescribe.aspx");
                }
                else if (i == 0)
                {
                    eMessage.Message("您的帐号还未通过验证，请联系老师！", "./subjectdescribe.aspx");
                }
                else if (i == -1)
                {
                    eMessage.Message("用户名或密码错误，登录失败！", "./subjectdescribe.aspx");
                }
            }
            catch (Exception err)
            {
                eMessage.Message(err);
                eMessage.Message(err.Message, "./subjectdescribe.aspx");
            }
            finally
            { } 
        }
    }
}
