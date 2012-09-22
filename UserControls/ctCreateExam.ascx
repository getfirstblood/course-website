<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ctCreateExam.ascx.cs" Inherits="UserControls_ctCreateExam" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
<ContentTemplate>
<asp:DropDownList ID="CreateType" runat="server" AutoPostBack="True" 
    Height="24px" Width="134px" 
            onselectedindexchanged="CreateType_SelectedIndexChanged">
    <asp:ListItem Value="Rand">随机生成试卷</asp:ListItem>
    <asp:ListItem Value="Hand">手动生成试卷</asp:ListItem>
    <asp:ListItem Value="Delete">删除试卷</asp:ListItem>
</asp:DropDownList>
<asp:Panel ID="Rand" runat="server">
    <table style="width: 100%;">
        <tr>
          <td style="width:120px">试卷标题：</td><td class="style2">
              <asp:TextBox ID="txtTitle" runat="server" CssClass="textboxa"></asp:TextBox><asp:RequiredFieldValidator
                  ID="vatitle" runat="server" ErrorMessage="**" ControlToValidate="txtTitle" 
                  Display="Dynamic" ValidationGroup="randcreate"></asp:RequiredFieldValidator>
            </td><td class="style1">
                评级限制:</td><td>
                  <asp:DropDownList ID="level1" runat="server" AutoPostBack="True" 
                      onselectedindexchanged="level1_SelectedIndexChanged">
                      <asp:ListItem Value="0">请选择</asp:ListItem>
                      <asp:ListItem Value="1">1</asp:ListItem>
                      <asp:ListItem Value="2"></asp:ListItem>
                      <asp:ListItem Value="3">3</asp:ListItem>
                      <asp:ListItem Value="4"></asp:ListItem>
                      <asp:ListItem Value="5">5</asp:ListItem>
                      <asp:ListItem Value="6">6</asp:ListItem>
                      <asp:ListItem Value="7">7</asp:ListItem>
                      <asp:ListItem Value="8">8</asp:ListItem>
                      <asp:ListItem Value="9">9</asp:ListItem>
                      <asp:ListItem Value="10">10</asp:ListItem>
                      <asp:ListItem Value="11">11</asp:ListItem>
                      <asp:ListItem Value="12">12</asp:ListItem>
                  </asp:DropDownList>至<asp:DropDownList ID="level2" runat="server">
                      <asp:ListItem Value="0">请选择</asp:ListItem>
                  </asp:DropDownList>
                  <asp:RequiredFieldValidator ID="valevel" runat="server" 
                      ControlToValidate="level2" Display="Dynamic" ErrorMessage="必选" InitialValue="0" 
                      ValidationGroup="randcreate"></asp:RequiredFieldValidator>
              </td>
        </tr>
        <tr>
            <td style="width:120px">
                选择题题数：
            </td>
            <td class="style2">
                <asp:TextBox ID="txtNumSelect" runat="server" Width="40px"></asp:TextBox>
                <asp:RangeValidator ID="vaselectnum" runat="server" 
                    ControlToValidate="txtNumSelect" ErrorMessage="请填0－100的数字" MaximumValue="100" 
                    MinimumValue="0" ValidationGroup="randcreate" Display="Dynamic" 
                    Type="Integer"></asp:RangeValidator><asp:RequiredFieldValidator
                        ID="vaselectnum2" runat="server" ErrorMessage="**" 
                    ControlToValidate="txtNumSelect" Display="Dynamic" ValidationGroup="randcreate"></asp:RequiredFieldValidator>
            </td>
            <td class="style1">
                选择题分值：
            </td>
            <td>
                <asp:TextBox ID="txtMarkSelect" runat="server" Width="40px"></asp:TextBox>
                <asp:RangeValidator ID="vaselectmark" runat="server" 
                    ControlToValidate="txtMarkSelect" Display="Dynamic" ErrorMessage="请填0－20的数字" 
                    MaximumValue="20" MinimumValue="0" ValidationGroup="randcreate" 
                    Type="Integer"></asp:RangeValidator><asp:RequiredFieldValidator
                        ID="vasmark2" runat="server" ErrorMessage="**" 
                    ControlToValidate="txtMarkSelect" Display="Dynamic" 
                    ValidationGroup="randcreate"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width:120px">
                问答题题数：
            </td>
            <td class="style2">
                <asp:TextBox ID="txtNumAsk" runat="server" Width="40px"></asp:TextBox>
                <asp:RangeValidator ID="vaasknum" runat="server" ControlToValidate="txtNumAsk" 
                    ErrorMessage="请填0－20的数字" MaximumValue="20" MinimumValue="0" 
                    ValidationGroup="randcreate" Display="Dynamic" Type="Integer"></asp:RangeValidator><asp:RequiredFieldValidator ID="vaasknum2"
                        runat="server" ErrorMessage="**" ControlToValidate="txtNumAsk" 
                    Display="Dynamic" ValidationGroup="randcreate"></asp:RequiredFieldValidator>
            </td>
            <td class="style1">
                问答题分值：
            </td>
            <td>
                <asp:TextBox ID="txtMarkAsk" runat="server" Width="40px"></asp:TextBox>
                <asp:RangeValidator ID="vaaskmark" runat="server" 
                    ControlToValidate="txtMarkAsk" Display="Dynamic" ErrorMessage="请填0－50的数字" 
                    MaximumValue="50" MinimumValue="0" ValidationGroup="randcreate" 
                    Type="Integer"></asp:RangeValidator>
                <asp:RequiredFieldValidator ID="vaamark2" runat="server" 
                    ControlToValidate="txtMarkAsk" Display="Dynamic" ErrorMessage="**" 
                    ValidationGroup="randcreate"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td style="width:120px">
                答卷截止时间：
            </td>
            <td class="style2">
                <asp:TextBox ID="lbEndTime" runat="server" Text="请选择" Width="80px"></asp:TextBox><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="**" ValidationGroup="randcreate" InitialValue="请选择" ControlToValidate="lbEndTime"></asp:RequiredFieldValidator>
                <asp:Button ID="btEndTime" runat="server" Text="选择" />
            </td>
            <td class="style1">
                考试分钟数： </td>
            <td>
                <asp:TextBox ID="Time" runat="server" Width="40px"></asp:TextBox>
                <asp:RangeValidator ID="vatime" runat="server" ControlToValidate="Time" 
                    Display="Dynamic" ErrorMessage="请填0－150的数字" MaximumValue="150" MinimumValue="0" 
                    Type="Integer" ValidationGroup="randcreate"></asp:RangeValidator>
                <asp:RequiredFieldValidator ID="vatime2" runat="server" 
                    ControlToValidate="Time" Display="Dynamic" ErrorMessage="**" 
                    ValidationGroup="randcreate"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
           <td style="width:120px">试卷过期时间：</td><td class="style2">
               <asp:TextBox ID="lbDeleteTime" runat="server" Text="请选择"
                   Width="80px"></asp:TextBox><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator2" runat="server" ErrorMessage="**" ValidationGroup="randcreate" InitialValue="请选择" ControlToValidate="lbDeleteTime"></asp:RequiredFieldValidator>
               <asp:Button ID="btDeleteTime" runat="server" Text="选择" />
            </td>
            <td class="style1">
                &nbsp;</td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
          <td style="width:120px">
              &nbsp;</td>
          <td class="style2" align="center" colspan="2">
              <asp:Button ID="btCreate" runat="server" onclick="btCreate_Click" 
                  style="margin:0 auto;" Text="生成试卷" ValidationGroup="randcreate" />
          </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <asp:CalendarExtender ID="CalendarExtender1" runat="server" 
        PopupButtonID="btEndTime" PopupPosition="Right" TargetControlID="lbEndTime" 
        Format="yyyy-MM-dd">
    </asp:CalendarExtender>
    <asp:CalendarExtender ID="CalendarExtender2" runat="server" 
        PopupButtonID="btDeleteTime" PopupPosition="Right" 
        TargetControlID="lbDeleteTime" 
        Format="yyyy-MM-dd">
    </asp:CalendarExtender>
