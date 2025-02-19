using PRIMA_HRIS.Class;
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

namespace PRIMA_HRIS.Page.PA.Employee
{
    public partial class pa_emp03 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        private const int ItemsPerRequest = 10;
        private static string selected_nik = null;
        protected void Page_Load(object sender, EventArgs e)
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

        protected void cb_status_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_status_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }
        protected void btn_add_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.ClearEditItems();
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_tr_code = (RadTextBox)item.FindControl("txt_tr_code");
            RadDatePicker dtp_tgl_transaksi = (RadDatePicker)item.FindControl("dtp_tgl_transaksi");
            RadComboBox cb_nik = (RadComboBox)item.FindControl("cb_nik");
            RadTextBox txt_EmployeeName = (RadTextBox)item.FindControl("txt_EmployeeName");
            RadDatePicker dtp_tgl_perubahan = (RadDatePicker)item.FindControl("dtp_tgl_perubahan");
            RadComboBox cb_posisi = (RadComboBox)item.FindControl("cb_posisi");
            RadComboBox cb_golongan = (RadComboBox)item.FindControl("cb_golongan");
            RadComboBox cb_sub_golongan = (RadComboBox)item.FindControl("cb_sub_golongan");
            RadComboBox cb_lokasi = (RadComboBox)item.FindControl("cb_lokasi");
            RadComboBox cb_status_karyawan = (RadComboBox)item.FindControl("cb_status_karyawan");
            Button btnCancel = (Button)item.FindControl("btnCancel"); 
            Button btnSave = (Button)item.FindControl("btnSave");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_tgl_transaksi.SelectedDate);

            try
            {
                if (cb_nik.Text == string.Empty || txt_EmployeeName.Text == string.Empty || cb_posisi.Text == string.Empty || cb_golongan.Text == string.Empty || cb_sub_golongan.Text == string.Empty || cb_lokasi.Text == string.Empty)
                {
                    string msg = "Mohon lengkapi inputan anda";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Allert", "allertFn('" + msg + "')", true);
                    return;
                }
                else if(btnSave.Text == "Update")
                {
                    run = txt_tr_code.Text;
                }
                else if(btnSave.Text == "Save")
                {
                    con.Open();
                    SqlDataReader sdr;
                    cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( TrEmpAction.trCode , 4 ) ) , 0 ) + 1 AS maxNo " +
                        "FROM TrEmpAction WHERE LEFT(TrEmpAction.trCode, 4) = 'EA01' " +
                        "AND SUBSTRING(TrEmpAction.trCode, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                        "AND SUBSTRING(TrEmpAction.trCode, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                    sdr = cmd.ExecuteReader();
                    if (sdr.HasRows == false)
                    {
                        //throw new Exception();
                        run = "EA01" + dtp_tgl_transaksi.SelectedDate.Value.Year + dtp_tgl_transaksi.SelectedDate.Value.Month + "0001";
                    }
                    else if (sdr.Read())
                    {
                        maxNo = Convert.ToInt32(sdr[0].ToString());
                        run = "EA01" + (dtp_tgl_transaksi.SelectedDate.Value.Year.ToString()).Substring(dtp_tgl_transaksi.SelectedDate.Value.Year.ToString().Length - 2) +
                            ("0000" + dtp_tgl_transaksi.SelectedDate.Value.Month).Substring(("0000" + dtp_tgl_transaksi.SelectedDate.Value.Month).Length - 2, 2) +
                            ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                    }
                    con.Close();
                }

                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "spSaveEmployeeAction";
                cmd.Parameters.AddWithValue("@trCode", run);
                cmd.Parameters.AddWithValue("@trDate", string.Format("{0:yyyy-MM-dd}", dtp_tgl_transaksi.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@employeeNo", cb_nik.Text);
                cmd.Parameters.AddWithValue("@EADate", string.Format("{0:yyyy-MM-dd}", dtp_tgl_perubahan.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@positionCode", cb_posisi.SelectedValue);
                cmd.Parameters.AddWithValue("@GradeCode", cb_golongan.Text);
                cmd.Parameters.AddWithValue("@SubGradeCode", cb_sub_golongan.Text);
                cmd.Parameters.AddWithValue("@Location", cb_lokasi.SelectedValue);
                cmd.Parameters.AddWithValue("@EmploymentStatus", cb_status_karyawan.SelectedValue);
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uName"]);
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                con.Close();
                string Message = "Error: " + ex;
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Allert", "allertFn('" + Message + "')", true);
                return;
            }
            finally
            {
                con.Close();

                RadGrid1.MasterTableView.IsItemInserted = false;
                RadGrid1.Rebind();
                
            }
        }
        #region Main Grid

        public DataTable GetDataTable(string uid)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT * FROM v_employee_action WHERE RecordStatus = 'A' " +
                                "AND Location IN (SELECT region_code FROM MsUsersJobsite WHERE MsUsersJobsite.kduser = @kdUser)";
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
            var Kode = ((GridDataItem)e.Item).GetDataKeyValue("trCode");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE TrEmpAction SET RecordStatus = 'D', ChangeBy = @ChangeBy, ChangeDate = GETDATE() WHERE trCode = @trCode";
            cmd.Parameters.AddWithValue("@trCode", Kode);
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
        #endregion
        #region NIK
        private static DataTable GetNIK(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT EmployeeNo, FirstName FROM TrEmployee " +
                "WHERE (RecordStatus = 'A') AND EmployeeNo LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_nik_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetNIK(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["EmployeeNo"].ToString(), data.Rows[i]["EmployeeNo"].ToString()));
            }
        }

        protected void cb_nik_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadTextBox txt_EmployeeName = (RadTextBox)item.FindControl("txt_EmployeeName");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT FirstName As EmployeeName FROM TrEmployee WHERE EmployeeNo = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                txt_EmployeeName.Text= dr["EmployeeName"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region Posisi
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
        protected void cb_posisi_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_posisi_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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
        protected void cb_golongan_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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
        #endregion
        #region Sub golongan
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
        protected void cb_sub_golongan_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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
        #endregion
        #region Sub lokasi
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
        protected void cb_lokasi_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_lokasi_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
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

        #region Status karyawan
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
        protected void cb_status_karyawan_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_status_karyawan_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_status_karyawan_PreRender(object sender, EventArgs e)
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
    }
}