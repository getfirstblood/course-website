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
///ChatMessage 的摘要说明
/// </summary>
public class ChatMessage
{
    private string _Message;
    private DateTime _Time;
    private string _From;
	public ChatMessage()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}
    public ChatMessage(string message, string from)
    {
        _Message = message;
        _From = from;
        _Time=DateTime.Now;
    }
    public string MessageDetails
    {
        get
        {
            return ("\n"+_Time.ToString() + "\t" + _From + "\t说：" + "\n" + _Message);
        }
    }
}
