<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>登录 － 网络信息安全精品课程</title>
        <link href="logincss.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="loginbg">
       <div id="lgbox">
          <p style="line-height:22px;margin:2px 0;padding:0">
           <asp:TextBox ID="txtUsr" runat="server" style="margin:0;padding:0;width:150px"></asp:TextBox><asp:RequiredFieldValidator
               ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" 
               ControlToValidate="txtUsr" Display="Dynamic" ValidationGroup="btlogin"></asp:RequiredFieldValidator>
            </p>
             <p style="line-height:22px;margin:13px 0 0 0;padding:0">
           <asp:TextBox ID="txtPaWord" runat="server" style="margin:0;padding:0;width:150px"
               TextMode="Password"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                   runat="server" ErrorMessage="*" ControlToValidate="txtPaWord" 
               Display="Dynamic" ValidationGroup="btlogin"></asp:RequiredFieldValidator>
           </p>
       </div>
       <div id="lgbutton">
         <p style="margin:0 0 5px 0;padding:0">
         <a style="margin:0;padding:0;font-size:small;">匿名登录</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <a style="margin:0;padding:0;font-size:small;">取回密码</a>
         </p>
         <p style="margin:5px 0 0 0;padding:0; width: 189px; height: 25px;">
           <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
               Style="cursor:pointer; background-image:url(images/lgbutton.gif);margin:0 5px 0 0;" Height="22px" 
               Width="74px" BorderWidth="0px" ValidationGroup="btlogin" />
             <asp:Button ID="Button2"
                   runat="server" Text="Button" Width="74px" BorderWidth="0px" Style="cursor:pointer;background-image:url(images/regbutton.gif);margin:0 0 0 10px"
                   Height="22px" onclick="Button2_Click"/>
         </p>
      </div>
    </div>

    </form>
</body>
</html>
