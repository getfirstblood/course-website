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

public partial class principles : System.Web.UI.Page
{
    public DataView data;
    public string content;
    protected void Page_Load(object sender, EventArgs e)
    {
            PnVistor.Visible = false;
            PnStudent.Visible = false;
            PnTeacher.Visible = false;
            PnAdmin.Visible = false;
            if (UserIdentity.IsInRole(UserIdentity.Role.Admin))
            {
                PnAdmin.Visible = true;
                btEdit.Visible = true;
            }
            else if (UserIdentity.IsInRole(UserIdentity.Role.Student))
            {
                PnStudent.Visible = true;
                btEdit.Visible = false;
            }
            else if (UserIdentity.IsInRole(UserIdentity.Role.Teacher))
            {
                PnTeacher.Visible = true;
                btEdit.Visible = true;
            }
            else
            {
                PnVistor.Visible = true; ;
                btEdit.Visible = false;
            }

        data = (DataView)SqlDataSource1.Select(new DataSourceSelectArguments());
        if (data.Count == 0)
            content = "无内容";
        else
            content = data.ToTable().Rows[0][0].ToString();
        DataBind();
    }
}
