﻿<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="QuestionManage.aspx.cs" Inherits="QuestionManage" Title="无标题页" %>

<%@ Register src="../UserControls/AddQuestion.ascx" tagname="AddQuestion" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
          <ContentTemplate>
    <asp:DropDownList ID="drSelectType" runat="server" AutoPostBack="True" 
        onselectedindexchanged="drSelectType_SelectedIndexChanged">
        <asp:ListItem Value="1">管理试题</asp:ListItem>
        <asp:ListItem Value="2">添加试题</asp:ListItem>
    </asp:DropDownList>
        <asp:Panel ID="pnAdd" runat="server">
        <uc1:AddQuestion ID="AddQuestion1" runat="server" />
    
    </asp:Panel>
    <asp:Panel ID="pnManage" runat="server">

        <asp:DropDownList ID="drType1" runat="server" AutoPostBack="True" 
            onselectedindexchanged="drType1_SelectedIndexChanged">
            <asp:ListItem Value="select">选择题</asp:ListItem>
            <asp:ListItem Value="ask">问答题</asp:ListItem>
        </asp:DropDownList> 
        <asp:SqlDataSource ID="SDManageQ" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
            SelectCommand="usp_ShowQuestion" SelectCommandType="StoredProcedure">
            <SelectParameters>
               <asp:ControlParameter ControlID="drType1" Name="type" Type="String" PropertyName="SelectedValue" />            
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GVManageQ" runat="server" AllowPaging="True" DataKeyNames="Lock"
            AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SDManageQ" 
             onrowcommand="GVManageQ_RowCommand" onrowdatabound="GVManageQ_RowDataBound" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="题干预览" ItemStyle-Width="500px">
                   <ItemTemplate>
                       <asp:LinkButton ID="lbQDetails" runat="server" Text='<%#DealData.SubStr(Eval("Question").ToString(),20) %>'></asp:LinkButton>
                   </ItemTemplate>
                    <ItemStyle Width="550px" />
                </asp:TemplateField>
                <asp:BoundField DataField="Level" HeaderText="评级" SortExpression="Level">
                    <ItemStyle Width="50px" />
                </asp:BoundField>
                <asp:BoundField DataField="Type" HeaderText="类型" SortExpression="Type">
                    <ItemStyle Width="50px" />
                </asp:BoundField>
                <asp:TemplateField>
                  <ItemTemplate>
                      <asp:LinkButton ID="lbDelete2" runat="server" Text="删除" CommandName="lbdelete" CommandArgument='<%#DataBinder.Eval(Container,"RowIndex")%>'></asp:LinkButton>
                  </ItemTemplate>
                    <ItemStyle Width="50px" />                  
                </asp:TemplateField>
            </Columns>
            <AlternatingRowStyle BackColor="#DEDEDE" />
        </asp:GridView>

    </asp:Panel>
        </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="content4" ContentPlaceHolderID="daohang" runat="server">
          <ul id="Qmanage"> 
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