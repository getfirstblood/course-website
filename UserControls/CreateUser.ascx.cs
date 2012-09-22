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
using System.Text.RegularExpressions;

public partial class UserControls_CreateUser : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            SerialNumber1.Create();
    }
    protected void BtReg_Click(object sender, EventArgs e)
    {
        RequiredFieldValidator1.Validate();
        RequiredFieldValidator2.Validate();
        RequiredFieldValidator3.Validate();
        RequiredFieldValidator4.Validate();
        RequiredFieldValidator5.Validate();
        RequiredFieldValidator6.Validate();
        RequiredFieldValidator7.Validate();
        CompareValidator1.Validate();
        RegularExpressionValidator1.Validate();
        RegularExpressionValidator2.Validate();
        RegularExpressionValidator3.Validate();
        RequiredFieldValidator8.Validate();
        RequiredFieldValidator9.Validate();
        if (!RequiredFieldValidator8.IsValid||!RequiredFieldValidator9.IsValid||!RequiredFieldValidator1.IsValid || !RequiredFieldValidator2.IsValid || !RequiredFieldValidator3.IsValid || !RequiredFieldValidator4.IsValid || !RequiredFieldValidator5.IsValid || !RequiredFieldValidator6.IsValid || !RequiredFieldValidator7.IsValid || !CompareValidator1.IsValid || !RegularExpressionValidator1.IsValid || !RegularExpressionValidator2.IsValid || !RegularExpressionValidator3.IsValid)
        {
            eMessage.Message("请仔细检查输入！", UpdatePanel1, this);
            return;
        }
        if (!this.SerialNumber1.CheckSN(txtCheck.Text)||txtCheck.Text==null||txtCheck.Text=="")
        {
            eMessage.Message("请输入正确的验证码",UpdatePanel1,this);
            this.SerialNumber1.Create();
            return;
        }
        
        if (!Regex.IsMatch(txtIdReg.Text, "^\\d{10}$"))
        {
            eMessage.Message("不正确的ID",UpdatePanel1,this);
            SerialNumber1.Create();
            return;

        }
        if (!Regex.IsMatch(txtNameReg.Text, "^[\u4E00-\u9FA5]{0,}$")) 
        {
            eMessage.Message("请输入正确的姓名",UpdatePanel1,this);
            SerialNumber1.Create();
            return;
  
        }
        if(txtPawReg.Text != txtPawRegCnf.Text)
        {
            eMessage.Message("您两次输入的密码不同",UpdatePanel1,this);
            SerialNumber1.Create();
            return;
        }
        
        
        var cn = new SqlConnection();
        cn.ConnectionString = DealData.constring;
        SqlCommand cmd = new SqlCommand("usp_VaUserName", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar, 50)).Value = txtUsrReg.Text;
        try
        {
            cn.Open();
            if ((string)cmd.ExecuteScalar() != null)
            {
                eMessage.Message("该用户名已被注册!",UpdatePanel1,this);
                SerialNumber1.Create();
                return;
            }
        }
        catch (Exception e1)
        {
            eMessage.Message("系统发生问题，请稍后重试或联系管理员",UpdatePanel1,this);
            SerialNumber1.Create();
            eMessage.Message(e1);
        }
        finally
        {
            cn.Close();          
        }

        int state = 0;
            var cn2 = new SqlConnection();
            cn2.ConnectionString = DealData.constring;
            SqlCommand cmd2 = new SqlCommand("usp_CreateUser", cn2);
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar, 50)).Value = txtUsrReg.Text;
            cmd2.Parameters.Add(new SqlParameter("@studentid", SqlDbType.NVarChar, 50)).Value = txtIdReg.Text;
            cmd2.Parameters.Add(new SqlParameter("@password", SqlDbType.NVarChar, 50)).Value = txtPawReg.Text;
            cmd2.Parameters.Add(new SqlParameter("@email", SqlDbType.NVarChar, 50)).Value = txtEmailReg.Text;
            cmd2.Parameters.Add(new SqlParameter("@question", SqlDbType.NVarChar, 50)).Value = txtQueReg.Text;
            cmd2.Parameters.Add(new SqlParameter("@key", SqlDbType.NVarChar, 50)).Value = txtAnsReg.Text;
            cmd2.Parameters.Add(new SqlParameter("@RealName", SqlDbType.NVarChar, 50)).Value = txtNameReg.Text;
            try
            {
                cn2.Open();
                if (cmd2.ExecuteNonQuery() > 0)
                {
                    eMessage.Message("注册成功，请等待老师的审核！",UpdatePanel1,this);
                    SerialNumber1.Create();
                    state = 1;
                }
                else
                {
                    eMessage.Message("注册失败,请稍后再试",UpdatePanel1,this);
                    SerialNumber1.Create();
                    state = -1;
                }

            }
            catch (Exception e2)
            {
                eMessage.Message("系统发生错误请稍后再试",UpdatePanel1,this);
                SerialNumber1.Create();
                eMessage.Message(e2);
            }
            finally
            {
                cn2.Close();
                if(state==1)
                    Response.Redirect("~/Default.aspx");              
            }
        

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (txtUsrReg.Text == null || txtUsrReg.Text.Trim() == "")
        {
            eMessage.Message("用户名不能为空！", UpdatePanel1, this);
            SerialNumber1.Create();
            return;
        }
        var cn = new SqlConnection();
        cn.ConnectionString = DealData.constring;
        SqlCommand cmd = new SqlCommand("usp_VaUserName", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar, 50)).Value = txtUsrReg.Text;
         try
        {
            cn.Open();
            if ((string)cmd.ExecuteScalar() != null)
            {
                
                Label1.Text = "该用户名已被注册!";
                SerialNumber1.Create();

            }
            else
            {
                
                Label1.Text = "恭喜，该用户名可以使用!";
                SerialNumber1.Create();
            }
         }
         catch(Exception e1)
         {
                   
        
            eMessage.Message("系统发生问题，请稍后重试或联系管理员",UpdatePanel1,this);
            SerialNumber1.Create();
            eMessage.Message(e1);
        
          }
         finally
         {
             cn.Close();

         }
        }

  
}
