using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;

public partial class UserControls_Exam : System.Web.UI.UserControl
{
    static string ScoreA = "";
    static String UserAnsA = "";
    String UserAnsB = "";
    static String QAId = "";
    String QBId = "";
    static System.DateTime timeBegin;
    static System.DateTime timeEnd;
    static string time = "";
    static Boolean checktime = false;
    
    
    protected void Page_Load(object sender, EventArgs e)
    {
       

    }

 
    protected void WizardExam_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if(e.CurrentStepIndex == 0)
        {
          if (RadioBtnExam.Checked)
          {
              //SqlDataSource9.SelectParameters["UserName"].DefaultValue = Session["UserName"].ToString();
              
              WizardExam.ActiveStepIndex = 4;
              
              return;
          }
          else if(RadioBtnTest.Checked)
          {
              WizardExam.ActiveStepIndex = 1;
              return;
          }
          
        }
        if (e.CurrentStepIndex == 3)
        {
            
            WizardExam.ActiveStepIndex = 8;
            BulletedList1.Items.Clear();
            BulletedList2.Items.Clear();
            int n1 = 0;
            int n2 = DataListTest1.Items.Count;
            foreach (DataListItem item1 in DataListTest1.Items)
            {


                string Ans = "";
                Label lbl = (Label)item1.FindControl("LabelTestAId1");
                Label ana = (Label)item1.FindControl("Ana");
                RadioButton A = ((RadioButton)item1.FindControl("RaBtnA"));
                RadioButton B = ((RadioButton)item1.FindControl("RaBtnB"));
                RadioButton C = ((RadioButton)item1.FindControl("RaBtnC"));
                RadioButton D = ((RadioButton)item1.FindControl("RaBtnD"));
                Label Answer = (Label)item1.FindControl("Ans");

                if (A.Checked)
                {
                    Ans = "A";
                }
                else if (B.Checked)
                {
                    Ans = "B";
                }
                else if (C.Checked)
                {
                    Ans = "C";
                }
                else if (D.Checked)
                {
                    Ans = "D";
                }
                n1 += 1;

                if (Ans == Answer.Text)
                {
                    BulletedList1.Items.Add(new ListItem(n1.ToString() + ":" + Ans + "  正确。", lbl.Text));
                }
                else
                {
                    BulletedList1.Items.Add(new ListItem(n1.ToString() + ":" + Ans + "  错误。答案为：" + Answer.Text+" 点评:"+ana.Text, lbl.Text));

                }
            }


            foreach (DataListItem item2 in DataListTest2.Items)
            {


                string Ans = "";
                Label lbl = (Label)item2.FindControl("LabelTestAId2");
                Label ana = (Label)item2.FindControl("Ana");
                CheckBox A = ((CheckBox)item2.FindControl("CheckBoxA"));
                CheckBox B = ((CheckBox)item2.FindControl("CheckBoxB"));
                CheckBox C = ((CheckBox)item2.FindControl("CheckBoxC"));
                CheckBox D = ((CheckBox)item2.FindControl("CheckBoxD"));
                Label Answer = (Label)item2.FindControl("Ans");

                if (A.Checked)
                {
                    Ans += "A";
                }
                if (B.Checked)
                {
                    Ans += "B";
                }
                if (C.Checked)
                {
                    Ans += "C";
                }
                if (D.Checked)
                {
                    Ans += "D";
                }
                n2 += 1;

                if (Ans == Answer.Text)
                {
                    BulletedList2.Items.Add(new ListItem(n2.ToString() + ":" + Ans + "  正确。", lbl.Text));
                }
                else
                {
                    BulletedList2.Items.Add(new ListItem(n2.ToString() + ":" + Ans + "  错误。答案为：" + Answer.Text + " 点评:" + ana.Text, lbl.Text));

                }
            }
            return;
        }

        if (e.CurrentStepIndex == 4)
        {
        
            SqlDataSource6.SelectParameters["ExamId"].DefaultValue = GridView1.SelectedRow.Cells[1].Text;
            timeBegin = System.DateTime.Now;
            
            return;

        }
       
