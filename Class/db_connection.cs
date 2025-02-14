using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace PRIMA_HRIS.Class
{
    public class db_connection
    {
        public static string koneksi = ConfigurationManager.ConnectionStrings["DbConString"].ConnectionString;
        public SqlConnection kon = new SqlConnection(koneksi);
        public SqlTransaction transaksi;

        public void open_koneksi()
        {
            //kon.Close();
            kon.Open();
        }

        public void close_koneksi()
        {
            kon.Close();
        }

        public void error_koneksi()
        {
            transaksi.Rollback();
            kon.Close();
        }
    }
}