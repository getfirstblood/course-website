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

public partial class SourceOnline : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!UserIdentity.IsInRole(UserIdentity.Role.Student) && !UserIdentity.IsInRole(UserIdentity.Role.Teacher) && !UserIdentity.IsInRole(UserIdentity.Role.Admin))
            eMessage.Message("您的权限不匹配此功能，页面将转到首页！", "../Default.aspx");
         this.Title = "在线课件 － 网络信息安全精品课程";
         if (DropDownList1.SelectedValue == "0")
         {
             PnView.Visible = true;
             PnManage.Visible = false;
         }
         else
         {
             ctUpLoad1.filetype = UserControls_ctUpLoad.FileType.onlinefile;
             PnView.Visible = false;
             PnManage.Visible = true;
         }

             PnVistor.Visible = false;
             PnStudent.Visible = false;
             PnTeacher.Visible = false;
             PnAdmin.Visible = false;
             if (UserIdentity.IsInRole(UserIdentity.Role.Admin))
             {
                 PnAdmin.Visible = true;
             }
             else if (UserIdentity.IsInRole(UserIdentity.Role.Student))
             {
                 PnStudent.Visible = true;
             }
             else if (UserIdentity.IsInRole(UserIdentity.Role.Teacher))
             {
                 PnTeacher.Visible = true;
             }
             else
             {
                 PnVistor.Visible = true; ;
             }

         
    }
    protected void btSearch_Click(object sender, EventArgs e)
    {
        if (txtSearch.Text != null && txtSearch.Text != "")
        {
            SDSourceOnline.SelectParameters.Clear();
            SDSourceOnline.SelectParameters.Add("type", DbType.Int32, "2");
            SDSourceOnline.SelectParameters.Add("tag", DbType.String, txtSearch.Text);
            SDSourceOnline.DataBind();
        }
    }
    protected void GVSourceOnline_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string filename = null;
        string fileurl = null;
        bool state = false;
        if (e.CommandName =="view")
        {
            SqlConnection con = new SqlConnection(DealData.constring);
            SqlCommand cmd = new SqlCommand("usp_OpenSourceOnline", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@sourceid", SqlDbType.Int)).Value = Convert.ToInt32(e.CommandArgument);
            SqlDataReader reader;
            try
            {
                con.Open();
                reader = cmd.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    filename = reader["SourceName"].ToString();
                    fileurl = reader["FileUrl"].ToString();
                }
                reader.Close();
                state = true;
            }
            catch (SqlException err)
            {
                eMessage.Message(err);
                eMessage.rMessage("与数据库连接发生错误，请与管理员联系或稍候再试！");
            }
            finally
            {
                if (con != null)
                    con.Close();
            }
            if (state)
            {
                string requesturl = "~/fileonline/" + filename.Substring(0, filename.LastIndexOf("."))+".html";
                string htmlfileurl = fileurl.Substring(0, fileurl.LastIndexOf(".")) + ".html";
                if (System.IO.File.Exists(htmlfileurl))
                {
                    Response.Redirect(requesturl);
                }
                else
                {
                    DealFile.PptToHtmlFile(fileurl);
                    Response.Redirect(requesturl);
                }

            }
        }
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        //if (DropDownList1.SelectedValue == "0")
        //{
        //    PnView.Visible = true;
        //    PnManage.Visible = false;
        //}
        //else
        //{
        //    PnView.Visible = false;
        //    PnManage.Visible = true;
        //}
    }
}
