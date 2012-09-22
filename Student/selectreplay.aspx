<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="selectreplay.aspx.cs" Inherits="selectreplay" Title="无标题页" %>

<%@ Register src="../UserControls/askanswer1.ascx" tagname="askanswer1" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <uc1:askanswer1 ID="askanswer11" runat="server" />

<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        
        SelectCommand="SELECT * FROM [Reply] WHERE ([UserName] = @UserName) ORDER BY [CreateTime] DESC" 
        DeleteCommand="DELETE FROM [Reply] WHERE [ReplyId] = @ReplyId" 
        InsertCommand="INSERT INTO [Reply] ([TopicId], [UserName], [Content], [CreateTime]) VALUES (@TopicId, @UserName, @Content, @CreateTime)" 
        UpdateCommand="UPDATE [Reply] SET [TopicId] = @TopicId, [UserName] = @UserName, [Content] = @Content, [CreateTime] = @CreateTime WHERE [ReplyId] = @ReplyId">
        <SelectParameters>
            <asp:SessionParameter Name="UserName" SessionField="Username" Type="String" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="ReplyId" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="TopicId" Type="Int32" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="Content" Type="String" />
            <asp:Parameter DbType="Date" Name="CreateTime" />
            <asp:Parameter Name="ReplyId" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="TopicId" Type="Int32" />
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="Content" Type="String" />
            <asp:Parameter DbType="Date" Name="CreateTime" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" DataSourceID="SqlDataSource1" PageSize="15" 
        Width="730px" DataKeyNames="ReplyId">
        <Columns>
            <asp:TemplateField HeaderText="我的回复">
            <ItemTemplate>
            <a href='replay.aspx?TopicId=<%# DataBinder.Eval(Container.DataItem,"TopicId")%>'><%# DataBinder.Eval(Container.DataItem,"Content").ToString().Length >30 ? Eval("Content").ToString().Substring(0, 30)+'.'+'.'+'.'+'.' : Eval("Content")%></a>
            </ItemTemplate>
                <ItemStyle Width="75%" />
            </asp:TemplateField>
            <asp:BoundField DataField="CreateTime" HeaderText="时间" />
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="Delete" onclientclick="return confirm('确认删除？');" Text="删除"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
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

