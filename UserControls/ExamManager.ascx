<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ExamManager.ascx.cs" Inherits="UserControls_ExamManager" %>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
    SelectCommand="SELECT [ExamId], [Title], [Time], [EndTime] FROM [Exam]" 
    DeleteCommand="DELETE FROM [Exam] WHERE [ExamId] = @ExamId" 
    InsertCommand="INSERT INTO [Exam] ([Title], [Time], [EndTime]) VALUES (@Title, @Time, @EndTime)" 
    UpdateCommand="UPDATE [Exam] SET [Title] = @Title, [Time] = @Time, [EndTime] = @EndTime WHERE [ExamId] = @ExamId">
    <DeleteParameters>
        <asp:Parameter Name="ExamId" Type="Int32" />
    </DeleteParameters>
    <UpdateParameters>
        <asp:Parameter Name="Title" Type="String" />
        <asp:Parameter Name="Time" Type="Int32" />
        <asp:Parameter DbType="Date" Name="EndTime" />
        <asp:Parameter Name="ExamId" Type="Int32" />
    </UpdateParameters>
    <InsertParameters>
        <asp:Parameter Name="Title" Type="String" />
        <asp:Parameter Name="Time" Type="Int32" />
        <asp:Parameter DbType="Date" Name="EndTime" />
    </InsertParameters>
</asp:SqlDataSource>
<asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
    AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ExamId" 
    DataSourceID="SqlDataSource1" Height="288px" Width="492px" 
    onrowdatabound="GridView1_RowDataBound1" 
    onrowcommand="GridView1_RowCommand" BackColor="White" 
    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
    ForeColor="Black" GridLines="Horizontal">
    <Columns>
        <asp:BoundField DataField="ExamId" HeaderText="编号" InsertVisible="False" 
            ReadOnly="True" SortExpression="ExamId" />
        <asp:BoundField DataField="Title" HeaderText="试卷名称" SortExpression="Title">
            <ControlStyle Width="80px" />
        </asp:BoundField>
        <asp:BoundField DataField="Time" DataFormatString="{0}分钟" HeaderText="时间" 
            SortExpression="Time" />
        <asp:BoundField DataField="EndTime" DataFormatString="{0:yyyy年M月dd日}" 
            HeaderText="交卷截止日期" SortExpression="EndTime" />
        <asp:TemplateField HeaderText="交卷截止日期" SortExpression="EndTime">
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" 
                    Text='<%# Eval("EndTime", "{0:yyyy年M月dd日}") %>'></asp:Label>
            </ItemTemplate>
        </asp:TemplateField>


    </Columns>
    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#99CCFF" Font-Bold="True" ForeColor="White" />
    <AlternatingRowStyle BackColor="#DEDEDE" />
</asp:GridView>


