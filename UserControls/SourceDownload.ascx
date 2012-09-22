<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SourceDownload.ascx.cs" Inherits="UserControls_SourceDownload" %>

<%--<%Server.ScriptTimeout = 300;%>
--%>    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>--%>
<table style="width: 100%;">
    <tr>
        <td style="width:80px">
            类型：
        </td>
        <td style="width:500px">
            <asp:DropDownList ID="drType" runat="server" 
                onselectedindexchanged="drType_SelectedIndexChanged" AutoPostBack="True">
                <asp:ListItem Value="1">共享资源</asp:ListItem>
                <asp:ListItem Value="2">在线资源</asp:ListItem>
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
    <td>
      关键字搜索：
    </td>
    <td>
        <asp:TextBox ID="txttag" runat="server" Wrap="False"></asp:TextBox>(选填)
    </td>
    </tr>
    <tr>
     <td>
     
     </td>
     <td align="center">
         <asp:Button ID="btshow" runat="server" Text="确定" onclick="btshow_Click" />
     </td>
    </tr>
</table>
<asp:Panel runat="server" ID="show">
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="usp_ShowSource" SelectCommandType="StoredProcedure" 
        UpdateCommand=" ">
    <SelectParameters>
        <asp:ControlParameter ControlID="drType" DefaultValue="1" Name="type" 
            PropertyName="SelectedValue" Type="Int32" />
     </SelectParameters>
    </asp:SqlDataSource>

<asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" 
        AutoGenerateColumns="False" DataSourceID="SqlDataSource1" HorizontalAlign="Left" 
        PageSize="15" onrowcommand="GridView1_RowCommand" 
        DataKeyNames="SourceId,FileUrl,SourceName,Count,FileFormate" 
        >
    <Columns>
        <asp:BoundField DataField="SourceName" HeaderText="资源名称" HtmlEncode="False" 
            HtmlEncodeFormatString="False" InsertVisible="False">
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle Width="200px" Wrap="False" />
        </asp:BoundField>
        <asp:TemplateField SortExpression="Size">
           <HeaderTemplate>
             大小(K)
           </HeaderTemplate>
           <ItemTemplate>
             <%#Convert.ToInt32(Eval("Size"))/1024 %>
           </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Tag" HeaderText="分类标签" HtmlEncode="False" 
            HtmlEncodeFormatString="False" InsertVisible="False">
            <ItemStyle Width="100px" />
        </asp:BoundField>
        <asp:BoundField DataField="UserName" HeaderText="上传人" HtmlEncode="False" 
            HtmlEncodeFormatString="False" InsertVisible="False">
            <ItemStyle Width="100px" Wrap="False" />
        </asp:BoundField>
        <asp:BoundField DataField="UpdateTime" HeaderText="上传时间" HtmlEncode="False" 
            HtmlEncodeFormatString="False" InsertVisible="False" SortExpression="UpdateTime">
            <ItemStyle Width="150px" />
        </asp:BoundField>
        <asp:BoundField DataField="Count" HeaderText="热度" HtmlEncode="False" 
            HtmlEncodeFormatString="False" InsertVisible="False" SortExpression="Count"/>
        <asp:TemplateField>
            <ItemTemplate>
                <asp:Button ID="btDelete" runat="server" 
                    CommandArgument='<%#DataBinder.Eval(Container,"RowIndex")%>' 
                    CommandName="btdownload" Text="下载" OnInit="btDelete_oninit"/>
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
    <AlternatingRowStyle BackColor="#DEDEDE" />
</asp:GridView>
</asp:Panel>
<%--</ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="drType" EventName="SelectedIndexChanged" />
        <asp:AsyncPostBackTrigger ControlID="btshow" EventName="Click" />
        <asp:PostBackTrigger ControlID="btDelete" />
    </Triggers>
    </asp:UpdatePanel>--%>