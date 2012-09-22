<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AskAndAnser.aspx.cs" Inherits="AskAndAnser" Title="无标题页" %>


<%@ Register src="../UserControls/askanswer1.ascx" tagname="askanswer1" tagprefix="uc1" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server"/>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
   <uc1:askanswer1 ID="askanswer11" runat="server" /> 
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
        Height="24px" Width="198px" 
        onselectedindexchanged="DropDownList1_SelectedIndexChanged">
        <asp:ListItem Value="view">查看提问</asp:ListItem>
        <asp:ListItem Value="add">发布提问</asp:ListItem>
    </asp:DropDownList>
    <asp:Panel ID="PanelView" runat="server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="Data Source=.\SQLEXPRESS;AttachDbFilename=|DataDirectory|\webdata.mdf;Integrated Security=True;User Instance=True" 
        ProviderName="System.Data.SqlClient" SelectCommand="usp_AskAndAnserMain" 
        SelectCommandType="StoredProcedure"
        DeleteCommand="usp_DeleteTopic" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
           <asp:Parameter Name="TopicId" DbType="Int32" />
        </DeleteParameters>
        </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" DataKeyNames="TopicId" 
        DataSourceID="SqlDataSource1" EnableViewState="False" PageSize="20" 
        Width="100%" oninit="GridView1_Init">
        <Columns>
            <asp:HyperLinkField DataNavigateUrlFields="TopicId,UserName" 
                DataNavigateUrlFormatString="~/Student/replay.aspx?TopicId={0}" DataTextField="Title" 
                HeaderText="主题" InsertVisible="False">
                <ItemStyle Width="70%" Wrap="False" />
            </asp:HyperLinkField>
            <asp:BoundField DataField="UserName" HeaderText="提问人" SortExpression="UserName">
                <ItemStyle Width="10%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="CreateTime" HeaderText="提问时间" 
                SortExpression="CreateTime">
                <ItemStyle Width="13%" Wrap="False" Font-Size="Small" />
            </asp:BoundField>
            <asp:CommandField CausesValidation="False" InsertVisible="False" 
                ShowCancelButton="False" ShowDeleteButton="True">
            </asp:CommandField>
        </Columns>
    </asp:GridView>
    </asp:Panel>
    <asp:Panel ID="PanelAdd" runat="server">
        <table style="width: 100%;">
            <tr>
                <td style="width:75px;" align="left">
                   标题: 
                </td>
                <td>
                    <asp:TextBox ID="txtTitle" runat="server" Height="23px" Width="350px" 
                     Wrap="False"></asp:TextBox> <asp:RequiredFieldValidator
                   ID="VatxtTitle" runat="server" ErrorMessage="*" ControlToValidate="txtTitle" ValidationGroup="ask"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td align="left" valign="top">
                  详细内容: 
                </td>
                <td>
                  <asp:TextBox ID="TextBox1" runat="server" Height="350px" TextMode="MultiLine" 
                     Width="98%"></asp:TextBox><asp:RequiredFieldValidator ID="VatxtContent"
                         runat="server" ErrorMessage="*" ControlToValidate="TextBox1" ValidationGroup="ask"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <p class="btcenter"><asp:Button ID="Button1" runat="server" Text="提交" onclick="Button1_Click" ValidationGroup="ask"/></p>
    </asp:Panel>
    </ContentTemplate>
 </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="content4" ContentPlaceHolderID="daohang" runat="server">
          <ul id="askanswer"> 
            <asp:Panel ID="PnVistor" runat="server">
              <li class="subject"><asp:HyperLink ID="HyperLink15" runat="server" NavigateUrl="~/subjectdescribe.aspx">课 程 介 绍</asp:HyperLink></li>
              <li class="principle"><asp:HyperLink ID="HyperLink16" runat="server" NavigateUrl="~/principles.aspx">教 学 大 纲</asp:HyperLink></li>
              <li class="plan"><asp:HyperLink ID="HyperLink17" runat="server" NavigateUrl="~/plan.aspx">教 学 日 历</asp:HyperLink></li>
              <li class="inform"><asp:HyperLink ID="HyperLink18" runat="server" NavigateUrl="~/inform.aspx">课 程 通 知</asp:HyperLink></li>
              </asp:Panel>
              <asp:Panel ID="PnStudent" runat="server">
              <li class="subject"><asp:HyperLink ID="HyperLink19" runat="server" NavigateUrl="~/subjectdescribe.aspx">课 程 介 绍</asp:HyperLink></li>
              <li class="principle"><asp:HyperLink ID="HyperLink20" runat="server" NavigateUrl="~/principles.aspx">教 学 大 纲</asp:HyperLink></li>
              <li class="plan"><asp:HyperLink ID="HyperLink21" runat="server" NavigateUrl="~/plan.aspx">教 学 日 历</asp:HyperLink></li>
              <li class="inform"><asp:HyperLink ID="HyperLink22" runat="server" NavigateUrl="~/inform.aspx">课 程 通 知</asp:HyperLink></li>     
              <li class="askanswer"><asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Student/AskAndAnser.aspx">答 疑 讨 论</asp:HyperLink></li>
              <li class="online"><asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Student/SourceOnline.aspx">在 线 课 件</asp:HyperLink></li>
              <li class="share"><asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Student/SourceShare.aspx">资 源 共 享</asp:HyperLink></li>
              <li class="practice"><asp:HyperLink ID="HyperLink4" runat="server" NavigateUrl="~/Student/PracticeOnline.aspx">在 线 答 题</asp:HyperLink></li>
              <li class="score"><asp:HyperLink ID="HyperLink27" runat="server" NavigateUrl="~/Student/ViewScore.aspx">成 绩 查 询</asp:HyperLink></li>
              <li class="changekey"><asp:HyperLink ID="HyperLink5" runat="server" NavigateUrl="~/Student/ChangeKey.aspx">密 码 更 改</asp:HyperLink></li>
              </asp:Panel>
              <asp:Panel ID="PnTeacher" runat="server">
              <li class="subject"><asp:HyperLink ID="HyperLink23" runat="server" NavigateUrl="~/subjectdescribe.aspx">课 程 介 绍</asp:HyperLink></li>
              <li class="principle"><asp:HyperLink ID="HyperLink24" runat="server" NavigateUrl="~/principles.aspx">教 学 大 纲</asp:HyperLink></li>
              <li class="plan"><asp:HyperLink ID="HyperLink25" runat="server" NavigateUrl="~/plan.aspx">教 学 日 历</asp:HyperLink></li>
              <li class="inform"><asp:HyperLink ID="HyperLink26" runat="server" NavigateUrl="~/inform.aspx">课 程 通 知</asp:HyperLink></li>     
              <li class="askanswer"><asp:HyperLink ID="HyperLink6" runat="server" NavigateUrl="~/Student/AskAndAnser.aspx">答 疑 讨 论</asp:HyperLink></li>
              <li class="online"><asp:HyperLink ID="HyperLink7" runat="server" NavigateUrl="~/Student/SourceOnline.aspx">在 线 课 件</asp:HyperLink></li>
              <li class="share"><asp:HyperLink ID="HyperLink8" runat="server" NavigateUrl="~/Student/SourceShare.aspx">资 源 共 享</asp:HyperLink></li>          
              <li class="Qmanage"><asp:HyperLink ID="HyperLink9" runat="server" NavigateUrl="~/Teacher/QuestionManage.aspx">题 库 管 理</asp:HyperLink></li>
              <li class="Emanage"><asp:HyperLink ID="HyperLink10" runat="server" NavigateUrl="~/Teacher/ExamManage.aspx">试 卷 管 理</asp:HyperLink></li>
              <li class="correct"><asp:HyperLink ID="HyperLink11" runat="server" NavigateUrl="~/Teacher/CorrectOnline.aspx">在 线 批 阅</asp:HyperLink></li>
              <li class="analysis"><asp:HyperLink ID="HyperLink12" runat="server" NavigateUrl="~/Teacher/ExamAnalysis.aspx">考 后 统 计</asp:HyperLink></li>
              <li class="Umanage"><asp:HyperLink ID="HyperLink13" runat="server" NavigateUrl="~/Teacher/usermanage.aspx">学 生 管 理</asp:HyperLink></li>
              <li class="changekey"><asp:HyperLink ID="HyperLink14" runat="server" NavigateUrl="~/Student/ChangeKey.aspx">密 码 更 改</asp:HyperLink></li>           
              </asp:Panel>
              <asp:Panel ID="PnAdmin" runat="server">
              <li class="Tmanage">成 员 管 理</li>
              <li class="Smanage">资 源 管 理</li>
              <li class="Pinform">发 布 通 知</li>
            </asp:Panel>
          </ul>
</asp:Content>
