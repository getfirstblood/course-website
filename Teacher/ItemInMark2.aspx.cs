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

public partial class ItemInMark2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!UserIdentity.IsInRole(UserIdentity.Role.Teacher))
                Response.Redirect("~/Default.aspx");
            if (Request.QueryString["Mark"] == null)
                Response.Write("不能直接打开此页面！");
            else
            {
                Int();
            }
        }
    }
    protected void Int()
    {
        LabelMark.Text = Request.QueryString["Mark"].ToString();
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = DealData.constring;
        SqlCommand cmd = new SqlCommand("usp_ShowMarkQB", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@QuestionId", SqlDbType.Int, Int32.MaxValue)).Value = Request.QueryString["QuestionId"].ToString();
        try
        {
            cn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                LabelQue.Text = reader[0].ToString();
                LabelAna.Text = reader[1].ToString();
                reader.Close();
            }

        }
        catch (Exception ex)
        {
            eMessage.Message("连接数据库失败...请稍后再试");
            eMessage.Message(ex);
        }
        finally
        {
            cn.Close();
        }
        SqlDataSource1.SelectParameters["ExamId"].DefaultValue = Request.QueryString["ExamId"].ToString();
        SqlDataSource1.SelectParameters["QuestionId"].DefaultValue = Request.QueryString["QuestionId"].ToString();
    }

  
    protected void Button1_Click(object sender, EventArgs e)
    {
        String Comment = "";
        String Score = "";
        String UserName = "";
        foreach (DataListItem Item in DataList1.Items)
        {
            
            TextBox textScore = (TextBox)Item.FindControl("TextBox3");
            TextBox textComment = (TextBox)Item.FindControl("TextBox2");
            Label lblUserName = (Label)Item.FindControl("UserNameLabel");
            Comment += textComment.Text + ",";
            Score += textScore.Text + ",";
            UserName += lblUserName.Text + ",";
        }
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = DealData.constring;
        SqlCommand cmd = new SqlCommand("usp_UpdateQBAMark2", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar, 50)).Value = UserName;
        cmd.Parameters.Add(new SqlParameter("@ExamId", SqlDbType.Int, int.MaxValue)).Value = Request.QueryString["ExamId"].ToString();
        cmd.Parameters.Add(new SqlParameter("@Comments", SqlDbType.NText, 20000)).Value = Comment;
        cmd.Parameters.Add(new SqlParameter("@QBId", SqlDbType.NVarChar, 4000)).Value = Request.QueryString["QuestionId"].ToString();
        cmd.Parameters.Add(new SqlParameter("@Marks", SqlDbType.NVarChar, 4000)).Value = Score;
        try
        {
            cn.Open();
            if (cmd.ExecuteNonQuery() > 0)
            {
                Response.Write("<script language='javascript'>window.close()</script>");
            }
            else
            {
                eMessage.Message("更新数据失败...请稍后再试");
            }


        }
        catch (Exception ex)
        {
            eMessage.Message("连接数据库失败...请稍后再试");
            eMessage.Message(ex);
        }
        finally
        {
            cn.Close();
        }
    }
}
