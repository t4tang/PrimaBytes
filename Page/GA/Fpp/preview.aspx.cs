using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using Telerik.Reporting;
using System.Data.SqlClient;
using PRIMA_HRIS.Class;
//using Telerik.Reporting.Processing;
using Telerik.ReportViewer.WebForms;
using PRIMA_HRIS.Report;

namespace PRIMA_HRIS.Page.GA.Fpp
{

    public partial class preview : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        
        protected void Page_Load(object sender, EventArgs e)
        {
            reportViewer.ViewMode = ViewMode.PrintPreview;
            slip_fpp._doc_code = Request.QueryString["doc_no"];

            //if (!IsPostBack)
            //{
            //    var reportSource = new Telerik.Reporting.UriReportSource();
            //    reportSource.Uri = "~/Report/slip-fpp.trdp";

            //    // Tambahkan nilai parameter
            //    reportSource.Parameters.Add(new Telerik.Reporting.Parameter("@doc_no", "002/FPP/PRIMA/IT/III/2025"));

            //    reportViewer.ReportSource = reportSource;
            //}



            //// Path ke file .trdp
            //string reportPath = Server.MapPath("~/Report/slip-fpp.trdp");

            //// Membaca file .trdp
            //Report report = null;
            //using (var sourceStream = File.OpenRead(reportPath))
            //{
            //    var reportPackager = new ReportPackager();
            //    report = (Report)reportPackager.UnpackageDocument(sourceStream);
            //    report.ReportParameters.Add("@doc_no", ReportParameterType.String, "002/FPP/PRIMA/IT/III/2025");
            //}

            //// Mengatur sumber data jika diperlukan
            //report.DataSource = con;
            
            //// Menampilkan report di ReportViewer
            //reportViewer.ReportSource = new InstanceReportSource { ReportDocument = report };
        }
    }
}