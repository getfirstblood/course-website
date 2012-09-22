<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="addinform.aspx.cs" Inherits="Admin_addinform" Title="无标题页" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
  .td1
  {
    width:80px;
  }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="daohang" Runat="Server">
         <ul id="Pinform">
              <li class="Tmanage"><asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Teacher/usermanage.aspx">成 员 管 理</asp:HyperLink></li>
              <li class="Smanage">资 源 管 理</li>
              <li class="Pinform"><asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Admin/addinform.aspx">发 布 通 知</asp:HyperLink></li>
          </ul>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
    <p><asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True">
      <asp:ListItem Value="0">发布通知</asp:ListItem>
      <asp:ListItem Value="1">管理通知</asp:ListItem>
    </asp:DropDownList></p>
    <asp:Panel ID="Pnpublic" runat="server" Visible="true" 
        EnableViewState="False">
        <table style="width: 100%;">
            <tr>
                <td class="td1">
                    标题：
                </td>
                <td>
                    <asp:TextBox ID="txtTitle" runat="server" ValidationGroup="addinform" Width="70%"></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ValidationGroup="addinform" ControlToValidate="txtTitle"></asp:RequiredFieldValidator> 
                </td>
            </tr>
            <tr>
                <td class="td1">
                   内容：
                </td>
                <td>
                    <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" ValidationGroup="addinform" Width="100%" Height="400px"></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ValidationGroup="addinform" ControlToValidate="txtContent"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="td1">
                    过期时间：
                </td>
                <td>
                    <asp:TextBox ID="txtDeleteTime" runat="server" Width="148px" Text="请选择" OnKeyPress="event.returnValue=false;"></asp:TextBox><asp:RequiredFieldValidator
                        ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txtDeleteTime" InitialValue="请选择" ValidationGroup="addinform"></asp:RequiredFieldValidator><asp:Button
                        ID="btDeleteTime" runat="server" Text="选择时间" /><asp:CalendarExtender ID="ceDeleteTime"
                            runat="server" Format="yyyy-MM-dd" PopupButtonID="btDeleteTime" PopupPosition="BottomRight" TargetControlID="txtDeleteTime">
                        </asp:CalendarExtender>
                </td>
            </tr>
        </table>
        <p class="btcenter">
            <asp:Button ID="btAdd" runat="server" Text="提交" ValidationGroup="addinform" 
              onclick="btAdd_Click"/></p>
    </asp:Panel>
    <asp:Panel ID="manage" runat="server" EnableViewState="False" >
            <asp:SqlDataSource ID="SDmanage" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="usp_ShowNews" SelectCommandType="StoredProcedure"
             DeleteCommand="usp_DeleteOneNews" DeleteCommandType="StoredProcedure">
              <DeleteParameters>
                 <asp:Parameter Name="NewsId" DbType="Int32" />
              </DeleteParameters>
             </asp:SqlDataSource>
        <asp:GridView ID="GVmanage" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="NewsId" 
            DataSourceID="SDmanage" Width="830px">
            <Columns>
                <asp:TemplateField HeaderText="标题">
                  <ItemTemplate>
                      <asp:LinkButton ID="LinkButton1" runat="server"><%#SubStr(Eval("Title").ToString(),20)%></asp:LinkButton>
                      <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="LinkButton1" DropShadow="False" PopupControlID="Panel1" Enabled="True" BackgroundCssClass="#b8b8b8" X="400" Y="200" OkControlID="Button1">
                      </asp:ModalPopupExtender>
                      <asp:Panel ID="Panel1" runat="server" BackColor="#cccccc" BorderColor="Black" Width="500px">                     
                      <p>标题：<%#Eval("Title") %></p>
                      <p>发布时间：<%#Eval("CreateTime") %></p>                    
                      <p>过期时间：<%#Eval("DeleteTime") %></p>
                      <p>内容：<%#Eval("Content") %></p>
                      <p class="btcenter">   <asp:Button ID="Button1" runat="server" Text="确定" OnClick="button1_click"/> </p>                   
                      </asp:Panel>
                  </ItemTemplate>
                  <ItemStyle Width="530px"/>
                </asp:TemplateField>
                <asp:BoundField DataField="UserName" HeaderText="作者" SortExpression="UserName">
                    <ItemStyle Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="CreateTime" HeaderText="发布时间" 
                    SortExpression="CreateTime">
                    <ItemStyle Width="150px" />
                </asp:BoundField>
                <asp:CommandField InsertVisible="False" ShowCancelButton="False" 
                    ShowDeleteButton="True">
                    <ItemStyle Width="30px" />
                </asp:CommandField>
            </Columns>
        </asp:GridView>
    </asp:Panel>
    </ContentTemplate>
      </asp:UpdatePanel>  
</asp:Content>

