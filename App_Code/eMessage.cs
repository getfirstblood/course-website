using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

/// <summary>
///eMessage 的摘要说明
/// </summary>
namespace System.Web
{
    public class eMessage
    {
        public eMessage()
        {
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }
        public static void UrlTo(string url)
        {
            string temp = "<script language='javascript'>window.location='" + url + "'</script>";
            HttpContext.Current.Response.Write(temp);
        }
        public static void Message(string message)
        {
            string temp = "<script language='javascript'>alert('" + message + "')</script>";
            HttpContext.Current.Response.Write(temp);
        }
        public static void Message(string message, string url)
        {
            string temp = "<script language='javascript'>alert('" + message + "');window.location='" + url + "'</script>";
            HttpContext.Current.Response.Write(temp);
        }
        public static void rMessage(string message)
        {
            string temp = "<script language='javascript'>alert('" + message + "');window.location.href=window.location.href</script>";
            HttpContext.Current.Response.Write(temp);
        }
        public static void Message(Exception e)
        {
        }
        public static void Message(string message, UpdatePanel updatepanel,object ob)
        {
            string temp = "alert('" + message + "')";
            ScriptManager.RegisterStartupScript(updatepanel, ob.GetType(), "updateScript", temp, true);

        }
    }
}
