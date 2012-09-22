<%@ Control Language="C#" AutoEventWireup="true" CodeFile="replay.ascx.cs" Inherits="UserControls_replay" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<div class="maincontent">
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>  

        <asp:FormView ID="FormView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="TopicId" BackColor="#DAF2D2" BorderStyle="None" CssClass="formview">
            <ItemTemplate>
                 <div class="hang">
                    <font size="5">主题：<%#Eval("Title") %></font></div>
                <asp:Panel ID="yuanjiao" runat="server" BackColor="White" CssClass="asktable">
                 <div class="fthang">
                      <p class="ftleft">提问者：<%# Eval("UserName")%></p>

                      <p class="ftright"><%# Eval("CreateTime")%></p>
                </div>
                <div class="hang">               <%# Eval("Content")%></div>

                </asp:Panel>
                <asp:RoundedCornersExtender ID="RoundedCornersExtender1" runat="server" 
                    BorderColor="#FFFFFF" Color="White" TargetControlID="yuanjiao">
                </asp:RoundedCornersExtender>
            </ItemTemplate>
        </asp:FormView> 
<div class="gridview">
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" PageSize="10" BorderStyle="None" CssClass="gridview">
      <Columns>
        <asp:TemplateField >
           <HeaderTemplate>
             回复信息:
           </HeaderTemplate>
           <HeaderStyle  HorizontalAlign="Left"/>
           <ItemTemplate>
              <table border="0" cellpadding="0" cellspacing="0" width="100%" id="yuanjiao" runat="server">
              <tr style="height:25px;font-size:small">
                 <td align="left" width="200px">
                    <font color="#3366cc">回复人：<%# Eval("UserName")%></font>
                 </td>
                 <td align="right" width="200px">
                    <font color="#3366cc"><%# Eval("CreateTime")%></font>
                 </td>
              </tr>
              <tr>
                <td colspan="2" width="100%" align="left">
                    <%# Eval("Content")%>   
                </td>
              </tr>
            </table>
          </ItemTemplate>
        </asp:TemplateField>
        </Columns>
        <AlternatingRowStyle BackColor="#DEDEDE" />
      </asp:GridView>

            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="SELECT * FROM [Topic] WHERE ([TopicId] = @TopicId)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="TopicId" QueryStringField="TopicId" 
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                
                SelectCommand="SELECT * FROM [Reply] WHERE ([TopicId] = @TopicId) ORDER BY [ReplyId] DESC">
                <SelectParameters>
                    <asp:QueryStringParameter Name="TopicId" QueryStringField="TopicId" 
                        Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
</div>
  <p>  <font color="red" size="2">我来回复：(请对自己的言行负责，遵守中华人民共和国有关法律、法规,尊重网上道德)</font></p>
  <p>  <asp:TextBox ID="textbox1" Runat="Server" Columns="70" Rows="10" Textmode="multiline" Width="100%" /> </p>   
  <p>  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
        ErrorMessage="回复不能为空" ValidationGroup="vareply" ControlToValidate="textbox1" 
        Font-Size="Small" Display="Dynamic"></asp:RequiredFieldValidator></p>
  <p class="btcenter">  <asp:Button ID="Send" Runat="Server" OnClick="Send_Click" Text="提交回复" 
        ValidationGroup="vareply"/></p>

<h1>
</h1>
</ContentTemplate>
    </asp:UpdatePanel>
</div>