        if (WizardExam.ActiveStepIndex == 5)
        {

            SqlDataSource7.SelectParameters["ExamId"].DefaultValue = GridView1.SelectedRow.Cells[1].Text;
            return;
        }
        if (WizardExam.ActiveStepIndex == 6)
        {
            SqlDataSource8.SelectParameters["ExamId"].DefaultValue = GridView1.SelectedRow.Cells[1].Text;
            return;
        }
        
                    
                return;             
            }
    

    protected void WizardExam_PreRender(object sender, EventArgs e)
    {
        if (WizardExam.ActiveStepIndex == 0)
        {
           
             Button btn = (Button)(WizardExam.WizardSteps[0].FindControl("StartNavigationTemplateContainerID").FindControl("Button3"));

             btn.Attributes.Add("onclick", "javascript: var test = document.getElementById('" + RadioBtnTest.ClientID + "');var exam = document.getElementById('" + RadioBtnExam .ClientID+ "');if(test.checked==true || exam.checked==true){return true;}else{alert('请选择一项后开始'); return false;}");
             
             
           return;
        }
        if(WizardExam.ActiveStepIndex == 1)
        {
            foreach (DataListItem itemT in DataListTest1.Items)
            {
                RadioButton RaBtn = (RadioButton)itemT.FindControl("RaBtnD");
                if (RaBtn.Text == "D - ")
                {
                    RaBtn.Visible = false;
                }
            }
            return;
        }

        if (WizardExam.ActiveStepIndex == 4)
        {
            if(GridView1.Rows.Count == 0)
            {
                WizardExam.ActiveStepIndex = 0;
                eMessage.Message("没有可用的新试卷",UpdatePanel1,this);
                return;
            }
            Button btn = (Button)(WizardExam.WizardSteps[4].FindControl("StepNavigationTemplateContainerID").FindControl("Button2"));
            btn.Attributes.Add("onclick", "javascript: confirm('请选择一张试卷'); return false;");
            return;
        }
       
        if (WizardExam.ActiveStepIndex == 5)
        {
            Button btn = (Button)(WizardExam.WizardSteps[5].FindControl("StepNavigationTemplateContainerID").FindControl("Button2"));
            btn.OnClientClick = "javascript:return true;";
     
            foreach (DataListItem itemE in DataListExam1.Items)
            {
                RadioButton RaBtn = (RadioButton)itemE.FindControl("RaBtnD");
                if (RaBtn.Text == "D - ")
                {
                    RaBtn.Visible = false;
                }
            }
           return;
        }
        if (WizardExam.ActiveStepIndex == 6)
        {
            Button btn = (Button)(WizardExam.WizardSteps[6].FindControl("StepNavigationTemplateContainerID").FindControl("Button2"));
            btn.OnClientClick = "javascript:return true;";
            foreach (DataListItem itemE in DataListExam2.Items)
            {
                CheckBox ChBtn = (CheckBox)itemE.FindControl("CheckBoxD");
                if (ChBtn.Text == "D - ")
                {
                    ChBtn.Visible = false;
                }
            }
            return;
        }

        if (WizardExam.ActiveStepIndex == 7)
        {
            Button btn = (Button)(WizardExam.WizardSteps[7].FindControl("FinishNavigationTemplateContainerID").FindControl("FinishButton"));
            btn.OnClientClick = "javascript:Stop();return true;";
        }
       
       

        
    }
    protected void WizardExam_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (RadioBtnExam.Checked)
        {
            WizardExam.WizardSteps[7].AllowReturn = false;
            BulletedList1.Items.Clear();
            BulletedList2.Items.Clear();
            int n1 = 0;
            int n2 = DataListExam1.Items.Count;
            foreach (DataListItem item1 in DataListExam1.Items)
            {


                string Ans = "";
                Label lbl = (Label)item1.FindControl("LabelExamAId1");
                RadioButton A = ((RadioButton)item1.FindControl("RaBtnA"));
                RadioButton B = ((RadioButton)item1.FindControl("RaBtnB"));
                RadioButton C = ((RadioButton)item1.FindControl("RaBtnC"));
                RadioButton D = ((RadioButton)item1.FindControl("RaBtnD"));
                Label Answer = (Label)item1.FindControl("Ans");
                Label Score = (Label)item1.FindControl("Score");
                if (A.Checked)
                {
                    Ans = "A";
                }
                else if (B.Checked)
                {
                    Ans = "B";
                }
                else if (C.Checked)
                {
                    Ans = "C";
                }
                else if (D.Checked)
                {
                    Ans = "D";
                }
                n1 += 1;
                UserAnsA += Ans + ",";
                QAId += lbl.Text + ",";

                if (Ans == Answer.Text)
                {
                    BulletedList1.Items.Add(new ListItem(n1.ToString() + ":" + Ans + "  正确。", lbl.Text));
                    ScoreA += Score.Text + ",";
                }
                else
                {
                    BulletedList1.Items.Add(new ListItem(n1.ToString() + ":" + Ans + "  错误。答案为：" + Answer.Text, lbl.Text));
                    ScoreA += "0" + ",";

                }

            }


            foreach (DataListItem item2 in DataListExam2.Items)
            {


                string Ans = "";
                Label lbl = (Label)item2.FindControl("LabelExamAId2");
                CheckBox A = ((CheckBox)item2.FindControl("CheckBoxA"));
                CheckBox B = ((CheckBox)item2.FindControl("CheckBoxB"));
                CheckBox C = ((CheckBox)item2.FindControl("CheckBoxC"));
                CheckBox D = ((CheckBox)item2.FindControl("CheckBoxD"));
                Label Answer = (Label)item2.FindControl("Ans");
                Label Score = (Label)item2.FindControl("Score");
                if (A.Checked)
                {
                    Ans += "A";
                }
                if (B.Checked)
                {
                    Ans += "B";
                }
                if (C.Checked)
                {
                    Ans += "C";
                }
                if (D.Checked)
                {
                    Ans += "D";
                }
                n2 += 1;
                UserAnsA += Ans + ",";
                QAId += lbl.Text + ",";

                if (Ans == Answer.Text)
                {
                    BulletedList2.Items.Add(new ListItem(n2.ToString() + ":" + Ans + "  正确。", lbl.Text));
                    ScoreA += Score.Text + ",";
                }
                else
                {
                    BulletedList2.Items.Add(new ListItem(n2.ToString() + ":" + Ans + "  错误。答案为：" + Answer.Text, lbl.Text));
                    ScoreA += "0" + ",";
                }

            }    



                time = GridView1.SelectedRow.Cells[3].Text;
                time = time.Substring(0, time.Length - 2);
                timeEnd = System.DateTime.Now;
                System.TimeSpan ts = timeEnd - timeBegin;

                if ((Int32.Parse(time) - (ts.Minutes + ts.Hours * 60)) >= 0)
                {
                    checktime = true;
                    if ((Int32.Parse(time) - (ts.Minutes + ts.Hours * 60)) >= 0)
                    {

                        checktime = true;
                        timepast.Text = "您共用：" + ts.Hours.ToString() + "时 " + ts.Minutes.ToString() + "分" + ts.Seconds.ToString() + "秒";
                    }
                    else
                    {
                        timepast.Text = "您共用：" + ts.Hours.ToString() + "时 " + ts.Minutes.ToString() + "分。已经超过预设时间，无法提交试卷!";

                    }
                }
            if (checktime)
            {
                foreach (DataListItem item in DataListExam3.Items)
                {
                    TextBox txtbox = (TextBox)item.FindControl("TextBox1");
                    Label lbl = (Label)item.FindControl("LabelExamBId");
                    UserAnsB += txtbox.Text + ",";
                    QBId += lbl.Text + ",";
                }

                var cn = new SqlConnection();
                cn.ConnectionString = DealData.constring;
                SqlCommand cmd = new SqlCommand("usp_InsertAns", cn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@ScoreA", SqlDbType.NVarChar, 4000)).Value = ScoreA;
                cmd.Parameters.Add(new SqlParameter("@ExamId", SqlDbType.Int,int.MaxValue)).Value = GridView1.SelectedRow.Cells[1].Text;
                cmd.Parameters.Add(new SqlParameter("@AnswerA", SqlDbType.NVarChar, 4000)).Value = UserAnsA;
                cmd.Parameters.Add(new SqlParameter("@AnswerB", SqlDbType.NVarChar, 4000)).Value = UserAnsB;
                cmd.Parameters.Add(new SqlParameter("@QAId", SqlDbType.NVarChar, 4000)).Value = QAId;
                cmd.Parameters.Add(new SqlParameter("@QBId", SqlDbType.NVarChar, 4000)).Value = QBId;
                cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar, 50)).Value = Session["UserName"].ToString();

                try
                {
                    cn.Open();
                    if (cmd.ExecuteNonQuery() <= 0)
                    {     
                        eMessage.Message("提交试卷失败!", UpdatePanel1, this);
                    }
                }
                catch (Exception ex)
                {
                    eMessage.Message("系统发生问题，请稍后重试或联系管理员", UpdatePanel1, this);
                    eMessage.Message(ex);
                    throw ex;
                }
                finally
                {
                    cn.Close();
                }
            }
            else
            {
                eMessage.Message("您已近超过做题时间，提交试卷失败", UpdatePanel1, this);
            }
        }
    }



   
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        
        GridView1.SelectedRowStyle.BackColor = System.Drawing.Color.FromArgb(43519);
        time = GridView1.SelectedRow.Cells[3].Text;
        Button btn = (Button)(WizardExam.WizardSteps[4].FindControl("StepNavigationTemplateContainerID").FindControl("Button2"));
        btn.OnClientClick = "javascript:Go();return true;";
     }


    protected void WizardExam_PreviousButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (WizardExam.ActiveStepIndex == 4)
        {
            Button btn = (Button)(WizardExam.WizardSteps[4].FindControl("StepNavigationTemplateContainerID").FindControl("Button2"));
            btn.OnClientClick = "javascript:return true;";
        }
    }

   
}

