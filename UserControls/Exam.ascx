<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Exam.ascx.cs" Inherits="UserControls_Exam" %>
<div id = "timediv">

</div>

<script  type="text/javascript">
 var ss=0, mm=0, hh=0,total=0;
 var Hours,Minutes,Seconds; 
 var hour=0,minute=0,second=0;
 var today;
 var i = 0;
 mycookie = document.cookie;
 function readcookie(name)
 {
var start1 = mycookie.indexOf(name + "=");
if (start1 != -1)
{
start=mycookie.indexOf("=",start1)+1; 
var end = mycookie.indexOf(";",start);
 if (end==-1)
  {
   end=mycookie.length;
}
   var value=unescape(mycookie.substring(start,end));
   if (value != null)   
   {return value;}
   else
   {
   return -1;
   }
}
else
{
return -1;
}
return -1;
}

function Go()
{
i = setInterval("TimeGo()",1000);

}
 function Stop()
 {
clearInterval(i);
 }
function TimeGo() {


if(readcookie("Seconds") != -1)
{
  var today;
 today = new Date();
 hour=today.getHours();
 minute=today.getMinutes();
 second=today.getSeconds(); 
 ss = parseInt(readcookie("Seconds")); 
 mm = parseInt(readcookie("Minutes"));
 hh = parseInt(readcookie("Hours"));
 hh = (hour - hh) * 3600;
 mm = (minute - mm) * 60;
 ss = (second - ss); 
total = hh + mm + ss;
hh = parseInt(total / 3600) ;
total = total % 3600;
mm = parseInt(total / 60);
ss = total % 60; 
}
else
{         
today = new Date();
Hours=today.getHours() + "";
Minutes=today.getMinutes() + "";
Seconds=today.getSeconds() + "";
document.cookie = "Hours=" + Hours + ";";
document.cookie = "Minutes=" + Minutes+ ";";
document.cookie = "Seconds=" + Seconds+ ";";
}


  
   ss++; 
   if(ss>=60) {
      mm+=1; 
      ss=0; 
   }
   if(mm>=60) { 
      hh+=1;    
   mm=0; 
   }
   ss_str=(ss<10 ? "0" + ss : ss); 
   mm_str=(mm<10 ? "0" + mm : mm); 
   tMsg="所用时间: " + hh + "小时" + mm_str + "分" + ss_str + "秒"; 
   document.getElementById('timediv').innerText=tMsg; 
   window.status = tMsg;
   
   
}

</script>
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
        <asp:Wizard ID="WizardExam" runat="server" ActiveStepIndex="0" 
    BackColor="#EFF3FB" BorderColor="#B5C7DE" BorderWidth="1px" 
    Font-Names="Verdana" Font-Size="1.2em" 
    onnextbuttonclick="WizardExam_NextButtonClick" 
    StartNextButtonText="开始" Width="100%" onprerender="WizardExam_PreRender" 
    onfinishbuttonclick="WizardExam_FinishButtonClick" 
    onpreviousbuttonclick="WizardExam_PreviousButtonClick">
            <StepStyle Font-Size="0.8em" ForeColor="#333333" />
            <StartNavigationTemplate>
                <asp:Button ID="Button3" runat="server" Text="开始" CommandName="MoveNext" 
             style="height: 26px" />
            </StartNavigationTemplate>
            <WizardSteps>
                <asp:WizardStep runat="server">
                    请选择一项后开始：<br />
                    <br />
                    <br />
                    <asp:RadioButton ID="RadioBtnTest" runat="server" GroupName="A" Text="模拟训练" />
                    <br />
                    <br />
                    <br />
                    <asp:RadioButton ID="RadioBtnExam" runat="server" GroupName="A" 
                Text="     考       试" />
                </asp:WizardStep>
                <asp:WizardStep runat="server">
                    <asp:DataList ID="DataListTest1" runat="server" DataKeyField="QuestionAId" 
                DataSourceID="SqlDataSource1" CellPadding="4" ForeColor="#333333">
                        <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <ItemStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <ItemTemplate>
                            <%# Container.ItemIndex + 1%>.Question:
                            <asp:Label ID="QuestionLabel" runat="server" Text='<%# Eval("Question") %>' />
                            <br />
                            <asp:Label ID="LabelTestAId1" runat="server" Text='<%# Eval("QuestionAId") %>' 
                        Visible="False" />
                            <asp:Label ID="Ans" runat="server" Text='<%# Eval("Answer") %>' Visible="False"></asp:Label>
                            <asp:Label ID="Ana" runat="server" Text='<%# Eval("Analysis") %>' 
                        Visible="False"></asp:Label>
                            <br />
                            <asp:RadioButton ID="RaBtnA" runat="server" 
                        Text='<%# Eval("A", "A - {0}") %>' GroupName="A" />
                            &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;<asp:RadioButton ID="RaBtnB" runat="server" 
                        Text='<%# Eval("B", "B - {0}") %>' GroupName="A" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<asp:RadioButton ID="RaBtnC" runat="server" 
                        Text='<%# Eval("C", "C - {0}") %>' GroupName="A" />
                            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<asp:RadioButton ID="RaBtnD" runat="server" 
                        Text='<%# Eval("D", "D - {0}") %>' GroupName="A" />
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                        </ItemTemplate>
                        <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 10 [Question],[QuestionAId],[A],[B],[C],[D],Answer,Analysis FROM QuestionA  WHERE  len(Answer)=1 ORDER BY NEWID() 
