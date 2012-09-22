<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NewsList.ascx.cs" Inherits="UserControls_NewsList" %>
<asp:SqlDataSource ID="SDNewsList" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
    SelectCommand="usp_ShowNews" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
<asp:GridView ID="GVNewsList" runat="server" AllowPaging="True" 
    AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="NewsId" 
    DataSourceID="SDNewsList">
    <Columns>
    <asp:TemplateField HeaderText="标题" SortExpression="Title">
        <ItemStyle Width="500px"/>
        <ItemTemplate>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%#"~/NewsDetails.aspx?id="+Eval("NewsId").ToString()%>'><%#SubStr(Eval("Title").ToString(),20)%></asp:HyperLink> 
        </ItemTemplate>
    </asp:TemplateField>
        <asp:BoundField DataField="UserName" HeaderText="发布人" SortExpression="UserName">
            <ItemStyle Width="100px" />
        </asp:BoundField>
        <asp:BoundField DataField="CreateTime" HeaderText="发布时间" 
            SortExpression="CreateTime">
            <ItemStyle Width="150px" />
        </asp:BoundField>
    </Columns>
</asp:GridView>
