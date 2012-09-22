<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="usermanage.aspx.cs" Inherits="Teacher_usermanage" Title="无标题页" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" 
        Height="80px" Width="100%" 
        DataKeyNames="UserId" DataSourceID="SqlDataSource1" 
        onrowupdating="GridView1_RowUpdating" 
        onrowdatabound="GridView1_RowDataBound1"  
        onrowediting="GridView1_RowEditing" AllowSorting="True"   >
        <Columns>
            <asp:TemplateField HeaderText="姓名">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("RealName") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Width="100px" />
            </asp:TemplateField>
            <asp:BoundField DataField="UserName" HeaderText="用户名" ReadOnly="True">
                <HeaderStyle HorizontalAlign="Center" />
                <ItemStyle HorizontalAlign="Center" Width="100px" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="学号" SortExpression="StudentId">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("StudentId") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Width="100px" />
            </asp:TemplateField>
            <asp:BoundField DataField="SourceSize" HeaderText="上传限制" 
                SortExpression="SourceSize" DataFormatString="{0}M" >
                <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="是否验证" SortExpression="IsVa">
                <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%#Eval("IsVa") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList2" runat="server"  ondatabound="DropDownList2_DataBound">
                        </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="角色">
                <ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("Role") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="角色">
                <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%#Eval("Role") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" ondatabound="DropDownList1_DataBound" >
                        </asp:DropDownList>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="注册时间" SortExpression="BirthTime">
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%#Eval("BirthTime") %>'></asp:Label>
                </ItemTemplate>
                <ItemStyle Width="150px" />
            </asp:TemplateField>
            <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        DeleteCommand="usp_DeleteOneUser" DeleteCommandType="StoredProcedure"
        InsertCommand="INSERT INTO [User] ([UserName], [StudentId], [Role], [PassWord], [Email], [IsVa], [Question], [Key], [SourceSize], [BirthTime], [RealName]) VALUES (@UserName, @StudentId, @Role, @PassWord, @Email, @IsVa, @Question, @Key, @SourceSize, @BirthTime, @RealName)" 
        SelectCommand="usp_ShowAllUser" SelectCommandType="StoredProcedure"
        UpdateCommand="UPDATE [User] SET  [Role] = @Role, [IsVa] = @IsVa,[SourceSize] = @SourceSize WHERE [UserId] = @UserId">
        <DeleteParameters>
            <asp:Parameter Name="UserId" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="StudentId" Type="String" />
            <asp:Parameter Name="Role" Type="String" />
            <asp:Parameter Name="PassWord" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="IsVa" Type="String" />
            <asp:Parameter Name="Question" Type="String" />
            <asp:Parameter Name="Key" Type="String" />
            <asp:Parameter Name="SourceSize" Type="Int32" />
            <asp:Parameter DbType="DateTime" Name="BirthTime" />
            <asp:Parameter Name="RealName" Type="String" />
            <asp:Parameter Name="UserId" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="UserName" Type="String" />
            <asp:Parameter Name="StudentId" Type="String" />
            <asp:Parameter Name="Role" Type="String" />
            <asp:Parameter Name="PassWord" Type="String" />
            <asp:Parameter Name="Email" Type="String" />
            <asp:Parameter Name="IsVa" Type="String" />
            <asp:Parameter Name="Question" Type="String" />
            <asp:Parameter Name="Key" Type="String" />
            <asp:Parameter Name="SourceSize" Type="Int32" />
            <asp:Parameter DbType="DateTime" Name="BirthTime" />
            <asp:Parameter Name="RealName" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    </ContentTemplate>
     </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="content4" ContentPlaceHolderID="daohang" runat="server">
          <ul id="TUmanage"> 
            <asp:Panel ID="PnVistor" runat="server">
              <li class="subject"><asp:HyperLink ID="HyperLink15" runat="server" NavigateUrl="~/subjectdescribe.aspx">课 程 介 绍</asp:HyperLink></li>
              <li class="principle"><asp:HyperLink ID="HyperLink16" runat="server" NavigateUrl="~/principles.aspx">教 学 大 纲</asp:HyperLink></li>
              <li class="plan"><asp:HyperLink ID="HyperLink17" runat="server" NavigateUrl="~/plan.aspx">教 学 日 历</asp:HyperLink></li>
              <li class="inform"><asp:HyperLink ID="HyperLink18" runat="server" NavigateUrl="~/inform.aspx">课 程 通 知</asp:HyperLink></li>
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
              <li class="Tmanage"><asp:HyperLink ID="HyperLink28" runat="server" NavigateUrl="~/Teacher/usermanage.aspx">成 员 管 理</asp:HyperLink></li>
              <li class="Smanage"><asp:HyperLink ID="HyperLink1" runat="server">资 源 管 理</asp:HyperLink></li>
              <li class="Pinform">
                  <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Admin/addinform.aspx">发 布 通 知</asp:HyperLink></li>
            </asp:Panel>
          </ul>
          
</asp:Content>
