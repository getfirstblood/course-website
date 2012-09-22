<%@ WebHandler Language="C#" Class="Managefile_json" %>

using System;
using System.Web;
using System.Collections;
using System.IO;
public class Managefile_json : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        // context.Response.ContentType = "text/plain";
        //根目录URL
        string root_url = "/Kinde/UploadImg/";
        //根目录路径
        string root_path = System.Web.HttpContext.Current.Server.MapPath(root_url);
        if (!root_path.EndsWith("\\")) root_path = root_path + "\\";

        //图片扩展名
        string[] ext_arr = new string[] { "gif", "jpg", "jpeg", "png", "bmp" };

        //根据path参数，设置各路径和URL
        string current_path = "";
        string current_url = "";
        string current_dir_path = "";
        string moveup_dir_path = "";

        string quePath = context.Request.QueryString["path"];
        if (quePath == "")
        {
            current_path = root_path;
            current_url = root_url;
            current_dir_path = "";
            moveup_dir_path = "";
        }
        else
        {
            //current_path = root_path + quePath;
            current_url = root_url + quePath;
            current_path = System.Web.HttpContext.Current.Server.MapPath(current_url);
            if (!current_path.EndsWith("\\")) current_path = root_path + "\\";

            current_dir_path = quePath;
            moveup_dir_path = System.Text.RegularExpressions.Regex.Replace(current_dir_path, @"(.*?)[^\/]+\/$", "$1");
        }
        //排序形式，name or size or type
        string queOrder = context.Request.QueryString["order"].ToLower();

        //不允许使用..移动到上一级目录
        if (System.Text.RegularExpressions.Regex.IsMatch(current_path, @"\.\."))
        {
            context.Response.Write("Access is not allowed.");
            return;
        }
        //最后一个字符不是/
        if (current_path.EndsWith("/"))
        {
            context.Response.Write("Parameter is not valid.");
            return;
        }
        //目录不存在或不是目录
        if (!Directory.Exists(current_path))
        {
            context.Response.Write("Directory does not exist.");
            return;
        }

        //遍历目录取得文件信息
        string[] dir_list = Directory.GetDirectories(current_path);
        string[] file_list = Directory.GetFiles(current_path);
        switch (queOrder)
        {
            case "name":
                Array.Sort(dir_list, new NameSorter());
                Array.Sort(file_list, new NameSorter());
                break;
            case "size":
                Array.Sort(dir_list, new NameSorter());
                Array.Sort(file_list, new SizeSorter());
                break;
            case "type":
                Array.Sort(dir_list, new NameSorter());
                Array.Sort(file_list, new TypeSorter());
                break;
            case "date":
            default:
                Array.Sort(dir_list, new DateSorter());
                Array.Sort(file_list, new DateSorter());
                break;
        }

        //组合JSON字符串
        System.Text.StringBuilder json = new System.Text.StringBuilder();
        json.Append("{");
        json.Append("\"moveup_dir_path\":\"" + moveup_dir_path + "\",");
        json.Append("\"current_dir_path\":\"" + current_dir_path + "\",");
        json.Append("\"current_url\":\"" + current_url + "\",");
        json.Append("\"total_count\":" + (dir_list.Length + file_list.Length) + ",");
        json.Append("\"file_list\":");
        json.Append("[");
        System.Text.StringBuilder strList = new System.Text.StringBuilder();
        for (int i = 0; i < dir_list.Length; i++)
        {
            DirectoryInfo dir = new DirectoryInfo(dir_list[i]);
            strList.Append(",");
            strList.Append("{");
            strList.Append("\"is_dir\":true,");//是否文件夹
            strList.Append("\"has_file\":" + (dir.GetFileSystemInfos().Length > 0 ? "true" : "false") + ",");//文件夹是否包含文件
            strList.Append("\"filesize\":0,");//文件大小
            strList.Append("\"is_photo\":false,");// 是否图片
            strList.Append("\"filetype\":\"\",");// 文件类别，用扩展名判断
            strList.Append("\"filename\":\"" + dir.FullName.Substring(dir.FullName.LastIndexOf("\\") + 1) + "\",");//文件名，包含扩展名
            strList.Append("\"datetime\":\"" + dir.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss") + "\"");//文件最后修改时间
            strList.Append("}");
        }
        for (int i = 0; i < file_list.Length; i++)
        {
            FileInfo file = new FileInfo(file_list[i]);
            if (Array.IndexOf(ext_arr, file.Extension.Substring(1).ToLower()) == -1) continue;
            strList.Append(",");
            strList.Append("{");
            strList.Append("\"is_dir\":false,");// 是否文件夹
            strList.Append("\"has_file\":false,");// 文件夹是否包含文件
            strList.Append("\"filesize\":" + file.Length + ",");//文件大小
            strList.Append("\"dir_path\":\"\",");
            strList.Append("\"is_photo\":true,");// 是否图片
            strList.Append("\"filetype\":\"" + file.Extension.Substring(1) + "\",");//文件类别，用扩展名判断
            strList.Append("\"filename\":\"" + file.Name + "\",");//文件名，包含扩展名
            strList.Append("\"datetime\":\"" + file.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss") + "\"");//文件最后修改时间
            strList.Append("}");
        }
        //if (strList != null) strList = strList.ToString().Substring(1);
        json.Append(strList.ToString().Substring(1));
        json.Append("]");
        json.Append("}");
        context.Response.ContentType = "application/json";
        context.Response.Charset = "UTF-8";
        context.Response.Write(json.ToString());
    }

    #region 排序
    /// <summary>
    /// 按名称排序
    /// </summary>
    public class NameSorter : IComparer
    {
        public int Compare(object x, object y)
        {
            if (x == null && y == null)
            {
                return 0;
            }
            if (x == null)
            {
                return -1;
            }
            if (y == null)
            {
                return 1;
            }
            FileInfo xInfo = new FileInfo(x.ToString());
            FileInfo yInfo = new FileInfo(y.ToString());

            return xInfo.FullName.CompareTo(yInfo.FullName);//递增  
            //return yInfo.FullName.CompareTo(xInfo.FullName);//递减
        }
    }
    /// <summary>
    /// 按文件大小排序
    /// </summary>
    public class SizeSorter : IComparer
    {
        public int Compare(object x, object y)
        {
            if (x == null && y == null)
            {
                return 0;
            }
            if (x == null)
            {
                return -1;
            }
            if (y == null)
            {
                return 1;
            }
            FileInfo xInfo = new FileInfo(x.ToString());
            FileInfo yInfo = new FileInfo(y.ToString());

            //return xInfo.Length.CompareTo(yInfo.Length);//递增  
            return yInfo.Length.CompareTo(xInfo.Length);//递减  
        }
    }
    /// <summary>
    /// 按文件类型排序
    /// </summary>
    public class TypeSorter : IComparer
    {
        public int Compare(object x, object y)
        {
            if (x == null && y == null)
            {
                return 0;
            }
            if (x == null)
            {
                return -1;
            }
            if (y == null)
            {
                return 1;
            }
            FileInfo xInfo = new FileInfo(x.ToString());
            FileInfo yInfo = new FileInfo(y.ToString());

            return xInfo.Extension.CompareTo(yInfo.Extension);//递增  
            //return yInfo.Extension.CompareTo(xInfo.Extension);//递减  
        }
    }
    /// <summary>
    /// 按修改时间排序
    /// </summary>
    public class DateSorter : IComparer
    {
        public int Compare(object x, object y)
        {
            if (x == null && y == null)
            {
                return 0;
            }
            if (x == null)
            {
                return -1;
            }
            if (y == null)
            {
                return 1;
            }
            FileInfo xInfo = new FileInfo(x.ToString());
            FileInfo yInfo = new FileInfo(y.ToString());

            //return xInfo.LastWriteTime.CompareTo(yInfo.LastWriteTime);//递增  
            return yInfo.LastWriteTime.CompareTo(xInfo.LastWriteTime);//递减  
        }
    }
    #endregion 排序
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}