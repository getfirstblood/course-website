<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PswRetrive.ascx.cs" Inherits="UserControls_WebUserControl" %>
<p>
    &nbsp;</p>
<asp:ScriptManager ID="ScriptManager1" runat="server" 
    AsyncPostBackErrorMessage="服务器正忙请稍后再试" AsyncPostBackTimeout="100">
</asp:ScriptManager>
<p>
    <asp:Label ID="Label4" runat="server" Text="用户名："></asp:Label>
&nbsp;
    <asp:TextBox ID="TxtUser" runat="server" Width="124px"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" Height="0px" onclick="Button1_Click" 
        Text="获取提示问题" Width="0px" BorderStyle="None" BorderWidth="0px" />
</p>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Label ID="Label1" runat="server" Text="问题："></asp:Label>
        <asp:Label ID="LabelQue" runat="server"></asp:Label>
    </ContentTemplate>
</asp:UpdatePanel>
<p>
    <asp:Label ID="Label3" runat="server" Text="答案："></asp:Label>
    <asp:TextBox ID="TxtAns" runat="server" Width="218px"></asp:TextBox>
</p>
<asp:Button ID="BtnSend" runat="server" onclick="BtnSend_Click" 
    Text="发送邮件至注册邮箱" Width="185px" Height="52px" />


