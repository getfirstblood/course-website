<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Report.ascx.cs" Inherits="UserControls_Report" %>
<p>
<asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
    AutoGenerateColumns="False" 
    onrowdatabound="GridView1_RowDataBound" PageSize="3" Width="100%" 
        onpageindexchanging="GridView1_PageIndexChanging">
    <Columns>
        <asp:TemplateField>
            <HeaderTemplate>
                试卷编号<br />
            </HeaderTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Eval("ExamId") %>' oncommand="LinkButton_Command" 
                    CommandArgument='<%# Eval("ExamId") %>' CommandName="OnClick"></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField>
            <HeaderTemplate>
                试卷名
            </HeaderTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton2" runat="server" Text='<%# Eval("Title") %>' 
                    oncommand="LinkButton_Command" CommandArgument='<%# Eval("ExamId") %>' 
                    CommandName="OnClick"></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="创建时间">
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton3" runat="server" oncommand="LinkButton_Command" 
                    Text='<%# Eval("CreateTime", "{0:yyyy年M月dd日}") %>' CommandArgument='<%# Eval("ExamId") %>' 
                    CommandName="OnClick"></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
</p>
<asp:GridView ID="GridView2" runat="server" AllowPaging="True" 
    AllowSorting="True" CellPadding="4" DataSourceID="SqlDataSource2" 
    ForeColor="#333333" GridLines="None" onrowdatabound="GridView2_RowDataBound" 
    PageSize="20" Width="100%">
    <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
    <AlternatingRowStyle BackColor="White" />
</asp:GridView>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
    SelectCommand="usp_ShowMarks" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="ExamId" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
    Text="导出到EXCEl" />
