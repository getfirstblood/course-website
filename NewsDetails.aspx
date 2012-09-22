<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="NewsDetails.aspx.cs" Inherits="NewsDetails" Title="无标题页" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="daohang" Runat="Server">
          <ul id="info"> 
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
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="usp_ShowOneNews" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="NewsId" QueryStringField="id" 
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="FormView1" runat="server" AllowPaging="True" 
        DataSourceID="SqlDataSource1" BackColor="White" BorderColor="#CCCCCC" 
        BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" 
        GridLines="Horizontal" Width="100%" EnableViewState="False">
        <ItemTemplate>
            <table style="width: 100%;">
                <tr>
                    <td align="center" valign="top">
                       <asp:Label ID="Label1" runat="server" Text='<%#Bind("Title") %>' Font-Size="Large" Font-Bold="True"></asp:Label> 
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                         <p style="width:120px;float:left;font-size:small;color:blue;">发布人：<asp:Label ID="Label2" runat="server" Text='<%#Eval("UserName") %>'></asp:Label></p><p style="width:180px;float:right;font-size:small;color:blue;">发布时间：<asp:Label ID="Label3" runat="server" Text='<%#Eval("CreateTime")%>'></asp:Label></p>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                               <asp:Label ID="Label4" runat="server" Text='<%#Bind("Content") %>'></asp:Label>   
                    </td>
            </table>
        </ItemTemplate>
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
    </asp:FormView>
</asp:Content>

