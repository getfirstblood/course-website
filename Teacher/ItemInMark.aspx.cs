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

public partial class ItemInMark : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if(!UserIdentity.IsInRole(UserIdentity.Role.Teacher))
                Response.Redirect("~/Default.aspx");
            if (Request.QueryString["ExamId"] == null || Request.QueryString["UserName"] == null)
                Response.Write("您不能直接打开此页面！");
            else
            {
                SqlDataSource1.SelectParameters["ExamId"].DefaultValue = Request.QueryString["ExamId"].ToString();
                SqlDataSource1.SelectParameters["UserName"].DefaultValue = Request.QueryString["UserName"].ToString();
                DataList1.DataBind();
            }
        }
       
    }
    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        int nCount = e.Item.ItemIndex + 1;
        String str = "第"+nCount.ToString()+"题:";
        Label lbl = (Label)e.Item.FindControl("Label4");
        lbl.Text = str;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        String QBId = "";
        String Comment = "";
        String Score = "";
        foreach (DataListItem Item in DataList1.Items)
        {
            Label lblQBId = (Label)Item.FindControl("Label5");
            TextBox textScore = (TextBox)Item.FindControl("TextBox3");
            TextBox textComment = (TextBox)Item.FindControl("TextBox2");
            QBId += lblQBId.Text + ",";
            Comment += textComment.Text + ",";
            Score += textScore.Text +",";
           
        }

        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = DealData.constring;
        SqlCommand cmd = new SqlCommand("usp_UpdateQBAMark", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar, 50)).Value = Request.QueryString["UserName"].ToString();
        cmd.Parameters.Add(new SqlParameter("@ExamId", SqlDbType.Int, int.MaxValue)).Value = Request.QueryString["ExamId"].ToString();
        cmd.Parameters.Add(new SqlParameter("@Comments", SqlDbType.NText,20000)).Value = Comment;
        cmd.Parameters.Add(new SqlParameter("@QBId", SqlDbType.NVarChar, 4000)).Value = QBId;
        cmd.Parameters.Add(new SqlParameter("@Marks", SqlDbType.NVarChar, 4000)).Value = Score;
        try
        {
            cn.Open();
            if (cmd.ExecuteNonQuery() > 0)
            {
                Response.Write("<script language='javascript'>window.open('','_parent','');window.close()</script>");
            }
            else
            {
                eMessage.Message("更新数据失败...请稍后再试");
            }
        }
        catch (Exception ex)
        {
            eMessage.Message("无法连接到数据库");
            eMessage.Message(ex);
        }
        finally
        {
            cn.Close(); 
        }
    }
}
