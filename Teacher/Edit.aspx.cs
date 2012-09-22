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

public partial class Teacher_Edit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["type"] == null)
                Response.Redirect("~/subjectdescribe.aspx");
            else if (Request.QueryString["type"].ToString() == "0")
                this.Title = "编辑 - 课程介绍";
            else if (Request.QueryString["type"].ToString() == "1")
                this.Title = "编辑 - 教学大纲";
            else if (Request.QueryString["type"].ToString() == "2")
                this.Title = "编辑 - 教学日历";
            else if (Request.QueryString["type"].ToString() == "3")
                this.Title = "编辑 - 课程通知";
        }
    }
    protected void edit_Click(object sender, EventArgs e)
    {
        if (Editor1.Value != "" && Editor1.Value != null)
        {
            SqlDataSource1.InsertParameters.Clear();
            SqlDataSource1.InsertParameters.Add("type", DbType.Int32, Request.QueryString["type"].ToString());
            SqlDataSource1.InsertParameters.Add("content", DbType.String, Editor1.Value);
            SqlDataSource1.Insert();
        }
    }
}
