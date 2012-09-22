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

public partial class ItemInMark3 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!UserIdentity.IsInRole(UserIdentity.Role.Teacher))
                Response.Redirect("~/Default.aspx");
            if (Request.QueryString["Mark"] == null)
                Response.Write("不能直接打开此页面！");
            Int();
        }
    }
    protected void Int()
    {
        LabelMark.Text = Request.QueryString["Mark"].ToString();
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = DealData.constring;
        SqlCommand cmd = new SqlCommand("usp_ShowMarkQA", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@QuestionId", SqlDbType.Int, Int32.MaxValue)).Value = Request.QueryString["QuestionId"].ToString();
        try
        {
            cn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                LabelQue.Text = reader["Question"].ToString();
                LabelAns.Text = reader["Answer"].ToString();
                A.Text = reader["A"].ToString();
                B.Text = reader["B"].ToString();
                C.Text = reader["C"].ToString();
                if (reader["D"].ToString() != "")
                {
                    D.Text = reader["D"].ToString();
                }
                else
                {
                    D.Visible = false;
                    Label9.Visible = false;
                }
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
        Response.Write("<script language='javascript'>window.close()</script>");
    }

    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        Label lbl = (Label)e.Item.FindControl("AnswerLabel");
        if (lbl.Text == LabelAns.Text)
        {
            Image im = (Image)e.Item.FindControl("Image1");
            im.ImageUrl = "~/images/correct.jpg";
        }
        else
        {
            Image im = (Image)e.Item.FindControl("Image1");
            im.ImageUrl = "~/images/wrong.jpg";
        }
    }
}
