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

public partial class UserControls_ctCreateExam : System.Web.UI.UserControl
{
    public Exam exam1 = new Exam();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Rand.Visible = true;
            Hand.Visible = false;
            Delete.Visible = false;
            lbDeleteTime.Text = "请选择";
            lbdeletetime3.Text = "请选择";
            lbEndTime.Text = "请选择";
            lbendtime3.Text = "请选择";
            lbDeleteTime.Enabled = false;
            lbdeletetime3.Enabled = false;
            lbendtime3.Enabled = false;
            lbEndTime.Enabled = false;
            level1.SelectedValue = "1";
            level2.Items.Add(new ListItem("12", "12"));
            level2.SelectedValue = "12";
            level1b.SelectedValue = "1";
            level2b.Items.Add(new ListItem("12", "12"));
            level2b.SelectedValue = "12";
        }
    }
    protected void level1_SelectedIndexChanged(object sender, EventArgs e)
    {
        int i = System.Convert.ToInt32(level1.SelectedValue);
        level2.Items.Clear();
        level2.Items.Add(new ListItem("请选择", "0"));
        for (; i < 13; i++)
        {
            level2.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
    }


    protected void btCreate_Click(object sender, EventArgs e)
    {
        string type = "'exam'";
        int state = 0;
        Exam newExam = new Exam();
        if (vaamark2.IsValid && vaaskmark.IsValid && vaasknum.IsValid && vaasknum2.IsValid && valevel.IsValid && vaselectmark.IsValid && vaselectnum.IsValid && vaselectnum2.IsValid && vasmark2.IsValid && vatime.IsValid && vatime2.IsValid && vatitle.IsValid)
        {
            SqlCommand cmd = new SqlCommand("usp_SelectQA", new SqlConnection(DealData.constring));
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@selectnum", SqlDbType.Int)).Value = Convert.ToInt32(txtNumSelect.Text);
            cmd.Parameters.Add(new SqlParameter("@level1", SqlDbType.Int)).Value = Convert.ToInt32(level1.SelectedValue);
            cmd.Parameters.Add(new SqlParameter("@level2", SqlDbType.Int)).Value = Convert.ToInt32(level2.SelectedValue);
            cmd.Parameters.Add(new SqlParameter("@type", SqlDbType.NVarChar, 50)).Value = type.ToString();
            SqlDataReader reader;
            try
            {
                cmd.Connection.Open();
                reader = cmd.ExecuteReader();
                if (reader != null)
                {
                    while (reader.Read())
                    {
                        newExam.aAddId(Convert.ToInt32(reader["QuestionAId"]), Convert.ToInt32(txtMarkSelect.Text));
                    }
                }
                reader.Close();
                state = 1;
            }
            catch (Exception err)
            {
                eMessage.Message(err);
                ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('从选择题题中提取试题时出错，请联系管理员！')", true);
            }
            finally
            {
                if (cmd.Connection != null)
                    cmd.Connection.Close();
                cmd.Dispose();
            }
            if (state == 1)
            {
                SqlCommand cmd1 = new SqlCommand("usp_SelectQB", new SqlConnection(DealData.constring));
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@asknum", SqlDbType.Int)).Value = Convert.ToInt32(txtNumAsk.Text);
                cmd1.Parameters.Add(new SqlParameter("@level1", SqlDbType.Int)).Value = Convert.ToInt32(level1.SelectedValue);
                cmd1.Parameters.Add(new SqlParameter("@level2", SqlDbType.Int)).Value = Convert.ToInt32(level2.SelectedValue);
                cmd1.Parameters.Add(new SqlParameter("@type", SqlDbType.NVarChar, 50)).Value = "'exam'";
                try
                {
                    cmd1.Connection.Open();
                    reader = cmd1.ExecuteReader();
                    if (reader != null)
                    {
                        while (reader.Read())
                        {
                            newExam.bAddId(Convert.ToInt32(reader["QuestionBId"]), Convert.ToInt32(txtMarkAsk.Text));
                        }
                    }
                    reader.Close();
                    state = 2;

                }
                catch (Exception err)
                {
                    newExam.Clear();
                    eMessage.Message(err);
                    ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('从问答题题库中提取试题时发生错误，请稍候重试或联系管理员！')", true);
                }
                finally
                {
                    if (cmd1.Connection != null)
                        cmd1.Connection.Close();
                }
            }
            if (state == 2)
            {
                SqlCommand cmd2 = new SqlCommand("usp_CreateExam", new SqlConnection(DealData.constring));
                cmd2.CommandType = CommandType.StoredProcedure;
                cmd2.Parameters.Add(new SqlParameter("@title", SqlDbType.NVarChar, 50)).Value = HttpUtility.HtmlEncode(txtTitle.Text);
                cmd2.Parameters.Add(new SqlParameter("@qaid", SqlDbType.VarChar)).Value = newExam.QAId;
                cmd2.Parameters.Add(new SqlParameter("@qbid", SqlDbType.VarChar)).Value = newExam.QBId;
                cmd2.Parameters.Add(new SqlParameter("@amark", SqlDbType.VarChar)).Value = newExam.AMark;
                cmd2.Parameters.Add(new SqlParameter("@bmark", SqlDbType.VarChar)).Value = newExam.BMark;
                cmd2.Parameters.Add(new SqlParameter("@endtime", SqlDbType.DateTime)).Value = Convert.ToDateTime(lbEndTime.Text);
                cmd2.Parameters.Add(new SqlParameter("@deletetime", SqlDbType.DateTime)).Value = Convert.ToDateTime(lbDeleteTime.Text);
                cmd2.Parameters.Add(new SqlParameter("@time", SqlDbType.Int)).Value = Convert.ToInt32(Time.Text);
                try
                {
                    cmd2.Connection.Open();
                    if (cmd2.ExecuteNonQuery() > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('试卷生成成功！')", true);
                        ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "window.location.href='CreateExam.aspx'", true);

                    }
                    else
                        ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('试卷记录插入数据库发生问题，试卷生成失败，请联系管理员！');window.location.href='CreateExam.aspx'", true);
                }
                catch (Exception err)
                {
                    eMessage.Message(err);
                    ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('在将试卷记录保存在数据库过程中打开数据库连接发生错误，试卷生成失败，请联系管理员！');window.location.href='CreateExam.aspx'", true);
                }
                finally
                {
                    if (cmd.Connection != null)
                        cmd.Connection.Close();
                }
            }
            newExam.Clear();

        }
        else
        {
            ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('请填写完整的信息并仔细检查输入！');window.location.href='CreateExam.aspx'", true);
        }
    }
    protected void CreateType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (CreateType.SelectedValue == "Rand")
        {
            Rand.Visible = true;
            Hand.Visible = false;
            Delete.Visible = false;
        }
        else if (CreateType.SelectedValue == "Hand")
        {
            Rand.Visible = false;
            Hand.Visible = true;
            divShowQ.Visible = false;
            Delete.Visible = false;
        }
        else if (CreateType.SelectedValue == "Delete")
        {
            Rand.Visible = false;
            Hand.Visible = false;
            Delete.Visible = true;
        }
    }
    protected void btShow_Click(object sender, EventArgs e)
    {
        if (qutype.SelectedValue == "select")
        {
            DSShowQ.DataBind();
            GVShowQ2.Visible = false;
            GVShowQ.Visible = true;
            divShowQ.Visible = true;
        }
        else if (qutype.SelectedValue == "ask")
        {
            DSShowQ2.DataBind();
            GVShowQ.Visible = false;
            GVShowQ2.Visible = true;
            divShowQ.Visible = true;
        }

    }
    protected void level1b_SelectedIndexChanged(object sender, EventArgs e)
    {
        int i = System.Convert.ToInt32(level1b.SelectedValue);
        level2b.Items.Clear();
        level2b.Items.Add(new ListItem("请选择", "0"));
        for (; i < 13; i++)
        {
            level2b.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
        divShowQ.Visible = false;

    }

    //protected void QuView_onclick(Object sender, EventArgs e)
    //{
    //    ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "window.showModalDialog('QuestionDetails.aspx')", true);
    //}

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
    protected void GVShowQ_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "link")
        {
            string temp = "window.showModalDialog('QuestionDetails.aspx?id=" + e.CommandArgument.ToString() + "&type=select',,'dialogWidth=300px;center=yes;dialogHeight:200px;')";
            ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", temp, true);
        }
    }
    protected void addquestion_Click(object sender, EventArgs e)
    {
        if (Session["handexam"] != null)
            exam1 = (Exam)Session["handexam"];
        if (qutype.SelectedValue == "select")
        {
            foreach (GridViewRow row in GVShowQ.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox cb = (CheckBox)row.Cells[0].FindControl("cbAdd");
                    if (cb.Checked)
                    {
                        TextBox txt = (TextBox)row.Cells[1].FindControl("mark");
                        exam1.aAddId(Convert.ToInt32(GVShowQ.DataKeys[row.RowIndex].Value), Convert.ToInt32(txt.Text));
                    }
                }
            }
        }
        else if (qutype.SelectedValue == "ask")
        {
            foreach (GridViewRow row in GVShowQ2.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox cb = (CheckBox)row.Cells[0].FindControl("cbAdd2");
                    if (cb.Checked)
                    {
                        TextBox txt = (TextBox)row.Cells[1].FindControl("mark2");
                        exam1.bAddId(Convert.ToInt32(GVShowQ2.DataKeys[row.RowIndex].Value), Convert.ToInt32(txt.Text));
                    }
                }
            }
        }
        Session["handexam"] = exam1;
    }
    protected void cbAdd_checkedchanged(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;
        GridViewRow row = (GridViewRow)cb.NamingContainer;
        if (cb.Checked)
        {
            row.Cells[1].FindControl("chmark").Visible = true;
            row.Cells[1].FindControl("lbmark").Visible = false;
        }
        else
        {
            row.Cells[1].FindControl("chmark").Visible = false;
            row.Cells[1].FindControl("lbmark").Visible = true;
        }
    }

    protected void GVShowQ2_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "link")
        {
            //string temp = "window.location.href='QuestionDetails.aspx?id=" + e.CommandArgument.ToString() + "&type=ask'";
            //ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", temp, true);
        }
    }

    protected void cbAdd2_checkedchanged(object sender, EventArgs e)
    {
        CheckBox cb = (CheckBox)sender;
        GridViewRow row = (GridViewRow)cb.NamingContainer;
        if (cb.Checked)
        {
            row.Cells[1].FindControl("chmark2").Visible = true;
            row.Cells[1].FindControl("lbmark2").Visible = false;
        }
        else
        {
            row.Cells[1].FindControl("chmark2").Visible = false;
            row.Cells[1].FindControl("lbmark2").Visible = true;
        }
    }

    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (Session["handexam"] != null)
            exam1 = (Exam)Session["handexam"];
        vatxttitle3.Validate();
        vatxttime3.Validate();
        vatxttime3a.Validate();
        if (vatxttime3a.IsValid && vatxttime3.IsValid && vatxttitle3.IsValid)
        {
            SqlConnection con = new SqlConnection(DealData.constring);
            SqlCommand cmd = new SqlCommand("usp_CreateExam", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@qaid", SqlDbType.VarChar)).Value = exam1.QAId;
            cmd.Parameters.Add(new SqlParameter("@qbid", SqlDbType.VarChar)).Value = exam1.QBId;
            cmd.Parameters.Add(new SqlParameter("@amark", SqlDbType.VarChar)).Value = exam1.AMark;
            cmd.Parameters.Add(new SqlParameter("@bmark", SqlDbType.VarChar)).Value = exam1.BMark;
            cmd.Parameters.Add(new SqlParameter("@time", SqlDbType.VarChar)).Value = Convert.ToInt32(txttime3.Text);
            cmd.Parameters.Add(new SqlParameter("@endtime", SqlDbType.DateTime)).Value = Convert.ToDateTime(lbendtime3.Text);
            cmd.Parameters.Add(new SqlParameter("@deletetime", SqlDbType.DateTime)).Value = Convert.ToDateTime(lbdeletetime3.Text);
            cmd.Parameters.Add(new SqlParameter("@title", SqlDbType.NVarChar, 50)).Value = HttpUtility.HtmlEncode(txttitle3.Text);
            try
            {
                con.Open();
                if (cmd.ExecuteNonQuery() > 0)
                {
                    exam1.Clear();
                    if (Session["handexam"] != null)
                        Session["handexam"] = null;
                    ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('已成功生成试卷！')", true);
                }
            }
            catch (Exception err)
            {
                eMessage.Message(err);
                ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('试卷生成失败，数据库连接发生错误！')", true);
            }
            finally
            {
                if (con != null && con.State != ConnectionState.Closed)
                    con.Close();
            }
        }
        exam1.Clear();
        Session["handexam"] = null;
        Session["QAId"] = null;
        Session["QBId"] = null;
    }
    protected void wizardstep2_OnActivate(object sender, EventArgs e)
    {
        if (Session["handexam"] != null)
            exam1 = (Exam)Session["handexam"];
        lbaCount.Text = exam1.aCount.ToString();
        lbbCount.Text = exam1.bCount.ToString();
        lbTCount.Text = (exam1.aCount + exam1.bCount).ToString();
        lbamark.Text = exam1.aMark.ToString();
        lbbmark.Text = exam1.bMark.ToString();
        lbTmark.Text = (exam1.aMark + exam1.bMark).ToString();
    }

    protected void WizardStep1_activate(object sender, EventArgs e)
    {
        if (qutype.SelectedValue == "select")
        {
            GVShowQ.Visible = true;
            GVShowQ2.Visible = false;
        }
        else if (qutype.SelectedValue == "ask")
        {
            GVShowQ.Visible = false;
            GVShowQ2.Visible = true;
        }
    }
    protected void GVShowQ_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (Session["handexam"] != null)
                exam1 = (Exam)Session["handexam"];
            int key = Convert.ToInt32(GVShowQ.DataKeys[e.Row.RowIndex].Value.ToString());
            GridViewRow row = (GridViewRow)e.Row;
            string temp = "var st=window.showModalDialog('QuestionDetails.aspx?id=" + key.ToString() + "&type=select" + "','','dialogHeight=400px;dialogWidth=600px;')";
            ((LinkButton)row.FindControl("QuView")).Attributes.Add("OnClick", temp);
            int i;
            i = exam1.IsaIn(key);
            if (i >= 0)
            {
                ((CheckBox)row.FindControl("cbAdd")).Checked = true;
                ((TextBox)row.FindControl("mark")).Text = exam1.GetaMark(i).ToString();
                ((Panel)row.FindControl("chmark")).Visible = true;
                ((Label)row.FindControl("lbmark")).Visible = false;
            }
        }

    }
    protected void step3_onactivate(object sender, EventArgs e)
    {
    }

    protected void GVShowQ2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (Session["handexam"] != null)
            exam1 = (Exam)Session["handexam"];
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int key = Convert.ToInt32(GVShowQ2.DataKeys[e.Row.RowIndex].Value.ToString());
            GridViewRow row = (GridViewRow)e.Row;
            string temp = "var st=window.showModalDialog('QuestionDetails.aspx?id=" + key.ToString() + "&type=ask" + "','','dialogHeight=400px;dialogWidth=600px;')";
            ((LinkButton)row.FindControl("QuView2")).Attributes.Add("OnClick", temp);
            int i;
            i = exam1.IsbIn(key);
            if (i >= 0)
            {
                ((CheckBox)row.FindControl("cbAdd2")).Checked = true;
                ((TextBox)row.FindControl("mark2")).Text = exam1.GetbMark(i).ToString();
                ((Panel)row.FindControl("chmark2")).Visible = true;
                ((Label)row.FindControl("lbmark2")).Visible = false;
            }
        }
    }
    protected void GVDelete_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int key = Convert.ToInt32(GVDelete.DataKeys[e.Row.RowIndex].Value.ToString());
            GridViewRow row = (GridViewRow)e.Row;
            string temp = "var st=window.showModalDialog('ExamDetails.aspx?id=" + key.ToString() + "','','dialogHeight=400px;dialogWidth=600px;')";
            ((LinkButton)row.FindControl("lbTitle")).Attributes.Add("OnClick", temp);
        }
    }

    protected void SDmodifya_Selecting1(object sender, SqlDataSourceSelectingEventArgs e)
    {
        if (Session["handexam"] != null)
            exam1 = (Exam)Session["handexam"];
        Session["QAId"] = exam1.QAId;
        if (exam1.aCount == 0)
            e.Cancel = true;
    }
    protected void SDmodifyb_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        if (Session["handexam"] != null)
            exam1 = (Exam)Session["handexam"];
        Session["QBId"] = exam1.QBId;
        if (exam1.bCount == 0)
            e.Cancel = true;
    }

    protected void DLmodifya_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            Label lb = (Label)e.Item.FindControl("itemd");
            if (((DataRowView)e.Item.DataItem).Row["D"] == null || ((DataRowView)e.Item.DataItem).Row["D"].ToString() == "")
                lb.Visible = false;
        }
    }
    protected void DLmodifya_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "btremovea_command")
        {
            if (Session["handexam"] != null)
                exam1 = (Exam)Session["handexam"];
            exam1.removeA(Convert.ToInt32(e.CommandArgument));
            Session["handexam"] = exam1;
            DLmodifya.DataBind();
        }
    }
    protected void DLmodifyb_ItemCommand(object source, DataListCommandEventArgs e)
    {
        if (e.CommandName == "btremoveb_command")
        {
            if (Session["handexam"] != null)
                exam1 = (Exam)Session["handexam"];
            exam1.removeB(Convert.ToInt32(e.CommandArgument));
            Session["handexam"] = exam1;
            DLmodifyb.DataBind();
        }
    }
    protected void divShowQ_PreRender(object sender, EventArgs e)
    {
        if (qutype.SelectedValue == "select")
        {
            GVShowQ.Visible = true;
            GVShowQ2.Visible = false;
        }
        else if (qutype.SelectedValue == "ask")
        {
            GVShowQ.Visible = false;
            GVShowQ2.Visible = true;
        }
    }
    protected void WSmodify_activate(object sender, EventArgs e)
    {
        if (Session["handexam"] != null)
            exam1 = (Exam)Session["handexam"];
        if (exam1.aCount > 0)
        {
            DLmodifya.DataBind();
        }
        else
            DLmodifya.Visible = false;
        if (exam1.bCount > 0)
            DLmodifyb.DataBind();
        else
            DLmodifyb.Visible = false;
    }
}
