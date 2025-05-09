﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace PRIMA_HRIS.Class
{
    public class public_str
    {
        //User Login
        public static string user_id { get; set; }
        public static string user_name { get; set; }
        //Server
        public static string uid { get; set; }
        //public static string uname = "";
        public static string server_ip { get; set; }
        public static string database_name = "";
        public static string database_uid = "";
        public static string database_pwd = "";
        public static DateTime login_time;

        //===
        public static string site = "";
        public static string sitename = "";
        public static string level = "";
        public static string sec_group = "";

        public static string default_cashcode = "";
        public static string default_cashname = "";
        public static string default_bankcode = "";
        public static string default_bankname = "";

        public static string perstart;
        public static string perend;
        public static string Accstart;
        public static string Accperend;
        public static string Finstart;
        public static string Finperend;
        public static string Fuelstart;
        public static string Fuelend;
        public static string company_code;
        public static string company_name;
        //public static string modul;
        public static string selected_menu = "";

        //public static string selected_project_item;
        //public static string str_type_code = "";
        //public static string str_category = "";
        //public static string str_run_group_code = "";
        //public string str_run_group_code { get; set; }
        public static string posted_transaction_notif = "Simpan data gagal karena transaksi ini telah diposting";
        public static string outsite_periode_notif = "Tanggal transaksi di luar periode transaksi";

        public string kode_asset { get; set; }
        public string nama_aset { get; set; }
        public string deskripsi { get; set; }
        public string merek { get; set; }
        public string tipe { get; set; }
        //public string site { get; set; }
        public string kategori { get; set; }
        public string sub_kategori { get; set; }
        public string kode_syshab { get; set; }
        public string kode_syshab_plan { get; set; }
        public string kode_ga { get; set; }
        public string sn { get; set; }
        public string nomor_mesin { get; set; }
        public string p_i_c { get; set; }
        public string lokasi { get; set; }
        public string kondisi { get; set; }
        public string status_asset { get; set; }
        public string keterangan { get; set; }
        public string ceker { get; set; }
        public DateTime tgl_cek { get; set; }
    }
}