"></asp:SqlDataSource>
                </asp:WizardStep>
                <asp:WizardStep runat="server">
                    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT TOP 5 [Question],[QuestionAId],[A],[B],[C],[D],Answer,Analysis FROM QuestionA  WHERE  len(Answer)&gt;1 ORDER BY NEWID() 
"></asp:SqlDataSource>
                    <asp:DataList ID="DataListTest2" runat="server" DataKeyField="QuestionAId" 
                DataSourceID="SqlDataSource2" style="margin-right: 69px" CellPadding="4" 
                ForeColor="#333333">
                        <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <ItemStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <ItemTemplate>
                            <%#  DataListTest1.Items.Count + Container.ItemIndex + 1%>.Question:
                            <asp:Label ID="QuestionLabel" runat="server" Text='<%# Eval("Question") %>' />
                            <br />
                            &nbsp;<asp:Label ID="LabelTestAId2" runat="server" 
                        Text='<%# Eval("QuestionAId") %>' Visible="False" />
                            <asp:Label ID="Ans" runat="server" Text='<%# Eval("Answer") %>' Visible="False"></asp:Label>
                            <asp:Label ID="Ana" runat="server" Text='<%# Eval("Analysis") %>' 
                        Visible="False"></asp:Label>
                            <br />
                            <asp:CheckBox ID="CheckBoxA" runat="server" 
                        Text='<%# Eval("A", "A - {0}") %>' />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox ID="CheckBoxB" 
                        runat="server" Text='<%# Eval("B", "B - {0}") %>' />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="CheckBoxC" runat="server" 
                        Text='<%# Eval("C", "C - {0}") %>' />
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="CheckBoxD" runat="server" 
                        Text='<%# Eval("D", "D - {0}") %>' />
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <br />
                        </ItemTemplate>
                        <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    </asp:DataList>
                </asp:WizardStep>
                <asp:WizardStep runat="server" StepType="Step">
                    <asp:DataList ID="DataListTest3" runat="server" DataKeyField="QuestionBId" 
                DataSourceID="SqlDataSource3" CellPadding="4" ForeColor="#333333">
                        <AlternatingItemStyle BackColor="White" ForeColor="#284775" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <ItemStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <ItemTemplate>
                            <%#  DataListTest2.Items.Count+DataListTest1.Items.Count + Container.ItemIndex + 1%>.Question:
                            <asp:Label ID="QuestionLabel" runat="server" Text='<%# Eval("Question") %>' />
                            <br />
                            &nbsp;<asp:Label ID="LabelTestBId" runat="server" Text='<%# Eval("QuestionBId") %>' 
                        Visible="False" />
                            <br />
                            <asp:TextBox ID="TextBoxAns" runat="server" Height="60px" TextMode="MultiLine" 
                        Width="557px"></asp:TextBox>
                            <br />
                        </ItemTemplate>
                        <SelectedItemStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                    </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                
                
                        SelectCommand="SELECT TOP 3 [Question],[QuestionBId] FROM QuestionB  ORDER BY NEWID() ">
                    </asp:SqlDataSource>
                </asp:WizardStep>
                <asp:WizardStep runat="server">
                    <asp:Label ID="Label4" runat="server" Text="请选择一张试卷："></asp:Label>
                    <asp:SqlDataSource ID="SqlDataSource9" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="usp_SelectExam" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="UserName" 
                        SessionField="UserName" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView1" runat="server" 
                AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ExamId" 
                DataSourceID="SqlDataSource9" 
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="100%">
                        <Columns>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="ExamId" HeaderText="编号" 
                        InsertVisible="False" ReadOnly="True" SortExpression="ExamId" />
                            <asp:BoundField DataField="Title" HeaderText="试卷" 
                        SortExpression="Title">
                                <ItemStyle Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Time" DataFormatString="{0}分钟" 
                        HeaderText="考试时间" SortExpression="Time" />
                            <asp:BoundField DataField="EndTime" 
                        DataFormatString="{0:yyyy年M月dd日}" HeaderText="交卷截止时间" 
                        SortExpression="EndTime" />
                        </Columns>
                    </asp:GridView>
                    <br />
                </asp:WizardStep>
                <asp:WizardStep runat="server">

                    

                    <asp:Label ID="Label5" runat="server" Text="单项选择题："></asp:Label>

                    <asp:DataList ID="DataListExam1" runat="server" DataSourceID="SqlDataSource6" 
                DataKeyField="QuestionAId">
                        <ItemTemplate>
                            <%# Container.ItemIndex + 1%>.Question:<asp:Label ID="QuestionLabel" 
                         runat="server" Text='<%# Eval("Question") %>'></asp:Label>
                            <br />
                            <asp:Label ID="LabelExamAId1" runat="server" Text='<%# Eval("QuestionAId") %>' 
                        Visible="False"></asp:Label>
                            <asp:Label ID="Ans" runat="server" Text='<%# Eval("Answer") %>' Visible="False"></asp:Label>
                            <asp:Label ID="Ana" runat="server" Text='<%# Eval("Analysis") %>' 
                         Visible="False"></asp:Label>
                            <asp:Label ID="Score" runat="server" Text='<%# Eval("Score") %>' 
                         Visible="False"></asp:Label>
                            <br />
                            <asp:RadioButton ID="RaBtnA" runat="server" 
                         Text='<%# Eval("A", "A - {0}") %>' GroupName="A" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:RadioButton ID="RaBtnB" runat="server" 
                         Text='<%# Eval("B", "B - {0}") %>' GroupName="A" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:RadioButton ID="RaBtnC" runat="server" 
                         Text='<%# Eval("C", "C - {0}") %>' GroupName="A" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:RadioButton ID="RaBtnD" runat="server" 
                         Text='<%# Eval("D", "D - {0}") %>' GroupName="A" />
                            <br />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource6" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="usp_SelectQuestionA1" SelectCommandType="StoredProcedure" 
                EnableCaching="True">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="ExamId" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </asp:WizardStep>
                <asp:WizardStep runat="server">
                    

                    <asp:Label ID="Label6" runat="server" Text="多项选择题："></asp:Label>

                    <asp:DataList ID="DataListExam2" runat="server" DataSourceID="SqlDataSource7" 
                DataKeyField="QuestionAId">
                        <ItemTemplate>
                            <%#  DataListExam1.Items.Count + Container.ItemIndex + 1%>.Question:<asp:Label 
                        ID="QuestionLabel" runat="server" 
                        Text='<%# Eval("Question") %>'></asp:Label>
                            <br />
                            <asp:Label ID="LabelExamAId2" runat="server" Text='<%# Eval("QuestionAId") %>' 
                        Visible="False"></asp:Label>
                            <asp:Label ID="Ans" runat="server" Text='<%# Eval("Answer") %>' Visible="False"></asp:Label>
                            <asp:Label ID="Ana" runat="server" Text='<%# Eval("Analysis") %>' 
                        Visible="False"></asp:Label>
                            <asp:Label ID="Score" runat="server" Text='<%# Eval("Score") %>' 
                        Visible="False"></asp:Label>
                            <br />
                            <asp:CheckBox ID="CheckBoxA" runat="server" Text='<%# Eval("A","A - {0}") %>' />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="CheckBoxB" runat="server" Text='<%# Eval("B","B - {0}") %>' />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:CheckBox ID="CheckBoxC" runat="server" Text='<%# Eval("C","C - {0}") %>' />
                            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
                            <asp:CheckBox ID="CheckBoxD" runat="server" Text='<%# Eval("D","D - {0}") %>' />
                            <br />
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource7" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="usp_SelectQuestionA2" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="ExamId" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </asp:WizardStep>
                <asp:WizardStep runat="server">
                    

                    <asp:Label ID="Label7" runat="server" Text="简答题："></asp:Label>

                    <asp:DataList ID="DataListExam3" runat="server" DataSourceID="SqlDataSource8">
                        <ItemTemplate>
                            <%#  DataListExam2.Items.Count+DataListExam1.Items.Count + Container.ItemIndex + 1%>.Question:<asp:Label 
                        ID="QuestionLabel" runat="server" 
                        Text='<%# Eval("Question") %>'></asp:Label>
                            <br />
                            <asp:Label ID="LabelExamBId" runat="server" Text='<%# Eval("QuestionBId") %>' 
                        Visible="False"></asp:Label>
                            <br />
                            <asp:TextBox ID="TextBox1" runat="server" Height="59px" TextMode="MultiLine" 
                        Width="424px"></asp:TextBox>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="SqlDataSource8" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
                SelectCommand="usp_SelectQuestionB" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="ExamId" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </asp:WizardStep>
                <asp:WizardStep runat="server" StepType="Complete">
                    <asp:Label ID="Label1" runat="server" Text="单选："></asp:Label>
                    <asp:BulletedList ID="BulletedList1" runat="server">
                    </asp:BulletedList>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <asp:Label ID="Label2" runat="server" Text="多选："></asp:Label>
                    <br />
                    <asp:BulletedList ID="BulletedList2" runat="server" style="margin-bottom: 19px">
                    </asp:BulletedList>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <asp:Label ID="timepast" runat="server"></asp:Label>
                </asp:WizardStep>
            </WizardSteps>
            <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" 
        ForeColor="White" />
            <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" 
        BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" 
        ForeColor="#284E98" />
            <SideBarStyle Font-Size="0.9em" VerticalAlign="Top" />
            <FinishNavigationTemplate>
                <asp:Button ID="FinishPreviousButton" runat="server" BackColor="White" 
            BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" 
            CausesValidation="False" CommandName="MovePrevious" Font-Names="Verdana" 
            Font-Size="0.8em" ForeColor="#284E98" Text="上一步" />
                <asp:Button ID="FinishButton" runat="server" BackColor="White" 
            BorderColor="#507CD1" BorderStyle="Solid" BorderWidth="1px" 
            CommandName="MoveComplete" Font-Names="Verdana" Font-Size="0.8em" 
            ForeColor="#284E98" Text="完成" />
            </FinishNavigationTemplate>
            <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" 
        BorderWidth="2px" Font-Bold="True" Font-Size="0.9em" ForeColor="White" 
        HorizontalAlign="Center" />
            <HeaderTemplate>
                信息安全考试系统<br />
            </HeaderTemplate>
            <StepNavigationTemplate>
                <asp:Button ID="Button1" runat="server" CommandName="MovePrevious" Text="上一步" />
                <asp:Button ID="Button2" runat="server" 
            CommandName="MoveNext" Text="下一步" />
            </StepNavigationTemplate>
        </asp:Wizard>
    </ContentTemplate>
</asp:UpdatePanel>

