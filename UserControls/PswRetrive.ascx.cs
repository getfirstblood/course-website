using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mail;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;
using System.Net.Mail;
public partial class UserControls_WebUserControl : System.Web.UI.UserControl
{
    static string Ans = "";
    static string Email = "";
    static string UserName = "";
  
    protected void Page_Load(object sender, EventArgs e)
    {
        
        
        Button1.Attributes.Add("style", "visibility:hidden");
        TxtUser.Attributes.Add("onblur", "Javascript:document.getElementById('PswRetrive1_Button1').click(); return document.getElementById('PswRetrive1_LabelQue').innerText='正在载入问题...';");  
   }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = DealData.constring;
        SqlCommand cmd = new SqlCommand("usp_FindPsw", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar, 50)).Value = TxtUser.Text;
        try
        {
            cn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                string Question = reader[0].ToString();
                UserName = TxtUser.Text;
                Ans = reader[1].ToString();
                Email = reader[2].ToString();
                LabelQue.Text = Question;
               
                reader.Close();
            }
            else
            {
                reader.Close();
                
            }
        }
        catch (Exception ex)
        {
            eMessage.Message(ex);
        }
        finally
        {
            cn.Close();
           
        }
        
    }

    protected void BtnSend_Click(object sender, EventArgs e)
    {
        if (TxtAns.Text == Ans && UserName != "")
        {
            string date = System.DateTime.Now.ToString();

            byte[] bytes = System.Text.Encoding.Default.GetBytes(date + "\\" + UserName);
            string strEn = Convert.ToBase64String(bytes);
            string path = Request.Url.ToString();
            path = path.Substring(0, path.LastIndexOf("/") + 1);
            path += "PswReSet.aspx";

            string body = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
            body += "<HTML><HEAD><META http-equiv=Content-Type content=\"text/html; charset=iso-8859-1\">";
            body += "</HEAD><BODY><DIV><FONT face=Arial color=#ff0000 size=3>请点击下面的链接,并重置密码";
            body += "</FONT></DIV> <a href='";
            body += path + "?Code=" + strEn;
            body += "' target='_blank' rel='nofollow'>点我重置密码</a><DIV><FONT face=Arial color=#ff0000 size=3>如无法打开链接，请将下面链接复制进浏览器并打开</FONT> </DIV> <DIV>";
            body += path + "?Code=" + strEn;
            body += "</DIV></BODY></HTML>";
            System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();
            msg.To.Add(Email);
            msg.From = new MailAddress("minister_just@163.com", "Admin", System.Text.Encoding.UTF8);
            msg.Subject = "重置密码:信息安全课程系统";//邮件标题 
            msg.SubjectEncoding = System.Text.Encoding.UTF8;//邮件标题编码 
            msg.Body = body;//邮件内容 
            msg.BodyEncoding = System.Text.Encoding.UTF8; //邮件内容编码 
            msg.IsBodyHtml = true;//是否是HTML邮件 
            msg.Priority = System.Net.Mail.MailPriority.High;//邮件优先级 
            SmtpClient client = new SmtpClient();
            client.Credentials = new System.Net.NetworkCredential("minister_just@163.com", "woshihaoren"); //在zj.com注册的邮箱和密码 
            client.Host = "smtp.163.com";
            client.Port = 25;
            //client.Host = "localhost";
            SqlConnection cn = new SqlConnection();
            try
            {
                
                cn.ConnectionString = DealData.constring;
                SqlCommand cmd = new SqlCommand("usp_UpdatePswReSet", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar, 50)).Value = UserName;
                cmd.Parameters.Add(new SqlParameter("@PswReSet", SqlDbType.DateTime, 50)).Value = date;
                cn.Open();
                if (cmd.ExecuteNonQuery() > 0)
                {
                    client.Send(msg);
                 
                    eMessage.Message("邮件已发送，请注意查收。2秒后重定向至首页！");
                    Response.AddHeader("REFRESH", "2;URL=Default.aspx");
                }

            }
            catch (System.Net.Mail.SmtpException ex)
            {

                eMessage.Message("邮件发送失败，请稍后再试");
                eMessage.Message(ex);         

            }
            finally
            {
                cn.Close();
            }

        }
        else
        {
            eMessage.Message("输入的答案不正确");
        }

    }
}
