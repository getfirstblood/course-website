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

public partial class UserControls_SourceManage : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            show.Visible = false;
        }
    }
    protected void btShow_Click(object sender, EventArgs e)
    {
            if (txttag.Text != null && txttag.Text.Trim() != "")
            {
                SqlDataSource1.SelectParameters.Add("tag", DbType.String, txttag.Text);
            }
            show.Visible = true;
            //GridView1.DataBind();
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "btdelete")
        {
            int i =Convert.ToInt32( e.CommandArgument);
            int key =Convert.ToInt32(GridView1.DataKeys[i].Values[0].ToString());
            //DataRowView rowview =(DataRowView)GridView1.Rows[i].DataItem;
            string fileurl = GridView1.DataKeys[i].Values[1].ToString();
            if (drType.SelectedValue == "1")
            {
                if (DealFile.FilePicDelete(fileurl))
                {
                    SqlDataSource1.DeleteCommand = "usp_DeleteSource";
                    SqlDataSource1.DeleteCommandType = SqlDataSourceCommandType.StoredProcedure;
                    SqlDataSource1.DeleteParameters.Add("SourceId", DbType.Int32, key.ToString());
                    SqlDataSource1.DeleteParameters.Add("type", DbType.Int32, drType.SelectedValue);
                    SqlDataSource1.Delete();
                    GridView1.DataBind();
                }
            }
            else if(drType.SelectedValue=="2")
            {
                string pptfile = fileurl.Substring(0, fileurl.LastIndexOf(".")) + ".html";
                string pptfilefolder = fileurl.Substring(0, fileurl.LastIndexOf(".")) + ".files";
                if (DealFile.FilePicDelete(fileurl)&&DealFile.FilePicDelete(pptfile)&&DealFile.DeleteFolder(pptfilefolder))
                {
                    SqlDataSource1.DeleteCommand = "usp_DeleteSource";
                    SqlDataSource1.DeleteCommandType = SqlDataSourceCommandType.StoredProcedure;
                    SqlDataSource1.DeleteParameters.Add("SourceId", DbType.Int32, key.ToString());
                    SqlDataSource1.DeleteParameters.Add("type", DbType.Int32, drType.SelectedValue);
                    SqlDataSource1.Delete();
                    GridView1.DataBind();
                }
            }
        }

    }
    protected void drType_SelectedIndexChanged(object sender, EventArgs e)
    {
        show.Visible = false;
    }
}
