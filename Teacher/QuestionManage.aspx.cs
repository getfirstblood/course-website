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

public partial class QuestionManage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!UserIdentity.IsInRole(UserIdentity.Role.Teacher) && !UserIdentity.IsInRole(UserIdentity.Role.Admin))
            eMessage.Message("您的权限不匹配此功能，页面将转到首页！", "../Default.aspx");
        AddQuestion1.updatepanel = UpdatePanel1;
        this.Title = "管理试题 － 网络信息安全精品课程";
        if (!IsPostBack)
        {
            drSelectType.SelectedValue = "1";
            pnManage.Visible = true;
            pnAdd.Visible = false;
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

        
        string[] temp = new string[2];
        temp[1] = "Lock";
        if (drType1.SelectedValue == "select")
        {

            temp[0] = "QuestionAId";
            GVManageQ.DataKeyNames = temp;
        }
        else
        {
            temp[0] = "QuestionBId";
            GVManageQ.DataKeyNames = temp;
        }
    }

    protected void drSelectType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (drSelectType.SelectedValue == "1")
        {
            pnManage.Visible = true;
            pnAdd.Visible = false;
            SDManageQ.DataBind();
        }
        else if (drSelectType.SelectedValue == "2")
        {
            pnAdd.Visible = true;
            pnManage.Visible = false;
            SDManageQ.DataBind();
        }
    }
    protected void drType1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GVManageQ_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName =="lbdelete")
        {
            int i=Convert.ToInt32(e.CommandArgument);
            if (Convert.ToInt32(GVManageQ.DataKeys[i].Values[1].ToString()) > 0)
            {
                ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('此题正在使用中，无法删除！')", true);
            }
            else
            {
                SDManageQ.DeleteCommand = "usp_DeleteQuestion";
                SDManageQ.DeleteCommandType = SqlDataSourceCommandType.StoredProcedure;
                SDManageQ.DeleteParameters.Clear();
                SDManageQ.DeleteParameters.Add("id", DbType.Int32, GVManageQ.DataKeys[i].Values[0].ToString());
                SDManageQ.DeleteParameters.Add("type", DbType.String, drType1.SelectedValue);
                SDManageQ.Delete();
                SDManageQ.DataBind();
            }
        }
    }
    protected void GVManageQ_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            int key = Convert.ToInt32(GVManageQ.DataKeys[e.Row.RowIndex].Values[0].ToString());
            GridViewRow row = (GridViewRow)e.Row;
            string temp = "var st=window.showModalDialog('QuestionDetails.aspx?id=" + key.ToString() + "&type=" + drType1.SelectedValue + "','','dialogHeight=400px;dialogWidth=600px;')";
            ((LinkButton)row.FindControl("lbQDetails")).Attributes.Add("OnClick", temp);
        }
    }
}
