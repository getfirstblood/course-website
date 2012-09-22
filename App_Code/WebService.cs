using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml.Linq;
using System.Collections.Generic;

/// <summary>
///WebService 的摘要说明
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
//若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消对下行的注释。 
 [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    public WebService () {

        //如果使用设计的组件，请取消注释以下行 
        //InitializeComponent(); 
    }

    [WebMethod]
    public List<Level> GetLevel2ByLevel1(string level1)
    {
        List<Level> level2=new List<Level>();
        int temp = Convert.ToInt32(level1);
        for (int i = temp; i < 13; i++)
            level2.Add(new Level(temp, temp));
        return level2;
    }

    [WebMethod]
    public string[] GetNewChat()
    {
        return ((ChatRoom)Application["ChatRoom"]).NewContent;
    }
    [WebMethod]
    public ChatRoom.nMessage GetTotalChat()
    {
        return ((ChatRoom)Application["ChatRoom"]).TotalContent;
    }
    [WebMethod]
    public ChatRoom.nMember GetOnlineU()
    {
        return ((ChatRoom)Application["ChatRoom"]).Member;
    }
    [WebMethod(EnableSession=true)]
    public void AddNewMessage(string message)
    {
        ChatMessage chatm = new ChatMessage(message, Session["RealName"].ToString());
        ((ChatRoom)Application["ChatRoom"]).AddMessage(chatm);
    }
    [WebMethod(EnableSession = true)]
    public void RemoveUser()
    {
        ((ChatRoom)Application["ChatRoom"]).RemoveMember(Session["RealName"].ToString());
    }
    [WebMethod(EnableSession=true)]
    public Welcome GetWelcome()
    {
        return new Welcome(UserIdentity.GetRole);
    }
}

