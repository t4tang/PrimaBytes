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

namespace PRIMA_HRIS.Page.DS.Project
{
    public partial class ds_prj01 : System.Web.UI.Page
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        SqlConnection con = new SqlConnection(koneksi);
        SqlDataAdapter sda = new SqlDataAdapter();
        SqlCommand cmd = new SqlCommand();
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            (sender as RadGrid).DataSource = GetDataTable();
        }

        public DataTable GetDataTable()
        {
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "SELECT CompanyCode, LocationCode, LocationName, RecordStatus FROM MsLocation WHERE (RecordStatus <> 'D')";
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

        protected void RadGrid1_InsertCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem item = (GridEditableItem)e.Item;
            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "INSERT INTO MsLocation (CompanyCode, LocationCode, LocationName, RecordStatus, ChangeNo, CreateDate, CreateBy, ChangeDate, ChangeBy) " +
                "VALUES (@CompanyCode,@LocationCode,@LocationName, 'A', 0, GETDATE(),@CreateBy, GETDATE(),@ChangeBy)";
            cmd.Parameters.AddWithValue("@CompanyCode", Request.Cookies["authcookie"]["company_code"]);
            cmd.Parameters.AddWithValue("@LocationCode", (item.FindControl("txt_region_code") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@LocationName", (item.FindControl("txt_region_name") as RadTextBox).Text);
            cmd.Parameters.AddWithValue("@CreateBy", Request.Cookies["authcookie"]["uid"]);
            cmd.Parameters.AddWithValue("@ChangeBy", Request.Cookies["authcookie"]["uid"]);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            if (e.Item is GridEditFormItem)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                con.Open();
                cmd = new SqlCommand();
                cmd.CommandType = CommandType.Text;
                cmd.Connection = con;
                cmd.CommandText = "UPDATE MsLocation set LocationName = @LocationName, ChangeBy = @ChangeBy, ChangeDate = GETDATE() WHERE LocationCode = @LocationCode";
                cmd.Parameters.AddWithValue("@LocationName", (item.FindControl("txt_region_name") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@LocationCode", (item.FindControl("txt_region_code") as RadTextBox).Text);
                cmd.Parameters.AddWithValue("@ChangeBy", Request.Cookies["authcookie"]["uid"]);
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void RadGrid1_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            var LocationCode = ((GridDataItem)e.Item).GetDataKeyValue("LocationCode");

            con.Open();
            cmd = new SqlCommand();
            cmd.CommandType = CommandType.Text;
            cmd.Connection = con;
            cmd.CommandText = "UPDATE MsLocation SET RecordStatus = 'D', ChangeBy = @ChangeBy WHERE LocationCode = @LocationCode";
            cmd.Parameters.AddWithValue("@LocationCode", LocationCode);
            cmd.Parameters.AddWithValue("@ChangeBy", Request.Cookies["authcookie"]["uid"]);
            cmd.ExecuteNonQuery();
            con.Close();
        }

        protected void RadGrid1_ItemCreated(object sender, GridItemEventArgs e)
        {
            if (e.Item is GridEditableItem & e.Item.IsInEditMode)
            {
                GridEditFormItem item = (GridEditFormItem)e.Item;
                RadTextBox txt = (item.FindControl("txt_region_code") as RadTextBox);
                if (e.Item.OwnerTableView.IsItemInserted)
                    txt.Enabled = true;
                else
                    txt.Enabled = false;
            }
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            RadGrid1.MasterTableView.IsItemInserted = true;
            RadGrid1.MasterTableView.Rebind();
        }

        
    }
}