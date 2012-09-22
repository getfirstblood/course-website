<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CreateUser.ascx.cs" Inherits="UserControls_CreateUser" %>
<%@ Register Assembly="WebValidates" Namespace="WebValidates" TagPrefix="cc2" %>
<style type="text/css">
    .style1
    {
    }
    .style2
    {
      width:160px;
    }
</style>
<div id="createuser">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" EnableViewState="False">
   <ContentTemplate>
    <table style="width: 100%;">
        <tr>
            <td class="style1" colspan="2" align="center">
                用户注册              
            </td>
        </tr>
        <tr>
            <td class="style2">
                  用户名：
            </td>
            <td>
                   <asp:TextBox ID="txtUsrReg" runat="server" CssClass="textbox"></asp:TextBox>
   <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
    ControlToValidate="txtUsrReg" Display="Dynamic" ErrorMessage="*" ValidationGroup="createu"></asp:RequiredFieldValidator>
            </td>

        </tr>
        <tr>
            <td class="style2">

            </td>
            <td>
                            <asp:Button ID="Button1" runat="server" Height="21px" onclick="Button1_Click" 
    Text="检测用户名" Width="90px" />

<asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>  
            </td>
        </tr>
                <tr>
            <td class="style2">
              密码： 
            </td>
            <td>
                <asp:TextBox ID="txtPawReg" runat="server" TextMode="Password" CssClass="textbox"></asp:TextBox> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ValidationGroup="createu" ControlToValidate="txtPawReg"></asp:RequiredFieldValidator>
            </td>
        </tr>
                <tr>
            <td class="style2">
               确认密码：
            </td>
            <td>
               <asp:TextBox ID="txtPawRegCnf" CssClass="textbox" runat="server" EnableTheming="True" 
    TextMode="Password"></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2"
        runat="server" ErrorMessage="*" ControlToValidate="txtPawRegCnf" ValidationGroup="createu" Display="Dynamic"></asp:RequiredFieldValidator>
<asp:CompareValidator ID="CompareValidator1" runat="server" 
    ControlToCompare="txtPawReg" ControlToValidate="txtPawRegCnf" 
    ErrorMessage="两次输入的密码不相符" ValidationGroup="createu"></asp:CompareValidator>
            </td>
        </tr>
                <tr>
            <td class="style2">
              学号： 
            </td>
            <td>
               <asp:TextBox ID="txtIdReg" CssClass="textbox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                   ID="RequiredFieldValidator8" ControlToValidate="txtIdReg" ValidationGroup="createu" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
    ControlToValidate="txtIdReg" Display="Dynamic" ErrorMessage="请输入正确的学号" 
    ValidationExpression="^\d{10}$" ValidationGroup="createu"></asp:RegularExpressionValidator>
            </td>
        </tr>
                <tr>
            <td class="style2">
               真实姓名：
            </td>
            <td>
               <asp:TextBox ID="txtNameReg" CssClass="textbox" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                   ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtNameReg" ValidationGroup="createu" ErrorMessage="*"></asp:RequiredFieldValidator>
<asp:RegularExpressionValidator ID="RegularExpressionValidator3" 
    runat="server" ControlToValidate="txtNameReg" Display="Dynamic" 
    ErrorMessage="请输入中文姓名" ValidationGroup="createu" ValidationExpression="^[\u4E00-\u9FA5]{0,}$"></asp:RegularExpressionValidator>
            </td>
        </tr>
                <tr>
            <td class="style2">
              电子邮件： 
            </td>
            <td>
               <asp:TextBox ID="txtEmailReg" runat="server" CssClass="textbox"></asp:TextBox><asp:RequiredFieldValidator
                   ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ValidationGroup="createu" ControlToValidate="txtEmailReg" Display="Dynamic"></asp:RequiredFieldValidator>
<asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="createu" runat="server" 
    ControlToValidate="txtEmailReg" Display="Dynamic" ErrorMessage="电子邮件格式不正确" 
    ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            </td>
        </tr>
                <tr>
            <td class="style2">
               密码找回的问题：
            </td>
            <td>
                <asp:TextBox ID="txtQueReg" runat="server" CssClass="textbox"></asp:TextBox><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txtQueReg" ValidationGroup="createu"></asp:RequiredFieldValidator>
            </td>
        </tr>
                <tr>
            <td class="style2">
              密码找回的答案： 
            </td>
            <td>
               <asp:TextBox ID="txtAnsReg" runat="server" CssClass="textbox"></asp:TextBox><asp:RequiredFieldValidator
                   ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate="txtAnsReg" ValidationGroup="createu" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
        </tr>
         <tr>
            <td class="style2">
               验证码：<asp:TextBox ID="txtCheck" runat="server" Width="60px"></asp:TextBox><asp:RequiredFieldValidator
                   ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtCheck" ErrorMessage="*" ValidationGroup="createu" Display="Dynamic"></asp:RequiredFieldValidator>
            </td>
            <td>
               <cc2:SerialNumber ID="SerialNumber1" runat="server">
                </cc2:SerialNumber>
            </td>
            </tr>
        <tr>
            <td class="style2" align="center" colspan="2">
              <asp:Button ID="BtReg" runat="server" onclick="BtReg_Click" Text="注册" ValidationGroup="createu"/> 
            </td>
        </tr>
    </table>
    </ContentTemplate>
     </asp:UpdatePanel>
</div>
<%--<asp:Image ID="Image1" runat="server" Visible="False" Width="42px" EnableViewState="False"/>
--%>