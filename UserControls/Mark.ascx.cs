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
using System.IO;
using System.Text;

public partial class UserControls_WebUserControl : System.Web.UI.UserControl
{
    SqlConnection sqlcon = new SqlConnection();
    SqlCommand sqlcom;
    static int ExamId;
    DataSet myds=null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            bind();
           
        }
    }

   
    public void bind()
    {
        
        sqlcon.ConnectionString = DealData.constring;
        sqlcom = new SqlCommand("usp_MarkExam", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter myda = new SqlDataAdapter(sqlcom);
        DataSet myds = new DataSet();
        try
        {
            sqlcon.Open();
            myda.Fill(myds, "表");
            GridView1.DataSource = myds;
            Session["markds"] = myds;
            GridView1.DataKeyNames = new string[] { "ExamId" };
            GridView1.DataBind();

        }
        catch (Exception ex)
        {
            eMessage.Message("连接数据库失败，请稍后再试");
            eMessage.Message(ex);
        }
        finally
        {
            sqlcon.Close();
        }
    }



    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#E6F5FA'");
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#FFFFFF'");
            e.Row.Attributes.Add("style", "cursor: pointer");
        }
    }


   
    protected void LinkButton_Command(object sender, CommandEventArgs e)
    {
        if (e.CommandName == "OnClick")
        {
            
            Label2.Visible = true;
            ExamId = int.Parse(e.CommandArgument.ToString());
            SqlDataSource1.SelectParameters["ExamId"].DefaultValue = e.CommandArgument.ToString();
            SqlDataSource2.SelectParameters["ExamId"].DefaultValue = e.CommandArgument.ToString();
            
            Button2.Visible = true;
            
        }
    }

 
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            
            e.Row.Attributes.Add("onmouseover", "javascript:this.style.backgroundColor='#E6F5FA';");
            e.Row.Attributes.Add("style", "cursor: pointer");
            e.Row.Attributes.Add("onmouseout", "javascript:this.style.backgroundColor='#FFFFFF';this.style.cursor='hand';");
            //LinkButton lblA = (LinkButton)e.Row.FindControl("LinkButton5");
            //LinkButton lblB = (LinkButton)e.Row.FindControl("LinkButton6");
            //LinkButton lbl = (LinkButton)e.Row.FindControl("LinkButton7");
            //LinkButton lblUserName = (LinkButton)e.Row.FindControl("LinkButton4");
            //String UserName = lblUserName.Text;
            //int Total = int.Parse(lblA.Text) + int.Parse(lblB.Text);
            //lbl.Text = Total.ToString();
            
            //e.Row.Cells[5].Text = (int.Parse(e.Row.Cells[3].Text) + int.Parse(e.Row.Cells[4].Text)).ToString();
            string UserName = e.Row.Cells[3].Text;
            string Edit = "showModalDialog('ItemInMark.aspx?ExamId=" + ExamId + "&UserName=" + UserName +"','','dialogWidth=800px;dialogHeight=600px;help:no;status:no')";
            e.Row.Cells[0].Attributes.Add("onclick", Edit);
            e.Row.Cells[1].Attributes.Add("onclick", Edit);
            e.Row.Cells[2].Attributes.Add("onclick", Edit);
            e.Row.Cells[3].Attributes.Add("onclick", Edit);
            e.Row.Cells[4].Attributes.Add("onclick", Edit);
            e.Row.Cells[5].Attributes.Add("onclick", Edit);
            e.Row.Cells[6].Attributes.Add("onclick", Edit);
         
        }
    }

    public string SubStr(string sString, int nLeng)
    {
        if (sString.Length <= nLeng)
        {
            return sString;
        }
        string sNewStr = sString.Substring(0, nLeng);
        sNewStr = sNewStr + "...";
        return sNewStr;
    }

    protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string Context = e.Row.Cells[2].Text;
            e.Row.Cells[2].Text = SubStr(Context,20);
            e.Row.Attributes.Add("onmouseover", "javascript:this.style.backgroundColor='#E6F5FA';");
            e.Row.Attributes.Add("style", "cursor: pointer");
            e.Row.Attributes.Add("onmouseout", "javascript:this.style.backgroundColor='#FFFFFF';this.style.cursor='hand';");
            //LinkButton lblA = (LinkButton)e.Row.FindControl("LinkButton5");
            //LinkButton lblB = (LinkButton)e.Row.FindControl("LinkButton6");
            //LinkButton lbl = (LinkButton)e.Row.FindControl("LinkButton7");
            //LinkButton lblUserName = (LinkButton)e.Row.FindControl("LinkButton4");
            //String UserName = lblUserName.Text;
            //int Total = int.Parse(lblA.Text) + int.Parse(lblB.Text);
            //lbl.Text = Total.ToString();
            string QId = e.Row.Cells[1].Text;
            string Type = e.Row.Cells[5].Text;
            string Mark = e.Row.Cells[4].Text;
            string Edit = "";
            if (Type == "选择题")
            {
                 Edit = "showModalDialog('ItemInMark3.aspx?ExamId=" + ExamId + "&QuestionId=" + QId + "&Mark=" + Mark + "','','dialogWidth=800px;dialogHeight=600px;help:no;status:no')";
            }
            else
            {
                 Edit = "showModalDialog('ItemInMark2.aspx?ExamId=" + ExamId + "&QuestionId=" + QId + "&Mark=" + Mark +  "','','dialogWidth=800px;dialogHeight=600px;help:no;status:no')";
 
            }
            e.Row.Cells[0].Attributes.Add("onclick", Edit);
            e.Row.Cells[1].Attributes.Add("onclick", Edit);
            e.Row.Cells[2].Attributes.Add("onclick", Edit);
            e.Row.Cells[3].Attributes.Add("onclick", Edit);
            e.Row.Cells[4].Attributes.Add("onclick", Edit);
            e.Row.Cells[5].Attributes.Add("onclick", Edit);
            

        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {
        if(Button2.Text == "按题目归类")
        {
            sqlcon.ConnectionString = DealData.constring;
            sqlcom = new SqlCommand("usp_CalMarks", sqlcon);
            sqlcom.CommandType = CommandType.StoredProcedure;
            sqlcom.Parameters.Add(new SqlParameter("@ExamId", SqlDbType.Int, int.MaxValue)).Value = ExamId;
            SqlDataAdapter myda = new SqlDataAdapter(sqlcom);
            DataSet myds = new DataSet();
            sqlcon.Open();
            myda.Fill(myds, "表");
            sqlcon.Close();
            DataTable tb = myds.Tables[0];
            OutExcel(tb, Page);
        }
        else
        {
            sqlcon.ConnectionString = DealData.constring;
            sqlcom = new SqlCommand("usp_CalMarks2", sqlcon);
            sqlcom.CommandType = CommandType.StoredProcedure;
            sqlcom.Parameters.Add(new SqlParameter("@ExamId", SqlDbType.Int, int.MaxValue)).Value = ExamId;
            SqlDataAdapter myda = new SqlDataAdapter(sqlcom);
            DataSet myds = new DataSet();
            sqlcon.Open();
            myda.Fill(myds, "表");
            sqlcon.Close();
            DataTable tb = myds.Tables[0];
            tb.Columns.Remove(tb.Columns[0]);
            OutExcel(tb, Page);
            
        }

    }

    public void OutExcel(DataTable dt, Page page)
    {
        GridView gv = new GridView();
        page.Response.Clear();
        page.Response.Write("<meta http-equiv=Content-Type content=\"text/html; charset=utf-8\">");
        page.Response.AddHeader("content-disposition", "attachment;filename=StudentMarks.xls");
        page.Response.Charset = "GB2312";
        page.Response.ContentType = "application/vnd.xls";
        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        gv.AllowPaging = false;
        gv.AllowSorting = false;
        gv.AutoGenerateDeleteButton = false;
        gv.AutoGenerateEditButton = false;
        gv.AutoGenerateSelectButton = false;
        gv.ShowFooter = false;
        gv.DataSource = dt;
        gv.DataBind();
        gv.RenderControl(htmlWrite);
        page.Response.Write(stringWrite.ToString());
        page.Response.End();
    }


    protected void Button2_Click(object sender, EventArgs e)
    {
        if (Button2.Text == "按题目归类")
        {
        
            GridView2.Visible = false;
            GridView3.Visible = true;
            Button2.Text = "按学生归类";
            
        }
        else
        {
            GridView2.Visible = true;
            GridView3.Visible = false;
            Button2.Text = "按题目归类";
            
        }
    }

    protected void GridView3_RowCreated(object sender, GridViewRowEventArgs e)
    {
      
         if (e.Row.RowType == DataControlRowType.DataRow || 
             e.Row.RowType == DataControlRowType.Header)
         {
             e.Row.Cells[1].Visible = false; 
         } 
        
     
    }

    protected void GridView2_RowCreated(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow ||
            e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[4].Visible = false;
            e.Row.Cells[5].Visible = false;
            e.Row.Cells[6].Visible = false;
        } 
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (Session["markds"] != null)
            myds = (DataSet)Session["markds"];
        GridView1.PageIndex = e.NewPageIndex;
        GridView1.DataSource = myds;
        GridView1.DataBind();
    }
}
