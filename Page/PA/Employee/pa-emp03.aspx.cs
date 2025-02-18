using PRIMA_HRIS.Class;
using System;
using System.Collections.Generic;
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

        protected void btn_add_Click(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

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
            var NIK = ((GridDataItem)e.Item).GetDataKeyValue("EmployeeNo");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE TrEmpAction SET RecordStatus = 'D', ChangeBy = @ChangeBy, ChangeDate = GETDATE() WHERE EmployeeNo = @NIK";
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
        #endregion
        #region NIK
        protected void cb_nik_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_nik_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }
        #endregion
        #region Posisi
        protected void cb_posisi_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_posisi_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_posisi_PreRender(object sender, EventArgs e)
        {

        }
        #endregion
        #region golongan
        protected void cb_golongan_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }
        #endregion
        #region Sub golongan
        protected void cb_sub_golongan_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }
        #endregion
        #region Sub lokasi
        protected void cb_lokasi_ItemsRequested(object sender, Telerik.Web.UI.RadComboBoxItemsRequestedEventArgs e)
        {

        }

        protected void cb_lokasi_SelectedIndexChanged(object sender, Telerik.Web.UI.RadComboBoxSelectedIndexChangedEventArgs e)
        {

        }

        protected void cb_lokasi_PreRender(object sender, EventArgs e)
        {

        }
        #endregion

        protected void btnSearch_Click(object sender, EventArgs e)
        {

        }
    }
}