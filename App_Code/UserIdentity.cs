using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Data.SqlClient;

/// <summary>
///UserIdentity 的摘要说明
/// </summary>
public class UserIdentity
{
    public enum Role { Vistor, Student, Teacher, Admin };
    public enum TimeStamp {Inform,Topic};
	public UserIdentity()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    public static int GetUserId
    {
        get { return Convert.ToInt32(HttpContext.Current.Session["UserId"]); }
    }

    public static int Login(string username, string password)
    {
        if (username == "" || password == "")
        {
            throw new Exception("用户名或密码为空！");
        }
        SqlConnection cn = new SqlConnection();
        cn.ConnectionString = DealData.constring;
        SqlCommand cmd = new SqlCommand("usp_Login", cn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar, 50)).Value = username;
        cmd.Parameters.Add(new SqlParameter("@password", SqlDbType.NVarChar, 50)).Value = password;
        SqlDataReader reader;
        try
        {
            cn.Open();
            reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                reader.Read();
                HttpContext.Current.Session["UserName"] = reader["UserName"].ToString();
                HttpContext.Current.Session["Role"] = reader["Role"].ToString();
                HttpContext.Current.Session["UserId"] = reader["UserId"].ToString();
                HttpContext.Current.Session["IsVa"] = reader["IsVa"].ToString();
                HttpContext.Current.Session["RealName"] = reader["RealName"].ToString();
                HttpContext.Current.Session["SourceSize"] = reader["SourceSize"].ToString();
                reader.Close();

                if (HttpContext.Current.Session["IsVa"].ToString() == "未审核")
                {
                    //eMessage.Message("您未通过验证");
                    HttpContext.Current.Session.Abandon();
                    return 0;
                }
                else
                {
                   //eMessage.Message("登陆成功!");
                    return 1;

                }
            }
            else
            {
 //               eMessage.Message("用户名不存在或密码不正确");
                return -1;
            }
        }
        catch (Exception ex)
        {
//            eMessage.Message("系统发生问题，请稍后重试或联系管理员");
            eMessage.Message(ex);
            throw ex;
        }
        finally
        {
            if(cn.State!=ConnectionState.Closed)
                 cn.Close();
        }
    }

    public static bool IsInRole(Role role)
    {
        if (HttpContext.Current.Session["Role"] != null && HttpContext.Current.Session["Role"].ToString() != "")
        {
            if (HttpContext.Current.Session["Role"].ToString() == role.ToString())
                return true;
            else
                return false;
        }
        else
            return false;
    }

    public static void LogOut()
    {
        if (HttpContext.Current.Session["UserName"] != null && HttpContext.Current.Session["UserName"].ToString() != "")
            HttpContext.Current.Session.Abandon();
        else
            return;
    }

    public static bool VaUserName(string username)
    {
        if (username != "")
        {
            SqlConnection cn = new SqlConnection();
            cn.ConnectionString = DealData.constring;
            SqlCommand cmd = new SqlCommand("usp_VaUserName", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar, 50)).Value = username;
            SqlDataReader reader;
            try
            {
                using (cn)
                {
                    cn.Open();
                    reader = cmd.ExecuteReader();
                    if (reader.HasRows)
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
            catch (Exception ex)
            {
                //              eMessage.Message("系统发生问题，请稍后重试或联系管理员");
                eMessage.Message(ex);
                throw ex;
            }
            finally
            {
                if (cn.State != ConnectionState.Closed)
                    cn.Close();
            }
        }
        else
            return false;
    }
    public static void UpdateTimeStamp(TimeStamp stamp)
    {
        SqlConnection con = new SqlConnection(DealData.constring);
        SqlCommand cmd = new SqlCommand("usp_TimeStamp", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int)).Value = GetUserId;
        cmd.Parameters.Add(new SqlParameter("@type", SqlDbType.NVarChar, 50)).Value = stamp.ToString();
        try
        {
            con.Open();
            cmd.ExecuteNonQuery();
        }
        catch (SqlException err)
        {
            eMessage.Message(err);
        }
        finally
        {
            if (con != null)
                con.Close();
        }
    }
    public static UserIdentity.Role GetRole
    {
        get 
        {
            if (HttpContext.Current.Session["Role"] != null)
            {
                string role = HttpContext.Current.Session["Role"].ToString();
                if (role == "Admin")
                    return Role.Admin;
                else if (role == "Teacher")
                    return Role.Teacher;
                else
                    return Role.Student;
            }
            else
                return Role.Vistor;
        }
    }
}
