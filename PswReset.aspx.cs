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

public partial class PswReset : System.Web.UI.Page
{
    string UserName = "";
    string TimeEn = "";
    DateTime Time;
    TimeSpan span;
    protected void Page_Load(object sender, EventArgs e)
    {
        //Response.Expires = 0 ;
        //Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
        //Response.AddHeader("pragma","no-cache");
        //Response.AddHeader("cache-control","private");
        //Response.CacheControl="no-cache";
        //Response.Cache.SetCacheability(HttpCacheability.NoCache);
        SqlConnection cn = new SqlConnection();
        string strEn = Request.QueryString["Code"].ToString();
        try
        {
            byte[] bytes = Convert.FromBase64String(strEn);
            strEn = System.Text.Encoding.Default.GetString(bytes);
            int pos = strEn.IndexOf("\\");
            TimeEn = strEn.Substring(0, pos);
           // Response.Write(TimeEn);
            UserName = strEn.Substring(pos + 1);
            cn.ConnectionString = DealData.constring;
            SqlCommand cmd = new SqlCommand("usp_CheckPswReSet", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar, 50)).Value = UserName;
            cn.Open();
            Time = (DateTime)cmd.ExecuteScalar();
            span = System.DateTime.Now.Date - Time;
            if (span.TotalHours > 48 || TimeEn != Time.ToString())
            {
                Response.Redirect("~/Default.aspx");
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("~/Default.aspx");
            eMessage.Message(ex);
        }
        finally
        {
            cn.Close();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (UserName != "" && TextBox2.Text != "" && TextBox1.Text == TextBox2.Text && span.TotalHours < 48 && TimeEn == Time.ToString())
        {
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = DealData.constring;
            SqlCommand cmd = new SqlCommand("usp_UpdatePsw", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar, 50)).Value = UserName;
            cmd.Parameters.Add(new SqlParameter("@Psw", SqlDbType.NVarChar, 50)).Value = TextBox2.Text;
            try
            {
                cn.Open();
                if (cmd.ExecuteNonQuery() > 0)
                {
                    //HttpContext.Current.Response.Buffer = true;
                    //HttpContext.Current.Response.Expires = 0;
                    //HttpContext.Current.Response.ExpiresAbsolute = DateTime.Now.AddDays(-1);
                    //HttpContext.Current.Response.AddHeader("pragma", "no-cache");
                    //HttpContext.Current.Response.AddHeader("cache-control", "private");
                    //HttpContext.Current.Response.CacheControl = "no-cache";
                    eMessage.Message("修改成功。2秒后跳转至首页...");
                    //Response.Redirect("~/Default.aspx");
                    Response.AddHeader("REFRESH", "2;URL=Default.aspx");
                }
            }
            catch (Exception ex)
            {
                eMessage.Message("操作失败，请稍后再试");
                eMessage.Message(ex);
            }
            finally
            {
                cn.Close();
            }
        }
        else
        {
            eMessage.Message("你输入的有误，或页面已过期！");
        }

       
    }
}
