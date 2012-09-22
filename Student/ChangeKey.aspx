<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ChangeKey.aspx.cs" Inherits="ChangeKey" Title="无标题页" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div style="width:350px;margin:50px auto auto auto;">
    <p>原&nbsp;&nbsp;&nbsp; 密&nbsp;&nbsp;&nbsp; 码：<asp:TextBox ID="PrPaWord" 
            runat="server" TextMode="Password" 
            CausesValidation="True" Width="159px"></asp:TextBox><asp:RequiredFieldValidator
        ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" 
            ValidationGroup="changep" ControlToValidate="PrPaWord" Display="Dynamic" 
            Font-Size="Small"></asp:RequiredFieldValidator></p>
    <p>新&nbsp;&nbsp;&nbsp; 密&nbsp;&nbsp;&nbsp; 码：<asp:TextBox ID="NewPaWord" 
            runat="server" ValidationGroup="changep" TextMode="Password" 
            CausesValidation="True" Width="159px"></asp:TextBox><asp:RequiredFieldValidator
        ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" Display="Dynamic" Font-Size="Small" ControlToValidate="NewPaWord" ValidationGroup="changep"></asp:RequiredFieldValidator></p>
    <p>确认新密码：<asp:TextBox ID="VaNewPa" runat="server" ValidationGroup="changep" 
            TextMode="Password" CausesValidation="True" Width="159px"></asp:TextBox><asp:RequiredFieldValidator
                ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" Display="Dynamic" Font-Size="Small" ControlToValidate="VaNewPa" ValidationGroup="changep"></asp:RequiredFieldValidator><asp:CompareValidator
        ID="CompareValidator1" runat="server" ErrorMessage="新密码不一致" Display="Dynamic" Font-Size="Small" ControlToValidate="VaNewPa" ControlToCompare="NewPaWord" ValidationGroup="changep"></asp:CompareValidator></p>
    <p style="width:40px;margin:0 auto;">
        <asp:Button ID="btchange" runat="server" Text="确定" ValidationGroup="changep" 
            onclick="btchange_Click"/></p>
</div>
</asp:Content>

<asp:Content ID="content4" ContentPlaceHolderID="daohang" runat="server">
          <ul id="changekey"> 
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