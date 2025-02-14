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

namespace PRIMA_HRIS
{
    public partial class Main : System.Web.UI.MasterPage
    {
        SqlConnection con = new SqlConnection(db_connection.koneksi);
        public static string modul = null;
        //public static string uid = null;
        public string uid { get; set; }
        public static string user_name { get; set; }
        user_class uc = new user_class();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                modul = Request.Cookies["authcookie"]["modul"];
                //uid = Request.Cookies["authcookie"]["uid"];
                uid = uc.user_id;

                //LoadNode(Service);
                //LoadNode(Inventory);
                //LoadNode(Purchase);
                //LoadNode(Fico);
                //LoadNode(DataStore);
                //LoadNode(Security);
                
                user_name = Request.Cookies["authcookie"]["username"];

                //NavNode1.Text = Request.Cookies["authcookie"]["username"];
                //NavNode2.Text = public_str.selected_menu;
                //lblServer.Text = "Server: "+ public_str.server_ip;
                //lblPeriode.Text = "Transaction Periode: " + public_str.perstart + " - " + public_str.perend;
                lblUserInfo.Text = " Your login time: " + public_str.login_time;

                DataTable dt = new DataTable();
                SqlConnection con = new SqlConnection(
                ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT DISTINCT(modul) modul FROM v_user_menu WHERE [user_id]='" + Request.Cookies["authcookie"]["uid"] + "'", con);
                adapter.Fill(dt);                
            }

        }
        private void LoadNode(RadSiteMap siteMap)
        {
            DataTable dt = new DataTable();
            SqlConnection con = new SqlConnection(
            ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString);
            SqlDataAdapter adapter = new SqlDataAdapter("SELECT [user_id], menu_description, modul FROM v_user_menu WHERE modul = '" + siteMap.ID + "' " +
                " AND [user_id]='" + Request.Cookies["authcookie"]["uid"] + "'", con);
            adapter.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    foreach (RadSiteMapNode node in siteMap.Nodes)
                    {
                        if (node.Text == row["menu_description"].ToString())
                        //{
                        //    node.Visible = false;
                        //}
                        //else
                        {
                            node.Visible = true;
                        }
                    }
                }
            }
        }
        protected void btn_logout_Click(object sender, EventArgs e)
        {
            Cache["sKey"] = string.Empty;
            Response.Redirect("~/Home/Login.aspx");
        }
    }
}