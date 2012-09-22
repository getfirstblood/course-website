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

public partial class subjectdescribe : System.Web.UI.Page
{
    public DataView data;
    public string content;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            this.Title = "课程介绍 - 网络信息安全精品课程";
        PnAdmin.Visible = false;
        PnStudent.Visible = false;
        PnTeacher.Visible = false;
        PnVistor.Visible = false;
        if (UserIdentity.IsInRole(UserIdentity.Role.Admin))
        {
            btEdit.Visible = true;
            PnAdmin.Visible = true;
        }
        else if (UserIdentity.IsInRole(UserIdentity.Role.Student))
        {
           btEdit.Visible = false;
           PnStudent.Visible = true;
        }
        else if (UserIdentity.IsInRole(UserIdentity.Role.Teacher))
        {
             btEdit.Visible = true;
             PnTeacher.Visible = true;
        }
        else
        {
            btEdit.Visible = false;
            PnVistor.Visible = true;
        }

        data = (DataView)SqlDataSource1.Select(new DataSourceSelectArguments());
        if (data.Count == 0)
            content = "无内容";
        else
            content = data.ToTable().Rows[0][0].ToString();
        DataBind();
    }
}
