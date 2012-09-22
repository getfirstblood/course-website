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

public partial class UserControls_SourceDownload : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            show.Visible = false;
        }
    }

    protected void btshow_Click(object sender, EventArgs e)
    {

            if (txttag.Text != null && txttag.Text.Trim() != "")
            {
                SqlDataSource1.SelectParameters.Add("tag", DbType.String, txttag.Text);
            }
            show.Visible = true;
            GridView1.DataBind();
        
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "btdownload")
        {
            int i = Convert.ToInt32(e.CommandArgument);
            int key = Convert.ToInt32(GridView1.DataKeys[i].Values[0]);
            //DataRowView rowview =(DataRowView)GridView1.Rows[i].DataItem;
            string fileurl = GridView1.DataKeys[i].Values[1].ToString();
            string filename = GridView1.DataKeys[i].Values[2].ToString();
            bool temp=false;
            try
            {
                temp = DealFile.DownLoad(fileurl, filename, GridView1.DataKeys[i].Values[4].ToString());
            }
            catch(Exception err)
            {
                eMessage.Message(err);
                //ScriptManager.RegisterStartupScript(this.UpdatePanel1, this.GetType(), "updateScript", "alert('" + err.Message + "')", true);
            }
            finally
            {}
            if (temp)
            {
                SqlDataSource1.UpdateCommand = "usp_UpdateSourceCount";
                SqlDataSource1.UpdateCommandType = SqlDataSourceCommandType.StoredProcedure;
                SqlDataSource1.UpdateParameters.Add("type", DbType.Int32, drType.SelectedValue);
                SqlDataSource1.UpdateParameters.Add("sourceid", DbType.Int32, key.ToString());
                SqlDataSource1.UpdateParameters.Add("oldcount", DbType.Int32, GridView1.DataKeys[i].Values[3].ToString());
                SqlDataSource1.Update();
                DataBind();
                //GridView1.DataBind();
            }
        }

    }
    protected void drType_SelectedIndexChanged(object sender, EventArgs e)
    {
        show.Visible = false;
    }

    protected void btDelete_oninit(object sender, EventArgs e)
    {
    }
}
