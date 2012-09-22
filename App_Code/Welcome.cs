using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Data.SqlClient;

/// <summary>
///Welcome 的摘要说明
/// </summary>
public class Welcome
{
	public Welcome(UserIdentity.Role role)
	{
        _role = role.ToString();
        SqlConnection con=new SqlConnection(DealData.constring);
        if (role == UserIdentity.Role.Admin)
        {
            SqlCommand cmd = new SqlCommand("usp_AWelcome", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataReader reader;
            //cmd.Parameters.Add(new SqlParameter("@member", SqlDbType.Int)).Direction = ParameterDirection.ReturnValue;
            try
            {
                con.Open();
                reader = cmd.ExecuteReader();
                reader.Read();
                _member = reader[0].ToString();
                reader.Close();
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
        if (role == UserIdentity.Role.Teacher)
        {
            SqlCommand cmd = new SqlCommand("usp_TWelcome", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int)).Value =Convert.ToInt32( HttpContext.Current.Session["UserId"].ToString());
            cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar, 50)).Value = HttpContext.Current.Session["UserName"].ToString();
            SqlDataReader reader;
            try
            {
                con.Open();
                reader = cmd.ExecuteReader();
                reader.Read();
                _topic = reader["TopicCount"].ToString();
                _correct = reader["QuestionCount"].ToString();
                _member = reader["MemberCount"].ToString();
                _inform = reader["InformCount"].ToString();
                reader.Close();
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
        if (role == UserIdentity.Role.Student)
        {
            SqlCommand cmd = new SqlCommand("usp_UWelcome", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@UserId", SqlDbType.Int)).Value = Convert.ToInt32(HttpContext.Current.Session["UserId"].ToString());
            cmd.Parameters.Add(new SqlParameter("@UserName", SqlDbType.NVarChar, 50)).Value = HttpContext.Current.Session["UserName"].ToString();
            SqlDataReader reader;
            try
            {
                con.Open();
                reader = cmd.ExecuteReader();
                reader.Read();
                _exam = reader["ExamCount"].ToString();
                _inform = reader["InformCount"].ToString();
                reader.Close();
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
	}
    public string _exam;
    public string _inform;
    public string _member;
    public string _topic;
    public string _correct;
    public string _role;
}
