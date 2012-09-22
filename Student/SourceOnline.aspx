<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SourceOnline.aspx.cs" Inherits="SourceOnline" Title="无标题页" %>

<%@ Register src="../UserControls/ctUpLoad.ascx" tagname="ctUpLoad" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script language="javascript" type="text/javascript">
    function CheckWorkFile()
     {
       if(document.getElementById('ctl00_ContentPlaceHolder1_ctUpLoad1_FileUpload1').value=='')
         {
            alert('请选择要上传的作业书文件');
            return false;
         }
        var stuff=document.getElementById('ctl00_ContentPlaceHolder1_ctUpLoad1_FileUpload1').value.match(/^(.*)(\.)(.{1,8})$/)[3]; //这个文件类型正则很有用：）
        if(stuff!='ppt'||stuff!='pptx')
        {
           alert('文件类型不正确，请选择ppt文件');
           return false;
        }
        return true;
     }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
        Height="20px" onselectedindexchanged="DropDownList1_SelectedIndexChanged" 
        Width="167px">
        <asp:ListItem Value="0">查看资源</asp:ListItem>
        <asp:ListItem Value="1">上传资源</asp:ListItem>
    </asp:DropDownList>
    <asp:Panel ID="PnView" runat="server">

  <p>搜索：<asp:TextBox ID="txtSearch" runat="server" Width="521px"></asp:TextBox>（默认为空）</p>
  <p style="margin:0 auto;width:50px;"><asp:Button ID="btSearch" runat="server" 
          Text="确定" onclick="btSearch_Click"/></p>
    <asp:SqlDataSource ID="SDSourceOnline" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="usp_ShowSource" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:Parameter DefaultValue="2" Name="type" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:GridView ID="GVSourceOnline" runat="server" Width="805px" 
        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
        DataSourceID="SDSourceOnline" onrowcommand="GVSourceOnline_RowCommand">
        <Columns>
            <asp:BoundField DataField="SourceName" HeaderText="文件名" InsertVisible="False" 
                ReadOnly="True" >
                <ItemStyle Width="300px" />
            </asp:BoundField>
            <asp:TemplateField SortExpression="Size">
            <ItemStyle  Width="60px"/>
               <HeaderTemplate>
                  大小(K)
               </HeaderTemplate>
               <ItemTemplate>
                  <%#(Convert.ToInt32(Eval("Size"))/1024).ToString() %>
               </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Tag" HeaderText="标签">
                <ItemStyle Width="100px" />
            </asp:BoundField>
            <asp:BoundField DataField="UserName" HeaderText="上传者">
                <ItemStyle Width="100px" />
            </asp:BoundField>
            <asp:BoundField DataField="UpdateTime" DataFormatString="{0:d}" 
                HeaderText="上传时间">
                <ItemStyle Width="80px" />
            </asp:BoundField>
            <asp:BoundField DataField="Count" HeaderText="热度">
                <ItemStyle Width="40px" />
            </asp:BoundField>
            <asp:TemplateField>
              <ItemTemplate>
                  <asp:Button ID="btView" runat="server" Text="打开" CommandArgument='<%# Eval("SourceId") %>' CommandName="view"/>
              </ItemTemplate>
                <ItemStyle Width="50px" />
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </asp:Panel>

    <asp:Panel ID="PnManage" runat="server">
        <uc1:ctUpLoad ID="ctUpLoad1" runat="server" />
    </asp:Panel>

</asp:Content>
<asp:Content ID="content4" ContentPlaceHolderID="daohang" runat="server">
          <ul id="online"> 
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
