<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Mark.ascx.cs" Inherits="UserControls_WebUserControl" %>
<asp:Label ID="Label1" runat="server" Text="选择一张试卷："></asp:Label>
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
            <ItemStyle Width="80px" />
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
            <ItemStyle Width="120px" />
        </asp:TemplateField>
    </Columns>
</asp:GridView>
<asp:Label ID="Label2" runat="server" Text="试卷阅览（点击某一项进行批改）：" Visible="False"></asp:Label>
<div>
<asp:GridView ID="GridView2" runat="server" AllowPaging="True" 
    AllowSorting="True" 
    DataSourceID="SqlDataSource1" onrowdatabound="GridView2_RowDataBound" 
    PageSize="8" onrowcreated="GridView2_RowCreated" Width="100%">
</asp:GridView>
    <asp:GridView ID="GridView3" runat="server" AllowPaging="True" 
        AllowSorting="True" DataSourceID="SqlDataSource2" 
        onrowcreated="GridView3_RowCreated" onrowdatabound="GridView3_RowDataBound" 
        PageSize="8" Visible="False" style="margin-right: 0px" Width="100%">
    </asp:GridView>
</div>
<p>
    <asp:Button ID="Button2" runat="server" Height="25px" onclick="Button2_Click" 
        Text="按题目归类" Visible="False" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
&nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
    SelectCommand="usp_CalMarks" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="ExamId" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

&nbsp;<asp:SqlDataSource ID="SqlDataSource2" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
    SelectCommand="usp_CalMarks2" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter DefaultValue="" Name="ExamId" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>
<p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</p>
<p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<p>
    &nbsp;</p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<p>
    &nbsp;</p>
<p>
    &nbsp;</p>


