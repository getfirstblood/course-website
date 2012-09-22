<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Chat.aspx.cs" Inherits="Chat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
    <script type="text/javascript">
    var k=0;
    
    function textonscroll()
    {
       k=5;
    }
    
    function GetUser()
    {
       WebService.GetOnlineU(dealUser);
    }
    
    function dealUser(result)
    {
       if(result.count>0)
       {
         document.getElementById("UserArea").value=result.member[0];
         for(var n=1;n<result.count;n++)
         {            
            document.getElementById("UserArea").value=document.getElementById("UserArea").innerHTML+"\n"+result.member[n];
         }         
       }
    }
      function GetMessage()
      {
         WebService.GetTotalChat(OnRequestComplete);
      }
      function pageLoad() 
      {
      GetUser();
      GetMessage();
      }
      function OnRequestComplete(result)
      {
         if(result.count>0)
         {
            document.getElementById("MessageArea").value=result.message[0];
            for(var n=1;n<result.count;n++)
            {            
              document.getElementById("MessageArea").value=document.getElementById("MessageArea").innerHTML+result.message[n];
             }
             if(k==0)
             {
               document.getElementById("MessageArea").scrollTop = document.getElementById("MessageArea").scrollHeight;
             }
             else if(k>0&&k<=5)
             {
                k=k-1;
             }
          }
      }
    window.setInterval("GetMessage()",1000);
    window.setInterval("GetUser()",10000);
    
    function addmessage()
    {
       WebService.AddNewMessage(document.getElementById("Message").innerHTML);
       document.getElementById("Message").innerHTML="";
       document.getElementById("Message").focus();
    }
    function window.onbeforeunload() 
    { 
        WebService.RemoveUser(); 
     }
   
    </script>
    </head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Scripts>
          <asp:ScriptReference Path="~/js/webkit.js" />
        </Scripts>
          <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
          </Services>
        </asp:ScriptManager>
    </div>
    <div>
        <table style="width: 600px;height:500px;" align="center">
            <tr>
                <td>
                   <asp:TextBox ID="MessageArea" runat="server" TextMode="MultiLine"  
             ReadOnly="True" onscroll="textonscroll()" Height="380px" Width="480px"></asp:TextBox>  
                </td>
                <td rowspan="3">
                    
                <asp:TextBox ID="UserArea" runat="server" TextMode="MultiLine" ReadOnly="True" 
                        Height="480px" Width="100px" ></asp:TextBox>   
                    
                </td>
            </tr>
            <tr>
                <td>
                <asp:TextBox ID="Message" runat="server" TextMode="MultiLine" Height="60px" 
                        Rows="3" Width="480px" ></asp:TextBox>
    
                </td>
            </tr>
            <tr>
                <td align="center" valign="middle">
                 <input id="Button2" type="button" value="确定" onclick="return addmessage()" 
                        style="float:left;margin:0 auto;" align="middle"/>
   
                </td>
            </tr>
        </table>  
    </div>
    </form>
</body>
</html>
