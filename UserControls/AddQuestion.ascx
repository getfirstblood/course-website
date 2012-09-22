<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddQuestion.ascx.cs" Inherits="UserControls_AddQuestion"%>

<asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
    Height="24px" Width="109px" 
    onselectedindexchanged="DropDownList1_SelectedIndexChanged">
    <asp:ListItem Value="select">选择题</asp:ListItem>
    <asp:ListItem Value="ask">问答题</asp:ListItem>
</asp:DropDownList>
    <asp:Panel runat="server" ID="select">
      <table style="width:100%;margin:0 auto">
        <tr>
          <td style="width:80px">
            题目：
          </td>
          <td>
              <asp:TextBox ID="txtquestion" runat="server" TextMode="MultiLine" Width="100%" Height="70px"></asp:TextBox>
              <asp:RequiredFieldValidator ID="vatxtquestion" runat="server" 
                  ControlToValidate="txtquestion" Display="Dynamic" ErrorMessage="*" 
                  ValidationGroup="insertselect">必填</asp:RequiredFieldValidator>
          </td>
        </tr>
        <tr>
         <td>
           A选项：
         </td>
         <td>
             <asp:TextBox ID="txtA" runat="server" CssClass="textboxa"></asp:TextBox>
             <asp:RequiredFieldValidator ID="vatxtA" runat="server" ControlToValidate="txtA" 
                 Display="Dynamic" EnableViewState="False" ErrorMessage="*" 
                 ValidationGroup="insertselect">必填</asp:RequiredFieldValidator>
         </td>
        </tr>
        <tr>
           <td>
            B选项：
           </td>
           <td>
               <asp:TextBox ID="txtB" runat="server" CssClass="textboxa"></asp:TextBox>
               <asp:RequiredFieldValidator ID="vatxtB" runat="server" ControlToValidate="txtB" 
                   ErrorMessage="*" ValidationGroup="insertselect">必填</asp:RequiredFieldValidator>
           </td>
        </tr>
        <tr>
         <td>
         C选项：
         </td>
         <td>
             <asp:TextBox ID="txtC" runat="server" CssClass="textboxa"></asp:TextBox>
             <asp:RequiredFieldValidator ID="vatxtC" runat="server" ControlToValidate="txtC" 
                 Display="Dynamic" ErrorMessage="*" ValidationGroup="insertselect">必填</asp:RequiredFieldValidator>
         </td>
        </tr>
        <tr>
         <td>
         D选项：
         </td>
         <td>
             <asp:TextBox ID="txtD" runat="server" CssClass="textboxa"></asp:TextBox>
             选填</td>
        </tr>
        <tr>
          <td>
            试题评级：
          </td>
          <td>
              <asp:DropDownList ID="selectlevel" runat="server">
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
              </asp:DropDownList>
              <asp:RequiredFieldValidator ID="vaselectl" runat="server" 
                  ControlToValidate="selectlevel" Display="Dynamic" ErrorMessage="必填" 
                  InitialValue="0" ValidationGroup="insertselect"></asp:RequiredFieldValidator>
              (某种合理的评级方式，如此题涉及第5章的知识，则可将其评级设为5，便于作为生成试卷的依据)</td>
        </tr>
        <tr>
          <td>
            标签：
          </td>
          <td>
              <asp:TextBox ID="txtTag" runat="server" CssClass="textboxa"></asp:TextBox><asp:RequiredFieldValidator
                  ID="vatag" runat="server" ErrorMessage="必填" ControlToValidate="txtTag" 
                  Display="Dynamic" ValidationGroup="insertselect"></asp:RequiredFieldValidator>
              （若干关键词，以逗号分隔，提供以后检索的依据）</td>
        </tr>
        <tr>
         <td>
           题目类型：
         </td>
         <td>
             <asp:DropDownList ID="selecttype" runat="server" Height="25px" Width="131px">
                 <asp:ListItem Value="exam">不公开的考试用题</asp:ListItem>
                 <asp:ListItem Value="practise">公开的练习用题</asp:ListItem>
             </asp:DropDownList>
             <asp:RequiredFieldValidator ID="vatype" runat="server" 
                 ControlToValidate="selecttype" Display="Dynamic" ErrorMessage="*" 
                 ValidationGroup="insertselect">必选</asp:RequiredFieldValidator>
         </td>
        </tr>
        <tr>
          <td>
            参考答案：
          </td>
          <td>
              <asp:CheckBoxList ID="selectanser" runat="server" RepeatDirection="Horizontal">
                  <asp:ListItem>A</asp:ListItem>
                  <asp:ListItem>B</asp:ListItem>
                  <asp:ListItem>C</asp:ListItem>
                  <asp:ListItem>D</asp:ListItem>
              </asp:CheckBoxList>
              &nbsp;</td>
        </tr>
        <tr>
         <td>
           答案解析：
         </td>
         <td>
             <asp:TextBox ID="txtanalysis" runat="server" CssClass="textboxb" 
                 TextMode="MultiLine"></asp:TextBox>
             选填</td>
        </tr>
      </table>
        <p style="margin:0 auto;width:70px;padding:0;">
            <asp:Button ID="update" runat="server" Text="提交" style="margin:0 auto" 
                ValidationGroup="insertselect" onclick="update_Click"/>
        </p>
    </asp:Panel> 
