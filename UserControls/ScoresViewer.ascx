<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ScoresViewer.ascx.cs" Inherits="UserControls_ScoresViewer" %>
<asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
    AutoGenerateColumns="False" 
    onrowdatabound="GridView1_RowDataBound" PageSize="3" BackColor="White" 
    BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
    Width="100%" onprerender="GridView1_PreRender" 
    onpageindexchanging="GridView1_PageIndexChanging">
    <RowStyle BackColor="White" ForeColor="#330099" />
    <Columns>
        <asp:TemplateField>
            <HeaderTemplate>
                试卷编号<br />
            </HeaderTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Eval("ExamId") %>' oncommand="LinkButton_Command" 
                    CommandArgument='<%# Eval("ExamId") %>' CommandName="OnClick"></asp:LinkButton>
            </ItemTemplate>
            <ItemStyle Width="80px" />
        </asp:TemplateField>
        <asp:TemplateField>
            <HeaderTemplate>
                试卷名
            </HeaderTemplate>
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton2" runat="server" Text='<%# Eval("Title") %>' 
                    oncommand="LinkButton_Command" CommandArgument='<%# Eval("ExamId") %>' 
                    CommandName="OnClick"></asp:LinkButton>
            </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="交卷截止日期">
            <ItemTemplate>
                <asp:LinkButton ID="LinkButton3" runat="server" oncommand="LinkButton_Command" 
                    Text='<%# Eval("EndTime", "{0:yyyy年M月dd日}") %>' CommandArgument='<%# Eval("ExamId") %>' 
                    CommandName="OnClick"></asp:LinkButton>
            </ItemTemplate>
            <ItemStyle Width="150px" />
        </asp:TemplateField>
    </Columns>
    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
</asp:GridView>
<p>
    <asp:Label ID="LabelScore1" runat="server" Text="Label"></asp:Label>
    <asp:Label ID="LabelScore2" runat="server" Text="Label"></asp:Label>
    <asp:Label ID="LabelScores" runat="server" Text="Label"></asp:Label>
    <br />
</p>
<asp:DataList ID="DataList1" runat="server" DataSourceID="SqlDataSource2" 
    onitemdatabound="DataList1_ItemDataBound" Width="100%">
    <ItemTemplate>
    <hr size="1″ color="#ff7755″/>
    <%#  Container.ItemIndex + 1%>.
        <asp:Label ID="LabelQue" runat="server" Text='<%# Eval("Question","题目:{0}") %>'></asp:Label>
        <asp:Label ID="LabelQAId" runat="server" Text='<%# Eval("QAId") %>' 
            Visible="False"></asp:Label>
        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Mark","该题分值：{0}") %>'></asp:Label>
        <asp:Label ID="LabelScore" runat="server" Text='<%# Eval("ScoreA") %>' 
            Visible="False"></asp:Label>
        <asp:Label ID="LabelAns" runat="server" Text='<%# Eval("Answer") %>' 
            Visible="False"></asp:Label>
        <asp:Label ID="LabelStdAns" runat="server" Text='<%# Eval("StdAns") %>' 
            Visible="False"></asp:Label>
        <br />
        <br />
        <p>
        <asp:RadioButton ID="A" runat="server" Text='<%# Eval("A","A. {0}") %>' />
        &nbsp;<asp:Image ID="Image1" runat="server" Height="18px" Width="18px" 
            Visible="False" /></p>
        <p>
        <asp:RadioButton ID="B" runat="server" Text='<%# Eval("B","B. {0}") %>' 
            
            style="text-align: right;  background-color: #FFFFFF" 
            oncheckedchanged="B_CheckedChanged" />
        &nbsp;<asp:Image ID="Image2" runat="server" Height="18px" Visible="False" 
            Width="18px" /></p>
        <p>
        <asp:RadioButton ID="C" runat="server" Text='<%# Eval("C","C. {0}") %>' />
        &nbsp;<asp:Image ID="Image3" runat="server" Height="18px" Visible="False" 
            Width="18px" /></p>
            <p>
        <asp:RadioButton ID="D" runat="server" Text='<%# Eval("D","D. {0}") %>' style="text-align: right" />
        <asp:Image ID="Image4" runat="server" Visible="False" /></p>
    </ItemTemplate>
</asp:DataList>
<p>
    <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource1" 
        onprerender="DataList2_PreRender" Width="100%">
        <ItemTemplate>
        <hr size="1″ color="#ff7755″/>
        <%# DataList1.Items.Count + Container.ItemIndex + 1%>.
            <asp:Label ID="Label4" runat="server" Text='<%# Eval("Question","题目：{0}") %>'></asp:Label>
            <asp:Label ID="Label5" runat="server" Text='<%# Eval("Mark","该题分值：{0}") %>'></asp:Label>
            <asp:Label ID="Label10" runat="server" Text="本题得分："></asp:Label>
            <asp:Label ID="LabelScore" runat="server" Text='<%# Eval("ScoreB") %>'></asp:Label>
            <br />
            <asp:Label ID="Label8" runat="server" Text="您的答案："></asp:Label>
            <br />
            <asp:TextBox ID="TextBox1" runat="server" ReadOnly="True" TextMode="MultiLine" 
                Width="100%" Text='<%# Eval("Answer") %>'></asp:TextBox>
            <br />
            <asp:Label ID="Label9" runat="server" Text="点评："></asp:Label>
            <br />
            <asp:TextBox ID="TextBox2" runat="server" ReadOnly="True" TextMode="MultiLine" 
                Width="100%" Text='<%# Eval("Comment") %>'></asp:TextBox>
        </ItemTemplate>
    </asp:DataList>
</p>
<asp:SqlDataSource ID="SqlDataSource2" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
    SelectCommand="usp_ShowDetailsForStu3" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="ExamId" Type="Int32" />
        <asp:Parameter Name="UserName" Type="String" />
    </SelectParameters>
</asp:SqlDataSource>
<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>" 
    SelectCommand="usp_ShowDetailsForStu2" SelectCommandType="StoredProcedure">
    <SelectParameters>
        <asp:Parameter Name="UserName" Type="String" />
        <asp:Parameter Name="ExamId" Type="Int32" />
    </SelectParameters>
</asp:SqlDataSource>

