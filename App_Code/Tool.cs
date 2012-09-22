using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
///Tool 的摘要说明
/// </summary>
public class Tool
{
	public Tool()
	{
		//
		//TODO: 在此处添加构造函数逻辑
		//
	}

    /// <summary>返回当前应用程序虚拟路径的根路径
    /// 在网上则返回/，本地则返回/5mdn，本地返回的要在最后加个/，即返回/5mdn/
    /// </summary>
    /// <returns></returns>
    public static string GetApplicationPath()
    {
        string path = HttpContext.Current.Request.ApplicationPath;
        return path == "/" ? path : path + "/";
    }
}
