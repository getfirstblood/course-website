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

public partial class UserControls_ctUpLoad : System.Web.UI.UserControl
{
    public enum FileType { userfile, onlinefile };
    private int size;
    public int Size
    {
        get { return size; }
        set { size = value*1024*1024; }
    }

    private FileType ftype=FileType.userfile;
    public FileType filetype
    {
        get
        {
            return ftype;
        }
        set
        {
            ftype = value;
        }
    }

    public string Path
    {
        get 
        {
            if(filetype==FileType.userfile)
                return Request.PhysicalApplicationPath+@"\uploadfile\";
            else
                return (Request.PhysicalApplicationPath + @"\fileonline\");
        }
    }

    public string Command
    {
        get 
        {
            if (filetype == FileType.userfile)
                return "usp_InsertSource";
            else
                return "usp_InsertSourceOnline";
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //if (filetype == FileType.onlinefile)
        //{
        //    upload.Attributes.Add("OnClientClick", "CheckWorkFile()");
        //}
        if (!UserIdentity.IsInRole(UserIdentity.Role.Student) && !UserIdentity.IsInRole(UserIdentity.Role.Teacher) && !UserIdentity.IsInRole(UserIdentity.Role.Admin))
            eMessage.Message("您的权限不匹配此功能，页面将转到首页！", "../Default.aspx");
        else
        {
            Size = Convert.ToInt32(Session["SourceSize"].ToString());
        }
    }
    protected void upload_Click(object sender, EventArgs e)
    {
        if (FileUpload1.HasFile)
        {
            Double fileSize = FileUpload1.PostedFile.ContentLength;
            if (fileSize < Size)
            {
                int state=0;
                string savepath;
                string filename =Server.HtmlEncode(FileUpload1.FileName);
                savepath = Path+ filename;
                if (System.IO.File.Exists(savepath))    //返回不重名的存储路径
                {
                   int counter = 2;
                   while (System.IO.File.Exists(savepath))
                   {
                      // if a file with this name already exists,
                      // prefix the filename with a number.
                      filename = counter.ToString()+"_" + filename;
                      savepath = Path + filename;
                      counter ++;
                    }
                }
                SqlConnection con = new SqlConnection(DealData.constring);
                SqlCommand cmd = new SqlCommand(Command, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@size", SqlDbType.Real)).Value = fileSize;
                cmd.Parameters.Add(new SqlParameter("@username", SqlDbType.NVarChar, 50)).Value = Session["UserName"].ToString();
                cmd.Parameters.Add(new SqlParameter("@fileformate",SqlDbType.NVarChar,50)).Value=FileUpload1.PostedFile.ContentType;
                cmd.Parameters.Add(new SqlParameter("@sourcename",SqlDbType.NVarChar)).Value=filename;
                cmd.Parameters.Add(new SqlParameter("@tag",SqlDbType.NVarChar,50)).Value=txtSrTag.Text;
                cmd.Parameters.Add(new SqlParameter("@fileurl",SqlDbType.NVarChar)).Value=savepath;
                cmd.Parameters.Add(new SqlParameter("@identity", SqlDbType.Int));
                cmd.Parameters[6].Direction = ParameterDirection.ReturnValue;   //接收这条记录的id，用于上传失败时删除该条记录
                int identity=1;
                try
                {
                    con.Open();
                    if(cmd.ExecuteNonQuery()>0)
                        state=1;
                }
                catch(Exception err)
                {
                    eMessage.Message(err);
                }
                finally
                {
                    if(con!=null&&con.State!=ConnectionState.Closed)
                        con.Close();
                }
                    identity = Convert.ToInt32(cmd.Parameters[6].Value);
                if (state == 1)   //如果记录插入数据库成功
                {
                    try
                    {
                        FileUpload1.SaveAs(savepath);
                        eMessage.rMessage("上传成功！");
                    }
                    catch (Exception err)  //上传过程中发生错误，删除刚刚插入数据库中的记录
                    {
                        eMessage.Message(err);
                        if (filetype==FileType.userfile)
                        {
                            cmd.CommandText = "usp_DeleteSource";
                        }
                        else if (filetype==FileType.onlinefile)
                        {
                            cmd.CommandText = "usp_DeleteSourceOnline";
                        }
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@id", SqlDbType.Int).Value = identity;
                        try
                        {
                            cmd.Connection.Open();
                            if (cmd.ExecuteNonQuery() > 0)
                            {
                                eMessage.Message(new Exception("上传资源失败回滚事务成功"));
                            }
                            else
                            {
                                string info = "上传资源回滚事务执行删除冗余数据失败，存储过程名称：" + Command.ToString() + "资源id=" + identity.ToString();
                                eMessage.Message(new Exception(info));
                            }
                        }
                        catch (Exception err1)
                        {
                            string info = "上传资源回滚事务过程中连接数据库失败，存储过程名称：" + Command.ToString() + "资源id=" + identity.ToString();
                            eMessage.Message(new Exception(info + err1.Message));
                        }
                        finally
                        {
                            if (cmd.Connection != null && cmd.Connection.State != ConnectionState.Closed)
                                cmd.Connection.Close();
                            eMessage.rMessage("上传资源失败！");
                        }
                    }
                    finally
                    {
                        
                    }
                }

            }
            else
            {
                eMessage.rMessage("上传资源过大！");
            }
        }
        else
        {
            eMessage.rMessage("请先选择文件！");
        }

    }
}