<asp:Panel ID="ask" runat="server">
    <table style="width: 100%;margin:0 auto;">
        <tr>
            <td style="width:80px;">
                题目：
            </td>
            <td>
                <asp:TextBox ID="txtquestionb" runat="server" TextMode="MultiLine" Height="70px" Width="100%"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vaquestionb" runat="server" 
                    ControlToValidate="txtquestionb" Display="Dynamic" ErrorMessage="必填" 
                    ValidationGroup="insertask"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td>
                答案：
            </td>
            <td>
                <asp:TextBox ID="txtanserb" runat="server" TextMode="MultiLine" Width="100%" Height="70px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="vaanserb" runat="server" 
                    ControlToValidate="txtanserb" Display="Dynamic" ErrorMessage="必填" 
                    ValidationGroup="insertask"></asp:RequiredFieldValidator>
            </td>
        </tr>
        
        <tr>
            <td>
                答案解析：<br />
                (选填)
            </td>
            <td>
                <asp:TextBox ID="txtanalysisb" runat="server" TextMode="MultiLine" Width="100%" Height="70px"></asp:TextBox>
            </td>
        </tr>
        <tr>
          <td>
             试题评级：
          </td>
          <td>
              <asp:DropDownList ID="asklevel" runat="server">
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
              </asp:DropDownList>
              <asp:RequiredFieldValidator ID="vaaskl" runat="server" 
                  ControlToValidate="asklevel" Display="Dynamic" ErrorMessage="必填" 
                  InitialValue="0" ValidationGroup="insertask"></asp:RequiredFieldValidator>
              (某种合理的评级方式，如此题涉及第5章的知识，则可将其评级设为5，便于作为生成试卷的依据)</td>
        </tr>
        <tr>
          <td>
            标签：
          </td>
          <td>
              <asp:TextBox ID="txtTagb" runat="server" CssClass="textboxa"></asp:TextBox><asp:RequiredFieldValidator
                  ID="vatagb" runat="server" ErrorMessage="必填" ControlToValidate="txtTagb" 
                  Display="Dynamic" ValidationGroup="insertask"></asp:RequiredFieldValidator>
              （若干关键词，以逗号分隔，提供以后检索的依据）</td>
        </tr>
        <tr>
           <td>
              题目类型：
           </td>
           <td>
               <asp:DropDownList ID="asktype" runat="server" Height="24px" Width="155px">
                   <asp:ListItem Value="exam">不公开的考试用题</asp:ListItem>
                   <asp:ListItem Value="practise">公开的练习用题</asp:ListItem>
               </asp:DropDownList>
               <asp:RequiredFieldValidator ID="vaasktype" runat="server" 
                   ControlToValidate="asktype" Display="Dynamic" ErrorMessage="必填" 
                   ValidationGroup="insertask"></asp:RequiredFieldValidator>
           </td>
        </tr>
    </table>
    <p style="width:70px;margin:0 auto">
        <asp:Button ID="updateask" runat="server" Text="提交" 
            Style="margin:0 auto;padding:0;" onclick="updateask_Click" 
            ValidationGroup="insertask"/></p>
</asp:Panel>