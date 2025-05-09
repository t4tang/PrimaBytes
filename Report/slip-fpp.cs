namespace PRIMA_HRIS.Report
{
    using System;
    using System.ComponentModel;
    using System.Drawing;
    using System.Windows.Forms;
    using Telerik.Reporting;
    using Telerik.Reporting.Drawing;

    /// <summary>
    /// Summary description for slip_fpp.
    /// </summary>
    public partial class slip_fpp : Telerik.Reporting.Report
    {
        public static string _doc_code;
        public slip_fpp()
        {
            //
            // Required for telerik Reporting designer support
            //
            InitializeComponent();

            //
            // TODO: Add any constructor code after InitializeComponent call
            //


            Telerik.Reporting.ReportParameter param = new ReportParameter();
            param.Name = "doc_code";
            param.Type = ReportParameterType.String;
            param.AllowBlank = false;
            param.AllowNull = false;
            param.Value = _doc_code;
            param.Visible = false;
            this.Report.ReportParameters.Add(param);

            sqlDataSource1.Parameters[0].Value = "=Parameters.doc_code.Value";

        }
    }
}