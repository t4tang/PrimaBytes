<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="pa-emp02.aspx.cs" Inherits="PRIMA_HRIS.Page.PA.Employee.pa_emp02" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../styles/custom-cs.css" rel="stylesheet" />    
    <link href="../../../styles/mail.css" rel="stylesheet" />
    <script src="../../../script/scripts.js"></script>
    <script type="text/javascript">
        function adjustColumnWidths() {
            var grid = $find("<%= RadGrid2.ClientID %>");
            var columns = grid.get_masterTableView().get_columns();
            for (var i = 0; i < columns.length; i++) {
                var headerText = columns[i].get_element().innerText;
                var width = headerText.length * 10; // Sesuaikan faktor pengali sesuai kebutuhan
                columns[i].get_element().style.width = width + 'px';
                var fontSize = headerText.fontSize * 20;
                columns[i].get_element().style.fontSize = fontSize + 'px';
            }
        }

        Sys.Application.add_load(adjustColumnWidths);

        function allertFn(arg) {
            alert(arg);
        }

    </script>
    <style>
        .rgHeader .rgHeaderText {
            white-space: nowrap;
        }
        .RadGrid .rgHeaderDiv, .RadGrid .rgDataDiv {
        overflow-x: auto;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" >
        <AjaxSettings>            
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="gridLoadingPanel"></telerik:AjaxUpdatedControl>
                </UpdatedControls>                
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <div style="padding-left: 15px; border-bottom-style:solid; border-bottom-color:cadetblue; border-bottom-width:thin; font-size:smaller; 
        font-family:'Tahoma'; background-color:#303d3f">
        <table>
            <tr>
                <td style="width: 96%; text-align: left">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight:normal; font-size: 10px; font-variant: small-caps; padding-right: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-family:Mistral">
                    </telerik:RadLabel>
                </td>
                
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 7px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_add" Skin="Glow" AutoPostBack="false" Enabled="false" 
                        runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbAdd" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 7px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_filter" Skin="Glow" AutoPostBack="false" Enabled="false"  
                        runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbSearch" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_refresh" Skin="Glow" AutoPostBack="false" Enabled="false" 
                        runat="server" Width="30px" Height="30px" >
                        <Icon PrimaryIconCssClass="rbRefresh" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_upload" Skin="Glow" AutoPostBack="false"  
                        Enabled="false" runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbUpload" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="RadButton4" Skin="Glow" AutoPostBack="false" Enabled="false" runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbDownload" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="RadButton5" Skin="Glow" AutoPostBack="false" Enabled="false" runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbOpen" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="RadButton6" Skin="Glow" AutoPostBack="false" Enabled="false" runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbAttach" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="RadButton7" Skin="Glow" AutoPostBack="false" Enabled="false" runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbConfig" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 25px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="RadButton1" Skin="Glow" AutoPostBack="false" Enabled="false" runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbHelp" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
    </div>
    <div  class="scroller" runat="server" style="overflow-y:auto; height:575px; font-size:small; font-family:Tahoma; background-color:#303d3f;">                    
        <div runat="server" style="overflow:auto; width:99%; height:unset; padding-top:10px">
            <telerik:RadTabStrip RenderMode="Auto" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="97%" 
            AutoPostBack="false" SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Glow">
            <Tabs>
                <telerik:RadTab Text="Utama" Height="15px"> 
                </telerik:RadTab>
                <telerik:RadTab Text="Keluarga" Height="15px">
                </telerik:RadTab>
                <telerik:RadTab Text="Pendidikan" Height="15px">
                </telerik:RadTab>
                <telerik:RadTab Text="Pelatihan" Height="15px">
                </telerik:RadTab>
                <telerik:RadTab Text="Lisensi" Height="15px">
                </telerik:RadTab>
            </Tabs>
            </telerik:RadTabStrip>
             <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="100%" BorderStyle="none" BorderColor="YellowGreen" Height="100%">
                 <telerik:RadPageView runat="server" ID="RadPageView1" Height="100%" >
                    <div runat="server" style="overflow:hidden; height:30px; margin-top:7px; width:100%;" >               
                        <table>
                            <tr>
                                <td style="padding-left:100px; width:80%" >                                            
                                    <asp:FileUpload ID="FileUpload1" runat="server" Enabled="true" />
                                </td>
                                <td style="padding-left:5px;" >
                                    <telerik:RadButton ID="btn_ok" runat="server" Text="Upload" Width="125" Height="25px" OnClick="btn_upload_Click" 
                                        Skin="Telerik" AutoPostBack="true" >
                                    </telerik:RadButton>
                                </td>
                                <td style="padding-left:5px;" >
                                    <telerik:RadButton ID="btn_confirm" runat="server" Text="Confirm" Width="125" Height="25px" OnClick="btn_confirm_Click" 
                                        Skin="Telerik" AutoPostBack="true" ></telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="overflow:auto; padding:5px 5px 5px 5px; vertical-align:top; ">                        
                        <telerik:RadGrid runat="server" ID="RadGrid2" AllowPaging="true" ShowFooter="false" Skin="Glow" CssClass="RadGrid_ModernBrowsers" 
                            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="20" 
                             OnNeedDataSource="RadGrid2_NeedDataSource" OnItemDataBound="RadGrid2_ItemDataBound">
                            <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                            <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="white" />
                            <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                            <ItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="white" />
                            <SelectedItemStyle Font-Italic="False"/>
                            <SortingSettings EnableSkinSortStyles="false" />
                            <MasterTableView Width="11000px" CommandItemDisplay="Top" Font-Size="11px" Font-Names="Century Gothic" 
                                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" 
                                CommandItemSettings-ShowAddNewRecordButton="false"
                                 CommandItemSettings-ShowRefreshButton="false">
                                <ColumnGroups>
                                    <telerik:GridColumnGroup HeaderText="POSISI" Name="group_posisi">
                                        <HeaderStyle Width="500px" />
                                    </telerik:GridColumnGroup>
                                    <telerik:GridColumnGroup HeaderText="ASSIGN" Name="group_assign">
                                        <HeaderStyle Width="500px" />
                                    </telerik:GridColumnGroup>
                                </ColumnGroups>
                                <Columns>
                                    <telerik:GridBoundColumn DataField="NIK" HeaderText="NIK" UniqueName="NIK">
                                        <HeaderStyle Width="60px" />
                                        <ItemStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA" HeaderText="NAMA" UniqueName="NAMA">
                                        <HeaderStyle Width="150px" />
                                        <ItemStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_POSISI" UniqueName="KODE_POSISI" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_POISIS" HeaderText="POSISI" UniqueName="NAMA_POISIS" >
                                        <HeaderStyle Width="250px" />
                                        <ItemStyle Width="250px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="COSTING" HeaderText="COSTING" UniqueName="COSTING">
                                        <HeaderStyle Width="60px" />
                                        <ItemStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ACTUAL" HeaderText="ACTUAL" UniqueName="ACTUAL">
                                        <HeaderStyle Width="60px" />
                                        <ItemStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_ASSIGN" UniqueName="KODE_ASSIGN"  >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_ASSIGN" HeaderText="NAMA ASSIGN" UniqueName="NAMA_ASSIGN">
                                        <HeaderStyle Width="250px" />
                                        <ItemStyle Width="250px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="CATEGORY" HeaderText="CATEGORY" UniqueName="CATEGORY">
                                        <HeaderStyle Width="80px" />
                                        <ItemStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="GOL" HeaderText="GOLONGAN" UniqueName="GOL">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Width="50px" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="SUB-GOL" HeaderText="SUB GOL" UniqueName="SUB-GOL">
                                        <HeaderStyle Width="70px" />
                                        <ItemStyle Width="50px" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TMP_LAHIR" HeaderText="KOTA KELAHIRAN" UniqueName="TMP_LAHIR">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_LAHIR" HeaderText="TGL LAHIR" UniqueName="TGL_LAHIR" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_GROUP" HeaderText="TGL GROUP" UniqueName="TGL_GROUP" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_MASUK" HeaderText="TGL MASUK" UniqueName="TGL_MASUK" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_JENIS_HUB" UniqueName="KODE_JENIS_HUB" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_JENIS_HUB" HeaderText="JENIS HUB" UniqueName="NAMA_JENIS_HUB">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_AWAL_KONTRAK" HeaderText="TGL AWL KONTRAK" UniqueName="TGL_AWAL_KONTRAK" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_AKHIR_KONTRAK" HeaderText="TGL AKH KONTRAK" UniqueName="TGL_AKHIR_KONTRAK" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_TETAP" HeaderText="TGL TETAP" UniqueName="TGL_TETAP" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_KELUAR" HeaderText="TGL KELUAR" UniqueName="TGL_KELUAR" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_JENIS_KELAMIN" UniqueName="KODE_JENIS_KELAMIN" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_JENIS_KELAMIN" HeaderText="JNS KELAMIN" UniqueName="NAMA_JENIS_KELAMIN">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_AGAMA" UniqueName="KODE_AGAMA" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_AGAMA" HeaderText="AGAMA" UniqueName="NAMA_AGAMA">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DOMISILI" HeaderText="DOMISILI" UniqueName="DOMISILI" >
                                        <HeaderStyle Width="250px" />
                                        <ItemStyle Width="250px" />
                                    </telerik:GridBoundColumn>
                        
                                    <telerik:GridBoundColumn DataField="KODE_KOTA" UniqueName="KODE_KOTA">
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_KOTA" HeaderText="KOTA" UniqueName="NAMA_KOTA">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_PROPINSI" UniqueName="KODE_PROPINSI" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_PROPINSI" HeaderText="PROPINSI" UniqueName="NAMA_PROPINSI">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TELPON_1" HeaderText="TELPON" UniqueName="TELPON_1">
                                        <HeaderStyle Width="80px" />
                                        <ItemStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="HP_1" HeaderText="HP" UniqueName="HP_1">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DARAH" HeaderText="DARAH" UniqueName="DARAH">
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Width="50px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KTP" HeaderText="NO. KTP" UniqueName="KTP">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ALAMAT_KTP" HeaderText="ALAMAT KTP" UniqueName="ALAMAT_KTP">
                                        <HeaderStyle Width="250px" />
                                        <ItemStyle Width="250px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NPWP" HeaderText="NPWP" UniqueName="NPWP">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BPJS-TK" HeaderText="BPJS-TK" UniqueName="BPJS-TK">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="DAPEN" HeaderText="DAPEN" UniqueName="DAPEN">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NOMOR_REKENING" HeaderText="NOMOR REK." UniqueName="NOMOR_REKENING">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_REKENING" HeaderText="NAMA REK." UniqueName="NAMA_REKENING">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_STATUS_KAWIN" UniqueName="KODE_STATUS_KAWIN" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_STATUS_KAWIN" HeaderText="STS KAWIN" UniqueName="NAMA_STATUS_KAWIN">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="JML_ANAK" HeaderText="JML ANAK" UniqueName="JML_ANAK">
                                        <HeaderStyle Width="60px" HorizontalAlign="Center" />
                                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PAJAK" HeaderText="PAJAK" UniqueName="PAJAK">
                                        <HeaderStyle Width="60px" HorizontalAlign="Center" />
                                        <ItemStyle Width="60px" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="STRATA" HeaderText="PENDIDIKAN" UniqueName="STRATA">
                                        <HeaderStyle Width="70px" HorizontalAlign="Center" />
                                        <ItemStyle Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_JURUSAN" UniqueName="KODE_JURUSAN" >
                                        <HeaderStyle Width="0" HorizontalAlign="Center" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_JURUSAN" HeaderText="JURUSAN" UniqueName="NAMA_JURUSAN">
                                        <HeaderStyle Width="100px" />
                                        <ItemStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_SEKOLAH" HeaderText="NAMA SEKOLAH" UniqueName="NAMA_SEKOLAH">
                                        <HeaderStyle Width="150px" />
                                        <ItemStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_KOTA_SEKOLAH" UniqueName="KODE_KOTA_SEKOLAH" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_KOTA_SEKOLAH" HeaderText="KOTA SEKOLAH" UniqueName="NAMA_KOTA_SEKOLAH">
                                        <HeaderStyle Width="100px" />
                                        <ItemStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_STATUS_LULUS" UniqueName="KODE_STATUS_LULUS" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_STATUS_LULUS" HeaderText="STATUS LULUS" UniqueName="NAMA_STATUS_LULUS" >
                                        <HeaderStyle Width="80px" />
                                        <ItemStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KETERANGAN" HeaderText="KETERANGAN LULUS" UniqueName="KETERANGAN" >
                                        <HeaderStyle Width="180px" />
                                        <ItemStyle Width="180px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE" HeaderText="KODE" UniqueName="KODE" >
                                        <HeaderStyle Width="70px" />
                                        <ItemStyle Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_MENIKAH" HeaderText="TGL MENIKAH" UniqueName="TGL_MENIKAH" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_CERAI" HeaderText="TGL CERAI" UniqueName="TGL_CERAI" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_WAFAT" HeaderText="TGL WAFAT" UniqueName="TGL_WAFAT" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PAY_CYCLE" HeaderText="PAY CYCLE" UniqueName="PAY_CYCLE" >
                                        <HeaderStyle Width="70px" />
                                        <ItemStyle Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_BANK" HeaderText="KODE BANK" UniqueName="KODE_BANK" >
                                        <HeaderStyle Width="70px" />
                                        <ItemStyle Width="70px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_BANK" HeaderText="NAMA BANK" UniqueName="NAMA_BANK" >
                                        <HeaderStyle Width="150px" />
                                        <ItemStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="BANK_BRANCH" HeaderText="BANK BRANCH" UniqueName="BANK_BRANCH" >
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_SUB_DEPT" UniqueName="KODE_SUB_DEPT">
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_SUB_DEPT" HeaderText="SUB DEPT" UniqueName="NAMA_SUB_DEPT" >
                                        <HeaderStyle Width="110px" />
                                        <ItemStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_DEPARTMENT"  UniqueName="KODE_DEPARTMENT" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_DEPARTMENT" HeaderText="DEPARTMENT" UniqueName="NAMA_DEPARTMENT" >
                                        <HeaderStyle Width="110px" />
                                        <ItemStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_DIVISI" UniqueName="KODE_DIVISI">
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_DIVISI" HeaderText="DIVISI" UniqueName="NAMA_DIVISI" >
                                        <HeaderStyle Width="110px" />
                                        <ItemStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_KONTAK_DARURAT" HeaderText="NAMA KONTAK DARURAT" UniqueName="NAMA_KONTAK_DARURAT" >
                                        <HeaderStyle Width="110px" />
                                        <ItemStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="JENIS_HUBUNGAN" HeaderText="HUBUNGAN DARURAT" UniqueName="JENIS_HUBUNGAN" >
                                        <HeaderStyle Width="110px" />
                                        <ItemStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="ALAMAT_DARURAT" HeaderText="ALAMAT DARURAT" UniqueName="ALAMAT_DARURAT" >
                                        <HeaderStyle Width="180px" />
                                        <ItemStyle Width="180px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NOMOR_TELEPON_DARURAT_1" HeaderText="NO TLP DARURAT" UniqueName="NOMOR_TELEPON_DARURAT_1" >
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UKURAN_SEPATU" HeaderText="UK SEPATU" UniqueName="UKURAN_SEPATU" >
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Width="50px" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UKURAN_BAJU" HeaderText="UK BAJU" UniqueName="UKURAN_BAJU" >
                                        <HeaderStyle Width="50px" />
                                        <ItemStyle Width="50px" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LOKASI_SEBELUMNYA" HeaderText="LOKASI SEBELUMNYA" UniqueName="LOKASI_SEBELUMNYA" >
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TANGGAL_MUTASI" HeaderText="TANGGAL MUTASI" UniqueName="TANGGAL_MUTASI" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UNIT_YANG_DIBAWA" HeaderText="UNIT YANG DIBAWA" UniqueName="UNIT_YANG_DIBAWA" >
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_POO" UniqueName="KODE_POO" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_POO" HeaderText="POO" UniqueName="NAMA_POO" >
                                        <HeaderStyle Width="110px" />
                                        <ItemStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_POH" UniqueName="KODE_POH" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_POH" HeaderText="POH" UniqueName="NAMA_POH" >
                                        <HeaderStyle Width="110px" />
                                        <ItemStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NO_KK" HeaderText="NO KK" UniqueName="NO_KK" >
                                        <HeaderStyle Width="110px" />
                                        <ItemStyle Width="110px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UID" HeaderText="UID" UniqueName="UID" >
                                        <HeaderStyle Width="80px" />
                                        <ItemStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadPageView >
                <telerik:RadPageView runat="server" ID="RadPageView2" Height="100%">
                    <div runat="server" style="overflow:hidden; height:30px; margin-top:7px; width:100%;" >               
                        <table>
                            <tr>
                                <td style="padding-left:100px; width:80%" >                                            
                                    <asp:FileUpload ID="FileUpload2" runat="server" Enabled="true" OnUnload="FileUpload2_Unload" />
                                </td>
                                <td style="padding-left:5px;" >
                                    <telerik:RadButton ID="btn_upload_family" runat="server" Text="Upload" Width="125" Height="25px" OnClick="btn_upload_family_Click" 
                                        Skin="Telerik" AutoPostBack="true" >
                                    </telerik:RadButton>
                                </td>
                                <td style="padding-left:5px;" >
                                    <telerik:RadButton ID="btn_confirm_family" runat="server" Text="Confirm" Width="125" Height="25px" OnClick="btn_confirm_family_Click"
                                        Skin="Telerik" AutoPostBack="true" ></telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="overflow:auto; padding:5px 5px 5px 5px; vertical-align:top; ">  
                                               
                        <telerik:RadGrid runat="server" ID="RG_FAMILY" AllowPaging="true" ShowFooter="false" Skin="Glow" CssClass="RadGrid_ModernBrowsers"
                            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="20" 
                             OnNeedDataSource="RG_FAMILY_NeedDataSource" OnItemDataBound="RG_FAMILY_ItemDataBound" >
                            <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                            <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="white" />
                            <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                            <ItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="white" />
                            <SelectedItemStyle Font-Italic="False"/>
                            <SortingSettings EnableSkinSortStyles="false" />
                            <MasterTableView Width="1500px" CommandItemDisplay="Top" Font-Size="11px" Font-Names="Century Gothic" 
                                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" 
                                CommandItemSettings-ShowAddNewRecordButton="false"
                                 CommandItemSettings-ShowRefreshButton="false">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="NIK" HeaderText="NIK" UniqueName="NIK">
                                        <HeaderStyle Width="60px" />
                                        <ItemStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="HUBUNGAN" UniqueName="HUBUNGAN"  Visible="true">
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_HUBUNGAN" HeaderText="HUBUNGAN KELUARGA" UniqueName="NAMA_HUBUNGAN">
                                        <HeaderStyle Width="150px" />
                                        <ItemStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA" HeaderText="NAMA" UniqueName="NAMA">
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_JENIS_KELAMIN" UniqueName="KODE_JENIS_KELAMIN" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="JNS_KELAMIN" HeaderText="JNS KELAMIN" UniqueName="JNS_KELAMIN">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_LAHIR" HeaderText="TGL LAHIR" UniqueName="TGL_LAHIR" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PENDIDIKAN" HeaderText="PENDIDIKAN" UniqueName="PENDIDIKAN">
                                        <HeaderStyle Width="60px" />
                                        <ItemStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="PEKERJAAN" HeaderText="PEKERJAAN" UniqueName="PEKERJAAN">
                                        <HeaderStyle Width="160px" />
                                        <ItemStyle Width="160px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KETERANGAN" HeaderText="KETERANGAN" UniqueName="KETERANGAN">
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UID" HeaderText="UID" UniqueName="UID" >
                                        <HeaderStyle Width="80px" />
                                        <ItemStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                            </ClientSettings>
                        </telerik:RadGrid>
                        
                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView3" Height="100%">
                    <div runat="server" style="overflow:hidden; height:30px; margin-top:7px; width:100%;" >               
                        <table>
                            <tr>
                                <td style="padding-left:100px; width:80%" >                                            
                                    <asp:FileUpload ID="FileUpload3" runat="server" Enabled="true" />
                                </td>
                                <td style="padding-left:5px;" >
                                    <telerik:RadButton ID="btn_upload_edu" runat="server" Text="Upload" Width="125" Height="25px" OnClick="btn_upload_edu_Click" 
                                        Skin="Telerik" AutoPostBack="true" >
                                    </telerik:RadButton>
                                </td>
                                <td style="padding-left:5px;" >
                                    <telerik:RadButton ID="btn_confirm_edu" runat="server" Text="Confirm" Width="125" Height="25px" OnClick="btn_confirm_edu_Click" 
                                        Skin="Telerik" AutoPostBack="true" ></telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="overflow:auto; padding:5px 5px 5px 5px; vertical-align:top; ">  
                                               
                        <telerik:RadGrid runat="server" ID="RG_Education" AllowPaging="true" ShowFooter="false" Skin="Glow" CssClass="RadGrid_ModernBrowsers"
                            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="20" 
                             OnNeedDataSource="RG_Education_NeedDataSource" OnItemDataBound="RG_Education_ItemDataBound" >
                            <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                            <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="white" />
                            <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                            <ItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="white" />
                            <SelectedItemStyle Font-Italic="False"/>
                            <SortingSettings EnableSkinSortStyles="false" />
                            <MasterTableView Width="1500px" CommandItemDisplay="Top" Font-Size="11px" Font-Names="Century Gothic" 
                                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" 
                                CommandItemSettings-ShowAddNewRecordButton="false"
                                 CommandItemSettings-ShowRefreshButton="false">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="NIK" HeaderText="NIK" UniqueName="NIK">
                                        <HeaderStyle Width="60px" />
                                        <ItemStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_JENJANG" UniqueName="KODE_JENJANG" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="JENJANG" HeaderText="JENJANG" UniqueName="JENJANG">
                                        <HeaderStyle Width="150px" />
                                        <ItemStyle Width="150px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_JURUSAN" UniqueName="KODE_JURUSAN">
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="JURUSAN" HeaderText="JURUSAN" UniqueName="JURUSAN">
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_INSTITUSI" HeaderText="INSTITUSI" UniqueName="NAMA_INSTITUSI">
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KODE_KOTA" UniqueName="KODE_KOTA" >
                                        <HeaderStyle Width="0" />
                                        <ItemStyle Width="0" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KOTA" HeaderText="KOTA" UniqueName="KOTA">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="STATUS_PENDIDIKAN" HeaderText="STATUS" UniqueName="STATUS_PENDIDIKAN">
                                        <HeaderStyle Width="90px" />
                                        <ItemStyle Width="90px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KETERANGAN" HeaderText="KETERANGAN" UniqueName="KETERANGAN">
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UID" HeaderText="UID" UniqueName="UID" >
                                        <HeaderStyle Width="80px" />
                                        <ItemStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                            </ClientSettings>
                        </telerik:RadGrid>
                          

                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView4" Height="100%">
                    <div runat="server" style="overflow:hidden; height:30px; margin-top:7px; width:100%;" >               
                        <table>
                            <tr>
                                <td style="padding-left:100px; width:80%" >                                            
                                    <asp:FileUpload ID="FileUpload4" runat="server" Enabled="true" />
                                </td>
                                <td style="padding-left:5px;" >
                                    <telerik:RadButton ID="btn_upload_training" runat="server" Text="Upload" Width="125" Height="25px" OnClick="btn_upload_training_Click" 
                                        Skin="Telerik" AutoPostBack="true" >
                                    </telerik:RadButton>
                                </td>
                                <td style="padding-left:5px;" >
                                    <telerik:RadButton ID="btn_confirm_training" runat="server" Text="Confirm" Width="125" Height="25px" OnClick="btn_confirm_training_Click" 
                                        Skin="Telerik" AutoPostBack="true" ></telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="overflow:auto; padding:5px 5px 5px 5px; vertical-align:top; ">  
                        <telerik:RadGrid runat="server" ID="RG_Training" AllowPaging="true" ShowFooter="false" Skin="Glow" CssClass="RadGrid_ModernBrowsers" 
                            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="20" 
                             OnNeedDataSource="RG_Training_NeedDataSource" >
                            <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                            <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="white" />
                            <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                            <ItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="white" />
                            <SelectedItemStyle Font-Italic="False"/>
                            <SortingSettings EnableSkinSortStyles="false" />
                            <MasterTableView Width="1500px" CommandItemDisplay="Top" Font-Size="11px" Font-Names="Century Gothic" 
                                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" 
                                CommandItemSettings-ShowAddNewRecordButton="false"
                                 CommandItemSettings-ShowRefreshButton="false">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="NIK" HeaderText="NIK" UniqueName="NIK">
                                        <HeaderStyle Width="60px" />
                                        <ItemStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TRAINING_KE" HeaderText="TRAINING KE" UniqueName="TRAINING_KE">
                                        <HeaderStyle Width="100px" />
                                        <ItemStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_TRAINING" HeaderText="NAMA TRAINING" UniqueName="NAMA_TRAINING">
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LEMBAGA" HeaderText="LEMBAGA" UniqueName="LEMBAGA">
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_TRAINING" HeaderText="TGL TRAINING" UniqueName="TGL_TRAINING" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KETERANGAN" HeaderText="KETERANGAN" UniqueName="KETERANGAN">
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UID" HeaderText="UID" UniqueName="UID" >
                                        <HeaderStyle Width="80px" />
                                        <ItemStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadPageView>
                <telerik:RadPageView runat="server" ID="RadPageView5" Height="100%">
                    <div runat="server" style="overflow:hidden; height:30px; margin-top:7px; width:100%;" >               
                        <table>
                            <tr>
                                <td style="padding-left:100px; width:80%" >                                            
                                    <asp:FileUpload ID="FileUpload5" runat="server" Enabled="true" />
                                </td>
                                <td style="padding-left:5px;" >
                                    <telerik:RadButton ID="btn_upload_lisensi" runat="server" Text="Upload" Width="125" Height="25px" OnClick="btn_upload_lisensi_Click" 
                                        Skin="Telerik" AutoPostBack="true" >
                                    </telerik:RadButton>
                                </td>
                                <td style="padding-left:5px;" >
                                    <telerik:RadButton ID="btn_confirm_lisensi" runat="server" Text="Confirm" Width="125" Height="25px" OnClick="btn_confirm_lisensi_Click" 
                                        Skin="Telerik" AutoPostBack="true" ></telerik:RadButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div style="overflow:auto; padding:5px 5px 5px 5px; vertical-align:top; ">  
                        <telerik:RadGrid runat="server" ID="RG_Lisensi" AllowPaging="true" ShowFooter="false" Skin="Glow" CssClass="RadGrid_ModernBrowsers" 
                            AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="20" 
                             OnNeedDataSource="RG_Lisensi_NeedDataSource" >
                            <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                            <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="white" />
                            <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                            <ItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="white" />
                            <SelectedItemStyle Font-Italic="False"/>
                            <SortingSettings EnableSkinSortStyles="false" />
                            <MasterTableView Width="1500px" CommandItemDisplay="Top" Font-Size="11px" Font-Names="Century Gothic" 
                                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" 
                                CommandItemSettings-ShowAddNewRecordButton="false"
                                 CommandItemSettings-ShowRefreshButton="false">
                                <Columns>
                                    <telerik:GridBoundColumn DataField="NIK" HeaderText="NIK" UniqueName="NIK">
                                        <HeaderStyle Width="60px" />
                                        <ItemStyle Width="60px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LISENSI_KE" HeaderText="LISENSI KE" UniqueName="LISENSI_KE">
                                        <HeaderStyle Width="100px" />
                                        <ItemStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NAMA_LISENSI" HeaderText="NAMA LISENSI" UniqueName="NAMA_LISENSI">
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="LEMBAGA" HeaderText="LEMBAGA" UniqueName="LEMBAGA">
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="TGL_LISENSI" HeaderText="TGL LISENSI" UniqueName="TGL_LISENSI" DataFormatString="{0:dd/MM/yyyy}">
                                        <HeaderStyle Width="120px" />
                                        <ItemStyle Width="120px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="NO_LISENSI" HeaderText="NO LISENSI" UniqueName="NO_LISENSI">
                                        <HeaderStyle Width="100px" />
                                        <ItemStyle Width="100px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="KETERANGAN" HeaderText="KETERANGAN" UniqueName="KETERANGAN">
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="UID" HeaderText="UID" UniqueName="UID" >
                                        <HeaderStyle Width="80px" />
                                        <ItemStyle Width="80px" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                            </MasterTableView>
                            <ClientSettings>
                                <Scrolling AllowScroll="True" UseStaticHeaders="True" />
                            </ClientSettings>
                        </telerik:RadGrid>
                    </div>
                </telerik:RadPageView>
            </telerik:RadMultiPage>
        </div>
    </div>
    
    <telerik:RadWindowManager RenderMode="Auto" ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow RenderMode="Auto" ID="PreviewDialog" runat="server"  ReloadOnShow="false" ShowContentDuringLoad="false"
                Width="1150px" Height="670px" Modal="true">
            </telerik:RadWindow>

        </Windows>
    </telerik:RadWindowManager>
</asp:Content>
