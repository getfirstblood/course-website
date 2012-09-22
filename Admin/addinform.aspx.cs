using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Admin_addinform : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        manage.Visible = false;
        Pnpublic.Visible = false;
        if (DropDownList1.SelectedValue == "0")
        {
            Pnpublic.Visible = true;
            if (!IsPostBack)
            {
                txtDeleteTime.Text = "请选择";
            }
            txtDeleteTime.Enabled = false;
        }
        else
            manage.Visible = true;
        DataBind();

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
    protected void button1_click(object sender, EventArgs e)
    {
        GridViewRow row = (GridViewRow)((Panel)((Button)sender).NamingContainer).NamingContainer;
        ((AjaxControlToolkit.ModalPopupExtender)row.FindControl("ModalPopupExtender1")).Hide();
    }
    protected void btAdd_Click(object sender, EventArgs e)
    {
        RequiredFieldValidator1.Validate();
        RequiredFieldValidator2.Validate();
        RequiredFieldValidator3.Validate();
        if (!RequiredFieldValidator3.IsValid||!RequiredFieldValidator2.IsValid || !RequiredFieldValidator1.IsValid)
            eMessage.Message("请填写完整信息！", UpdatePanel1, this);
        else
        {
            SqlConnection con = new SqlConnection(DealData.constring);
            SqlCommand cmd = new SqlCommand("usp_InsertNews", con);
            cmd.CommandType=CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@Title", SqlDbType.NVarChar, 50)).Value =HttpUtility.HtmlEncode(txtTitle.Text);
            cmd.Parameters.Add(new SqlParameter("@Content", SqlDbType.NText)).Value = HttpUtility.HtmlEncode(txtContent.Text).Replace("\r", "<br>").Replace(" ", "&nbsp;");
            cmd.Parameters.Add(new SqlParameter("@DeleteTime", SqlDbType.DateTime)).Value = Convert.ToDateTime(txtDeleteTime.Text);
            cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar, 50)).Value = Session["UserName"].ToString();
            try
            {
                con.Open();
                if (cmd.ExecuteNonQuery() > 0)
                    eMessage.Message("发布成功！", UpdatePanel1, this);
            }
            catch (SqlException err)
            {
                eMessage.Message(err);
                eMessage.Message("与数据库连接发生故障！详细信息："+err.Message, UpdatePanel1, this);
            }
            finally
            {
                if (con != null)
                    con.Close();
            }
        }
    }
}
