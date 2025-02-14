using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using PRIMA_HRIS.Class;
using System.IO;
using System.Data.OleDb;

namespace PRIMA_HRIS.Page.PA.Employee
{
    public partial class pa_emp02 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;

        private void connection()
        {
            sqlconn = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
            con = new SqlConnection(sqlconn);

        }

        OleDbConnection Econ;
        string constr, Query, sqlconn;
        private void ExcelConn(string FilePath)
        {
            constr = string.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=""Excel 12.0 Xml;HDR=YES;""", FilePath);
            Econ = new OleDbConnection(constr);

        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region EmployeeData
        protected void btn_upload_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "truncate table UplEmpData";
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }
            

            string filePath = Path.Combine(Path.GetTempPath(), Guid.NewGuid().ToString("N") + ".xlsx");
            FileUpload1.SaveAs(filePath);

            try
            {
                InsertExcelRecords(filePath);
            }
            finally
            {
                File.Delete(filePath);
                RadGrid2.Rebind();
                (sender as RadButton).Enabled = false;
            }
        }

        protected void btn_confirm_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "spSaveConfirmUploadEmp";
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);

                cmd.ExecuteNonQuery();


                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE UplEmpData WHERE [UID] = @UID";
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);

                cmd.ExecuteNonQuery();
                con.Close();

                //string Message = "Data karyawan baru berhasil disimpan";
                //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Allert", "allertFn('" + Message + "')", true);

                string script = "alert('Data karyawan baru berhasil disimpan');";
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", script, true);
            }
            catch (Exception ex)
            {
                con.Close();
                //string Message = "Error: " + ex;
                //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Allert", "allertFn('" + Message + "')", true);

                string errorMessage = ex.Message.Replace("'", "\\'");
                string script = $"alert('Error: {errorMessage}');";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
                return;
            }
            finally
            {
                (sender as RadButton).Enabled = false;
            }
        }
        public DataTable GetDataTable(string UID)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM vEmpUpload WHERE UID = @UID";
            cmd.Parameters.AddWithValue("@UID", UID);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            DataTable DT = new DataTable();

            try
            {
                sda.Fill(DT);
            }
            finally
            {
                con.Close();
            }

            return DT;
        }
        protected void RadGrid2_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(Request.Cookies["authcookie"]["uName"]);
        }

        protected void RadGrid2_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataBoundItem = e.Item as GridDataItem;
                GridDataItem dataItem = e.Item as GridDataItem;
                TableCell kodePosisi = dataItem["KODE_POSISI"];
                TableCell namaPosisi = dataItem["NAMA_POISIS"];
                TableCell kodeAssign = dataItem["KODE_ASSIGN"];
                TableCell namaAssign = dataItem["NAMA_ASSIGN"];
                TableCell kodeHub = dataItem["KODE_JENIS_HUB"];
                TableCell namaHub = dataItem["NAMA_JENIS_HUB"];
                TableCell kodeKelamin = dataItem["KODE_JENIS_KELAMIN"];
                TableCell namaKelamin = dataItem["NAMA_JENIS_KELAMIN"];
                TableCell kodeAgama = dataItem["KODE_AGAMA"];
                TableCell namaAgama = dataItem["NAMA_AGAMA"];
                TableCell kodeKota = dataItem["KODE_KOTA"];
                TableCell namaKota = dataItem["NAMA_KOTA"];
                TableCell kodeProv = dataItem["KODE_PROPINSI"];
                TableCell namaProv = dataItem["NAMA_PROPINSI"];
                TableCell kodeStatusKwn = dataItem["KODE_STATUS_KAWIN"];
                TableCell namaStatusKwn = dataItem["NAMA_STATUS_KAWIN"];
                TableCell kodeJurusan = dataItem["KODE_JURUSAN"];
                TableCell namaJurusan = dataItem["NAMA_JURUSAN"];
                TableCell kodeKotaSekolah = dataItem["KODE_KOTA_SEKOLAH"];
                TableCell namaKotaSekolah = dataItem["NAMA_KOTA_SEKOLAH"];
                TableCell kodeStatusLulus = dataItem["KODE_STATUS_LULUS"];
                TableCell namaStatusLulus = dataItem["NAMA_STATUS_LULUS"];
                TableCell kodeSubDept = dataItem["KODE_SUB_DEPT"];
                TableCell namaSubDept = dataItem["NAMA_SUB_DEPT"];
                TableCell kodeDept = dataItem["KODE_DEPARTMENT"];
                TableCell namaDept = dataItem["NAMA_DEPARTMENT"];
                TableCell kodeDivisi = dataItem["KODE_DIVISI"];
                TableCell namaDivisi = dataItem["NAMA_DIVISI"];
                TableCell kodePOO = dataItem["KODE_POO"];
                TableCell namaPOO = dataItem["NAMA_POO"];
                TableCell kodePOH = dataItem["KODE_POH"];
                TableCell namaPOH = dataItem["NAMA_POH"];

                if (kodePosisi.Text == "&nbsp;")
                {
                    namaPosisi.ForeColor = System.Drawing.Color.OrangeRed;
                    namaPosisi.Font.Italic = true;
                }
                if (kodeAssign.Text == "&nbsp;")
                {
                    namaAssign.ForeColor = System.Drawing.Color.OrangeRed;
                    namaAssign.Font.Italic = true;
                }
                if (kodeHub.Text == "&nbsp;")
                {
                    namaHub.ForeColor = System.Drawing.Color.OrangeRed;
                    namaHub.Font.Italic = true;
                }


                if (kodeKelamin.Text == "&nbsp;")
                {
                    namaKelamin.ForeColor = System.Drawing.Color.OrangeRed;
                    namaKelamin.Font.Italic = true;
                }
                if (kodeAgama.Text == "&nbsp;")
                {
                    namaAgama.ForeColor = System.Drawing.Color.OrangeRed;
                    namaAgama.Font.Italic = true;
                }
                if (kodeKota.Text == "&nbsp;")
                {
                    namaKota.ForeColor = System.Drawing.Color.OrangeRed;
                    namaKota.Font.Italic = true;
                }
                if (kodeProv.Text == "&nbsp;")
                {
                    namaProv.ForeColor = System.Drawing.Color.OrangeRed;
                    namaProv.Font.Italic = true;
                }
                if (kodeStatusKwn.Text == "&nbsp;")
                {
                    namaStatusKwn.ForeColor = System.Drawing.Color.OrangeRed;
                    namaStatusKwn.Font.Italic = true;
                }
                if (kodeJurusan.Text == "&nbsp;")
                {
                    namaJurusan.ForeColor = System.Drawing.Color.OrangeRed;
                    namaJurusan.Font.Italic = true;
                }
                if (kodeKotaSekolah.Text == "&nbsp;")
                {
                    namaKotaSekolah.ForeColor = System.Drawing.Color.OrangeRed;
                    namaKotaSekolah.Font.Italic = true;
                }
                if (kodeStatusLulus.Text == "&nbsp;")
                {
                    namaStatusLulus.ForeColor = System.Drawing.Color.OrangeRed;
                    namaStatusLulus.Font.Italic = true;
                }
                if (kodeSubDept.Text == "&nbsp;")
                {
                    namaSubDept.ForeColor = System.Drawing.Color.OrangeRed;
                    namaSubDept.Font.Italic = true;
                }
                if (kodeDept.Text == "&nbsp;")
                {
                    namaDept.ForeColor = System.Drawing.Color.OrangeRed;
                    namaDept.Font.Italic = true;
                }
                if (kodeDivisi.Text == "&nbsp;")
                {
                    namaDivisi.ForeColor = System.Drawing.Color.OrangeRed;
                    namaDivisi.Font.Italic = true;
                }
                if (kodePOO.Text == "&nbsp;")
                {
                    namaPOO.ForeColor = System.Drawing.Color.OrangeRed;
                    namaPOO.Font.Italic = true;
                }
                if (kodePOH.Text == "&nbsp;")
                {
                    namaPOH.ForeColor = System.Drawing.Color.OrangeRed;
                    namaPOH.Font.Italic = true;
                }
            }
        }

        private void InsertExcelRecords(string FilePath)
        {
            ExcelConn(FilePath);

            Query = string.Format("Select [NIK],[NAMA],[POSISI],[COSTING],[ACTUAL],[ASSIGN],[CATEGORY],[GOL],[SUB-GOL],[TMP LAHIR],[TGL LAHIR], " +
                "[TGL GROUP],[TGL MASUK],[JENIS HUB],[TGL AWAL KONTRAK],[TGL AKHIR KONTRAK],[TGL TETAP],[TGL KELUAR],[KELAMIN],[AGAMA],[DOMISILI], " +
                "[KOTA],[PROPINSI],[TELPON 1],[TELPON 2],[HP 1],[HP 2],[DARAH],[KTP],[ALAMAT KTP],[NPWP],[BPJS-TK],[DAPEN],[NOMOR REKENING],[NAMA REKENING], " + //[NOMOR REKENING],[NAMA REKENING], " + //," + //[BPJS-TK],[DAPEN],[NOMOR REKENING],[NAMA REKENING], " +
                "[KAWIN/TIDAK KAWIN],[JML ANAK],[PAJAK],[STRATA],[JURUSAN],[NAMA SEKOLAH],[KOTA SEKOLAH],[STATUS],[KETERANGAN],[KODE],[TGL MENIKAH], " +
                "[TGL CERAI],[TGL WAFAT],[PAY CYCLE],[BANK NAME],[BANK BRANCH],[SUB-DEPT],[DEPARTMENT],[DIVISI],[NAMA KONTAK DARURAT],[JENIS HUBUNGAN], " +
                "[ALAMAT DARURAT],[NOMOR TELEPON DARURAT 1],[NOMOR TELEPON DARURAT 2],[UKURAN SEPATU],[UKURAN BAJU],[LOKASI SEBELUMNYA],[TANGGAL MUTASI], " +
                "[UNIT YANG DIBAWA],[POO],[POH],[NO KK],[NIK KK], [USER ID] FROM [{0}]", "Sheet1$");
            OleDbCommand Ecom = new OleDbCommand(Query, Econ);
            Econ.Open();

            DataSet ds = new DataSet();
            OleDbDataAdapter oda = new OleDbDataAdapter(Query, Econ);
            Econ.Close();
            oda.Fill(ds);
            DataTable Exceldt = ds.Tables[0];
            connection();
            //creating object of SqlBulkCopy
            SqlBulkCopy objbulk = new SqlBulkCopy(con);
            //assigning Destination table name    
            objbulk.DestinationTableName = "UplEmpData";
            //Mapping Table column    
            objbulk.ColumnMappings.Add("NIK", "NIK");
            objbulk.ColumnMappings.Add("NAMA", "NAMA");
            objbulk.ColumnMappings.Add("POSISI", "POSISI");
            objbulk.ColumnMappings.Add("COSTING", "COSTING");
            objbulk.ColumnMappings.Add("ACTUAL", "ACTUAL");
            objbulk.ColumnMappings.Add("ASSIGN", "ASSIGN");
            objbulk.ColumnMappings.Add("CATEGORY", "CATEGORY");
            objbulk.ColumnMappings.Add("GOL", "GOL");
            objbulk.ColumnMappings.Add("SUB-GOL", "SUB-GOL");
            objbulk.ColumnMappings.Add("TMP LAHIR", "TMP LAHIR");
            objbulk.ColumnMappings.Add("TGL LAHIR", "TGL LAHIR");
            objbulk.ColumnMappings.Add("TGL GROUP", "TGL GROUP");
            objbulk.ColumnMappings.Add("TGL MASUK", "TGL MASUK");
            objbulk.ColumnMappings.Add("JENIS HUB", "JENIS HUB");
            objbulk.ColumnMappings.Add("TGL AWAL KONTRAK", "TGL AWAL KONTRAK");
            objbulk.ColumnMappings.Add("TGL AKHIR KONTRAK", "TGL AKHIR KONTRAK");
            objbulk.ColumnMappings.Add("TGL TETAP", "TGL TETAP");
            objbulk.ColumnMappings.Add("TGL KELUAR", "TGL KELUAR");
            objbulk.ColumnMappings.Add("KELAMIN", "KELAMIN");
            objbulk.ColumnMappings.Add("AGAMA", "AGAMA");
            objbulk.ColumnMappings.Add("DOMISILI", "DOMISILI");
            objbulk.ColumnMappings.Add("KOTA", "KOTA");
            objbulk.ColumnMappings.Add("PROPINSI", "PROPINSI");
            objbulk.ColumnMappings.Add("TELPON 1", "TELPON 1");
            objbulk.ColumnMappings.Add("TELPON 2", "TELPON 2");
            objbulk.ColumnMappings.Add("HP 1", "HP 1");
            objbulk.ColumnMappings.Add("HP 2", "HP 2");
            objbulk.ColumnMappings.Add("DARAH", "DARAH");
            objbulk.ColumnMappings.Add("KTP", "KTP");
            objbulk.ColumnMappings.Add("ALAMAT KTP", "ALAMAT KTP");
            objbulk.ColumnMappings.Add("NPWP", "NPWP");
            objbulk.ColumnMappings.Add("BPJS-TK", "BPJS-TK");
            objbulk.ColumnMappings.Add("DAPEN", "DAPEN");
            objbulk.ColumnMappings.Add("NOMOR REKENING", "NOMOR REKENING");
            objbulk.ColumnMappings.Add("NAMA REKENING", "NAMA REKENING");
            objbulk.ColumnMappings.Add("KAWIN/TIDAK KAWIN", "KAWIN/TIDAK KAWIN");
            objbulk.ColumnMappings.Add("JML ANAK", "JML ANAK");
            objbulk.ColumnMappings.Add("PAJAK", "PAJAK");
            objbulk.ColumnMappings.Add("STRATA", "STRATA");
            objbulk.ColumnMappings.Add("JURUSAN", "JURUSAN");
            objbulk.ColumnMappings.Add("NAMA SEKOLAH", "NAMA SEKOLAH");
            objbulk.ColumnMappings.Add("KOTA SEKOLAH", "KOTA SEKOLAH");
            objbulk.ColumnMappings.Add("STATUS", "STATUS");
            objbulk.ColumnMappings.Add("KETERANGAN", "KETERANGAN");
            objbulk.ColumnMappings.Add("KODE", "KODE");
            objbulk.ColumnMappings.Add("TGL MENIKAH", "TGL MENIKAH");
            objbulk.ColumnMappings.Add("TGL CERAI", "TGL CERAI");
            objbulk.ColumnMappings.Add("TGL WAFAT", "TGL WAFAT");
            objbulk.ColumnMappings.Add("PAY CYCLE", "PAY CYCLE");
            objbulk.ColumnMappings.Add("BANK NAME", "BANK NAME");
            objbulk.ColumnMappings.Add("BANK BRANCH", "BANK BRANCH");
            objbulk.ColumnMappings.Add("SUB-DEPT", "SUB-DEPT");
            objbulk.ColumnMappings.Add("DEPARTMENT", "DEPARTMENT");
            objbulk.ColumnMappings.Add("DIVISI", "DIVISI");
            objbulk.ColumnMappings.Add("NAMA KONTAK DARURAT", "NAMA KONTAK DARURAT");
            objbulk.ColumnMappings.Add("JENIS HUBUNGAN", "JENIS HUBUNGAN");
            objbulk.ColumnMappings.Add("ALAMAT DARURAT", "ALAMAT DARURAT");
            objbulk.ColumnMappings.Add("NOMOR TELEPON DARURAT 1", "NOMOR TELEPON DARURAT 1");
            objbulk.ColumnMappings.Add("NOMOR TELEPON DARURAT 2", "NOMOR TELEPON DARURAT 2");
            objbulk.ColumnMappings.Add("UKURAN SEPATU", "UKURAN SEPATU");
            objbulk.ColumnMappings.Add("UKURAN BAJU", "UKURAN BAJU");
            objbulk.ColumnMappings.Add("LOKASI SEBELUMNYA", "LOKASI SEBELUMNYA");
            objbulk.ColumnMappings.Add("TANGGAL MUTASI", "TANGGAL MUTASI");
            objbulk.ColumnMappings.Add("UNIT YANG DIBAWA", "UNIT YANG DIBAWA");
            objbulk.ColumnMappings.Add("POO", "POO");
            objbulk.ColumnMappings.Add("POH", "POH");
            objbulk.ColumnMappings.Add("NO KK", "NO KK");
            objbulk.ColumnMappings.Add("USER ID", "UID");
            //inserting Datatable Records to DataBase    
            con.Open();
            objbulk.WriteToServer(Exceldt);
            con.Close();
        }
        #endregion

        #region Family
        
        public DataTable GetDataFamily(string UID)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT NIK, (SELECT FamilyTypeCode FROM MsFamilyType WHERE FamilyTypeName=HUBUNGAN) AS HUBUNGAN, HUBUNGAN AS NAMA_HUBUNGAN, NAMA, " +
                "(CASE [JENIS KELAMIN] WHEN 'WANITA' THEN 'F' WHEN 'PRIA' THEN 'M' END) AS KODE_JENIS_KELAMIN,[JENIS KELAMIN] AS JNS_KELAMIN, " +
                "[TGL LAHIR] AS TGL_LAHIR, PENDIDIKAN, PEKERJAAN, KETERANGAN,UplEmpFamily.[UID] " +
                "FROM UplEmpFamily " +
                "WHERE (UplEmpFamily.[UID] = @UID)";
            cmd.Parameters.AddWithValue("@UID", UID);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            DataTable DT = new DataTable();

            try
            {
                sda.Fill(DT);
            }
            finally
            {
                con.Close();
            }

            return DT;
        }
        protected void RG_FAMILY_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataFamily(Request.Cookies["authcookie"]["uName"]);
        }

        private void InsertExcelFamilyRecords(string FilePath)
        {
            ExcelConn(FilePath);

            Query = string.Format("SELECT [NIK],[HUBUNGAN],[NAMA],[TGL_LAHIR],[PENDIDIKAN],[PEKERJAAN],[KETERANGAN],[JNS_KELAMIN], " +
                "[USER_ID] FROM [{0}]", "Sheet2$");
            OleDbCommand Ecom = new OleDbCommand(Query, Econ);
            Econ.Open();

            DataSet ds = new DataSet();
            OleDbDataAdapter oda = new OleDbDataAdapter(Query, Econ);
            Econ.Close();
            oda.Fill(ds);
            DataTable Exceldt = ds.Tables[0];
            connection();
            //creating object of SqlBulkCopy
            SqlBulkCopy objbulk = new SqlBulkCopy(con);
            //assigning Destination table name    
            objbulk.DestinationTableName = "UplEmpFamily";
            //Mapping Table column    
            objbulk.ColumnMappings.Add("NIK", "NIK");
            objbulk.ColumnMappings.Add("HUBUNGAN", "HUBUNGAN");
            objbulk.ColumnMappings.Add("NAMA", "NAMA");
            objbulk.ColumnMappings.Add("TGL_LAHIR", "TGL LAHIR");
            objbulk.ColumnMappings.Add("PENDIDIKAN", "PENDIDIKAN");
            objbulk.ColumnMappings.Add("PEKERJAAN", "PEKERJAAN");
            objbulk.ColumnMappings.Add("KETERANGAN", "KETERANGAN");
            objbulk.ColumnMappings.Add("JNS_KELAMIN", "JENIS KELAMIN");
            objbulk.ColumnMappings.Add("USER_ID", "UID");
            //inserting Datatable Records to DataBase    
            con.Open();
            objbulk.WriteToServer(Exceldt);
            con.Close();
        }
        protected void btn_upload_family_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "truncate table UplEmpFamily";
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }


            string filePath = Path.Combine(Path.GetTempPath(), Guid.NewGuid().ToString("N") + ".xlsx");
            FileUpload2.SaveAs(filePath);

            try
            {
                InsertExcelFamilyRecords(filePath);
            }
            finally
            {
                File.Delete(filePath);
                RG_FAMILY.Rebind();
                (sender as RadButton).Enabled = false;
            }
        }

        protected void FileUpload2_Unload(object sender, EventArgs e)
        {
            btn_upload_family.Enabled = true;
        }

        protected void RG_FAMILY_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataBoundItem = e.Item as GridDataItem;
                GridDataItem dataItem = e.Item as GridDataItem;
                TableCell namaHubungan = dataItem["NAMA_HUBUNGAN"];
                TableCell kodeHubungan = dataItem["HUBUNGAN"];
                TableCell kodekelamin = dataItem["KODE_JENIS_KELAMIN"];
                TableCell kelamiin = dataItem["JNS_KELAMIN"];

                if (kodeHubungan.Text == "&nbsp;")
                {
                    namaHubungan.ForeColor = System.Drawing.Color.OrangeRed;
                    namaHubungan.Font.Italic = true;
                }
                if (kodekelamin.Text  == string.Empty)
                {
                    kelamiin.ForeColor = System.Drawing.Color.OrangeRed;
                    kelamiin.Font.Italic = true;
                }
            }
        }

        protected void btn_confirm_family_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "spSaveConfirmUploadEmpFamily";
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);

                cmd.ExecuteNonQuery();


                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE UplEmpFamily WHERE [UID] = @UID";
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);

                cmd.ExecuteNonQuery();
                con.Close();
                
                string script = "alert('Data keluarga karyawan berhasil disimpan');";
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", script, true);
            }
            catch (Exception ex)
            {
                con.Close();
                string errorMessage = ex.Message.Replace("'", "\\'");
                string script = $"alert('Error: {errorMessage}');";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
                return;
            }
        }
        #endregion

        #region Education

        public DataTable GetDataEducation(string UID)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT NIK,(SELECT EducationCode FROM MsEducation WHERE JENJANG = EducationDescription) AS KODE_JENJANG, JENJANG, " +
                "(SELECT MajorCode FROM MsMajor WHERE MajorName = JURUSAN) AS KODE_JURUSAN, JURUSAN, [NAMA INSTITUSI] AS NAMA_INSTITUSI, " +
                "(SELECT CityCode FROM MSCity WHERE CityName = KOTA) AS KODE_KOTA, KOTA, [STATUS] AS STATUS_PENDIDIKAN, " +
                "(SELECT EducationStatusCode FROM MsEducationStatus WHERE EducationStatusDescription = STATUS) AS KODE_STATUS, KETERANGAN, UID " +
                "FROM UplEmpEducation WHERE (UplEmpEducation.[UID] = @UID)";
            cmd.Parameters.AddWithValue("@UID", UID);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            DataTable DT = new DataTable();

            try
            {
                sda.Fill(DT);
            }
            finally
            {
                con.Close();
            }

            return DT;
        }
        protected void RG_Education_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataEducation(Request.Cookies["authcookie"]["uName"]);
        }

        private void InsertExcelEducationRecords(string FilePath)
        {
            ExcelConn(FilePath);

            Query = string.Format("SELECT [NIK],[JENJANG],[JURUSAN],[NAMA INSTITUSI],[KOTA],[STATUS],[KETERANGAN], " +
                "[USER_ID] FROM [{0}]", "Sheet3$");
            OleDbCommand Ecom = new OleDbCommand(Query, Econ);
            Econ.Open();

            DataSet ds = new DataSet();
            OleDbDataAdapter oda = new OleDbDataAdapter(Query, Econ);
            Econ.Close();
            oda.Fill(ds);
            DataTable Exceldt = ds.Tables[0];
            connection();
            //creating object of SqlBulkCopy
            SqlBulkCopy objbulk = new SqlBulkCopy(con);
            //assigning Destination table name    
            objbulk.DestinationTableName = "UplEmpEducation";
            //Mapping Table column    
            objbulk.ColumnMappings.Add("NIK", "NIK");
            objbulk.ColumnMappings.Add("JENJANG", "JENJANG");
            objbulk.ColumnMappings.Add("JURUSAN", "JURUSAN");
            objbulk.ColumnMappings.Add("NAMA INSTITUSI", "NAMA INSTITUSI");
            objbulk.ColumnMappings.Add("KOTA", "KOTA");
            objbulk.ColumnMappings.Add("STATUS", "STATUS");
            objbulk.ColumnMappings.Add("KETERANGAN", "KETERANGAN");
            objbulk.ColumnMappings.Add("USER_ID", "UID");
            //inserting Datatable Records to DataBase    
            con.Open();
            objbulk.WriteToServer(Exceldt);
            con.Close();
        }
        protected void btn_upload_edu_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "truncate table UplEmpEducation";
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }
            
            string filePath = Path.Combine(Path.GetTempPath(), Guid.NewGuid().ToString("N") + ".xlsx");
            FileUpload3.SaveAs(filePath);

            try
            {
                InsertExcelEducationRecords(filePath);
            }
            finally
            {
                File.Delete(filePath);
                RG_Education.Rebind();
                (sender as RadButton).Enabled = false;
            }
        }
        
        
        protected void RG_Education_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                GridDataItem dataBoundItem = e.Item as GridDataItem;
                GridDataItem dataItem = e.Item as GridDataItem;
                TableCell kodeJenjang = dataItem["KODE_JENJANG"];
                TableCell jenjang = dataItem["JENJANG"];
                TableCell kodeMajor = dataItem["KODE_JURUSAN"];
                TableCell major = dataItem["JURUSAN"];
                TableCell kodeKota = dataItem["KODE_KOTA"];
                TableCell kota = dataItem["KOTA"];

                if (kodeJenjang.Text == "&nbsp;")
                {
                    jenjang.ForeColor = System.Drawing.Color.OrangeRed;
                    jenjang.Font.Italic = true;
                }
                if (kodeMajor.Text == "&nbsp;")
                {
                    major.ForeColor = System.Drawing.Color.OrangeRed;
                    major.Font.Italic = true;
                }
                if (kodeKota.Text == "&nbsp;")
                {
                    kota.ForeColor = System.Drawing.Color.OrangeRed;
                    kota.Font.Italic = true;
                }
            }
        }

        protected void btn_confirm_edu_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "spSaveConfirmUploadEmpEducation";
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);

                cmd.ExecuteNonQuery();


                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE UplEmpEducation WHERE [UID] = @UID";
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);

                cmd.ExecuteNonQuery();
                con.Close();

                string script = "alert('Data pendidikan karyawan berhasil disimpan');";
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", script, true);
            }
            catch (Exception ex)
            {
                con.Close();
                string errorMessage = ex.Message.Replace("'", "\\'");
                string script = $"alert('Error: {errorMessage}');";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
                return;
            }
        }
        #endregion

        #region Training

        public DataTable GetDataTraining(string UID)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT NIK, [TRAINING KE-] AS TRAINING_KE, [NAMA TRAINING] AS NAMA_TRAINING, LEMBAGA,  " +
                "[TANGGAL TRINING] AS TGL_TRAINING, KETERANGAN, UID FROM UplEmpTraining WHERE (UplEmpTraining.[UID] = @UID)";
            cmd.Parameters.AddWithValue("@UID", UID);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            DataTable DT = new DataTable();

            try
            {
                sda.Fill(DT);
            }
            finally
            {
                con.Close();
            }

            return DT;
        }
        protected void RG_Training_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTraining(Request.Cookies["authcookie"]["uName"]);
        }

        private void InsertExcelTrainingRecords(string FilePath)
        {
            ExcelConn(FilePath);

            Query = string.Format("SELECT [NIK],[TRAINING KE],[NAMA TRAINING],[PENYELENGGARA],[TANGGAL], [KETERANGAN], " +
                "[USER_ID] FROM [{0}]", "Sheet4$");
            OleDbCommand Ecom = new OleDbCommand(Query, Econ);
            Econ.Open();

            DataSet ds = new DataSet();
            OleDbDataAdapter oda = new OleDbDataAdapter(Query, Econ);
            Econ.Close();
            oda.Fill(ds);
            DataTable Exceldt = ds.Tables[0];
            connection();
            //creating object of SqlBulkCopy
            SqlBulkCopy objbulk = new SqlBulkCopy(con);
            //assigning Destination table name    
            objbulk.DestinationTableName = "UplEmpTraining";
            //Mapping Table column    
            objbulk.ColumnMappings.Add("NIK", "NIK");
            objbulk.ColumnMappings.Add("TRAINING KE", "TRAINING KE-");
            objbulk.ColumnMappings.Add("NAMA TRAINING", "NAMA TRAINING");
            objbulk.ColumnMappings.Add("PENYELENGGARA", "LEMBAGA");
            objbulk.ColumnMappings.Add("TANGGAL", "TANGGAL TRINING");
            objbulk.ColumnMappings.Add("USER_ID", "UID");
            //inserting Datatable Records to DataBase    
            con.Open();
            objbulk.WriteToServer(Exceldt);
            con.Close();
        }
        protected void btn_upload_training_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "truncate table UplEmpTraining";
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }

            string filePath = Path.Combine(Path.GetTempPath(), Guid.NewGuid().ToString("N") + ".xlsx");
            FileUpload4.SaveAs(filePath);

            try
            {
                InsertExcelTrainingRecords(filePath);
            }
            finally
            {
                File.Delete(filePath);
                RG_Training.Rebind();
                (sender as RadButton).Enabled = false;
            }
        }
        
        protected void btn_confirm_training_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "spSaveConfirmUploadEmpTraining";
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);

                cmd.ExecuteNonQuery();


                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE UplEmpTraining WHERE [UID] = @UID";
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);

                cmd.ExecuteNonQuery();
                con.Close();

                string script = "alert('Data training karyawan berhasil disimpan');";
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", script, true);
            }
            catch (Exception ex)
            {
                con.Close();
                string errorMessage = ex.Message.Replace("'", "\\'");
                string script = $"alert('Error: {errorMessage}');";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
                return;
            }
        }
        #endregion

        #region Lisensi

        public DataTable GetDataLisensi(string UID)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT NIK, [LISENSI KE-] AS LISENSI_KE, [NAMA LISENSI] AS NAMA_LISENSI, LEMBAGA,  " +
                "[TANGGAL] AS TGL_LISENSI, [NOMOR LISENSI] AS NO_LISENSI, KETERANGAN, UID FROM UplEmpLisensi WHERE (UplEmpLisensi.[UID] = @UID)";
            cmd.Parameters.AddWithValue("@UID", UID);
            cmd.CommandTimeout = 0;
            cmd.ExecuteNonQuery();
            sda = new SqlDataAdapter(cmd);

            DataTable DT = new DataTable();

            try
            {
                sda.Fill(DT);
            }
            finally
            {
                con.Close();
            }

            return DT;
        }
        protected void RG_Lisensi_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataLisensi(Request.Cookies["authcookie"]["uName"]);
        }

        private void InsertExcelLisensiRecords(string FilePath)
        {
            ExcelConn(FilePath);

            Query = string.Format("SELECT [NIK],[LISENSI KE],[NAMA LISENSI], [LEMBAGA], [TANGGAL], [NOMOR LISENSI], [KETERANGAN], " +
                "[USER_ID] FROM [{0}]", "Sheet5$");
            OleDbCommand Ecom = new OleDbCommand(Query, Econ);
            Econ.Open();

            DataSet ds = new DataSet();
            OleDbDataAdapter oda = new OleDbDataAdapter(Query, Econ);
            Econ.Close();
            oda.Fill(ds);
            DataTable Exceldt = ds.Tables[0];
            connection();
            //creating object of SqlBulkCopy
            SqlBulkCopy objbulk = new SqlBulkCopy(con);
            //assigning Destination table name    
            objbulk.DestinationTableName = "UplEmpLisensi";
            //Mapping Table column    
            objbulk.ColumnMappings.Add("NIK", "NIK");
            objbulk.ColumnMappings.Add("LISENSI KE", "LISENSI KE-");
            objbulk.ColumnMappings.Add("NAMA LISENSI", "NAMA LISENSI");
            objbulk.ColumnMappings.Add("LEMBAGA", "LEMBAGA");
            objbulk.ColumnMappings.Add("TANGGAL", "TANGGAL");
            objbulk.ColumnMappings.Add("NOMOR LISENSI", "NOMOR LISENSI");
            objbulk.ColumnMappings.Add("KETERANGAN", "KETERANGAN");
            objbulk.ColumnMappings.Add("USER_ID", "UID");
            //inserting Datatable Records to DataBase    
            con.Open();
            objbulk.WriteToServer(Exceldt);
            con.Close();
        }
        protected void btn_upload_lisensi_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "truncate table UplEmpLisensi";
                cmd.ExecuteNonQuery();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
                Response.Write("<font color='red'>" + ex.Message + "</font>");
            }

            string filePath = Path.Combine(Path.GetTempPath(), Guid.NewGuid().ToString("N") + ".xlsx");
            FileUpload5.SaveAs(filePath);

            try
            {
                InsertExcelLisensiRecords(filePath);
            }
            finally
            {
                File.Delete(filePath);
                RG_Lisensi.Rebind();
                (sender as RadButton).Enabled = false;
            }
        }

        protected void btn_confirm_lisensi_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "spSaveConfirmUploadEmpLisensi";
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);

                cmd.ExecuteNonQuery();


                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "DELETE UplEmpLisensi WHERE [UID] = @UID";
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);

                cmd.ExecuteNonQuery();
                con.Close();

                string script = "alert('Data lisensi karyawan berhasil disimpan');";
                ClientScript.RegisterStartupScript(this.GetType(), "AlertScript", script, true);
            }
            catch (Exception ex)
            {
                con.Close();
                string errorMessage = ex.Message.Replace("'", "\\'");
                string script = $"alert('Error: {errorMessage}');";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
                return;
            }
        }
        #endregion
    }
}