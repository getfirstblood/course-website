<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuestionDetails.aspx.cs" Inherits="QuestionDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>详细信息</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="usp_ShowQuestionDetails" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:QueryStringParameter Name="type" QueryStringField="type" Type="String" />
                <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:DetailsView ID="DetailsView1" runat="server" Width="580px" Style="margin:30px 0 0 0"
            AutoGenerateRows="False" DataSourceID="SqlDataSource1" EmptyDataText="没有记录" 
            EnableTheming="False" EnableViewState="False" HorizontalAlign="Center" 
            ForeColor="#003399" GridLines="Vertical">
            <RowStyle BackColor="White" />
            <Fields>
                <asp:BoundField DataField="Question" HeaderText="题干"
                    SortExpression="Question" >
                    <HeaderStyle Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="A" HeaderText="A" SortExpression="A" />
                <asp:BoundField DataField="B" HeaderText="B" SortExpression="B" />
                <asp:BoundField DataField="C" HeaderText="C" SortExpression="C" />
                <asp:BoundField DataField="D" HeaderText="D" SortExpression="D" />
                <asp:BoundField DataField="Answer" HeaderText="答案" 
                    SortExpression="Answer" />
                <asp:BoundField DataField="LastUsedTime" HeaderText="上次使用时间" 
                    SortExpression="LastUsedTime" />
                <asp:BoundField DataField="CreateTime" HeaderText="添加时间" 
                    SortExpression="CreateTime" />
                <asp:BoundField DataField="Level" HeaderText="分级" SortExpression="Level" />
            </Fields>
            <AlternatingRowStyle BackColor="#CCCCFF" />
        </asp:DetailsView>
        <asp:DetailsView ID="DetailsView2" runat="server" Width="580px" 
            style="margin:30px 0 0 0" EmptyDataText="没有记录" 
            EnableTheming="False" EnableViewState="False" HorizontalAlign="Center" 
            ForeColor="#003399" GridLines="Vertical" AutoGenerateRows="False" 
            DataSourceID="SqlDataSource1">
            <Fields>
                <asp:BoundField DataField="Question" HeaderText="题干" 
                    SortExpression="Question" >
                    <HeaderStyle Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="Answer" HeaderText="参考答案" SortExpression="Answer" />
                <asp:BoundField DataField="Level" HeaderText="评级" SortExpression="Level" />
                <asp:BoundField DataField="CreateTime" HeaderText="添加时间" 
                    SortExpression="CreateTime" />
                <asp:BoundField DataField="LastUsedTime" HeaderText="上次使用时间" 
                    SortExpression="LastUsedTime" />
            </Fields>
            <AlternatingRowStyle BackColor="#CCCCFF" />
        </asp:DetailsView>
    </div>
    </form>
</body>
</html>
