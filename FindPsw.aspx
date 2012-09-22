<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FindPsw.aspx.cs" Inherits="FindPsw" %>

<%@ Register src="UserControls/PswRetrive.ascx" tagname="PswRetrive" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <uc1:PswRetrive ID="PswRetrive1" runat="server" />
    
    </div>
    </form>
</body>
</html>
