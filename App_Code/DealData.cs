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
using System.IO;

/// <summary>
///DealData 的摘要说明
/// </summary>
namespace System.Web
{
    public class DealData
    {
       private static string connectionstr;
       public static string constring
       {
           get { return System.Web.Configuration.WebConfigurationManager.ConnectionStrings["constr"].ConnectionString; }
        }
        public DealData()
        {
            //
            //TODO: 在此处添加构造函数逻辑
            //
        }

        public static string SubStr(string sString, int nLeng)
        {
            if (sString.Length <= nLeng)
            {
                return sString;
            }
            string sNewStr = sString.Substring(0, nLeng);
            sNewStr = sNewStr + "...";
            return sNewStr;
        }

        public static bool GetDataSet(SqlCommand cmd,ref DataSet ds, string tablename)
        {
            SqlDataAdapter adt = new SqlDataAdapter(cmd);
            try
            {
                adt.Fill(ds, tablename);
                return true;
            }
            catch (Exception e)
            {
                eMessage.Message(e);
                return false;
            }
            finally
            {
            }
        }
    }

    public class DealFile
    {
        public static bool FilePicDelete(string path)
        {
            bool ret = true;
            System.IO.FileInfo file = new System.IO.FileInfo(path);
            if (file.Exists)
            {
                try
                {
                    file.Delete();
                    ret = true;
                }
                catch (Exception err)
                {
                    eMessage.Message(err);
                    ret = false;
                }
                finally
                {
                }
            }
            return ret;
        }

        private static string UTF_FileName(string filename)
        {
            return HttpUtility.UrlEncode(filename, System.Text.Encoding.UTF8);
        }

        public static bool DownLoad(string fileurl,string filename,string type)
        {
            filename = filename+".temp";
            bool temp = true;
            long chunkSize = 102400;  
            //建立一个100K的缓冲区  
            byte[] buffer = new byte[chunkSize];  
            //已读的字节数  
            long dataToRead = 0;  
            FileStream stream = null;  
            try   
            {  
                //打开文件  
                stream = new FileStream(fileurl, FileMode.Open, FileAccess.Read, FileShare.Read);  
                dataToRead = stream.Length;  
  
                //添加Http头  attachement
                //HttpContext.Current.Response.ContentType = "application/octet-stream";x-msdownload
                HttpContext.Current.Response.ContentType = "application/octet-stream";
                HttpContext.Current.Response.AddHeader("Content-Disposition", "attachement;filename=" + UTF_FileName(filename));
                HttpContext.Current.Response.AddHeader("Content-Length", dataToRead.ToString());  
  
                while (dataToRead > 0)   
                {
                    if (HttpContext.Current.Response.IsClientConnected)  
                    {  
                        int length = stream.Read(buffer, 0, Convert.ToInt32(chunkSize));
                        HttpContext.Current.Response.OutputStream.Write(buffer, 0, length);
                        HttpContext.Current.Response.Flush();
                        HttpContext.Current.Response.Clear();  
                        dataToRead -= length;  
                    }  
                    else   
                    {  
                        //防止client失去连接  
                        dataToRead = -1;  
                    }  
                }  
            }  
            catch (Exception ex)  
            {
                throw ex;
                temp = false;
            }  
            finally   
            {  
                if (stream != null)   
                {  
                    stream.Close();  
                }
                HttpContext.Current.Response.Close();  
            }
            return temp;
        }

        public static bool DeleteFolder(string dir)
        {
            if (Directory.Exists(dir)) //如果存在这个文件夹删除之    
            {
                foreach (string d in Directory.GetFileSystemEntries(dir))
                {
                    if (File.Exists(d))
                        File.Delete(d); //直接删除其中的文件                           
                    else
                        DeleteFolder(d); //递归删除子文件夹    
                }
                Directory.Delete(dir, true); //删除已空文件夹                    
            }
            return true;
        }  


        public static void PptToHtmlFile(string PptFilePath)
        {
            //获得html文件名

            string htmlFileName = PptFilePath.Substring(0, PptFilePath.LastIndexOf(".")) + ".html";

            Microsoft.Office.Interop.PowerPoint.Application ppt = new Microsoft.Office.Interop.PowerPoint.Application();

            Microsoft.Office.Interop.PowerPoint.Presentation pptFile = null;

            try
            {

                //打开一个ppt文件

                pptFile = ppt.Presentations.Open(PptFilePath, Microsoft.Office.Core.MsoTriState.msoTrue,

                    Microsoft.Office.Core.MsoTriState.msoCTrue, Microsoft.Office.Core.MsoTriState.msoFalse);

                //转换成html格式

                pptFile.SaveAs(htmlFileName, Microsoft.Office.Interop.PowerPoint.PpSaveAsFileType.ppSaveAsHTML,

                    Microsoft.Office.Core.MsoTriState.msoCTrue);

            }

            finally
            {

                if (pptFile != null)
                {

                    pptFile.Close();

                }
                ppt.Quit();
                GC.Collect();
            }
        }

        public static void openfile(string fileurl)
        {
            string temp = "<script language='javascript'>open(" + fileurl + ")</script>";
            HttpContext.Current.Response.Write(temp);
        }
    }
}

