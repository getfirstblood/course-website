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

public partial class UserControls_ExamManager : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if ((e.Row.RowState == DataControlRowState.Edit) || (e.Row.RowState == (DataControlRowState.Alternate | DataControlRowState.Edit)))
        {
            System.Data.DataRowView drv = (System.Data.DataRowView)e.Row.DataItem;
            DropDownList ddl = (DropDownList)e.Row.Cells[9].FindControl("DropDownList1");
            
          ListItem li = ddl.Items.FindByValue(drv["Type"].ToString());
            li.Selected = true;
        }
    }
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow gvr = this.GridView1.Rows[this.GridView1.EditIndex];
        DropDownList ddl = (DropDownList)gvr.Cells[9].FindControl("DropDownList1");
       
        e.NewValues["Type"] = ddl.SelectedValue;
    }
    protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }

    protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#E6F5FA'");
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#FFFFFF'");
        

            string ExamID = e.Row.Cells[0].Text;
            string Edit = "showModalDialog('ItemsInExam.aspx?ExamId=" + ExamID + "',null,'dialogWidth=800px;dialogHeight=600px;help:no;status:no')";
            e.Row.Cells[0].Attributes.Add("onclick",Edit);
            e.Row.Cells[1].Attributes.Add("onclick",Edit);
            e.Row.Cells[2].Attributes.Add("onclick",Edit);
            e.Row.Cells[3].Attributes.Add("onclick", Edit);

        }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        

    }
}
