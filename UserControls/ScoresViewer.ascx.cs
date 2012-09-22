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

public partial class UserControls_ScoresViewer : System.Web.UI.UserControl
{
    DataSet myds = null;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string UserName = Session["UserName"].ToString();
            bind(UserName);
        }
    }
    public void bind(string UserName)
    {
        SqlConnection sqlcon = new SqlConnection();
        SqlCommand sqlcom;
        sqlcon.ConnectionString = DealData.constring;
        sqlcom = new SqlCommand("usp_ShowExamsForStu", sqlcon);
        sqlcom.CommandType = CommandType.StoredProcedure;
        sqlcom.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar, 50)).Value = UserName;
        SqlDataAdapter myda = new SqlDataAdapter(sqlcom);
        DataSet myds = new DataSet();
        try
        {
            sqlcon.Open();
            myda.Fill(myds, "表");
            GridView1.DataSource = myds;
            Session["scoreds"] = myds;
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
            
            int ExamId = int.Parse(e.CommandArgument.ToString());
            SqlDataSource1.SelectParameters["ExamId"].DefaultValue = e.CommandArgument.ToString();
            SqlDataSource1.SelectParameters["UserName"].DefaultValue = Session["UserName"].ToString();
            SqlDataSource2.SelectParameters["UserName"].DefaultValue = Session["UserName"].ToString();
            SqlDataSource2.SelectParameters["ExamId"].DefaultValue = e.CommandArgument.ToString();
            

        }
    }
    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        Label lblStdAns = (Label)e.Item.FindControl("LabelStdAns");
        Label lblAns =(Label)e.Item.FindControl("LabelAns");
        RadioButton RaA = (RadioButton)e.Item.FindControl("A");
        RadioButton RaB = (RadioButton)e.Item.FindControl("B");
        RadioButton RaC = (RadioButton)e.Item.FindControl("C");
        RadioButton RaD = (RadioButton)e.Item.FindControl("D");
        Image ImA = (Image)e.Item.FindControl("Image1");
        Image ImB = (Image)e.Item.FindControl("Image2");
        Image ImC = (Image)e.Item.FindControl("Image3");
        Image ImD = (Image)e.Item.FindControl("Image4");
        foreach (char ans in lblAns.Text)
        {

            switch (ans)
            {
                case 'A':
                    {
                        RaA.Checked = true;
                        RaA.ForeColor = System.Drawing.Color.OrangeRed; ;
                        bool IsWrong = true;
                        foreach (char Stdans in lblStdAns.Text)
                        {
                            if (ans == Stdans)
                            {
                                IsWrong = false;
                            }
                        }
                        if (IsWrong == true)
                        {
                            ImA.ImageUrl = "~/images/wrong.jpg";
                            ImA.Visible = true;
                        }
                        break;
                    }

                case 'B':
                    {
                        RaB.Checked = true;
                        RaB.ForeColor = System.Drawing.Color.OrangeRed; ;
                        bool IsWrong = true;
                        foreach (char Stdans in lblStdAns.Text)
                        {
                            if (ans == Stdans)
                            {
                                IsWrong = false;
                            }
                        }
                        if (IsWrong == true)
                        {
                            ImB.ImageUrl = "~/images/wrong.jpg";
                            ImB.Visible = true;
                        }
                        break;
                    }
                case 'C':
                    {
                        RaC.Checked = true;
                        RaC.ForeColor = System.Drawing.Color.OrangeRed;
                        bool IsWrong = true;
                        foreach (char Stdans in lblStdAns.Text)
                        {
                            if (ans == Stdans)
                            {
                                IsWrong = false;
                            }
                        }
                        if (IsWrong == true)
                        {
                            ImC.ImageUrl = "~/images/wrong.jpg";
                            ImC.Visible = true;
                        }
                        break;
                    }
                case 'D':
                    {
                        RaD.Checked = true;
                        RaD.ForeColor = System.Drawing.Color.OrangeRed;
                        bool IsWrong = true;
                        foreach (char Stdans in lblStdAns.Text)
                        {
                            if (ans == Stdans)
                            {
                                IsWrong = false;
                            }
                        }
                        if (IsWrong == true)
                        {
                            ImD.ImageUrl = "~/images/wrong.jpg";
                            ImD.Visible = true;
                        }
                        break;
                    }
                default: break;
            }
        }

        foreach (char Stdans in lblStdAns.Text)
        {
            switch (Stdans)
            {
                case 'A': ImA.ImageUrl = "~/images/correct.jpg"; ImA.Visible = true; break;
                case 'B': ImB.ImageUrl = "~/images/correct.jpg"; ImB.Visible = true; break;
                case 'C': ImC.ImageUrl = "~/images/correct.jpg"; ImC.Visible = true; break;
                case 'D': ImD.ImageUrl = "~/images/correct.jpg"; ImD.Visible = true; break;
                default: break;
            }
        }

    }
    protected void B_CheckedChanged(object sender, EventArgs e)
    {
        
    }
    protected void DataList2_PreRender(object sender, EventArgs e)
    {
        int totalScore = 0;
        int ScoreA = 0;
        int ScoreB = 0;
        foreach (DataListItem item in DataList2.Items)
        {
            Label lblScore = (Label)item.FindControl("LabelScore");
            ScoreB += int.Parse(lblScore.Text);
        }
        foreach (DataListItem item in DataList1.Items)
        {
            Label lblScore = (Label)item.FindControl("LabelScore");
            ScoreA += int.Parse(lblScore.Text);
        }
        if (ScoreB >= 0)
        {
            totalScore = ScoreB + ScoreA;
            LabelScore1.Text = "选择题得分：" + ScoreA.ToString();
            LabelScore2.Text = "简答题得分：" + ScoreB.ToString();
            LabelScores.Text = "总得分：" + totalScore.ToString();
        }

        else
        {
            LabelScore1.Text = "选择题得分：" + ScoreA.ToString();
            LabelScore2.Text = "简答题得分：" + "（此部分暂未批阅）";
            LabelScores.Text = "总得分：";
        }
    }
    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count == 0)
        {
            LabelScore1.Visible = false;
            LabelScore2.Visible = false;
            LabelScores.Visible = false;
            Response.Write("您还没有试卷记录");
        }
       
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (Session["scoreds"] != null)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataSource = (DataSet)Session["scoreds"];
            GridView1.DataBind();
        }
    }
}