</asp:Panel>
<asp:Panel ID="Hand" runat="server">
  <div>
    <asp:Wizard ID="Wizard1" runat="server" Width="100%" DisplaySideBar="False" 
        onfinishbuttonclick="Wizard1_FinishButtonClick" ActiveStepIndex="0">
        <WizardSteps>
            <asp:WizardStep ID="WizardStep1" runat="server" Title="添加试题" StepType="Start" OnActivate="WizardStep1_activate">
                请选择筛选条件：
                <table style="width: 100%;">
                    <tr>
                        <td width="120px">
                         评级限制：
                        </td>
                        <td width="300px">
                            <asp:DropDownList ID="level1b" runat="server" AutoPostBack="True" 
                               onselectedindexchanged="level1b_SelectedIndexChanged">
                                <asp:ListItem Value="0">请选择</asp:ListItem>
                                <asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                                <asp:ListItem>3</asp:ListItem>
                                <asp:ListItem>4</asp:ListItem>
                                <asp:ListItem>5</asp:ListItem>
                                <asp:ListItem>6</asp:ListItem>
                                <asp:ListItem>7</asp:ListItem>
                                <asp:ListItem>8</asp:ListItem>
                                <asp:ListItem>9</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>11</asp:ListItem>
                                <asp:ListItem>12</asp:ListItem>
                            </asp:DropDownList>至
                            <asp:DropDownList ID="level2b" runat="server">
                                <asp:ListItem Value="0">请选择</asp:ListItem>
                            </asp:DropDownList>
                               (默认为1至12级)
                        </td>
                        <td width="120px">
                          试题类型：
                        </td>
                        <td>
                        <asp:DropDownList ID="qutype" runat="server">
                            <asp:ListItem Value="select">选择题</asp:ListItem>
                            <asp:ListItem Value="ask">问答题</asp:ListItem>
                        </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td width="120px">
                          筛选试题数量：
                        </td>
                        <td width="300px">
                            <asp:TextBox ID="txtNum" runat="server" Width="66px"></asp:TextBox>
                            (默认200条)
                        </td>
                        <td width="120px">
                           关键字搜索：
                        </td>
                        <td>
                           <asp:TextBox ID="txtTag" runat="server"></asp:TextBox>
                           (默认为空)
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="4" valign="middle">
                           &nbsp;
                            <asp:Button ID="btShow" runat="server" Text="确定" onclick="btShow_Click" />
                        </td>
                    </tr>
                </table>
                <asp:Panel runat="server" id="divShowQ" visible="true" 
                    OnPreRender="divShowQ_PreRender">
                    <asp:SqlDataSource ID="DSShowQ" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                        SelectCommand="usp_ShowSelect" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="'exam'" Name="type" Type="String" />
                            <asp:ControlParameter ControlID="level2b" DefaultValue="12" Name="level2" 
                               PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="txtNum" DefaultValue="200" Name="selectnum" 
                               PropertyName="Text" Type="Int32" />
                            <asp:ControlParameter ControlID="txtTag" DefaultValue="%" Name="tag" 
                               PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="level1b" DefaultValue="1" Name="level1" 
                               PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GVShowQ" runat="server" 
                         DataKeyNames="QuestionAId" DataSourceID="DSShowQ" 
                         AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True"  
                         Width="100%" onrowcommand="GVShowQ_RowCommand" Caption="选择题" PageSize="8" 
                         OnRowDataBound="GVShowQ_RowDataBound" EnableViewState="false">
                        <Columns>
                            <asp:TemplateField HeaderText="选择" InsertVisible="False">
                               <ItemTemplate>
                                   <asp:CheckBox ID="cbAdd" runat="server" OnCheckedChanged="cbAdd_checkedchanged" AutoPostBack="true"/>
                               </ItemTemplate>
                               <ItemStyle Width="40px" Wrap="False" HorizontalAlign="Center"/>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="分值" InsertVisible="False">
                               <ItemTemplate>
                                   <asp:Panel runat="server" ID="chmark" Visible="false">
                                   <asp:TextBox ID="mark" runat="server" Width="30px" Height="16px"></asp:TextBox><asp:RequiredFieldValidator
                                      ID="vamark" runat="server" ErrorMessage="*" ControlToValidate="mark" Display="Dynamic" ValidationGroup="handcreate"></asp:RequiredFieldValidator><asp:RangeValidator
                                          ID="vamark1" runat="server" ErrorMessage="err" Type="Integer" ValidationGroup="handcreate" MinimumValue="0" MaximumValue="100" ControlToValidate="mark" Display="Dynamic"></asp:RangeValidator></asp:Panel>
                                   <asp:Label ID="lbmark" runat="server"
                                      Text="未选择"></asp:Label>
                               </ItemTemplate>
                               <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                               <ItemStyle HorizontalAlign="Left" Width="60px" Wrap="False" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="题干预览" InsertVisible="false">
                               <ItemTemplate>
                                   <asp:LinkButton ID="QuView" runat="server" Text='<%#SubStr(Eval("Question").ToString(),20)%>' CommandName="link" CommandArgument='<%#Eval("QuestionAId") %>'></asp:LinkButton>
                               </ItemTemplate>
                            </asp:TemplateField>
   
                            <asp:BoundField DataField="Level" HeaderText="评级" SortExpression="Level" >
                               <ItemStyle Width="40px" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="LastUsedTime" HeaderText="上次使用时间" 
                                SortExpression="LastUsedTime" HtmlEncode="False" 
                                HtmlEncodeFormatString="False" InsertVisible="False" 
                                NullDisplayText="首次使用" DataFormatString="{0:d}" >
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                                <ItemStyle Font-Size="Small" HorizontalAlign="Center" VerticalAlign="Middle" 
                                Wrap="False" Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CreateTime" HeaderText="题目添加时间" 
                                SortExpression="CreateTime" DataFormatString="{0:d}" HtmlEncode="False" 
                                 HtmlEncodeFormatString="False" InsertVisible="False" NullDisplayText="空" >
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle Font-Size="Small" HorizontalAlign="Center" VerticalAlign="Middle" 
                                  Wrap="False" Width="110px" />
                            </asp:BoundField>
                        </Columns>
                        <AlternatingRowStyle BackColor="#DEDEDE" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="DSShowQ2" runat="server"
                         ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                         SelectCommand="usp_ShowAsk" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="'exam'" Name="type" Type="String" />
                            <asp:ControlParameter ControlID="level2b" DefaultValue="12" Name="level2" 
                                 PropertyName="SelectedValue" Type="Int32" />
                            <asp:ControlParameter ControlID="txtNum" DefaultValue="200" Name="selectnum" 
                                 PropertyName="Text" Type="Int32" />
                            <asp:ControlParameter ControlID="txtTag" DefaultValue="%" Name="tag" 
                                 PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="level1b" DefaultValue="1" Name="level1" 
                                 PropertyName="SelectedValue" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GVShowQ2" runat="server" DataKeyNames="QuestionBId" DataSourceID="DSShowQ2" 
                         AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True"  
                         Width="100%" onrowcommand="GVShowQ2_RowCommand" Caption="问答题" 
                         PageSize="8" OnRowDataBound="GVShowQ2_RowDataBound" 
                        EnableViewState="false">
                        <Columns>
                           <asp:TemplateField HeaderText="选择" InsertVisible="False">
                               <ItemTemplate>
                                  <asp:CheckBox ID="cbAdd2" runat="server" OnCheckedChanged="cbAdd2_checkedchanged" AutoPostBack="true"/>
                               </ItemTemplate>
                               <ItemStyle Width="40px" Wrap="False" HorizontalAlign="Center"/>
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="分值" InsertVisible="False">
                               <ItemTemplate>
                                   <asp:Panel runat="server" ID="chmark2" Visible="false">
                                        <asp:TextBox ID="mark2" runat="server" Width="30px" Height="16px"></asp:TextBox><asp:RequiredFieldValidator
                                          ID="vamark2" runat="server" ErrorMessage="*" ControlToValidate="mark2" Display="Dynamic" ValidationGroup="handcreate2"></asp:RequiredFieldValidator><asp:RangeValidator
                                              ID="vamark12" runat="server" ErrorMessage="err" ValidationGroup="handcreate2" Type="Integer" MinimumValue="0" MaximumValue="100" ControlToValidate="mark2"></asp:RangeValidator></asp:Panel>
                                        <asp:Label ID="lbmark2" runat="server"
                                           Text="未选择"></asp:Label>
                               </ItemTemplate>
                               <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                               <ItemStyle HorizontalAlign="Left" Width="60px" Wrap="False" />
                           </asp:TemplateField>
                           <asp:TemplateField HeaderText="题干预览" InsertVisible="false">
                               <ItemTemplate>
                                    <asp:LinkButton ID="QuView2" runat="server" Text='<%#SubStr(Eval("Question").ToString(),20)%>' CommandName="link" CommandArgument='<%#Eval("QuestionBId") %>'></asp:LinkButton>
                               </ItemTemplate>
                           </asp:TemplateField>
                           <asp:BoundField DataField="Level" HeaderText="评级" SortExpression="Level" >
                               <ItemStyle Width="40px" HorizontalAlign="Center"/>
                           </asp:BoundField>
                           <asp:BoundField DataField="LastUsedTime" HeaderText="上次使用时间" 
                                SortExpression="LastUsedTime" HtmlEncode="False" 
                                HtmlEncodeFormatString="False" InsertVisible="False" 
                                NullDisplayText="首次使用" DataFormatString="{0:d}" >
                              <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
                              <ItemStyle Font-Size="Small" HorizontalAlign="Center" VerticalAlign="Middle" 
                                Wrap="False" Width="100px" />
                           </asp:BoundField>
                           <asp:BoundField DataField="CreateTime" HeaderText="题目添加时间" 
                                SortExpression="CreateTime" DataFormatString="{0:d}" HtmlEncode="False" 
                                HtmlEncodeFormatString="False" InsertVisible="False" NullDisplayText="空" >
                              <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                              <ItemStyle Font-Size="Small" HorizontalAlign="Center" VerticalAlign="Middle" 
                                Wrap="False" Width="110px" />
                           </asp:BoundField>
                        </Columns>
                        <AlternatingRowStyle BackColor="#DEDEDE" />
                    </asp:GridView>
                    <p style="width:50px;margin:0 auto;">
                        <asp:Button ID="addquestion" runat="server" Text="添加" 
                          onclick="addquestion_Click" ValidationGroup="handcreate" />                      
                    </p>
                 </asp:Panel>
            </asp:WizardStep>
            <asp:WizardStep ID="WSmodify" runat="server" Title="试题调整" 
                StepType="Step" OnActivate="WSmodify_activate">
                <asp:SqlDataSource ID="SDmodifya" runat="server" SelectCommandType="StoredProcedure"
                 SelectCommand="usp_PreShowQ" 
                    ConnectionString='<%$ ConnectionStrings:ConnectionString %>' 
                    OnSelecting="SDmodifya_Selecting1">
                    <SelectParameters>
                       <asp:SessionParameter Name="ids" DbType="String" SessionField="QAId" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:DataList ID="DLmodifya" runat="server" DataSourceID="SDmodifya" 
                    Width="100%" 
                    EnableViewState="false"
                    OnItemDataBound="DLmodifya_ItemDataBound" 
                    OnItemCommand="DLmodifya_ItemCommand" ItemStyle-BorderStyle="Dashed" ItemStyle-BorderColor="#999966" HeaderStyle-HorizontalAlign="Center" BorderStyle="Dotted"> 
                    <HeaderStyle BackColor="#FFFF99" HorizontalAlign="Center" />
                    <HeaderTemplate>
                       选择题：
                    </HeaderTemplate>
                    <ItemTemplate>
                      <p style="width:100%">分值：<%# ((Exam)Session["handexam"]).GetaMarkById(Convert.ToInt32(Eval("QuestionAId"))).ToString()%>;<asp:LinkButton
                           ID="btremovea" runat="server" Text="移除此题" Font-Size="Small" ForeColor="#0000CC" CommandName="btremovea_command" CommandArgument='<%#Eval("QuestionAId") %>' CssClass="floatright"/></p>
                      <p><%#Eval("Question","题干-{0}")%></p>
                      <p><%#Eval("A", "A-{0}")%></p>
                      <p><%#Eval("B","B-{0}") %></p>
                      <p><%#Eval("C","C-{0}") %></p>
                      <asp:Label ID="itemd" runat="server" Text='<%#Eval("D","D-{0}") %>'></asp:Label>
                      <p>参考答案：<%#Eval("Answer") %></p>
                    </ItemTemplate>               
                    <ItemStyle BorderColor="#999966" BorderStyle="Dashed" />
                </asp:DataList>
                <asp:SqlDataSource ID="SDmodifyb" runat="server" SelectCommandType="StoredProcedure"
                 SelectCommand="usp_PreShowQB" 
                    ConnectionString='<%$ ConnectionStrings:ConnectionString %>' 
                    OnSelecting="SDmodifyb_Selecting">
                    <SelectParameters>
                       <asp:SessionParameter Name="ids" DbType="String" SessionField="QBId" />
                    </SelectParameters>
                </asp:SqlDataSource>
                  <asp:DataList ID="DLmodifyb" runat="server" DataSourceID="SDmodifyb" 
                    Width="100%" 
                    EnableViewState="false"
                    OnItemCommand="DLmodifyb_ItemCommand" ItemStyle-BorderStyle="Dashed" ItemStyle-BorderColor="#999966"> 
                      <HeaderStyle BackColor="#FFFF99" HorizontalAlign="Center" />
                    <HeaderTemplate>
                       问答题：
                    </HeaderTemplate>
                    <ItemTemplate>
                      <p style="width:100%">分值：<%# ((Exam)Session["handexam"]).GetbMarkById(Convert.ToInt32(Eval("QuestionBId"))).ToString()%>;<asp:LinkButton
                           ID="btremoveb" runat="server" Text="移除此题" Font-Size="Small" ForeColor="#0000CC" CommandName="btremoveb_command" CommandArgument='<%#Eval("QuestionBId") %>' CssClass="floatright"/></p>
                      <p><%#Eval("Question","题干-{0}")%></p>
                      <p>参考答案：<%#Eval("Answer") %></p>
                    </ItemTemplate>               
                      <ItemStyle BorderColor="#999966" BorderStyle="Dashed" />
                </asp:DataList>              
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep2" runat="server" Title="统计添加" 
                OnActivate="wizardstep2_OnActivate" StepType="Step">
                已添加有效试题信息：
                <table style="width: 35%;" align="center">
                    <tr>
                        <td>
                            
                        </td>
                        <td>
                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                           选择题数量：
                        </td>
                        <td>
                            <asp:Label ID="lbaCount" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                           选择题总分值：
                        </td>
                        <td>
                            <asp:Label ID="lbamark" runat="server"></asp:Label>
                        </td>
                    </tr>
                     <tr>
                        <td>
                            问答题数量：
                        </td>
                        <td>
                            <asp:Label ID="lbbCount" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            问答题总分值：
                        </td>
                        <td>
                            <asp:Label ID="lbbmark" runat="server"></asp:Label>
                        </td>
                    </tr>
                     <tr>
                        <td>
                           总题数：
                        </td>
                        <td>
                            <asp:Label ID="lbTCount" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            总分值：
                        </td>
                        <td>
                           <asp:Label ID="lbTmark" runat="server"></asp:Label>
                        </td>
                    </tr>                                                           
                </table>           
            </asp:WizardStep>
            <asp:WizardStep ID="WSfinal" runat="server" Title="其它信息" OnActivate="step3_onactivate" 
                StepType="Finish">
                <table style="width: 100%;" align="left">
                    <tr>
                        <td style="width:190px">
                            试卷标题：
                        </td>
                        <td style="width:230px">
                            <asp:TextBox ID="txttitle3" runat="server"></asp:TextBox><asp:RequiredFieldValidator
                                ID="vatxttitle3" runat="server" ErrorMessage="*" ControlToValidate="txttitle3" Display="Dynamic" ValidationGroup="handcreate3"></asp:RequiredFieldValidator>
                        </td>
                        <td style="width:230px">
                            答题截止时间： 
                        </td>
                        <td style="width:230px">
                            <asp:TextBox ID="lbendtime3" runat="server" Text="请选择"></asp:TextBox><asp:RequiredFieldValidator
                    ID="RequiredFieldValidator3" runat="server" ErrorMessage="**" ValidationGroup="handcreate3" InitialValue="请选择" ControlToValidate="lbendtime3"></asp:RequiredFieldValidator>
                            <asp:CalendarExtender ID="CalendarExtender3" runat="server" Enabled="True" 
                                PopupButtonID="SLendtime3" PopupPosition="Right" TargetControlID="lbendtime3" Format="yyyy-MM-dd">
                            </asp:CalendarExtender>
                            <asp:Button ID="SLendtime3" runat="server" Text="选择" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            考试持续分钟数： 
                        </td>
                        <td>
                            <asp:TextBox ID="txttime3" runat="server" Width="50px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="vatxttime3" runat="server" 
                                ControlToValidate="txttime3" Display="Dynamic" ErrorMessage="*" 
                                ValidationGroup="handcreate3"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="vatxttime3a" runat="server" 
                                ControlToValidate="txttime3" Display="Dynamic" ErrorMessage="必须为正整数" 
                                MaximumValue="1000" MinimumValue="0" Type="Integer" 
                                ValidationGroup="handcreate3"></asp:RangeValidator>
                        </td>
                        <td>
                            试卷过期时间： 
                        </td>
                        <td>
                            <asp:TextBox ID="lbdeletetime3" runat="server" Text="请选择"></asp:TextBox><asp:RequiredFieldValidator
                                ID="RequiredFieldValidator4" runat="server" ErrorMessage="**" ValidationGroup="handcreate3" ControlToValidate="lbdeletetime3" InitialValue="请选择"></asp:RequiredFieldValidator>
                            <asp:CalendarExtender ID="CalendarExtender4" runat="server" Enabled="True" 
                                PopupButtonID="SLdeletetime3" PopupPosition="Right" 
                                TargetControlID="lbdeletetime3" Format="yyyy-MM-dd">
                            </asp:CalendarExtender>
                            <asp:Button ID="SLdeletetime3" runat="server" Text="选择" />
                        </td>
                    </tr>
                </table> 
            </asp:WizardStep>
        </WizardSteps>
    </asp:Wizard>
  </div>
