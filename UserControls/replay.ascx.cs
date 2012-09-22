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

public partial class UserControls_replay : System.Web.UI.UserControl
{
    public string username;
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void Send_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(DealData.constring);
        SqlCommand cmd = new SqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "usp_InsertReply";
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@topicid", SqlDbType.Int)).Value =Convert.ToInt32(Request.QueryString["TopicId"].ToString());
        cmd.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar)).Value = Session["UserName"].ToString();
        cmd.Parameters.Add(new SqlParameter("@content", SqlDbType.NText)).Value = HttpUtility.HtmlEncode(textbox1.Text).Replace("\r", "<br>").Replace(" ", "&nbsp;");
        cmd.Parameters.Add(new SqlParameter("@creattime", SqlDbType.DateTime)).Value = DateTime.Now;
        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
            DataBind();
            textbox1.Text = "";
        }
        catch (Exception err)
        {
            eMessage.Message(err);
            string temp = "提交过程中发生错误，请稍候重试或联系管理员" + err.Message;
            eMessage.Message(temp,UpdatePanel1,this);
        }
        finally
        {
            if (con.State != ConnectionState.Closed)
                con.Close();
        }

    }
}
