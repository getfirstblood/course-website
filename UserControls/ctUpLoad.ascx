<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ctUpLoad.ascx.cs" Inherits="UserControls_ctUpLoad" %>

<table style="width: 100%;" runat="server" id="table1">
    <tr>
        <td style="width:120px">
            资源分类标签：
        </td>
        <td style="width:320px">
            <asp:TextBox ID="txtSrTag" runat="server" Width="311px"></asp:TextBox> 
            <asp:RequiredFieldValidator ID="vatxtSrTag" runat="server" ErrorMessage="*" ControlToValidate="txtSrTag" Display="Dynamic" EnableViewState="False" ValidationGroup="insertsource"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td colspan="2" style="width:440px">
        <asp:FileUpload ID="FileUpload1" runat="server" Width="440px" />
        </td>
    </tr>
    <tr>
        <td align="center" colspan="2" style="width:440px">
        <asp:Button ID="upload" runat="server"
    Text="上传" onclick="upload_Click" ValidationGroup="insertsource" OnClientClick="return CheckWorkFile()"/>
        </td>
    </tr>
</table>

