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
///ChatRoom 的摘要说明
/// </summary>
public class ChatRoom
{
    private string[] _TotalContent;
    private int _TotalContentC=0;
    public int TotalContentC
    {
        get 
        { 
            return _TotalContentC; 
        }
    }
    public nMessage TotalContent
    {
        get 
        {
            nMessage temp = new nMessage(_TotalContentC, _TotalContent);
            return temp; 
        }
    }

    private string[] _NewContent;
    private int _NewContentC=0;
    public int NewContentC
    {
        get 
        { 
            return _NewContentC; 
        }
    }
    public string[] NewContent
    {
        get
        {
            _NewContentC = 0;
            return _NewContent;
        }
    }

    public int _MemberC;
    
    public string[] _Member;
    public nMember Member
    {
        get
        {
            return new nMember(_MemberC,_Member);
        }
    }
    public void AddMember(string realname)
    {
        if (_MemberC == 1000)
            throw new Exception("聊天室超出最大允许在线人数");
        _Member[_MemberC] = realname;
        _MemberC++;
    }
    public void RemoveMember(string realname)
    {
        int i = IsMemberIn(realname);
        if (i >= 0)
        {
            for (int j = i; j < _MemberC; j++)
                _Member[i] = _Member[i + 1];
            _MemberC--;
        }
    }
    public int IsMemberIn(string realname)
    {
        for (int i = 0; i < _MemberC; i++)
        {
            if (_Member[i] == realname)
                return i;
        }
        return -1;
    }

    public ChatRoom()
	{
        _NewContent = new string[50];
        _NewContentC = 0;
        _TotalContent = new string[100];
        _TotalContentC = 0;
        _MemberC = 0;
        _Member = new string[1000];
	}

    public void AddMessage(ChatMessage message)
    {
        if (_NewContentC == 50)
        {
            for (int i = 0; i < 49; i++)
            {
                _NewContent[i] = _NewContent[i + 1];
            }
            _NewContentC = 49;
        }
        if (_TotalContentC == 100)
        {
            for (int i = 0; i < 99; i++)
                _TotalContent[i] = _TotalContent[i + 1];
            _TotalContentC = 99;
        }
        _NewContent[_NewContentC] = message.MessageDetails;
        _NewContentC++;
        _TotalContent[_TotalContentC] = message.MessageDetails;
        _TotalContentC++;
    }

    public class ChatMember
    {
        public int id;
        public string realname;
        ChatMember(int _id, string _realname)
        {
            id = _id;
            realname = _realname;
        }
    }

    public class nMessage
    {
        public int count;
        public string[] message;
        public nMessage(int _count, string[] _message)
        {
            count = _count;
            message = _message;
        }
    }
    public class nMember
    {
        public int count;
        public string[] member;
        public nMember(int _count, string[] _member)
        {
            count = _count;
            member = _member;
        }
    }
}