</asp:Panel>
<asp:Panel ID="Delete" runat="server">
    <asp:SqlDataSource ID="SDDelete" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
        SelectCommand="usp_ShowExam" SelectCommandType="StoredProcedure" DeleteCommand="usp_DeleteExam" DeleteCommandType="StoredProcedure">
        <DeleteParameters>
           <asp:Parameter Name="ExamId" DbType="Int32"/>
        </DeleteParameters>
        
        </asp:SqlDataSource>
    <asp:GridView ID="GVDelete" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SDDelete" 
        Width="720px" onrowdatabound="GVDelete_RowDataBound" DataKeyNames="ExamId" >
        <Columns>
         <asp:TemplateField HeaderText="试卷标题" ItemStyle-Width="470px">
           <ItemTemplate>
               <asp:LinkButton ID="lbTitle" runat="server" Text='<%#SubStr(Eval("Title").ToString(),20)%>'></asp:LinkButton>
           </ItemTemplate>
             <ItemStyle Width="470px" />
         </asp:TemplateField>
            <asp:BoundField DataField="CreateTime" DataFormatString="{0:d}" 
                HeaderText="生成时间">
                <ItemStyle Width="100px" />
            </asp:BoundField>
            <asp:BoundField DataField="EndTime" DataFormatString="{0:d}" HeaderText="结束时间">
                <ItemStyle Width="100px" />
            </asp:BoundField>
          <asp:CommandField ShowDeleteButton="true" DeleteText="删除" />
        </Columns>
        <AlternatingRowStyle BackColor="#DEDEDE" />
    </asp:GridView>
</asp:Panel>
</ContentTemplate>
</asp:UpdatePanel>