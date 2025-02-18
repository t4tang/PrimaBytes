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
    public partial class pa_emp01 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        private string maritalSts;
        private static string selected_nik = null;
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
       

        protected void btn_add_Click(object sender, EventArgs e)
        {

        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {

        }

        protected void cb_project_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_project_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_project_prm_PreRender(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void chk_filter_CheckedChanged(object sender, EventArgs e)
        {

        }
        public DataTable GetDataTable(string uid)
        {
           
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM v_employee WHERE RecordStatus = 'A' " +
                                "AND LocationCode IN (SELECT region_code FROM MsUsersJobsite WHERE MsUsersJobsite.kduser = @kdUser)";
            //cmd.Parameters.AddWithValue("@project", project);
            cmd.Parameters.AddWithValue("@kdUser", uid);
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
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            if (Request.Cookies["authcookie"]["site"].ToString() == "HO")
            {
                (sender as RadGrid).DataSource = GetDataTable("");
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataTable(Request.Cookies["authcookie"]["uid"].ToString());
            }
        }
        protected void RadGrid1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //foreach (GridDataItem item in RadGrid1.SelectedItems)
            //{
            //    selected_nik = item["EmployeeNo"].Text;
            //}
        }
        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var NIK = ((GridDataItem)e.Item).GetDataKeyValue("EmployeeNo");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE TrEmployee SET RecordStatus = 'D', ChangeBy = @ChangeBy, ChangeDate = GETDATE() WHERE EmployeeNo = @NIK";
            cmd.Parameters.AddWithValue("@NIK", NIK);
            cmd.Parameters.AddWithValue("@ChangeBy", Request.Cookies["authcookie"]["uid"]);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                (sender as RadGrid).MasterTableView.IsItemInserted = false;
                (sender as RadGrid).MasterTableView.Rebind();
                
                GridDataItem item = e.Item as GridDataItem;
                selected_nik = item["EmployeeNo"].Text;

                Session["actionHeader"] = "headerEdit";
                Session["actionDetail"] = null;
            }
        }

        protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadBinaryImage RadBinaryImage1 = (RadBinaryImage)item.FindControl("RadBinaryImage1");
            RadTextBox txt_nik = (RadTextBox)item.FindControl("txt_nik");
            RadTextBox txt_EmployeeName = (RadTextBox)item.FindControl("txt_EmployeeName");
            RadTextBox txt_posisi = (RadTextBox)item.FindControl("txt_posisi");
            RadTextBox txt_kartu_keluarga = (RadTextBox)item.FindControl("txt_kartu_keluarga");
            RadTextBox txt_ktp = (RadTextBox)item.FindControl("txt_ktp");
            RadTextBox txt_bpjs_kesehatan = (RadTextBox)item.FindControl("txt_bpjs_kesehatan");
            RadTextBox txt_bpjs_ketenagakerjaan = (RadTextBox)item.FindControl("txt_bpjs_ketenagakerjaan");
            RadTextBox txt_npwp = (RadTextBox)item.FindControl("txt_npwp");
            RadTextBox txt_sim = (RadTextBox)item.FindControl("txt_sim");
            RadTextBox txt_dapen = (RadTextBox)item.FindControl("txt_dapen");
            RadTextBox txt_norek = (RadTextBox)item.FindControl("txt_norek");
            RadTextBox txt_nama_rekening = (RadTextBox)item.FindControl("txt_nama_rekening");
            RadTextBox txt_tempat_lahir = (RadTextBox)item.FindControl("txt_tempat_lahir");
            RadTextBox txt_telp = (RadTextBox)item.FindControl("txt_telp");
            RadTextBox txt_domisili = (RadTextBox)item.FindControl("txt_domisili");
            RadTextBox txt_alamat_ktp = (RadTextBox)item.FindControl("txt_alamat_ktp");
            RadTextBox txt_no_hp = (RadTextBox)item.FindControl("txt_no_hp");
            RadTextBox txt_email = (RadTextBox)item.FindControl("txt_email");
            RadTextBox txt_gol_darah = (RadTextBox)item.FindControl("txt_gol_darah");
            //RadTextBox txt_jns_hub_emergency_contak = (RadTextBox)item.FindControl("txt_jns_hub_emergency_contak");
            RadTextBox txt_alamat_kontak_darurat = (RadTextBox)item.FindControl("txt_alamat_kontak_darurat");
            RadTextBox txt_tlp_kontak_darurat = (RadTextBox)item.FindControl("txt_tlp_kontak_darurat");
            RadTextBox txt_ukuran_baju = (RadTextBox)item.FindControl("txt_ukuran_baju");
            RadTextBox txt_ukuran_sepatu = (RadTextBox)item.FindControl("txt_ukuran_sepatu");
            RadTextBox txt_kode_unit = (RadTextBox)item.FindControl("txt_kode_unit");
            RadTextBox txt_bank_branch = (RadTextBox)item.FindControl("txt_bank_branch");
            RadTextBox txt_nama_kontak = (RadTextBox)item.FindControl("txt_nama_kontak");

            RadNumericTextBox txt_jumlah_anak = (RadNumericTextBox)item.FindControl("txt_jumlah_anak");

            RadComboBox cb_lokasi = (RadComboBox)item.FindControl("cb_lokasi");
            RadComboBox cb_jns_hubungan = (RadComboBox)item.FindControl("cb_jns_hubungan");
            RadComboBox cb_source_bank_name = (RadComboBox)item.FindControl("cb_source_bank_name");
            RadComboBox cb_status_pajak = (RadComboBox)item.FindControl("cb_status_pajak");
            RadComboBox cb_poh = (RadComboBox)item.FindControl("cb_poh");
            RadComboBox cb_poo = (RadComboBox)item.FindControl("cb_poo");
            RadComboBox cb_jns_kelamin = (RadComboBox)item.FindControl("cb_jns_kelamin");
            RadComboBox cb_agama = (RadComboBox)item.FindControl("cb_agama");
            RadComboBox cb_marital_status = (RadComboBox)item.FindControl("cb_marital_status");
            RadComboBox cb_posisi = (RadComboBox)item.FindControl("cb_posisi");
            RadComboBox cb_kategori_pangkat = (RadComboBox)item.FindControl("cb_kategori_pangkat");
            RadComboBox cb_golongan = (RadComboBox)item.FindControl("cb_golongan");
            RadComboBox cb_sub_golongan = (RadComboBox)item.FindControl("cb_sub_golongan");
            RadComboBox cb_costing = (RadComboBox)item.FindControl("cb_costing");
            RadComboBox cb_actual = (RadComboBox)item.FindControl("cb_actual");
            RadComboBox cb_divisi = (RadComboBox)item.FindControl("cb_divisi");
            RadComboBox cb_department = (RadComboBox)item.FindControl("cb_department");
            RadComboBox cb_section = (RadComboBox)item.FindControl("cb_section");
            RadComboBox cb_posisi_assign = (RadComboBox)item.FindControl("cb_posisi_assign");
            RadComboBox cb_jns_hub_emergency_kontak = (RadComboBox)item.FindControl("CB_jns_hub_emergency_kontak");

            RadDatePicker dtp_tgl_group = (RadDatePicker)item.FindControl("dtp_tgl_group");
            RadDatePicker dtp_tgl_masuk = (RadDatePicker)item.FindControl("dtp_tgl_masuk");
            RadDatePicker dtp_tgl_tetap = (RadDatePicker)item.FindControl("dtp_tgl_tetap");
            RadDatePicker dtp_tgl_awal_kontrak = (RadDatePicker)item.FindControl("dtp_tgl_awal_kontrak");
            RadDatePicker dtp_tgl_akhir_kontrak = (RadDatePicker)item.FindControl("dtp_tgl_akhir_kontrak");
            RadDatePicker dtp_akhir = (RadDatePicker)item.FindControl("dtp_akhir");
            RadDatePicker dtp_tgl_lahir = (RadDatePicker)item.FindControl("dtp_tgl_lahir");
            RadDatePicker dtp_tgl_menikah = (RadDatePicker)item.FindControl("dtp_tgl_menikah");
            
            Button btnCancel = (Button)item.FindControl("btnCancel");
            RadGrid rg_family = (RadGrid)item.FindControl("rg_family");
            RadGrid rg_pendidikan = (RadGrid)item.FindControl("rg_pendidikan");
            RadGrid rg_training = (RadGrid)item.FindControl("rg_training");
            RadGrid rg_lisensi = (RadGrid)item.FindControl("rg_lisensi");

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "spSaveEmployee";
                cmd.Parameters.AddWithValue("@CompanyCode", Request.Cookies["authcookie"]["company_code"]);
                cmd.Parameters.AddWithValue("@EmployeeNo", txt_nik.Text);
                cmd.Parameters.AddWithValue("@Title", DBNull.Value);
                cmd.Parameters.AddWithValue("@FirstName", txt_EmployeeName.Text);
                cmd.Parameters.AddWithValue("@MiddleName", DBNull.Value);
                cmd.Parameters.AddWithValue("@LastName", DBNull.Value);
                cmd.Parameters.AddWithValue("@BirthPlace", txt_tempat_lahir.Text);
                DateTime? tgl_lahir = dtp_tgl_lahir.SelectedDate;
                if (tgl_lahir.HasValue)
                {
                    cmd.Parameters.AddWithValue("@BirthDate", tgl_lahir.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@BirthDate", DBNull.Value);
                }                
                cmd.Parameters.AddWithValue("@Gender", cb_jns_kelamin.SelectedValue);
                cmd.Parameters.AddWithValue("@MaritalStatus", cb_marital_status.SelectedValue);
                cmd.Parameters.AddWithValue("@NoOfDependents", txt_jumlah_anak.Value);
                cmd.Parameters.AddWithValue("@TaxRegisteredNo", txt_npwp.Text);
                cmd.Parameters.AddWithValue("@ReligionCode", cb_agama.SelectedValue);
                cmd.Parameters.AddWithValue("@EmploymentStatus", cb_jns_hubungan.SelectedValue);

                DateTime? tgl_masuk = dtp_tgl_masuk.SelectedDate;
                if (tgl_masuk.HasValue)
                {
                    cmd.Parameters.AddWithValue("@JoinDate", tgl_masuk.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@JoinDate", DBNull.Value);
                }

                DateTime? tgl_awal_kontrak = dtp_tgl_awal_kontrak.SelectedDate;
                if (tgl_awal_kontrak.HasValue)
                {
                    cmd.Parameters.AddWithValue("@ContractStartDate", tgl_awal_kontrak.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@ContractStartDate", DBNull.Value);
                }

                DateTime? tgl_akhir_kontrak = dtp_tgl_akhir_kontrak.SelectedDate;
                if (tgl_akhir_kontrak.HasValue)
                {
                    cmd.Parameters.AddWithValue("@ContractEndDate", tgl_akhir_kontrak.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@ContractEndDate", DBNull.Value);
                }

                DateTime? tgl_akhir = dtp_akhir.SelectedDate;
                if (tgl_akhir.HasValue)
                {
                    cmd.Parameters.AddWithValue("@TerminationDate", tgl_akhir.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@TerminationDate", DBNull.Value);
                }
                
                cmd.Parameters.AddWithValue("@BPJSNo", txt_bpjs_ketenagakerjaan.Text);
                cmd.Parameters.AddWithValue("@BPJSKesNo", txt_bpjs_kesehatan.Text);
                cmd.Parameters.AddWithValue("@DapenNo", txt_dapen.Text);
                cmd.Parameters.AddWithValue("@LocationCode", cb_actual.SelectedValue);
                cmd.Parameters.AddWithValue("@GradeCode", cb_golongan.SelectedValue);
                cmd.Parameters.AddWithValue("@SubGradeCode", cb_sub_golongan.SelectedValue);
                cmd.Parameters.AddWithValue("@PositionCode", cb_posisi.SelectedValue);
                cmd.Parameters.AddWithValue("@RankingCode", DBNull.Value);
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);
                cmd.Parameters.AddWithValue("@StatusTax",  cb_status_pajak.Text);
                cmd.Parameters.AddWithValue("@Assign", cb_posisi_assign.SelectedValue);
                cmd.Parameters.AddWithValue("@EmpCategory", cb_kategori_pangkat.SelectedValue);

                DateTime? tgl_group = dtp_tgl_group.SelectedDate;
                if (tgl_group.HasValue)
                {
                    cmd.Parameters.AddWithValue("@GroupDate", tgl_group.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@GroupDate", DBNull.Value);
                }

                DateTime? tgl_tetap = dtp_tgl_tetap.SelectedDate;
                if (tgl_tetap.HasValue)
                {
                    cmd.Parameters.AddWithValue("@PermanentDate", tgl_tetap.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@PermanentDate", DBNull.Value);
                }
                
                cmd.Parameters.AddWithValue("@Domicile", txt_domisili.Text);
                cmd.Parameters.AddWithValue("@DomicileCity", DBNull.Value);
                cmd.Parameters.AddWithValue("@DomicileProvince", DBNull.Value);
                cmd.Parameters.AddWithValue("@Phone1", txt_telp.Text);
                cmd.Parameters.AddWithValue("@Hp1", txt_no_hp.Text);
                cmd.Parameters.AddWithValue("@BloodType", txt_gol_darah.Text);
                cmd.Parameters.AddWithValue("@IdCardNo", txt_ktp.Text);
                cmd.Parameters.AddWithValue("@IdCardAddress", txt_alamat_ktp.Text);
                cmd.Parameters.AddWithValue("@DrivingLisenceNo", txt_sim.Text);
                cmd.Parameters.AddWithValue("@BankAccNo", txt_norek.Text);
                cmd.Parameters.AddWithValue("@BankAccName", txt_nama_rekening.Text);
                cmd.Parameters.AddWithValue("@BankCode", cb_source_bank_name.SelectedValue);
                cmd.Parameters.AddWithValue("@BankBranch", txt_bank_branch.Text);
                cmd.Parameters.AddWithValue("@EducationLevel", DBNull.Value);
                cmd.Parameters.AddWithValue("@EducationMajor", DBNull.Value);
                cmd.Parameters.AddWithValue("@SchoolName", DBNull.Value);
                cmd.Parameters.AddWithValue("@CityOfSchool", DBNull.Value);
                cmd.Parameters.AddWithValue("@EducationStatus", DBNull.Value);
                cmd.Parameters.AddWithValue("@EducationNote", DBNull.Value);
                cmd.Parameters.AddWithValue("@EducationCode", DBNull.Value);

                DateTime? tgl_menikah = dtp_tgl_menikah.SelectedDate;
                if (tgl_menikah.HasValue)
                {
                    cmd.Parameters.AddWithValue("@MarriedDate", tgl_menikah.Value);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@MarriedDate", DBNull.Value);
                }
                                
                cmd.Parameters.AddWithValue("@DivorcedDate", DBNull.Value);
                cmd.Parameters.AddWithValue("@SpouseDeathDate ", DBNull.Value);
                cmd.Parameters.AddWithValue("@PayCycle", DBNull.Value);
                cmd.Parameters.AddWithValue("@SubDepartment", cb_section.SelectedValue);
                cmd.Parameters.AddWithValue("@Department", cb_department.SelectedValue);
                cmd.Parameters.AddWithValue("@Division", cb_divisi.SelectedValue);
                cmd.Parameters.AddWithValue("@EmergencyContactName", txt_nama_kontak.Text);
                cmd.Parameters.AddWithValue("@EmergencyContactType", cb_jns_hub_emergency_kontak.Text);
                cmd.Parameters.AddWithValue("@EmergencyContactAddress", txt_alamat_kontak_darurat.Text);
                cmd.Parameters.AddWithValue("@EmergencyContactPhone1", txt_tlp_kontak_darurat.Text);
                cmd.Parameters.AddWithValue("@EmergencyContactPhone2", DBNull.Value);
                cmd.Parameters.AddWithValue("@ShoeSize", txt_ukuran_sepatu.Text);
                cmd.Parameters.AddWithValue("@ClothSize", txt_ukuran_baju.Text);
                cmd.Parameters.AddWithValue("@UnitCode", txt_kode_unit.Text);
                cmd.Parameters.AddWithValue("@POO", cb_poo.SelectedValue);
                cmd.Parameters.AddWithValue("@POH", cb_poh.SelectedValue);
                cmd.Parameters.AddWithValue("@FamilyCardNo", txt_kartu_keluarga.Text);
                cmd.Parameters.AddWithValue("@Email", txt_email.Text);
                cmd.Parameters.AddWithValue("@SpouseName", DBNull.Value);
                cmd.Parameters.AddWithValue("@SpouseBirthDate", DBNull.Value);
                cmd.Parameters.AddWithValue("@SpouseRemark", DBNull.Value);
                cmd.Parameters.AddWithValue("@costingCode", cb_costing.SelectedValue);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                con.Close();
                string errorMessage = ex.Message.Replace("'", "\\'");
                string script = $"alert('Error: {errorMessage}');";
                ClientScript.RegisterStartupScript(this.GetType(), "ErrorAlert", script, true);
                return;
            }
            finally
            {
                con.Close();
                RadGrid1.Rebind();
            }

        }
        #region Lokasi
        private static string selected_lokasi = null;
        
        private static DataTable GetLokasi(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT LocationCode, LocationName FROM MsLocation WHERE recordStatus = 'A' " +
                "AND LocationName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_lokasi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetLokasi(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["LocationName"].ToString(), data.Rows[i]["LocationName"].ToString()));
            }
        }

        protected void cb_lokasi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT LocationCode FROM MsLocation WHERE LocationName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["LocationCode"].ToString();
                selected_lokasi = dr["LocationCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_lokasi_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT LocationCode FROM MsLocation WHERE LocationName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["LocationCode"].ToString();
                selected_lokasi = dr["LocationCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region Jenis Hubungan
        private static string selected_sts_karyawan = null;
        private static DataTable GetStatusKaryawan(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT EmpStatusCode, EmpStatusName FROM MsEmployeeStatus WHERE recordStatus = 'A' " +
                "AND EmpStatusName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_jns_hubungan_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetStatusKaryawan(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["EmpStatusName"].ToString(), data.Rows[i]["EmpStatusName"].ToString()));
            }
        }
        protected void cb_jns_hubungan_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT EmpStatusCode FROM MsEmployeeStatus WHERE EmpStatusName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["EmpStatusCode"].ToString();
                selected_sts_karyawan = dr["EmpStatusCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_jns_hubungan_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT EmpStatusCode FROM MsEmployeeStatus WHERE EmpStatusName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["EmpStatusCode"].ToString();
                selected_sts_karyawan = dr["EmpStatusCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region statusPajak
        protected void cb_status_pajak_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("KO");
            (sender as RadComboBox).Items.Add("K1");
            (sender as RadComboBox).Items.Add("K2");
            (sender as RadComboBox).Items.Add("K3");
            (sender as RadComboBox).Items.Add("TK");
            (sender as RadComboBox).Items.Add("TK0");
            (sender as RadComboBox).Items.Add("TK1");
            (sender as RadComboBox).Items.Add("TK2");
            (sender as RadComboBox).Items.Add("TK3");
        }
        
        #endregion
        #region statusKawin
        private static DataTable GetStatusKawin(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT MaritalStatusName, MaritalStatusCode FROM MsMaritalStatus WHERE recordStatus = 'A' " +
                "AND MaritalStatusName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_status_perkawinan_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetStatusKawin(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["MaritalStatusName"].ToString(), data.Rows[i]["MaritalStatusName"].ToString()));
            }
        }

        protected void cb_status_perkawinan_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT MaritalStatusCode FROM MsMaritalStatus WHERE MaritalStatusName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["MaritalStatusCode"].ToString();
                maritalSts = dr["MaritalStatusCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_status_perkawinan_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT MaritalStatusCode FROM MsMaritalStatus WHERE MaritalStatusName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["MaritalStatusCode"].ToString();
                maritalSts = dr["MaritalStatusCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        #endregion
        #region POH/POO
        private static string selected_poh = null;
        private static string selected_poo = null;
        private static DataTable GetPohPoo(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CityCode, CityName FROM MSCity WHERE (RecordStatus = 'A') AND CityName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_poh_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetPohPoo(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["CityName"].ToString(), data.Rows[i]["CityName"].ToString()));
            }
        }

        protected void cb_poh_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT CityCode FROM MSCity WHERE CityName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CityCode"].ToString();
                selected_poh = dr["CityCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_poh_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT CityCode FROM MSCity WHERE CityName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CityCode"].ToString();
                selected_poh = dr["CityCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_poo_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetPohPoo(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["CityName"].ToString(), data.Rows[i]["CityName"].ToString()));
            }
        }

        protected void cb_poo_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT CityCode FROM MSCity WHERE CityName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CityCode"].ToString();
                selected_poo = dr["CityCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_poo_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT CityCode FROM MSCity WHERE CityName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CityCode"].ToString();
                selected_poo = dr["CityCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region Jenis Kelamin
        protected void cb_jns_kelamin_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("PRIA");
            (sender as RadComboBox).Items.Add("WANITA");
        }
        protected void cb_jns_kelamin_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if((sender as RadComboBox).Text == "PRIA")
            {
                (sender as RadComboBox).SelectedValue = "M";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "F";
            }
        }
        protected void cb_jns_kelamin_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "PRIA")
            {
                (sender as RadComboBox).SelectedValue = "M";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "F";
            }
        }
        #endregion
        #region Agama
        private static string selected_agama = null;
        private static DataTable GetAgama(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT ReligionCode, ReligionName from MsReligion WHERE (RecordStatus = 'A') " +
                "AND ReligionName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_agama_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetAgama(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["ReligionName"].ToString(), data.Rows[i]["ReligionName"].ToString()));
            }
        }

        protected void cb_agama_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT ReligionCode FROM MsReligion WHERE ReligionName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["ReligionCode"].ToString();
                selected_agama = dr["ReligionCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_agama_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT ReligionCode FROM MsReligion WHERE ReligionName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["ReligionCode"].ToString();
                selected_agama = dr["ReligionCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region posisi
        private static string selected_posisi = null;
        private static DataTable GetPosisi(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT PositionCode, PositionName FROM MsPosition WHERE (RecordStatus = 'A') " +
                "AND PositionName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_posisi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetPosisi(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["PositionName"].ToString(), data.Rows[i]["PositionName"].ToString()));
            }
        }

        protected void cb_posisi_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT PositionCode FROM MsPosition WHERE PositionName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["PositionCode"].ToString();
                selected_posisi = dr["PositionCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_posisi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT PositionCode FROM MsPosition WHERE PositionName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["PositionCode"].ToString();
                selected_posisi = dr["PositionCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        private static string selected_posisi_assign = null;
        protected void cb_posisi_assign_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT PositionCode FROM MsPosition WHERE PositionName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["PositionCode"].ToString();
                selected_posisi_assign = dr["PositionCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_posisi_assign_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT PositionCode FROM MsPosition WHERE PositionName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["PositionCode"].ToString();
                selected_posisi_assign = dr["PositionCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region pangkat
        private static string selected_kategori_pangkat = null;
        private static DataTable GetKategoriPangkat(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT EmployeeCategoryCode, EmployeeCategoryName FROM MsEmployeeCategory WHERE (RecordStatus = 'A') " +
                "AND EmployeeCategoryName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_kategori_pangkat_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetKategoriPangkat(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["EmployeeCategoryName"].ToString(), data.Rows[i]["EmployeeCategoryName"].ToString()));
            }
        }
        protected void cb_kategori_pangkat_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT EmployeeCategoryCode FROM MsEmployeeCategory WHERE EmployeeCategoryName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["EmployeeCategoryCode"].ToString();
                selected_kategori_pangkat = dr["EmployeeCategoryCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_kategori_pangkat_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT EmployeeCategoryCode FROM MsEmployeeCategory WHERE EmployeeCategoryName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["EmployeeCategoryCode"].ToString();
                selected_kategori_pangkat = dr["EmployeeCategoryCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region golongan
        private static string selected_golongan = null;
        private static DataTable GetGolongan(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT GradeCode, GradeName FROM MsGrade " +
                "WHERE (RecordStatus = 'A') AND GradeName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_golongan_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetGolongan(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["GradeName"].ToString(), data.Rows[i]["GradeName"].ToString()));
            }
        }
        protected void cb_golongan_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT GradeCode FROM MsGrade WHERE GradeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["GradeCode"].ToString();
                selected_golongan = dr["GradeCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_golongan_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT GradeCode FROM MsGrade WHERE GradeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["GradeCode"].ToString();
                selected_golongan = dr["GradeCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region sub golongan
        private static string selected_sub_golongan = null;
        private static DataTable GetSubGolongan(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT SubGradeCode, SubGradeName FROM MsSubGrade " +
                "WHERE (RecordStatus = 'A') AND SubGradeName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_sub_golongan_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetSubGolongan(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["SubGradeName"].ToString(), data.Rows[i]["SubGradeName"].ToString()));
            }
        }
        protected void cb_sub_golongan_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT SubGradeCode FROM MsSubGrade WHERE SubGradeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["SubGradeCode"].ToString();
                selected_sub_golongan = dr["SubGradeCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_sub_golongan_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT SubGradeCode FROM MsSubGrade WHERE SubGradeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["SubGradeCode"].ToString();
                selected_sub_golongan = dr["SubGradeCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region costing
        private static string selected_costing = null;
        protected void cb_costing_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT LocationCode FROM MsLocation WHERE LocationName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["LocationCode"].ToString();
                selected_costing = dr["LocationCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_costing_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT LocationCode FROM MsLocation WHERE LocationName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["LocationCode"].ToString();
                selected_costing = dr["LocationCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region aktual
        private static string selected_actual = null;
        
        protected void cb_actual_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT LocationCode FROM MsLocation WHERE LocationName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["LocationCode"].ToString();
                selected_actual = dr["LocationCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_actual_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT LocationCode FROM MsLocation WHERE LocationName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["LocationCode"].ToString();
                selected_actual = dr["LocationCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion

        #region Divisi
        private static string selected_divisi = null;
        private static DataTable GetDivisi(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT DivisionCode, DivisionName FROM MsDivision " +
                "WHERE (RecordStatus = 'A') AND DivisionName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_divisi_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetDivisi(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["DivisionName"].ToString(), data.Rows[i]["DivisionName"].ToString()));
            }
        }
        protected void cb_divisi_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT DivisionCode FROM MsDivision WHERE DivisionName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["DivisionCode"].ToString();
                selected_divisi = dr["DivisionCode"].ToString();
            }
            dr.Close();
            con.Close();
        }


        protected void cb_divisi_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT DivisionCode FROM MsDivision WHERE DivisionName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["DivisionCode"].ToString();
                selected_divisi = dr["DivisionCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region Department
        private static string selected_department = null;
        private static DataTable GetDepartment(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT DepartmentCode, DepartmentName FROM MsDepartment " +
                "WHERE (RecordStatus = 'A') AND DepartmentName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_department_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetDepartment(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["DepartmentName"].ToString(), data.Rows[i]["DepartmentName"].ToString()));
            }
        }

        protected void cb_department_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT DepartmentCode FROM MsDepartment WHERE DepartmentName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["DepartmentCode"].ToString();
                selected_department = dr["DepartmentCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_department_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT DepartmentCode FROM MsDepartment WHERE DepartmentName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["DepartmentCode"].ToString();
                selected_department = dr["DepartmentCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region Section
        private static string selected_section = null;
        
        protected void cb_section_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT DepartmentCode FROM MsDepartment WHERE DepartmentName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["DepartmentCode"].ToString();
                selected_section = dr["DepartmentCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_section_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT DepartmentCode FROM MsDepartment WHERE DepartmentName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["DepartmentCode"].ToString();
                selected_section = dr["DepartmentCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region mutasi/pergerakan
        protected void rg_pergerakan_karyawan_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = new string[] { };
        }

        protected void rg_pergerakan_karyawan_DeleteCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void rg_pergerakan_karyawan_ItemCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void cb_jabatan_temp_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_jabatan_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
        #endregion

        #region Family
        public DataTable GetDataEmpFamilyTable(string nik)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM vEmployeeFamily WHERE EmployeeNo = @nik";
            cmd.Parameters.AddWithValue("@nik", nik);
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
        protected void rg_family_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                if(selected_nik == null)
                {
                    (sender as RadGrid).DataSource = new string[] { };
                }
                else
                {
                    (sender as RadGrid).DataSource = GetDataEmpFamilyTable(selected_nik);
                }
                
            }

        }

        protected void rg_family_DeleteCommand(object sender, GridCommandEventArgs e)
        {

        }
        private static DataTable GetFamily(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT FamilyTypeCode, FamilyTypeName FROM MsFamilyType WHERE (RecordStatus = 'A') " +
                "AND FamilyTypeName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_jenis_keluarga_temp_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetFamily(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["FamilyTypeName"].ToString(), data.Rows[i]["FamilyTypeName"].ToString()));
            }

        }

        protected void cb_jenis_keluarga_edit_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT FamilyTypeCode FROM MsFamilyType WHERE FamilyTypeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["FamilyTypeCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        

        protected void cb_jenis_keluarga_insert_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT FamilyTypeCode FROM MsFamilyType WHERE FamilyTypeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["FamilyTypeCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_jns_kelamin_edit_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "PRIA")
            {
                (sender as RadComboBox).SelectedValue = "L";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "P";
            }
        }

        protected void cb_jns_kelamin_insert_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "PRIA")
            {
                (sender as RadComboBox).SelectedValue = "L";
            }
            else
            {
                (sender as RadComboBox).SelectedValue = "P";
            }
        }

        protected void rg_family_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO TrEmpFamily(EmployeeNo, FamilyType, FamilyName, FamilyBirthDate, FamilyEducation, " +
                               " Remark, Gender, CreateBy, ChangeBy, CreateDate, ChangeDate, ChangeNo) " +
                               " VALUES(@EmployeeNo, @FamilyType, @FamilyName, @FamilyBirthDate, @FamilyEducation, " +
                               " @Remark, @Gender, @UID, @UID, GETDATE(), GETDATE(), 0)";
            cmd.Parameters.AddWithValue("@EmployeeNo", selected_nik);
            cmd.Parameters.AddWithValue("@FamilyType", (item.FindControl("cb_jenis_keluarga_insert_temp") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@FamilyName", (item.FindControl("txt_nama_keluarga_insert_temp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@FamilyBirthDate", (item.FindControl("dtp_tgl_lahir_insert_temp") as RadDatePicker).SelectedDate.Value);
            cmd.Parameters.AddWithValue("@FamilyEducation", DBNull.Value);
            cmd.Parameters.AddWithValue("@Remark", (item.FindControl("txt_keterangan_insert_temp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@Gender", (item.FindControl("cb_jns_kelamin_insert_temp") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void rg_family_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            if (e.Item is GridEditableItem)
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE TrEmpFamily SET FamilyType = @FamilyType, FamilyBirthDate = @FamilyBirthDate, FamilyName = @FamilyName, " +
                               "Remark = @Remark, Gender = @Gender, ChangeBy = @UID, ChangeDate = GETDATE(), ChangeNo = ChangeNo + 1 " +
                               "WHERE (EmployeeNo = @EmployeeNo) AND (ID = @ID)";
                cmd.Parameters.AddWithValue("@EmployeeNo", selected_nik);
                cmd.Parameters.AddWithValue("@ID", ((GridDataItem)e.Item).GetDataKeyValue("ID"));
                cmd.Parameters.AddWithValue("@FamilyType", (item.FindControl("cb_jenis_keluarga_edit_temp") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@FamilyName", (item.FindControl("txt_nama_keluarga_edit_temp") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@FamilyBirthDate", (item.FindControl("dtp_tgl_lahir_edit_temp") as RadDatePicker).SelectedDate.Value);
                cmd.Parameters.AddWithValue("@Remark", (item.FindControl("txt_keterangan_edit_temp") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@Gender", (item.FindControl("cb_jns_kelamin_edit_temp") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        #endregion
        #region Pendidikan
        public DataTable GetDataEmpEducationTable(string nik)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM vEmployeeEducation WHERE EmployeeNo = @nik";
            cmd.Parameters.AddWithValue("@nik", nik);
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
        protected void rg_pendidikan_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataEmpEducationTable(selected_nik);               
            }
        }

        protected void rg_pendidikan_DeleteCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void rg_pendidikan_ItemCommand(object sender, GridCommandEventArgs e)
        {

        }

        private static DataTable GetPendidikan(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT EducationCode, EducationDescription FROM MsEducation WHERE (RecordStatus = 'A') " +
                "AND EducationDescription LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_jenjang_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetPendidikan(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["EducationDescription"].ToString(), data.Rows[i]["EducationDescription"].ToString()));
            }
        }

        protected void cb_jenjang_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT EducationCode FROM MsEducation WHERE EducationDescription = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["EducationCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_jenjang_temp_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT EducationCode FROM MsEducation WHERE EducationDescription = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["EducationCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        private static DataTable GetKota(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CityCode, CityName FROM MSCity WHERE (RecordStatus = 'A') AND CityName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_kota_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetKota(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["CityName"].ToString(), data.Rows[i]["CityName"].ToString()));
            }
        }

        protected void cb_kota_edit_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT CityCode FROM MSCity WHERE CityName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CityCode"].ToString();                
            }
            dr.Close();
            con.Close();
        }
        
        protected void cb_kota_insert_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT CityCode FROM MSCity WHERE CityName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CityCode"].ToString();
            }
            dr.Close();
            con.Close();
        }


        private static DataTable GetStsPend(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT EducationStatusCode, EducationStatusDescription FROM MsEducationStatus WHERE (RecordStatus = 'A') AND EducationStatusDescription LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_status_temp_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetStsPend(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["EducationStatusDescription"].ToString(), data.Rows[i]["EducationStatusDescription"].ToString()));
            }
        }

        protected void cb_status_edit_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT EducationStatusCode FROM MsEducationStatus WHERE EducationStatusDescription = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["EducationStatusCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_status_temp_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT EducationStatusCode FROM MsEducationStatus WHERE EducationStatusDescription = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["EducationStatusCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_status_insert_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT EducationStatusCode FROM MsEducationStatus WHERE EducationStatusDescription = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["EducationStatusCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void rg_pendidikan_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO TrEmpEducation(EmployeeNo, EducationCode, MajorCode, InstitutionName, InstitutionCity, " +
                               " EducationStatusCode, ChangeNo, CreateDate, CreateBy, ChangeDate, ChangeBy) " +
                               " VALUES (@EmployeeNo,@EducationCode,@MajorCode,@InstitutionName,@InstitutionCity, " +
                               " @EducationStatusCode, 0, GETDATE(),@UID, GETDATE(),@UID)";
            cmd.Parameters.AddWithValue("@EmployeeNo", selected_nik);
            cmd.Parameters.AddWithValue("@EducationCode", (item.FindControl("cb_jenjang_insert_temp") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@MajorCode", (item.FindControl("cb_jurusan_insert_temp") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@InstitutionName", (item.FindControl("txt_lembaga_insert_temp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@InstitutionCity", (item.FindControl("cb_kota_insert_temp") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@EducationStatusCode", (item.FindControl("cb_status_insert_temp") as RadComboBox).SelectedValue);
            cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void rg_pendidikan_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            if (e.Item is GridEditableItem)
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE TrEmpEducation SET EducationCode = @EducationCode, MajorCode = @MajorCode, InstitutionName = @InstitutionName, " +
                               "InstitutionCity = @InstitutionCity, EducationStatusCode = @EducationStatusCode, ChangeBy = @UID, ChangeDate = GETDATE(), ChangeNo = ChangeNo + 1 " +
                               "WHERE (EmployeeNo = @EmployeeNo) AND (ID = @ID)";
                cmd.Parameters.AddWithValue("@EmployeeNo", selected_nik);
                cmd.Parameters.AddWithValue("@EducationCode", (item.FindControl("cb_jenjang_edit_temp") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@MajorCode", (item.FindControl("cb_jurusan_edit_temp") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@InstitutionName", (item.FindControl("txt_lembaga_edit_temp") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@InstitutionCity", (item.FindControl("cb_kota_edit_temp") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@EducationStatusCode", (item.FindControl("cb_status_edit_temp") as RadComboBox).SelectedValue);
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);
                cmd.Parameters.AddWithValue("@ID", ((GridDataItem)e.Item).GetDataKeyValue("ID"));
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        #endregion
        #region Training
        public DataTable GetDataEmpTrainingTable(string nik)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM TrEmpTraining WHERE EmployeeNo = @nik";
            cmd.Parameters.AddWithValue("@nik", nik);
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
        protected void rg_training_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataEmpTrainingTable(selected_nik);
            }
        }

        protected void rg_training_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO TrEmpTraining(EmployeeNo, TrainingNo, TrainingName, InstitutionName, " +
                               "TrainingDate, ChangeNo, CreateDate, CreateBy, ChangeDate, ChangeBy) " +
                               "VALUES (@EmployeeNo, @TrainingNo, @TrainingName, @InstitutionName, " +
                               "@TrainingDate, 0, GETDATE(), @UID, GETDATE(), @UID)";
            cmd.Parameters.AddWithValue("@EmployeeNo", selected_nik);
            cmd.Parameters.AddWithValue("@TrainingNo", (item.FindControl("txt_training_ke_insert_temp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@TrainingName", (item.FindControl("txt_nama_training_insert_temp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@InstitutionName", (item.FindControl("txt_lembaga_training_insert_temp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@TrainingDate", (item.FindControl("dtp_tanggal_training_insert_temp") as RadDatePicker).SelectedDate.Value);
            cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void rg_training_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            if (e.Item is GridEditableItem)
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE TrEmpTraining SET EmployeeNo = @EmployeeNo, TrainingNo = @TrainingNo, TrainingName = @TrainingName, " +
                               "InstitutionName = @InstitutionName, TrainingDate = @TrainingDate, ChangeNo = ChangeNo + 1, " +
                               "ChangeDate = GETDATE(), ChangeBy = @UID WHERE  (ID = @ID)";
                cmd.Parameters.AddWithValue("@EmployeeNo", selected_nik);
                cmd.Parameters.AddWithValue("@TrainingNo", (item.FindControl("txt_training_ke_edit_temp") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@TrainingName", (item.FindControl("txt_nama_training_edit_temp") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@InstitutionName", (item.FindControl("txt_lembaga_training_edit_temp") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@TrainingDate", (item.FindControl("dtp_tanggal_training_edit_temp") as RadDatePicker).SelectedDate.Value);
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);
                cmd.Parameters.AddWithValue("@ID", ((GridDataItem)e.Item).GetDataKeyValue("ID"));
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void rg_training_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "DELETE FROM TrEmpTraining WHERE  (ID = @ID)";
            cmd.Parameters.AddWithValue("@ID", ((GridDataItem)e.Item).GetDataKeyValue("ID"));
            cmd.ExecuteNonQuery();
            con.Close();
        }
        #endregion
        #region Lisensi
        public DataTable GetDataEmpLicenseTable(string nik)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM TrEmpLicense WHERE EmployeeNo = @nik";
            cmd.Parameters.AddWithValue("@nik", nik);
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
        protected void rg_lisensi_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            if (!IsPostBack)
            {
                (sender as RadGrid).DataSource = new string[] { };
            }
            else
            {
                (sender as RadGrid).DataSource = GetDataEmpLicenseTable(selected_nik);
            }
        }

        protected void rg_lisensi_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO TrEmpLicense(EmployeeNo, LicenseNo, LicenseName, InstitutionName, LicenseDate, LicenseCode, " +
                               "ChangeNo, CreateDate, CreateBy, ChangeDate, ChangeBy) " +
                               "VALUES (@EmployeeNo, @LicenseNo, @LicenseName, @InstitutionName, @LicenseDate, @LicenseCode," +
                               "0, GETDATE(), @UID, GETDATE(), @UID)";
            cmd.Parameters.AddWithValue("@EmployeeNo", selected_nik);
            cmd.Parameters.AddWithValue("@LicenseNo", (item.FindControl("txt_lisensi_ke_insert_temp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@LicenseName", (item.FindControl("txt_nama_lisensi_insert_temp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@InstitutionName", (item.FindControl("txt_lembaga_lisensi_insert_temp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@LicenseDate", (item.FindControl("dtp_tanggal_lisensi_insert_temp") as RadDatePicker).SelectedDate.Value);
            cmd.Parameters.AddWithValue("@LicenseCode", (item.FindControl("txt_no_lisensi_insert_temp") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void rg_lisensi_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            if (e.Item is GridEditableItem)
            {
                GridEditableItem item = (GridEditableItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE TrEmpLicense SET EmployeeNo = @EmployeeNo, LicenseNo = @LicenseNo, LicenseName = @LicenseName, " +
                               "InstitutionName = @InstitutionName, LicenseDate = @LicenseDate, LicenseCode = @LicenseCode, " +
                               "ChangeNo = ChangeNo + 1, ChangeDate = GETDATE(), ChangeBy = @UID WHERE  (ID = @ID)";
                cmd.Parameters.AddWithValue("@EmployeeNo", selected_nik);
                cmd.Parameters.AddWithValue("@LicenseNo", (item.FindControl("txt_lisensi_ke_edit_temp") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@LicenseName", (item.FindControl("txt_nama_lisensi_edit_temp") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@InstitutionName", (item.FindControl("txt_lembaga_lisensi_edit_temp") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@LicenseDate", (item.FindControl("dtp_tanggal_lisensi_edit_temp") as RadDatePicker).SelectedDate.Value);
                cmd.Parameters.AddWithValue("@LicenseCode", (item.FindControl("txt_no_lisensi_edit_temp") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);
                cmd.Parameters.AddWithValue("@ID", ((GridDataItem)e.Item).GetDataKeyValue("ID"));
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void rg_lisensi_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "DELETE FROM TrEmpLicense WHERE  (ID = @ID)";
            cmd.Parameters.AddWithValue("@ID", ((GridDataItem)e.Item).GetDataKeyValue("ID"));
            cmd.ExecuteNonQuery();
            con.Close();
        }
        #endregion

       
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


            //string CurrentFilePath = Path.GetFullPath(FileUpload1.PostedFile.FileName);
            //InsertExcelRecords(CurrentFilePath);

            string filePath = Path.Combine(Path.GetTempPath(), Guid.NewGuid().ToString("N") + ".xlsx");
            FileUpload1.SaveAs(filePath);
            
            try
            {
                InsertExcelRecords(filePath);
            }
            finally
            {
                File.Delete(filePath);
            }
        }

        OleDbConnection Econ;
        string constr, Query, sqlconn;
        private void ExcelConn(string FilePath)
        {
            constr = string.Format(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source={0};Extended Properties=""Excel 12.0 Xml;HDR=YES;""", FilePath);
            Econ = new OleDbConnection(constr);

        }
        private static DataTable GetBank(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT SourceBankCode, SourceBankName FROM MsBank " +
                "WHERE (RecordStatus = 'A') AND SourceBankName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_source_bank_name_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetBank(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["SourceBankName"].ToString(), data.Rows[i]["SourceBankName"].ToString()));
            }
        }

        protected void cb_source_bank_name_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT SourceBankCode FROM MsBank WHERE SourceBankName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["SourceBankCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_source_bank_name_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT SourceBankCode FROM MsBank WHERE SourceBankName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["SourceBankCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_costing_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_jenis_keluarga_edit_temp_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT FamilyTypeCode FROM MsFamilyType WHERE FamilyTypeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["FamilyTypeCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void CB_jns_hub_emergency_kontak_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT FamilyTypeCode FROM MsFamilyType WHERE FamilyTypeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["FamilyTypeCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void CB_jns_hub_emergency_kontak_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT FamilyTypeCode FROM MsFamilyType WHERE FamilyTypeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["FamilyTypeCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        private static DataTable GetMajor(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT MajorCode, MajorName FROM MsMajor " +
                "WHERE (RecordStatus = 'A') AND MajorName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_jurusan_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetMajor(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["MajorName"].ToString(), data.Rows[i]["MajorName"].ToString()));
            }
        }

        protected void cb_jurusan_edit_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT MajorCode FROM MsMajor WHERE MajorName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["MajorCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_jurusan_insert_temp_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT MajorCode FROM MsMajor WHERE MajorName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["MajorCode"].ToString();
            }
            dr.Close();
            con.Close();

        }

        protected void cb_jurusan_temp_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT MajorCode FROM MsMajor WHERE MajorName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["MajorCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        


        protected void cb_kota_temp_PreRender(object sender, EventArgs e)
        {

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT CityCode FROM MSCity WHERE CityName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["CityCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        private void connection()
        {
            sqlconn = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
            con = new SqlConnection(sqlconn);

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
                "[UNIT YANG DIBAWA],[POO],[POH],[NO KK],[NIK KK] FROM [{0}]", "Sheet1$");
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
            objbulk.ColumnMappings.Add("NIK KK", "NIK KK");
            //inserting Datatable Records to DataBase    
            con.Open();
            objbulk.WriteToServer(Exceldt);
            con.Close();
        }
    }
}