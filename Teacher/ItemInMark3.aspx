<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemInMark3.aspx.cs" Inherits="ItemInMark3" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>批阅选择题</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="Label1" runat="server" Text="题目："></asp:Label>
        <asp:Label ID="LabelQue" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:Label ID="Label3" runat="server" Text="A:"></asp:Label>
        <asp:Label ID="A" runat="server" Text="Label"></asp:Label>
&nbsp;
        <asp:Label ID="Label5" runat="server" Text="B:"></asp:Label>
        <asp:Label ID="B" runat="server" Text="Label"></asp:Label>
&nbsp;
        <asp:Label ID="Label7" runat="server" Text="C:"></asp:Label>
        <asp:Label ID="C" runat="server" Text="Label"></asp:Label>
&nbsp;
        <asp:Label ID="Label9" runat="server" Text="D:"></asp:Label>
        <asp:Label ID="D" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:Label ID="Label12" runat="server" Text="正确答案："></asp:Label>
        <asp:Label ID="LabelAns" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:Label ID="Label10" runat="server" Text="分值："></asp:Label>
        <asp:Label ID="LabelMark" runat="server" Text="Label"></asp:Label>
        <br />
        <br />
        <asp:DataList ID="DataList1" runat="server" CellPadding="4" 
            DataSourceID="SqlDataSource1" ForeColor="#333333" 
            onitemdatabound="DataList1_ItemDataBound" Width="100%">
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <AlternatingItemStyle BackColor="White" />
            <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <ItemTemplate>
                <asp:Label ID="Label13" runat="server" Text="昵 称 ："></asp:Label>
                <asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' />
                <br />
                &nbsp;<asp:Label ID="Label14" runat="server" Text="考生答案："></asp:Label>
                <asp:Label ID="AnswerLabel" runat="server" Text='<%# Eval("Answer") %>' />
                <asp:Image ID="Image1" runat="server" />
                <br />
                &nbsp;<asp:Label ID="Label15" runat="server" Text="完成时间："></asp:Label>
                <asp:Label ID="DoneTimeLabel" runat="server" Text='<%# Eval("DoneTime") %>' />
                <br />
                <br />
            </ItemTemplate>
        </asp:DataList>
        <br />
        <asp:Button ID="Button1" runat="server" Height="25px" onclick="Button1_Click" 
            Text="关闭窗口" Width="73px" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="usp_MarkQB3" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="ExamId" Type="Int32" />
                <asp:Parameter Name="QuestionId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
