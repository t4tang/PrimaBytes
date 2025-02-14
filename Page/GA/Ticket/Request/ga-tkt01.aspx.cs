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

namespace PRIMA_HRIS.Page.GA.Ticket.Request
{
    public partial class ga_tkt01 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        private static string selected_route_code = null;
        private static string selected_passenger_type = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {                
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;

                RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate.Value), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate.Value));
                RadGrid1.DataBind();

                Session["action"] = "firstLoad";
                Session["TableDetail"] = null;
                Session["actionDetail"] = null;
                Session["actionHeader"] = null;
            }
        }
        protected void RadAjaxManager1_AjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            try
            {
                if (e.Argument == "Rebind")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.Rebind();
                    RadGrid1.MasterTableView.Items[0].Selected = true;

                }
                else if (e.Argument == "RebindAndNavigate")
                {
                    RadGrid1.MasterTableView.SortExpressions.Clear();
                    RadGrid1.MasterTableView.GroupByExpressions.Clear();
                    RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate));
                    RadGrid1.DataBind();
                    RadGrid1.MasterTableView.CurrentPageIndex = RadGrid1.MasterTableView.PageCount - 1;

                    RadGrid1.MasterTableView.Items[RadGrid1.Items.Count - 1].Selected = true;

                    Session["action"] = "list";
                }
            }
            catch (Exception ex)
            {
                RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "callBackFn", "~/Images/error.png");
            }
        }
        public DataTable GetDataTable(string date1, string date2)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "spGetTicketOrder";
            cmd.Parameters.AddWithValue("@date", date1);
            cmd.Parameters.AddWithValue("@todate", date2);
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
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate));
        }
        
        protected void RadGrid1_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            var trCode = ((GridDataItem)e.Item).GetDataKeyValue("trCode");
            
            bool used = false;
            used = cekTrStatus(trCode.ToString());
            if (used)
            {
                string msg = trCode + " tidak dapat diedit lagi karena telah digunakan di transaksi lain";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Allert", "allertFn('" + msg + "')", true);
                return;
            }
            else
            {
                try
                {
                    //var trCode = ((GridDataItem)e.Item).GetDataKeyValue("trCode");

                    con.Open();
                    cmd = new SqlCommand();
                    cmd.CommandType = CommandType.Text;
                    cmd.Connection = con;
                    cmd.CommandText = "UPDATE TrTicketOrder SET recordStatus = 'D', changeBy = @uid, changeDate = GETDATE() WHERE trCode = @trCode";
                    cmd.Parameters.AddWithValue("@trCode", trCode);
                    cmd.Parameters.AddWithValue("@uid", Request.Cookies["authcookie"]["uid"]);
                    cmd.ExecuteNonQuery();
                    con.Close();

                    notif.Text = "DELETED SUCCESSFULLY";
                    notif.Title = "Notification";
                    notif.Show("Deleted Successful");
                }
                catch (Exception ex)
                {
                    con.Close();
                    RadWindowManager2.RadAlert(ex.Message, 500, 200, "Error", "");
                    e.Canceled = true;
                }
            }
            
        }

        protected void RadGrid1_ItemCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                (sender as RadGrid).MasterTableView.IsItemInserted = false;
                (sender as RadGrid).MasterTableView.Rebind();

                Session["actionHeader"] = "headerEdit";
                //Session["actionDetail"] = null;
            }
        }

        protected void RadGrid1_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {

        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            Session["TableDetail"] = null;
            Session["actionHeader"] = "headerNew";
            RadGrid1.MasterTableView.ClearEditItems();
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate));
            RadGrid1.DataBind();
        }

        protected void cb_status_prm_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_status_prm_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
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

        private bool cekTrStatus(string tr_code)
        {
            bool is_used = false;
            using (SqlCommand cmd = new SqlCommand())
            {
                con.Open();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "SELECT * FROM TrTicketIssued WHERE reffNo = '" + tr_code + "' AND recordStatus = 'A' ";
                SqlDataReader dr;
                dr = null;
                try
                {
                    dr = cmd.ExecuteReader();
                    while (dr.Read())
                    {
                        is_used = true;
                    }
                }
                catch (Exception ex)
                {
                    throw new ApplicationException("Error :", ex);
                }
                finally
                {
                    con.Close();
                }
                return is_used;

            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadComboBox cb_nik = (RadComboBox)item.FindControl("cb_nik");
            RadLabel lbl_tr_code = (RadLabel)item.FindControl("lbl_tr_code");
            RadTextBox txt_EmployeeName = (RadTextBox)item.FindControl("txt_EmployeeName");
            RadTextBox txt_lokasi = (RadTextBox)item.FindControl("txt_lokasi");
            RadTextBox txt_telp = (RadTextBox)item.FindControl("txt_telp");
            RadComboBox cb_route = (RadComboBox)item.FindControl("cb_route");
            RadDatePicker rdp_birthDate = (RadDatePicker)item.FindControl("rdp_birthDate");
            RadDatePicker dtp_trDate = (RadDatePicker)item.FindControl("dtp_trDate");
            RadDatePicker dtp_tgl_berangkat = (RadDatePicker)item.FindControl("dtp_tgl_berangkat");            
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");

            Button btnCancel = (Button)item.FindControl("btnCancel");

            long maxNo;
            string run = null;
            string trDate = string.Format("{0:dd/MM/yyyy}", dtp_trDate.SelectedDate);

            if (Session["actionHeader"].ToString() == "headerEdit")
            {
                run = lbl_tr_code.Text;

                bool used = false;
                used = cekTrStatus(run);
                if (used)
                {
                    string msg = run + " tidak dapat diedit lagi karena telah digunakan di transaksi lain";
                    ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Allert", "allertFn('" + msg + "')", true);
                    return;
                }
            }
            else
            {
                con.Open();
                SqlDataReader sdr;
                cmd = new SqlCommand("SELECT ISNULL ( MAX ( RIGHT ( TrTicketOrder.trCode , 4 ) ) , 0 ) + 1 AS maxNo " +
                    "FROM TrTicketOrder WHERE LEFT(TrTicketOrder.trCode, 4) ='TK01' " +
                    "AND SUBSTRING(TrTicketOrder.trCode, 5, 2) = SUBSTRING('" + trDate + "', 9, 2) " +
                    "AND SUBSTRING(TrTicketOrder.trCode, 7, 2) = SUBSTRING('" + trDate + "', 4, 2) ", con);
                sdr = cmd.ExecuteReader();
                if (sdr.HasRows == false)
                {
                    //throw new Exception();
                    run = "TK01" + dtp_trDate.SelectedDate.Value.Year + dtp_trDate.SelectedDate.Value.Month + "0001";
                }
                else if (sdr.Read())
                {
                    maxNo = Convert.ToInt32(sdr[0].ToString());
                    run = "TK01" +
                        (dtp_trDate.SelectedDate.Value.Year.ToString()).Substring(dtp_trDate.SelectedDate.Value.Year.ToString().Length - 2) +
                        ("0000" + dtp_trDate.SelectedDate.Value.Month).Substring(("0000" + dtp_trDate.SelectedDate.Value.Month).Length - 2, 2) +
                        ("0000" + maxNo).Substring(("0000" + maxNo).Length - 4, 4);
                }
                con.Close();

                lbl_tr_code.Text = run;
            }
            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "spSaveTicketOrder";
                cmd.Parameters.AddWithValue("@trCode", run);
                cmd.Parameters.AddWithValue("@trDate", string.Format("{0:yyyy-MM-dd}", dtp_trDate.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@employeeNo", cb_nik.Text);
                cmd.Parameters.AddWithValue("@route", selected_route_code);
                cmd.Parameters.AddWithValue("@departureDate", string.Format("{0:yyyy-MM-dd}", dtp_tgl_berangkat.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@remark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@UID", Request.Cookies["authcookie"]["uid"]);
                cmd.Parameters.AddWithValue("@passangerType", selected_passenger_type);
                cmd.Parameters.AddWithValue("@employeeName", txt_EmployeeName.Text);
                cmd.Parameters.AddWithValue("@location", txt_lokasi.Text);
                cmd.Parameters.AddWithValue("@phone", txt_telp.Text);
                cmd.Parameters.AddWithValue("@birthDate", string.Format("{0:yyyy-MM-dd}", rdp_birthDate.SelectedDate.Value));

                cmd.ExecuteNonQuery();
                                
                ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                (sender as Button).Text = "Update";
                btnCancel.Text = "Close";
                lbl_tr_code.Text = run;

                string Message = run + " Data Saved";
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Allert", "allertFn('" + Message + "')", true);
            }
            catch (Exception ex)
            {
                con.Close();
                string Message = "Error: " + ex;
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "Allert", "allertFn('" + Message + "')", true);
            }
            finally
            {
                con.Close();
                RadGrid1.MasterTableView.IsItemInserted = false;
                //RadGrid1.Rebind();
            }

        }

        #region Route
        private static DataTable GetRoute(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT CityCode, CityName FROM MSCity WHERE (RecordStatus = 'A') AND CityName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_route_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetRoute(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["CityName"].ToString(), data.Rows[i]["CityName"].ToString()));
            }
        }


        protected void cb_route_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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
                selected_route_code= dr["CityCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_route_PreRender(object sender, EventArgs e)
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
                selected_route_code = dr["CityCode"].ToString();
            }
            dr.Close();
        }
        #endregion

        #region Employee
        private static DataTable GetEmployee(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT EmployeeNo FROM v_employee WHERE EmployeeNo LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_nik_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetEmployee(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["EmployeeNo"].ToString(), data.Rows[i]["EmployeeNo"].ToString()));
            }
        }

        protected void cb_nik_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT EmployeeNo, EmployeeName, BirthDate, LocationName, PositionName, Hp1, Hp2 FROM v_employee WHERE EmployeeNo = '" + (sender as RadComboBox).Text + "'";
            //SqlDataReader dr;
            //dr = cmd.ExecuteReader();
            //while (dr.Read())
            //{
            //    (sender as RadComboBox).SelectedValue = dr["EmployeeNo"].ToString();
            //}
            //dr.Close();

            SqlDataAdapter adapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            foreach(DataRow dtr in dt.Rows)
            {
                RadComboBox cb = (RadComboBox)sender;
                GridEditableItem item = (GridEditableItem)cb.NamingContainer;
                //if (Session["actionDetail"].ToString() == "detailNew")
                //{
                //RadLabel employeeName = (RadLabel)item.FindControl("lbl_EmployeeName");
                //RadLabel posisi = (RadLabel)item.FindControl("lbl_posisi");
                //RadLabel lokasi = (RadLabel)item.FindControl("lbl_lokasi");
                //RadLabel telp = (RadLabel)item.FindControl("lbl_telp");
                RadTextBox employeeName = (RadTextBox)item.FindControl("txt_EmployeeName");
                RadTextBox posisi = (RadTextBox)item.FindControl("txt_posisi");
                RadTextBox lokasi = (RadTextBox)item.FindControl("txt_lokasi");
                RadTextBox telp = (RadTextBox)item.FindControl("txt_telp");
                RadDatePicker birthDate = (RadDatePicker)item.FindControl("rdp_birthDate");

                employeeName.Text = dtr["EmployeeName"].ToString();
                posisi.Text = dtr["PositionName"].ToString();
                lokasi.Text = dtr["LocationName"].ToString();
                telp.Text = dtr["Hp1"].ToString();
                birthDate.SelectedDate = Convert.ToDateTime(dtr["BirthDate"].ToString());
                //    }
            }
            con.Close();
        }

        protected void cb_nik_PreRender(object sender, EventArgs e)
        {
            //con.Open();
            //cmd = new SqlCommand();
            //cmd.CommandType = CommandType.Text;
            //cmd.Connection = con;
            //cmd.CommandText = "select region_code from ms_jobsite WHERE region_name = '" + (sender as RadComboBox).Text + "'";
            //SqlDataReader dr;
            //dr = cmd.ExecuteReader();
            //while (dr.Read())
            //    (sender as RadComboBox).SelectedValue = dr["region_code"].ToString();
            //dr.Close();
            //con.Close();
        }
        #endregion

        protected void cb_jns_user_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Karyawan");
            (sender as RadComboBox).Items.Add("Non Karyawan");
        }

        protected void cb_jns_user_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadComboBox nik = (RadComboBox)item.FindControl("cb_nik");
            RadTextBox employeeName = (RadTextBox)item.FindControl("txt_EmployeeName");
            RadTextBox posisi = (RadTextBox)item.FindControl("txt_posisi");
            RadTextBox lokasi = (RadTextBox)item.FindControl("txt_lokasi");
            RadTextBox telp = (RadTextBox)item.FindControl("txt_telp");
            RadDatePicker birthDate = (RadDatePicker)item.FindControl("rdp_birthDate");

            if ((sender as RadComboBox).Text == "Non Karyawan")
            {
                (sender as RadComboBox).SelectedValue = "0";
                selected_passenger_type = "0";

                nik.Text = string.Empty;
                employeeName.Text = string.Empty;
                posisi.Text = string.Empty;
                lokasi.Text = string.Empty;
                telp.Text = string.Empty;                

                nik.Enabled = false;
                employeeName.ReadOnly = false;
                posisi.ReadOnly = true;
                lokasi.ReadOnly = false;
                telp.ReadOnly = false;
                birthDate.Calendar.Enabled = true;
                birthDate.DateInput.Enabled = true;
            }
            else if ((sender as RadComboBox).Text == "Karyawan")
            {
                (sender as RadComboBox).SelectedValue = "1";
                selected_passenger_type = "1";

                nik.Enabled = true;
                employeeName.ReadOnly = true;
                posisi.ReadOnly = true;
                lokasi.ReadOnly = true;
                telp.ReadOnly = true;
                birthDate.Calendar.Enabled = false;
                birthDate.DateInput.Enabled = false;
            }
        }

        protected void cb_jns_user_PreRender(object sender, EventArgs e)
        {
            RadComboBox cb = (RadComboBox)sender;
            GridEditableItem item = (GridEditableItem)cb.NamingContainer;

            RadComboBox nik = (RadComboBox)item.FindControl("cb_nik");
            RadTextBox employeeName = (RadTextBox)item.FindControl("txt_EmployeeName");
            RadTextBox posisi = (RadTextBox)item.FindControl("txt_posisi");
            RadTextBox lokasi = (RadTextBox)item.FindControl("txt_lokasi");
            RadTextBox telp = (RadTextBox)item.FindControl("txt_telp");
            RadDatePicker birthDate = (RadDatePicker)item.FindControl("rdp_birthDate");

            if ((sender as RadComboBox).Text == "Non Karyawan")
            {
                (sender as RadComboBox).SelectedValue = "0";
                selected_passenger_type = "0";
                
                nik.Enabled = false;
                employeeName.ReadOnly = false;
                posisi.ReadOnly = true;
                lokasi.ReadOnly = false;
                telp.ReadOnly = false;
                birthDate.Calendar.Enabled = true;
                birthDate.DateInput.Enabled = true;
            }
            else if ((sender as RadComboBox).Text == "Karyawan")
            {
                (sender as RadComboBox).SelectedValue = "1";
                selected_passenger_type = "1";

                nik.Enabled = true;
                employeeName.ReadOnly = true;
                posisi.ReadOnly = true;
                lokasi.ReadOnly = true;
                telp.ReadOnly = true;
                birthDate.Calendar.Enabled = false;
                birthDate.DateInput.Enabled = false;
            }
        }
    }
}