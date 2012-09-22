<%@ Page Language="C#" AutoEventWireup="true" validateRequest=false CodeFile="Edit.aspx.cs" Inherits="Teacher_Edit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>编辑</title>
        <script src="../Kinde/kindeditor.js" type="text/javascript"></script>

    <script type="text/javascript">
    KE.show({
        id : '<%=Editor1.ClientID %>',
        urlType : 'absolute',
        allowFileManager : true,
        imageUploadJson: "../../Handler/uploadimg.ashx",
        filterMode:true
    });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width:840px;margin:0 auto;height:450px">
      <p><textarea id="Editor1" cols="20" rows="2" runat="server" style="width:795px;height:500px;"></textarea></p>
      <p style="width:50px;margin:5px auto;"><asp:Button ID="edit" runat="server" Text="确定" OnClick="edit_Click"/></p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        InsertCommand="usp_InsertEdit" InsertCommandType="StoredProcedure" 
        ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>"></asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
