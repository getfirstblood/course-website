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

public partial class UserControls_AddQuestion : System.Web.UI.UserControl
{
    private void Message(string me,string url)
    {
        if (this.updatepanel != null)
        {
            eMessage.Message(me, updatepanel,this);
        }
        else
        {
            eMessage.Message(me, url);
        }
    }
    private UpdatePanel _updatepanel=null;
    public UpdatePanel updatepanel
    {
        get
        {
            return _updatepanel;
        }
        set
        {
            _updatepanel = value;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            select.Visible = true;
            ask.Visible = false;
        }
    }
    protected void update_Click(object sender, EventArgs e)
    {

        string temp="";
        for (int i = 0; i < selectanser.Items.Count;i++ )
        {
            if (selectanser.Items[i].Selected)
                temp = temp + selectanser.Items[i].Value;
        }
        if (temp == "")
        {
            Message("请勾选参考答案，可多选","AddQuestion.aspx");
        }
        else
        {
            if (vatxtquestion.IsValid&&vatxtA.IsValid&&vatxtB.IsValid&&vatxtC.IsValid&&vatype.IsValid&&vatag.IsValid)
            {
                SqlConnection con = new SqlConnection(DealData.constring);
                SqlCommand cmd = new SqlCommand("usp_InsertSelect", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@question", SqlDbType.NText)).Value = HttpUtility.HtmlEncode(txtquestion.Text).Replace("\r", "<br>").Replace(" ", "&nbsp;");
                cmd.Parameters.Add(new SqlParameter("@answer", SqlDbType.NVarChar, 50)).Value = temp;
                cmd.Parameters.Add(new SqlParameter("@tag", SqlDbType.NVarChar,50)).Value = HttpUtility.HtmlEncode(txtTag.Text);
                cmd.Parameters.Add(new SqlParameter("@level", SqlDbType.Int)).Value = Convert.ToInt32(selectlevel.SelectedValue);
                if (txtanalysis.Text != null && txtanalysis.Text != "")
                {
                    cmd.Parameters.Add(new SqlParameter("@analysis", SqlDbType.NText)).Value = HttpUtility.HtmlEncode(txtanalysis.Text).Replace("\r", "<br>").Replace(" ", "&nbsp;");
                }
                else
                {
                    cmd.Parameters.Add(new SqlParameter("@analysis", SqlDbType.NText)).Value = "";
                }
                cmd.Parameters.Add(new SqlParameter("@type", SqlDbType.NVarChar, 50)).Value = selecttype.SelectedValue;
                cmd.Parameters.Add(new SqlParameter("@a", SqlDbType.NText)).Value = txtA.Text;
                cmd.Parameters.Add(new SqlParameter("@b", SqlDbType.NText)).Value = txtB.Text;
                cmd.Parameters.Add(new SqlParameter("@c", SqlDbType.NText)).Value = txtC.Text;
                if (txtD.Text != null && txtD.Text != "")
                {
                    cmd.Parameters.Add(new SqlParameter("@d", SqlDbType.NText)).Value = txtD.Text;
                }
                else
                {
                    cmd.Parameters.Add(new SqlParameter("@d", SqlDbType.NText)).Value = "";
                }
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    if (this.updatepanel != null)
                    {
                        eMessage.Message("提交成功！",updatepanel,this);
                    }
                    else
                    {
                        eMessage.Message("提交成功！", "AddQuestion.aspx");
                    }
                }
                catch (Exception err)
                {
                    eMessage.Message(err);
                    Message("提交过程中发生错误，请稍候重试或联系管理员", "AddQuestion.aspx");
                }
                finally
                {
                    if (con.State != ConnectionState.Closed)
                        con.Close();
                }
            }
            else
            {
                //this.savestate();
                Message("请填写完整", "AddQuestion.aspx");
            }
        }

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedValue == "select")
        {
            select.Visible = true;
            ask.Visible = false;
        }
        else
        {
            select.Visible = false;
            ask.Visible = true;
        }
    }
    protected void updateask_Click(object sender, EventArgs e)
    {
        if (vaquestionb.IsValid && vaanserb.IsValid && vaasktype.IsValid&&vatagb.IsValid)
        {
            SqlConnection con = new SqlConnection(DealData.constring);
            SqlCommand cmd = new SqlCommand("usp_InsertAsk", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@question", SqlDbType.NText)).Value = HttpUtility.HtmlEncode(txtquestionb.Text).Replace("\r", "<br>").Replace(" ", "&nbsp;");
            cmd.Parameters.Add(new SqlParameter("@answer", SqlDbType.NText)).Value = HttpUtility.HtmlEncode(txtanserb.Text).Replace("\r", "<br>").Replace(" ", "&nbsp;");
            cmd.Parameters.Add(new SqlParameter("@tag", SqlDbType.NVarChar,50)).Value = HttpUtility.HtmlEncode(txtTagb.Text);
            cmd.Parameters.Add(new SqlParameter("@level", SqlDbType.Int)).Value = Convert.ToInt32(asklevel.SelectedValue);
            if (txtanalysisb.Text != null && txtanalysisb.Text != "")
            {
                cmd.Parameters.Add(new SqlParameter("@analysis", SqlDbType.NText)).Value = HttpUtility.HtmlEncode(txtanalysisb.Text).Replace("\r", "<br>").Replace(" ", "&nbsp;");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@analysis", SqlDbType.NText)).Value = "";
            }
            cmd.Parameters.Add(new SqlParameter("@type", SqlDbType.NVarChar, 50)).Value = asktype.SelectedValue;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                Message("提交成功！","AddQuestion.aspx");
            }
            catch (Exception err)
            {
                eMessage.Message(err);
                Message("提交过程中发生错误，请稍候重试或联系管理员","AddQuestion.aspx");
            }
            finally
            {
                if (con.State != ConnectionState.Closed)
                    con.Close();
            }
        }
        else
        {
            Message("请填写完整的信息", "AddQuestion.aspx");
        }
    }
}
