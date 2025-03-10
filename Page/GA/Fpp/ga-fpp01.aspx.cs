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


namespace PRIMA_HRIS.Page.GA.Fpp
{
    public partial class ga_fpp01 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();

        private const int ItemsPerRequest = 10;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                dtp_from.SelectedDate = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                dtp_to.SelectedDate = DateTime.Now;

                //Session["action"] = "firstLoad";
                //Session["TableDetail"] = null;
                //Session["actionDetail"] = null;
                //Session["actionHeader"] = null;
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            RadGrid1.DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate), Request.Cookies["authcookie"]["uid"]);
            RadGrid1.DataBind();
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

        #region Main Grid
        public DataTable GetDataTable(string date1, string date2,string UID)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = con;
            cmd.CommandText = "sprFppMonitoring";
            cmd.Parameters.AddWithValue("@date", date1);
            cmd.Parameters.AddWithValue("@todate", date2);
            cmd.Parameters.AddWithValue("@uid", UID);
            //cmd.Parameters.AddWithValue("@vendor", date2);
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
        protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable(string.Format("{0:dd/MM/yyyy}", dtp_from.SelectedDate), string.Format("{0:dd/MM/yyyy}", dtp_to.SelectedDate),Request.Cookies["authcookie"]["uid"]);
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void RadGrid1_ItemCommand(object sender, GridCommandEventArgs e)
        {

        }
        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridDataItem)
            {
                ImageButton printLink = (ImageButton)e.Item.FindControl("PrintLink");
                printLink.Attributes["href"] = "javascript:void(0);";
                printLink.Attributes["onclick"] = String.Format("return ShowPreview('{0}','{1}');", e.Item.OwnerTableView.DataKeyValues[e.Item.ItemIndex]["doc_no"], e.Item.ItemIndex);

            }
        }
        protected void RadGrid1_ItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
            {
                var item = e.Item as GridEditFormItem;

                RadComboBox cb_statusDoc = item.FindControl("cb_statusDoc") as RadComboBox;

                if (e.Item.OwnerTableView.IsItemInserted)
                {
                    cb_statusDoc.Text = "Open";
                    cb_statusDoc.Enabled = false;
                }

            }
        }

        #endregion

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

        #region Department
        private static string selected_department = null;
        private static DataTable GetDepartment(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT DepartmentCode, DepartmentName FROM MsDepartment " +
                "WHERE (RecordStatus = 'A') AND DepartmentName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            //adapter.SelectCommand.Parameters.AddWithValue("@DivisionCode", selected_divisi);
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

        #region pay method
        protected void cb_pay_method_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Transfer");
            (sender as RadComboBox).Items.Add("Cash");
            (sender as RadComboBox).Items.Add("Other");
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
        protected void cb_bank_name_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
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

        protected void cb_bank_name_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
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

        protected void cb_bank_name_PreRender(object sender, EventArgs e)
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

        #endregion

        #region Approval
        private static DataTable GetEmployee(string text)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT EmployeeName FROM v_employee WHERE EmployeeName LIKE @text + '%'",
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            adapter.SelectCommand.Parameters.AddWithValue("@text", text);

            DataTable data = new DataTable();
            adapter.Fill(data);

            return data;
        }
        protected void cb_employee_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            DataTable data = GetEmployee(e.Text);

            int itemOffset = e.NumberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Rows.Count);
            e.EndOfItems = endOffset == data.Rows.Count;

            for (int i = itemOffset; i < endOffset; i++)
            {
                (sender as RadComboBox).Items.Add(new RadComboBoxItem(data.Rows[i]["EmployeeName"].ToString(), data.Rows[i]["EmployeeName"].ToString()));
            }
        }
        protected void cb_requestBy1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT InitialCode FROM vEmployeeInitial WHERE EmployeeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["InitialCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_requestBy1_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT InitialCode FROM vEmployeeInitial WHERE EmployeeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["InitialCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        protected void cb_requestBy2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT InitialCode FROM vEmployeeInitial WHERE EmployeeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["InitialCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_requestBy2_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT InitialCode FROM vEmployeeInitial WHERE EmployeeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["InitialCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_approveBy1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT InitialCode FROM vEmployeeInitial WHERE EmployeeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["InitialCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_approveBy1_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT InitialCode FROM vEmployeeInitial WHERE EmployeeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["InitialCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_approveBy2_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT InitialCode FROM vEmployeeInitial WHERE EmployeeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["InitialCode"].ToString();
            }
            dr.Close();
            con.Close();
        }

        protected void cb_approveBy2_PreRender(object sender, EventArgs e)
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT InitialCode FROM vEmployeeInitial WHERE EmployeeName = '" + (sender as RadComboBox).Text + "'";
            SqlDataReader dr;
            dr = cmd.ExecuteReader();
            while (dr.Read())
            {
                (sender as RadComboBox).SelectedValue = dr["InitialCode"].ToString();
            }
            dr.Close();
            con.Close();
        }
        #endregion
        #region Status Dokumen
        protected void cb_statusDoc_ItemsRequested(object sender, RadComboBoxItemsRequestedEventArgs e)
        {
            (sender as RadComboBox).Items.Add("Open");
            (sender as RadComboBox).Items.Add("Approved");
        }


        protected void cb_statusDoc_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            if ((sender as RadComboBox).Text == "Open")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Approved")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
        }

        protected void cb_statusDoc_PreRender(object sender, EventArgs e)
        {
            if ((sender as RadComboBox).Text == "Open")
            {
                (sender as RadComboBox).SelectedValue = "0";
            }
            else if ((sender as RadComboBox).Text == "Approved")
            {
                (sender as RadComboBox).SelectedValue = "1";
            }
        }
        #endregion


        protected void btnSave_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            GridEditableItem item = (GridEditableItem)btn.NamingContainer;

            RadTextBox txt_docNo = (RadTextBox)item.FindControl("txt_docNo");
            RadDatePicker dtp_docDate = (RadDatePicker)item.FindControl("dtp_docDate");
            RadDatePicker dtp_dueDate = (RadDatePicker)item.FindControl("dtp_dueDate");
            RadTextBox txt_description = (RadTextBox)item.FindControl("txt_description");
            RadNumericTextBox txt_amount = (RadNumericTextBox)item.FindControl("txt_amount");
            RadComboBox cb_project = (RadComboBox)item.FindControl("cb_project");
            RadComboBox cb_department = (RadComboBox)item.FindControl("cb_department");
            RadTextBox txt_partner = (RadTextBox)item.FindControl("txt_partner");
            RadComboBox cb_pay_method = (RadComboBox)item.FindControl("cb_pay_method");
            RadComboBox cb_bank = (RadComboBox)item.FindControl("cb_bank");
            RadTextBox txt_norek = (RadTextBox)item.FindControl("txt_norek");
            RadTextBox txt_nama_rekening = (RadTextBox)item.FindControl("txt_nama_rekening");
            RadTextBox txt_remark = (RadTextBox)item.FindControl("txt_remark");
            RadComboBox cb_requestBy1 = (RadComboBox)item.FindControl("cb_requestBy1");
            RadComboBox cb_requestBy2 = (RadComboBox)item.FindControl("cb_requestBy2");
            RadComboBox cb_approveBy1 = (RadComboBox)item.FindControl("cb_approveBy1");
            RadComboBox cb_approveBy2 = (RadComboBox)item.FindControl("cb_approveBy2");
            RadComboBox cb_statusDoc = (RadComboBox)item.FindControl("cb_statusDoc");
            
            Button btnCancel = (Button)item.FindControl("btnCancel");            

            try
            {
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Connection = con;
                cmd.CommandText = "sp_save_payment_request";
                cmd.Parameters.AddWithValue("@doc_no", txt_docNo.Text);
                cmd.Parameters.AddWithValue("@objek", txt_description.Text);
                cmd.Parameters.AddWithValue("@site_code", cb_project.SelectedValue);
                cmd.Parameters.AddWithValue("@dept_code", cb_department.SelectedValue);
                cmd.Parameters.AddWithValue("@pay_to", txt_partner.Text);
                cmd.Parameters.AddWithValue("@doc_reff", DBNull.Value);
                cmd.Parameters.AddWithValue("@description", txt_description.Text);
                cmd.Parameters.AddWithValue("@amount", txt_amount.Value);
                cmd.Parameters.AddWithValue("@doc_date", string.Format("{0:yyyy-MM-dd}", dtp_docDate.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@exp_date", string.Format("{0:yyyy-MM-dd}", dtp_dueDate.SelectedDate.Value));
                cmd.Parameters.AddWithValue("@doc_owner", Request.Cookies["authcookie"]["uid"]);
                cmd.Parameters.AddWithValue("@doc_status", cb_statusDoc.SelectedValue);
                cmd.Parameters.AddWithValue("@created_by1", cb_requestBy1.SelectedValue);
                cmd.Parameters.AddWithValue("@created_by2", cb_requestBy2.SelectedValue);
                cmd.Parameters.AddWithValue("@approved_by1", cb_approveBy1.SelectedValue);
                cmd.Parameters.AddWithValue("@approved_by2", cb_approveBy2.SelectedValue);
                cmd.Parameters.AddWithValue("@pay_metod", cb_pay_method.Text);
                cmd.Parameters.AddWithValue("@bankCode", cb_bank.SelectedValue);
                cmd.Parameters.AddWithValue("@BankAccName", txt_nama_rekening.Text);
                cmd.Parameters.AddWithValue("@BankAccNo", txt_norek.Text);
                cmd.Parameters.AddWithValue("@payRemark", txt_remark.Text);
                cmd.Parameters.AddWithValue("@editBy", Request.Cookies["authcookie"]["uid"]);
                cmd.Parameters.AddWithValue("@doc_ctrl", DBNull.Value);
                cmd.Parameters.AddWithValue("@sts_note", DBNull.Value);
                cmd.Parameters.AddWithValue("@approval_date", DBNull.Value);
                cmd.ExecuteNonQuery();

                ClientScript.RegisterStartupScript(Page.GetType(), "mykey", "CloseAndRebind('navigateToInserted');", true);
                (sender as Button).Text = "Update";
                btnCancel.Text = "Close";
                
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
                //notif.Show("Data Saved");
                RadGrid1.Rebind();
            }

        }

    }
}