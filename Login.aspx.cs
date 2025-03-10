using PRIMA_HRIS.Class;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PRIMA_HRIS
{
    public partial class Login : System.Web.UI.Page
    {
        user_class uc = new user_class();
        bool login_ok = false;
        SqlDataReader dr;
        public SqlConnection con = new SqlConnection(db_connection.koneksi);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.Cache.SetExpires(DateTime.Now);
                Response.Cache.SetNoServerCaching();
                Response.Cache.SetNoStore();

                //txtuid.Text = "";
                //txtpwd.Text = "";

            }
        }
        void login()
        {
            string mytxt_uid = Request.Form["txt_uid"];
            string mytxt_pass = Request.Form["txt_pass"];

            uc.user_id = txt_uid.Value;
            uc.password = txt_pass.Value;
            login_ok = uc.valid_reg_log_user();
            if (login_ok)
            {
                //Request.Cookies["authcookie"]["uid"] = uc.user_id;

                System.Data.SqlClient.SqlConnectionStringBuilder builder = new System.Data.SqlClient.SqlConnectionStringBuilder(db_connection.koneksi);
                public_str.server_ip = builder.DataSource;
                public_str.database_name = builder.InitialCatalog;
                public_str.database_uid = builder.UserID;
                public_str.database_pwd = builder.Password;
                public_str.login_time = DateTime.Now;

                con.Open();
                //SqlCommand cmd = new SqlCommand("SELECT USER_NAME, REGION_CODE, [LEVEL], sec_group FROM SEC_USER WHERE user_id='" + txt_uid.Text + "'", con);
                SqlCommand cmd = new SqlCommand("SELECT * FROM v_user_login_properties WHERE uName='" + txt_uid.Value + "' ", con);

                dr = cmd.ExecuteReader();
                //if (dr.HasRows == false)
                //{
                //    throw new Exception();
                //}
                if (dr.Read())
                {
                    Response.Cookies["authcookie"]["company_code"] = dr["company_code"].ToString();
                    Response.Cookies["authcookie"]["company_name"] = dr["company"].ToString();
                    Response.Cookies["authcookie"]["uid"] = dr["user_id"].ToString();
                    Response.Cookies["authcookie"]["username"] = dr["Name"].ToString();
                    Response.Cookies["authcookie"]["uName"] = txt_uid.Value;
                    Response.Cookies["authcookie"]["pass"] = txt_pass.Value;
                    Response.Cookies["authcookie"].Expires = DateTime.Now.AddHours(5);
                    Response.Cookies["authcookie"]["site"] = dr["LocationCode"].ToString();
                    Response.Cookies["authcookie"]["sitename"] = dr["LocationName"].ToString();
                    Response.Cookies["authcookie"]["level"] = dr["level"].ToString();
                    Response.Cookies["authcookie"]["sec_group"] = dr["sec_group"].ToString();
                    //Response.Cookies["authcookie"]["perstart"] = dr["perstart"].ToString();
                    //Response.Cookies["authcookie"]["perend"] = dr["perend"].ToString();
                    //Response.Cookies["authcookie"]["company_name"] = dr["company"].ToString();
                    //Response.Cookies["authcookie"]["company_code"] = dr["company_code"].ToString();
                    //Response.Cookies["authcookie"]["modul"] = dr["def_modul"].ToString();
                    //Response.Cookies["authcookie"]["default_cashcode"] = dr["kokas"].ToString();
                    //Response.Cookies["authcookie"]["default_cashname"] = dr["NamKas"].ToString();
                    //Response.Cookies["authcookie"]["default_bankcode"] = dr["KoBank"].ToString();
                    //Response.Cookies["authcookie"]["default_bankname"] = dr["NamBank"].ToString();

                    //public_str.Accstart = dr["Accstart"].ToString();
                    //public_str.Accperend = dr["Accperend"].ToString();
                    //public_str.Finstart = dr["Finstart"].ToString();
                    //public_str.Finperend = dr["Finperend"].ToString();
                    //public_str.Fuelstart = dr["Fuelstart"].ToString();
                    //public_str.Fuelend = dr["Fuelend"].ToString();
                    //public_str.perstart = dr["perstart"].ToString();
                    //public_str.perend = dr["perend"].ToString();
                    //public_str.company_name = dr["company"].ToString();
                    //public_str.company_code = dr["company_code"].ToString();

                    //Request.Cookies["authcookie"]["uid"] = dr["user_id"].ToString();
                    //Request.Cookies["authcookie"]["uid"] = dr["user_id"].ToString();
                    //public_str.user_name = dr["Name"].ToString();
                    //Request.Cookies["authcookie"]["site"] = dr["region_code"].ToString();
                    //Request.Cookies["authcookie"]["sitename"] = dr["region_name"].ToString();
                    //public_str.level = dr["level"].ToString();
                    //public_str.sec_group = dr["sec_group"].ToString();
                    //public_str.perstart = dr["perstart"].ToString();
                    //public_str.perend = dr["perend"].ToString();
                    //public_str.company_name = dr["company"].ToString();
                    //public_str.company_code = dr["company_code"].ToString();
                    //Request.Cookies["authcookie"]["modul"] = dr["def_modul"].ToString();
                    //public_str.Accstart = dr["Accstart"].ToString();
                    //public_str.Accperend = dr["Accperend"].ToString();
                    //public_str.Fuelstart = dr["Fuelstart"].ToString();
                    //public_str.Fuelend = dr["Fuelend"].ToString();
                    //Request.Cookies["authcookie"]["default_cashcode"] = dr["kokas"].ToString();
                    //Request.Cookies["authcookie"]["default_cashname"] = dr["NamKas"].ToString();
                    //Request.Cookies["authcookie"]["default_bankcode"] = dr["KoBank"].ToString();
                    //Request.Cookies["authcookie"]["default_bankname"] = dr["NamBank"].ToString();

                    string sKey = txt_uid.Value + txt_pass.Value;
                    string sUser = Convert.ToString(Cache[sKey]);

                    if (sUser == null || sUser == String.Empty)
                    {
                        //TimeSpan SessTimeOut = new TimeSpan(0, 1, HttpContext.Current.Session.Timeout, 0, 0);
                        TimeSpan SessTimeOut = new TimeSpan(0, 1, 1, 1, 1);
                        HttpContext.Current.Cache.Insert("sKey", sKey, null, DateTime.MaxValue, SessTimeOut,
                        System.Web.Caching.CacheItemPriority.NotRemovable, null);
                        Session["UID"] = txt_uid.Value + txt_pass.Value;
                    }

                    //Session["UID"] = txtuid.Text;
                    Response.Redirect("~/Main.aspx");
                }
                else
                {
                    //lbl_error.Text = "Something wrong with your login";
                }
                con.Close();

            }

        }

        public static void login_submit()
        {
            Login instance = new Login();
            instance.submit();
        }
        protected void submit()
        {
            login();
        }

        protected void btn_submit_Click(object sender, EventArgs e)
        {
            login();
        }
    }
}