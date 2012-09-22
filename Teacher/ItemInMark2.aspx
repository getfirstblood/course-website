<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemInMark2.aspx.cs" Inherits="ItemInMark2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>批阅简答题</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Label ID="Label1" runat="server" Text="题目："></asp:Label>
        <asp:Label ID="LabelQue" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:Label ID="Label8" runat="server" Text="满分分值："></asp:Label>
        <asp:Label ID="LabelMark" runat="server"></asp:Label>
        <br />
        <asp:Label ID="Label2" runat="server" Text="参考答案："></asp:Label>
        <asp:Label ID="LabelAna" runat="server" Text="Label"></asp:Label>
        <br />
        <asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource1" 
            CellPadding="4" ForeColor="#333333" Width="100%">
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" Width="100%"/>
            <AlternatingItemStyle BackColor="White" Width="100%"/>
            <ItemStyle BackColor="#FFFBD6" ForeColor="#333333" Width="100%"/>
            <SelectedItemStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" Width="100%"/>
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" Width="100%"/>
            <ItemTemplate>
           
                <asp:Label ID="Label3" runat="server" Text="昵称："></asp:Label>
                <asp:Label ID="UserNameLabel" runat="server" Text='<%# Eval("UserName") %>' />
                <br />
                <asp:Label ID="Label4" runat="server" Text="完成时间："></asp:Label>
                <asp:Label ID="DoneTimeLabel" runat="server" Text='<%# Eval("DoneTime") %>' />
                <br />
                <asp:Label ID="Label5" runat="server" Text="答案："></asp:Label>
                <br />
                <asp:TextBox ID="TextBox1" runat="server" Height="39px" ReadOnly="True" 
                    Text='<%# Eval("Answer") %>' TextMode="MultiLine" Width="100%"></asp:TextBox>
                <br />
                <asp:Label ID="Label6" runat="server" Text="教师点评："></asp:Label>
                <br />
                <asp:TextBox ID="TextBox2" runat="server" Height="35px" 
                    Text='<%# Eval("Comment") %>' TextMode="MultiLine" Width="100%"></asp:TextBox>
                <br />
                <asp:Label ID="Label7" runat="server" Text="评分:"></asp:Label>
                <asp:TextBox ID="TextBox3" runat="server" Height="19px" 
                    Text='<%# Eval("ScoreB") %>' Width="51px"></asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                    ControlToValidate="TextBox3" ErrorMessage="RegularExpressionValidator" 
                    ValidationExpression="^[0-9]{1,5}$"></asp:RegularExpressionValidator>
            </ItemTemplate>
        </asp:DataList>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="确  认" 
            Width="73px" Height="25px" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="usp_MarkQB2" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter Name="ExamId" Type="Int32" />
                <asp:Parameter Name="QuestionId" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
