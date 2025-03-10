<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="preview.aspx.cs" Inherits="PRIMA_HRIS.Page.GA.Fpp.preview" %>
<%--<%@ Register TagPrefix="telerik" Assembly="Telerik.ReportViewer.Html5.WebForms" Namespace="Telerik.ReportViewer.Html5.WebForms" %>--%>
<%@ Register Assembly="Telerik.ReportViewer.WebForms, Version=12.1.18.516, Culture=neutral, PublicKeyToken=a9d7983dfcc261be" 
    Namespace="Telerik.ReportViewer.WebForms" TagPrefix="telerik" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
		#preview {
			position: absolute;
			left: 5px;
			right: 5px;
			top: 5px;
			bottom: 5px;
			overflow: hidden;
			font-family: Verdana, Arial;
            text-align:center;
		}
	</style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <%--<telerik:ReportViewer ID="ReportViewer1" runat="server" Width="100%" Height="100%" />--%>
        <telerik:ReportViewer
            ID="reportViewer" 
			Width="1127px"
			Height="600px"
			EnableAccessibility="false"
            runat="server">
            <typereportsource typename="PRIMA_HRIS.Report.slip_fpp, PRIMA_HRIS, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"></typereportsource>
        </telerik:ReportViewer>
    </div>
    </form>
</body>
</html>
