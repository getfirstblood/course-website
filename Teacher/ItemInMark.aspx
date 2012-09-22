<%@ Page Language="C#" EnableEventValidation = "false" AutoEventWireup="true" CodeFile="ItemInMark.aspx.cs" Inherits="ItemInMark" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>答卷详细信息 - 网络信息安全精品课程</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" 
            onitemdatabound="DataList1_ItemDataBound" style="margin-bottom: 0px" 
            Width="100%">
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
                <asp:Label ID="Label2" runat="server" Text='<%# Eval("Question") %>'></asp:Label>
                <asp:Label ID="Label3" runat="server" Text='<%# Eval("Mark", "（{0}分）") %>'></asp:Label>
                <br />
                <asp:Label ID="Label1" runat="server" Text="考生答案"></asp:Label>
                ：<br />
                <asp:TextBox ID="TextBox1" runat="server" Height="53px" ReadOnly="True" 
                    Text='<%# Eval("Answer") %>' TextMode="MultiLine" Width="90%"></asp:TextBox>
                <br />
                打分：<asp:TextBox ID="TextBox3" runat="server" Width="44px" 
                    Text='<%# Eval("ScoreB") %>'></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="TextBox3" ErrorMessage="请输入数字" 
                    ValidationExpression="^[0-9]{1,5}$"></asp:RegularExpressionValidator>
                <asp:Label ID="Label5" runat="server" Text='<%# Eval("QBId") %>' 
                    Visible="False"></asp:Label>
                <br />
                点评：<asp:TextBox ID="TextBox2" runat="server" Height="24px" 
                    Text='<%# Eval("Comment") %>' TextMode="MultiLine" Width="90%"></asp:TextBox>
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="usp_MarkQB" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="ExamId" Type="Int32" />
                <asp:Parameter Name="UserName" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="提交" />
        <br />
    
    </div>
    </form>
</body>
</html>
