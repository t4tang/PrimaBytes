<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="pa-emp01.aspx.cs" Inherits="PRIMA_HRIS.Page.PA.Employee.pa_emp01" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../styles/custom-cs.css" rel="stylesheet" />    
    <link href="../../../styles/mail.css" rel="stylesheet" />
    <script src="../../../script/scripts.js"></script>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function ShowPreview(id) {
                window.radopen("acc00d22.aspx?asset_id=" + id, "PreviewDialog");
                return false;
            }

            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function allertFn(arg) {
                alert(arg);
            }

            function openWinFiterTemplate() {
                var filterDialog = $find("<%=FilterDialogWindows.ClientID%>");
                filterDialog.show();
            }

            function openWinUploadTemplate() {
                var uploadWindows = $find("<%=uploadDialogWindows.ClientID%>");
                uploadWindows.show();
            }

            Sys.Application.add_load(function () {
            $windowContentDemo.contentTemplateID = "<%=FilterDialogWindows.ClientID%>";
            $windowContentDemo.templateWindowID = "<%=FilterDialogWindows.ClientID %>";
            });

           function refreshGrid(arg) {
                if (!arg) {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("Rebind");
                }
                else {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest("RebindAndNavigate");
                }

            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow)
                    oWindow = window.RadWindow; //Will work in Moz in all cases, including clasic dialog     
                else if (window.frameElement.radWindow)
                    oWindow = window.frameElement.radWindow;//IE (and Moz as well)     
                return oWindow;
            }

            function Close() {
                GetRadWindow().Close();
            }

            function onPopUpShowing(sender, args) {
                args.get_popUp().className += " popUpEditForm";
            }

            function callServerMethod() {
                __doPostBack('CallServerMethod', '');
                return false;
            }

            <%--function triggerButtonClick() {
                var button = document.getElementById('<%= Button1.ClientID %>');
                button.click();
                return false;
            }--%>

        </script>
    </telerik:RadCodeBlock>
    <style type="text/css">      
       div.RadGrid .rgPager .rgAdvPart     
       {     
        display:none;        
       }

        .photo-container 
        {
            padding: 5px;
            width: 150px;
            height: 150px;
            float:right;
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
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="FilterDialogWindows" RestrictionZoneID="RestrictionZone" 
        IconUrl="~/Images/p.ico" Opacity="50" EnableShadow="true" DestroyOnClose="true" Skin="Glow"
        Modal="true" Width="420px" Height="260px" VisibleStatusbar="False" AutoSize="False" Animation="FlyIn" Behaviors="Close" >
        <ContentTemplate>
            <div runat="server" style="padding:20px 10px 10px 15px; overflow:hidden; font-size:smaller; font-family:'Tahoma'">
                 <table>
                     <tr>
                         <td style="width:300px">
                             <telerik:RadLabel runat="server" Text="Project " Skin="Glow"></telerik:RadLabel>
                         </td>                         
                         <td style="width:220px">
                              <telerik:RadComboBox ID="cb_project_prm" runat="server" RenderMode="Auto" AutoPostBack="false"
                                EnableLoadOnDemand="True" Skin="Glow"  EnableVirtualScrolling="true"  ShowMoreResultsBox="true"
                                Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="250px" 
                                OnItemsRequested="cb_project_prm_ItemsRequested" 
                                OnSelectedIndexChanged="cb_project_prm_SelectedIndexChanged"
                                OnPreRender="cb_project_prm_PreRender" 
                                BorderStyle="NotSet"></telerik:RadComboBox>
                         </td>
                     </tr>
                     <tr>        
                         
                         <td>                             
                             <telerik:RadLabel runat="server" Text="Asset Code " Skin="Glow"></telerik:RadLabel>
                         </td>                   
                         <td style="width:220px">
                              <telerik:RadTextBox ID="txt_prm_asset_code" runat="server"  Width="250px" Skin="Glow"></telerik:RadTextBox>
                         </td>
                     </tr>                     
                     <tr>
                         <td>                             
                             <telerik:RadLabel runat="server" Text="Asset Name" Skin="Glow"></telerik:RadLabel>                             
                         </td>                           
                         <td style="width:220px">
                              <telerik:RadTextBox ID="txt_prm_asset_name" runat="server" Width="250px" Skin="Glow"></telerik:RadTextBox>
                         </td>
                     </tr>
                     <tr>
                         <td>
                             
                         </td>   
                         <td style="width:320px">
                              <telerik:RadComboBox ID="cb_status_prm" runat="server" RenderMode="Auto" Label="Status" AutoPostBack="false"
                                EnableLoadOnDemand="True" Skin="Glow" EnableVirtualScrolling="true" 
                                Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px"
                                OnSelectedIndexChanged="cb_project_prm_SelectedIndexChanged" 
                                  OnItemsRequested="cb_project_prm_ItemsRequested"  
                                  BorderStyle="NotSet"
                                Visible="false" ></telerik:RadComboBox>
                         </td>
                     </tr>
                     <tr>
                         <td style="padding-top:30px;" colspan="2">
                              <%--<asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="Retrieve" 
                                  BackColor="Transparent" Width="100%" Height="25px" BorderColor="#999999" BorderStyle="Inset" />--%>
                             <telerik:RadButton ID="btnSearch" runat="server" Text="Retrieve" OnClick="btnSearch_Click" 
                                 Skin="Glow" Width="94%" Height="25px"></telerik:RadButton>

                         </td>
                         
                     </tr>
                 </table>  
            </div>
            
        </ContentTemplate>
    </telerik:RadWindow>
    
    <telerik:RadWindow RenderMode="Lightweight" runat="server" ID="uploadDialogWindows" RestrictionZoneID="RestrictionZone" 
        IconUrl="~/Images/p.ico" Opacity="50" EnableShadow="true" DestroyOnClose="true" Skin="Glow"
        Modal="true" Width="500px" Height="250px" VisibleStatusbar="False" AutoSize="False" Animation="FlyIn" Behaviors="Close" >
        <ContentTemplate>
            <div runat="server" style="overflow:hidden; height:180px; margin-top:20px; width:100%;" >
               
                <table>
                    <tr>
                        <td style="width:70px" >
                            <telerik:RadLabel Width="70px" runat="server" Text="Upload" CssClass="lbObject"></telerik:RadLabel>
                        </td>
                        <td>:</td>
                        <td colspan="2" >                                            
                            <asp:FileUpload ID="FileUpload1" runat="server" Enabled="true" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" style="padding-right:10px; text-align:center; padding-top:30px">
                            <telerik:RadButton ID="btn_ok" runat="server" Text="Star Upload" Width="155" Height="25px" OnClick="btn_upload_Click" 
                                Skin="Glow" ForeColor="YellowGreen" AutoPostBack="true" ></telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </div>
            <%--<div runat="server" style="overflow:auto; width:100%;">
                <telerik:RadGrid RenderMode="Lightweight" runat="server" ID="RadGrid2" AllowPaging="True" AllowSorting="true"
                    DataSourceID="SqlDataSource1" Skin="Glow" HeaderStyle-ForeColor="YellowGreen" >
                </telerik:RadGrid>
            </div>
            <asp:SqlDataSource ID="SqlDataSource1" ConnectionString="<%$ ConnectionStrings:DbConString %>"
                ProviderName="System.Data.SqlClient" SelectCommand="SELECT * FROM UplEmpData" runat="server">
            </asp:SqlDataSource>--%>
        </ContentTemplate>
    </telerik:RadWindow>
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
                    <telerik:RadButton RenderMode="Auto" ID="btn_add" Skin="Glow" Enabled="false" AutoPostBack="true" OnClick="btn_add_Click"
                        runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbAdd" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 7px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_filter" Skin="Glow" Enabled="false" AutoPostBack="false" 
                        OnClientClicked ="openWinFiterTemplate" 
                        runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbSearch" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_refresh" Skin="Glow" AutoPostBack="true" OnClick="btn_refresh_Click"
                        Enabled="false" runat="server" Width="30px" Height="30px" >
                        <Icon PrimaryIconCssClass="rbRefresh" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_upload" Skin="Glow" AutoPostBack="false" OnClientClicked="openWinUploadTemplate" 
                        Enabled="false" runat="server" Width="30px" Height="30px" >
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

   <div  class="scroller" runat="server" style="overflow-y:auto; height:575px; font-size:small; font-family:Tahoma; background-color:#303d3f" >
        <div runat="server" style="width:100%; overflow-y:hidden; background-color:#303d3f">        
           <telerik:RadGrid  RenderMode="Auto" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Glow" 
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="100" CssClass="RadGrid_ModernBrowsers"
                OnNeedDataSource="RadGrid1_NeedDataSource" 
                OnDeleteCommand="RadGrid1_DeleteCommand" 
                OnSelectedIndexChanged="RadGrid1_SelectedIndexChanged"
                OnItemCommand="RadGrid1_ItemCommand" 
                OnItemDataBound="RadGrid1_ItemDataBound" >
                <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                <ItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                <SelectedItemStyle Font-Italic="False"/>
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Tahoma" DataKeyNames="EmployeeNo" EditMode="EditForms" 
                    EditFormSettings-PopUpSettings-Modal="true" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" 
                    CommandItemSettings-ShowAddNewRecordButton="false" CommandItemSettings-ShowRefreshButton="false" >  
                                     
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            <HeaderStyle Width="40px"/>
                            <ItemStyle Width="40px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="EmployeeNo" HeaderText="NIK" DataField="EmployeeNo"
                            ItemStyle-Width="80px" FilterControlWidth="80">
                            <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="EmployeeName" HeaderText="Nama Karyawan" DataField="EmployeeName" 
                                ItemStyle-Width="230px" FilterControlWidth="250px">
                            <HeaderStyle Width="250px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Wrap="true" Width="230px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="PositionName" HeaderText="Jabatan" DataField="PositionName" 
                                ItemStyle-Width="320px" FilterControlWidth="320px">
                            <HeaderStyle Width="350px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="LocationName" HeaderText="Lokasi Kerja" DataField="LocationName" 
                                ItemStyle-Width="130px" FilterControlWidth="130px">
                            <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="JoinDate" HeaderText="Tgl Masuk" DataField="JoinDate" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="90px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="EmpStatusName" HeaderText="Satus Karyawan" DataField="EmpStatusName" 
                                ItemStyle-Width="100px" FilterControlWidth="100px">
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="ChangeDate" HeaderText="Tgl Update" DataField="ChangeDate" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="90px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>                                   
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" ItemStyle-ForeColor="OrangeRed"
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                            <HeaderStyle Width="30px"></HeaderStyle>
                        </telerik:GridButtonColumn>                     
                    </Columns>
                     <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <div style="padding: 15px 0px 0px 25px; color:white; display:inline-block; vertical-align:top; width:30%">
                                <table id="Table1" border="0" >    
                                    <tr style="vertical-align: top">
                                        <td style="vertical-align: top">
                                            <table id="Table2" border="0" >
                                                <tr>
                                                    <td colspan="2" style="padding: 0px 0px 10px 0px; text-align:left">
                                                        <asp:Button ID="btnSave" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" 
                                                            Height="25px" OnClick="btnSave_Click"
                                                            Text='<%# (Container is GridEditFormInsertItem) ? "Save" : "Update" %>' runat="server" 
                                                            CssClass="btn-entryFrm" >
                                                        </asp:Button>&nbsp;
                            
                                                        <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                            Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                            runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                                    </td>
                                                </tr>                                                
                                            </table>
                                        </td>
                                                            
                                    </tr>
                                    <tr style="vertical-align: top">
                                        <td style="margin-bottom:5px">
                                            <table id="Table3" border="0" class="module">                                                
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="NIK" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_nik" runat="server" Width="350px" RenderMode="Auto" Skin="Glow" ReadOnly="true"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeNo") %>'  AutoPostBack="false">
                                                        </telerik:RadTextBox> 
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="Nama Karyawan" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadTextBox ID="txt_EmployeeName" runat="server" Width="350px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeName") %>'  AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td class="tdLabel">
                                                         <telerik:RadLabel Text="Jabatan " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_posisi" runat="server" Width="350px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.PositionName") %>'  AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>    
                                                <tr>
                                                    <td class="tdLabel" style="width:100px">
                                                       <telerik:RadLabel Text="Lokasi" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <%--<telerik:RadComboBox RenderMode="Auto" ID="cb_lokasi" runat="server" Width="350px"  ReadOnly="false"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="False" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.LocationName") %>' 
                                                            OnItemsRequested="cb_lokasi_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_lokasi_SelectedIndexChanged"
                                                            OnPreRender="cb_lokasi_PreRender"></telerik:RadComboBox>--%>
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_lokasi" runat="server" Width="350px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.LocationName") %>'  AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>                                                          
                                            </table>           
                                        </td>
                                        
                                    </tr>                       
                                </table>
                            </div>
                            <div style="padding: 15px 0px 0px 25px; display:inline-block; width:60%">
                                <table>
                                    <tr>
                                        <td style="vertical-align: top;" class="photo-container">
                                            <telerik:RadBinaryImage runat="server" ID="RadBinaryImage1" 
                                                DataValue='<%# Eval("Photo") == DBNull.Value? new System.Byte[0]: Eval("Photo") %>'
                                                AutoAdjustImageControlSize="false" Width="130px" Height="150px" 
                                                ToolTip='<%#Eval("EmployeeName", "Photo of {0}") %>'
                                                AlternateText='<%#Eval("EmployeeName", "Photo of {0}") %>' />
                                        </td>
                                        <td style="vertical-align: top;">
                                            <telerik:RadAsyncUpload ID="RadAsyncUpload1" HideFileInput="true" runat="server" Skin="Glow" Localization-Select="Select Image" />
                                            <telerik:RadLabel ID="lblMessage" runat="server" Text="" Skin="Glow" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div style=" width:100%;" class="table_trx">
                                <telerik:RadTabStrip RenderMode="Auto" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="97%" 
                                AutoPostBack="false" SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Glow">
                                <Tabs>
                                    <telerik:RadTab Text="Data Inti" Height="15px"> 
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Data Pribadi" Height="15px">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Data Keluarga" Height="15px">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Data Organisasi" Height="15px">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Data Pendidikan" Height="15px">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Data Keahlian" Height="15px">
                                    </telerik:RadTab>
                                </Tabs>
                                </telerik:RadTabStrip>
                                <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="97%">
                                    <telerik:RadPageView runat="server" ID="RadPageView1" Height="100%" >
                                        <div style="height:300px; overflow:auto; padding:5px 5px 5px 5px; vertical-align:top; ">
                                            <div style="width:20%; padding: 10px 10px 10px 30px; display:inline-block; vertical-align:top; 
                                              font-family:Verdana; font-size:12px; margin-top:7px"> 
                                                Hubungan Kerja :
                                                <table style="padding: 10px 0px 10px 10px">
                                                    <tr >
                                                        <td style="width:140px">
                                                            Jenis Hubungan 
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox RenderMode="Auto" ID="cb_jns_hubungan" runat="server" Width="150px"
                                                                EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.EmpStatusName") %>' 
                                                                OnItemsRequested="cb_jns_hubungan_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_jns_hubungan_SelectedIndexChanged" 
                                                                OnPreRender="cb_jns_hubungan_PreRender" >                                                                                                     
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Tanggal Group
                                                        </td>
                                                        <td >
                                                            <telerik:RadDatePicker ID="dtp_tgl_group"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.GroupDate") %>' TabIndex="4" Skin="Glow"> 
                                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                </DateInput>                                                                        
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Tanggal masuk
                                                        </td>
                                                        <td >
                                                            <telerik:RadDatePicker ID="dtp_tgl_masuk"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.JoinDate") %>' TabIndex="4" Skin="Glow"> 
                                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                </DateInput>                                                                        
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Tanggal Tetap
                                                        </td>
                                                        <td >
                                                            <telerik:RadDatePicker ID="dtp_tgl_tetap"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.PermanentDate") %>' TabIndex="4" Skin="Glow"> 
                                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                </DateInput>                                                                        
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Tanggal Awal Kontrak 
                                                        </td>
                                                        <td >
                                                            <telerik:RadDatePicker ID="dtp_tgl_awal_kontrak"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.ContractStartDate") %>' TabIndex="4" Skin="Glow"> 
                                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                </DateInput>                                                                        
                                                            </telerik:RadDatePicker>                                
                                                        </td>
                                                    </tr>                                                            
                                                    <tr>
                                                        <td >
                                                            Tanggal Akhir Kontrak 
                                                        </td>
                                                        <td >
                                                            <telerik:RadDatePicker ID="dtp_tgl_akhir_kontrak"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.ContractEndDate") %>' TabIndex="4" Skin="Glow"> 
                                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                </DateInput>                                                                        
                                                            </telerik:RadDatePicker>                                
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Tanggal Akhir 
                                                        </td>
                                                        <td >
                                                            <telerik:RadDatePicker ID="dtp_akhir"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.TerminationDate") %>' TabIndex="4" Skin="Glow"> 
                                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                </DateInput>                                                                        
                                                            </telerik:RadDatePicker>                                
                                                        </td>
                                                    </tr>
                                                </table>             
                                            </div>
                                            <div style="width:25%; padding: 10px 10px 10px 10px; display:inline-block; vertical-align:top; 
                                                font-family:Verdana; font-size:12px; margin-top:7px;"> 
                                                Identitas Pribadi :
                                                <table style="padding: 10px 0px 10px 10px">
                                                    <tr >
                                                        <td style="width:150px">
                                                            Nomor Kartu Keluarga 
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_kartu_keluarga" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.FamilyCardNo") %>' >
                                                                </telerik:RadTextBox>  
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Nomor KTP
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_ktp" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.IdCardNo") %>' >
                                                                </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Nomor BPJS Kesehatan 
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_bpjs_kesehatan" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.BPJSKesNo") %>' >
                                                                </telerik:RadTextBox>                                
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Nomor BPJS TK 
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_bpjs_ketenagakerjaan" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.BPJSNo") %>' >
                                                                </telerik:RadTextBox>                                
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            NPWP
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_npwp" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.TaxRegisteredNo") %>' >
                                                                </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Nomor SIM
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_sim" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.DrivingLisenceNo") %>' >
                                                                </telerik:RadTextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Nomor Dapen 
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_dapen" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.DapenNo") %>' >
                                                                </telerik:RadTextBox>                                
                                                        </td>
                                                    </tr>                                                
                                                </table>
                                            </div>
                                            <div style="width:23%; padding: 10px 10px 10px 10px; display:inline-block; vertical-align:top; 
                                                font-family:Verdana; font-size:12px; margin-top:7px;"> 
                                                <div>
                                                    Rekening :
                                                    <table style="padding: 10px 0px 10px 10px">
                                                        <tr >
                                                            <td style="width:120px">
                                                                Nomor Rekening 
                                                            </td>
                                                            <td>
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_norek" Width="250px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.BankAccNo") %>' >
                                                                    </telerik:RadTextBox>  
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td >
                                                                Nama Rekening
                                                            </td>
                                                            <td >
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_nama_rekening" Width="250px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.BankAccName") %>' >
                                                                    </telerik:RadTextBox>
                                                            </td>
                                                        </tr>   
                                                        <tr>
                                                            <td >
                                                                Nama Bank 
                                                            </td>
                                                            <td >
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_source_bank_name" runat="server" Width="250px"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.BankName") %>' 
                                                                    OnItemsRequested="cb_source_bank_name_ItemsRequested"
                                                                    OnSelectedIndexChanged="cb_source_bank_name_SelectedIndexChanged"
                                                                    OnPreRender="cb_source_bank_name_PreRender" >                                                                                                     
                                                                </telerik:RadComboBox>                                
                                                            </td>
                                                        </tr>  
                                                        <tr>
                                                            <td >
                                                                Cabang Bank 
                                                            </td>
                                                            <td >                                                               
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_bank_branch" Width="200px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.BankBranch") %>' >
                                                                </telerik:RadTextBox>  
                                                                                         
                                                            </td>
                                                        </tr>  
                                                    </table>
                                                </div>
                                                <div>
                                                    Pajak :
                                                    <table style="padding: 10px 0px 10px 10px">                                                       
                                                        <%--<tr>
                                                            <td style="width:120px">
                                                                Status Pekawinan 
                                                            </td>
                                                            <td>                                                                    
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_status_perkawinan" runat="server" Width="120px"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true"  
                                                                    OnItemsRequested="cb_status_perkawinan_ItemsRequested"
                                                                    OnSelectedIndexChanged="cb_status_perkawinan_SelectedIndexChanged"
                                                                    OnPreRender="cb_status_perkawinan_PreRender" >                                                                                                     
                                                                </telerik:RadComboBox>   
                                                            </td>
                                                        </tr>  --%>                                                          
                                                        <tr>
                                                            <td style="width:120px">
                                                                Status Pajak 
                                                            </td>
                                                            <td >
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_status_pajak" runat="server" Width="120px"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" Height="150px"  
                                                                    OnItemsRequested="cb_status_pajak_ItemsRequested" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.StatusTax") %>' >                                                                                                     
                                                                </telerik:RadComboBox>                                
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td >
                                                                Jumlah Anak
                                                            </td>
                                                            <td >
                                                                <telerik:RadNumericTextBox ReadOnly="false" ID="txt_jumlah_anak" Width="70px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.NoOfDependents") %>' EnabledStyle-HorizontalAlign="Center"
                                                                    NumberFormat-DecimalDigits="0" >
                                                                    </telerik:RadNumericTextBox>
                                                            </td>
                                                        </tr>
                                                    </table>  
                                                </div>
                                            </div>
                                            <div style="width:15%; padding: 10px 10px 10px 10px; display:inline-block; vertical-align:top; 
                                                font-family:Verdana; font-size:12px; margin-top:7px;">  
                                                <table style="padding: 10px 0px 10px 10px">
                                                    <tr >
                                                        <td style="width:40px" >
                                                            POH 
                                                        </td>
                                                        <td>                                                                    
                                                            <telerik:RadComboBox RenderMode="Auto" ID="cb_poh" runat="server" Width="200px"
                                                                EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                                MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true"  
                                                                OnItemsRequested="cb_poh_ItemsRequested"
                                                                OnSelectedIndexChanged="cb_poh_SelectedIndexChanged" 
                                                                OnPreRender="cb_poh_PreRender"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.POHName") %>'>                                                                                                     
                                                            </telerik:RadComboBox>   
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            POO 
                                                        </td>
                                                        <td >
                                                            <telerik:RadComboBox RenderMode="Auto" ID="cb_poo" runat="server" Width="200px"
                                                                EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                                MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true"  
                                                                OnItemsRequested="cb_poo_ItemsRequested"
                                                                OnSelectedIndexChanged="cb_poo_SelectedIndexChanged" 
                                                                OnPreRender="cb_poo_PreRender"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.POOName") %>'>                                                                                                     
                                                            </telerik:RadComboBox>                                
                                                        </td>
                                                    </tr>                                                
                                                </table>
                                            </div>
                                        </div>    
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView2" Height="100%">
                                        <div style="height:300px; overflow:auto; padding:5px 5px 5px 5px; vertical-align:top; ">
                                            <div style="width:20%; padding: 10px 10px 10px 30px; display:inline-block; vertical-align:top; 
                                              font-family:Verdana; font-size:12px; margin-top:7px"> 
                                                Data Pribadi :
                                                <table style="padding: 10px 0px 10px 10px">
                                                    <tr >
                                                        <td style="width:140px">
                                                            Tempat Lahir 
                                                        </td>
                                                        <td>
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_tempat_lahir" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.BirthPlace") %>' >
                                                            </telerik:RadTextBox>  
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Tanggal Lahir
                                                        </td>
                                                        <td >
                                                            <telerik:RadDatePicker ID="dtp_tgl_lahir"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.BirthDate") %>' TabIndex="4" Skin="Glow"> 
                                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                </DateInput>                                                                        
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Jenis Kelamin
                                                        </td>
                                                        <td >
                                                            <telerik:RadComboBox RenderMode="Auto" ID="cb_jns_kelamin" runat="server" Width="150px"
                                                                EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.Gender") %>' 
                                                                OnItemsRequested="cb_jns_kelamin_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_jns_kelamin_SelectedIndexChanged"
                                                                OnPreRender="cb_jns_kelamin_PreRender" >                                                                                                     
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Agama
                                                        </td>
                                                        <td >
                                                            <telerik:RadComboBox RenderMode="Auto" ID="cb_agama" runat="server" Width="150px"
                                                                EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.ReligionName") %>' 
                                                                OnItemsRequested="cb_agama_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_agama_SelectedIndexChanged" 
                                                                OnPreRender="cb_agama_PreRender" >                                                                                                     
                                                            </telerik:RadComboBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            No. Telp 
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_telp" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.Phone1") %>' >
                                                            </telerik:RadTextBox>                                
                                                        </td>
                                                    </tr>                                                            
                                                    <tr>
                                                        <td >
                                                            Alamat Domisili 
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_domisili" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.Domicile") %>' >
                                                            </telerik:RadTextBox>                                
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Alamat KTP 
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_alamat_ktp" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.IdCardAddress") %>' >
                                                            </telerik:RadTextBox>                                
                                                        </td>
                                                    </tr>
                                                </table>             
                                            </div>
                                            <div style="width:25%; padding: 10px 10px 10px 10px; display:inline-block; vertical-align:top; 
                                                font-family:Verdana; font-size:12px; margin-top:7px;"> 
                                                <table style="padding: 10px 0px 10px 10px">                                             
                                                    <tr>
                                                        <td style="width: 150px">
                                                            No. HP 
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_no_hp" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.Hp1") %>' >
                                                            </telerik:RadTextBox>                                
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Email 
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_email" Width="200px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.Email") %>' >
                                                            </telerik:RadTextBox>                                
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Gol Darah 
                                                        </td>
                                                        <td >
                                                            <telerik:RadTextBox ReadOnly="false" ID="txt_gol_darah" Width="50px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.BloodType") %>' >
                                                            </telerik:RadTextBox>                                
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div>
                                                    Status Pernikahan :
                                                    <table style="padding: 10px 0px 10px 10px">
                                                    <tr >
                                                        <td style="width:150px">
                                                            Status 
                                                        </td>
                                                        <td>
                                                            <telerik:RadComboBox RenderMode="Auto" ID="cb_marital_status" runat="server" Width="150px"
                                                                EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.MaritalStatusName") %>' 
                                                                OnItemsRequested="cb_status_perkawinan_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_status_perkawinan_SelectedIndexChanged"
                                                                OnPreRender="cb_status_perkawinan_PreRender" >                                                                                                     
                                                            </telerik:RadComboBox> 
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Tgl. Menikah
                                                        </td>
                                                        <td >
                                                            <telerik:RadDatePicker ID="dtp_tgl_menikah"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.MarriedDate") %>' TabIndex="4" Skin="Glow"> 
                                                                <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                    EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                </DateInput>                                                                        
                                                            </telerik:RadDatePicker>
                                                        </td>
                                                    </tr>                                             
                                                </table>
                                                </div>
                                            </div>
                                            <div style="width:23%; padding: 10px 10px 10px 10px; display:inline-block; vertical-align:top; 
                                                font-family:Verdana; font-size:12px; margin-top:7px;"> 
                                                <div>
                                                    Kontak Darurat :
                                                    <table style="padding: 10px 0px 10px 10px">
                                                        <tr >
                                                            <td style="width:120px">
                                                                Nama Kontak 
                                                            </td>
                                                            <td>
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_nama_kontak" Width="250px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.EmergencyContactName") %>' >
                                                                    </telerik:RadTextBox>  
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td >
                                                                Jenis Hubungan
                                                            </td>
                                                            <td >
                                                                <%--<telerik:RadTextBox ReadOnly="false" ID="txt_jns_hub_emergency_contak" Width="250px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.EmergencyContactType") %>' >
                                                                    </telerik:RadTextBox>--%>
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_jns_hub_emergency_kontak" runat="server" Width="200px"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.EmergencyContactType") %>' 
                                                                    OnItemsRequested="cb_jenis_keluarga_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="CB_jns_hub_emergency_kontak_SelectedIndexChanged"
                                                                    OnPreRender="CB_jns_hub_emergency_kontak_PreRender" >                                                                                                     
                                                                </telerik:RadComboBox> 
                                                            </td>
                                                        </tr>   
                                                        <tr>
                                                            <td >
                                                                Alamat Kontak 
                                                            </td>
                                                            <td >
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_alamat_kontak_darurat" Width="250px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.EmergencyContactAddress") %>' >
                                                                    </telerik:RadTextBox>                                
                                                            </td>
                                                        </tr>  
                                                       
                                                        <tr>
                                                            <td >
                                                                No. Telp 
                                                            </td>
                                                            <td >
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_tlp_kontak_darurat" Width="250px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.EmergencyContactPhone1") %>' >
                                                                    </telerik:RadTextBox>                                
                                                            </td>
                                                        </tr>  
                                                    </table>
                                                </div>
                                            
                                            </div>
                                            <div style="width:15%; padding: 10px 10px 10px 10px; display:inline-block; vertical-align:top; 
                                                font-family:Verdana; font-size:12px; margin-top:7px;">
                                                 <div>
                                                    Ukuran Pakaian :
                                                    <table style="padding: 10px 0px 10px 10px">                                                       
                                                        <tr>
                                                            <td style="width:120px">
                                                                Ukuran Baju 
                                                            </td>
                                                            <td>                                                                    
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_ukuran_baju" Width="100px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.ShoeSize") %>' >
                                                            </telerik:RadTextBox>    
                                                            </td>
                                                        </tr>                                                            
                                                        <tr>
                                                            <td >
                                                                Ukuran Sepatu 
                                                            </td>
                                                            <td >                                                                                                                                
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_ukuran_sepatu" Width="100px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.ClothSize") %>' >  
                                                                </telerik:RadTextBox>                              
                                                            </td>
                                                        </tr>
                                                    </table>  
                                                </div>
                                            
                                            </div>
                                        </div>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView3" Height="100%">
                                        <div style="height:300px; overflow:auto; padding:5px 5px 5px 5px; vertical-align:top; ">
                                            <h5>Keluarga :</h5>                                            
                                            <telerik:RadGrid  RenderMode="Auto" ID="rg_family"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Glow" 
                                                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="10" CssClass="RadGrid_ModernBrowsers"
                                                OnNeedDataSource="rg_family_NeedDataSource"
                                                OnDeleteCommand="rg_family_DeleteCommand" 
                                                OnInsertCommand="rg_family_InsertCommand" 
                                                OnUpdateCommand="rg_family_UpdateCommand">
                                                <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                                                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                                                <AlternatingItemStyle Font-Names="Tahoma" Font-Size="11px" ForeColor="YellowGreen" />
                                                <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                                                <ItemStyle Font-Names="Tahoma" Font-Size="11px" ForeColor="YellowGreen" />
                                                <SelectedItemStyle Font-Italic="False"/>
                                                <SortingSettings EnableSkinSortStyles="false" />
                                                <MasterTableView CommandItemDisplay="Top" Font-Size="11px" ClientDataKeyNames="ID" Font-Names="Tahoma" DataKeyNames="EmployeeNo,FamilyName" 
                                                    EditMode="InPlace" EditFormSettings-PopUpSettings-Modal="true" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" 
                                                    AllowFilteringByColumn="false" CommandItemSettings-ShowAddNewRecordButton="true" 
                                                    CommandItemSettings-ShowRefreshButton="false" > 
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn" ItemStyle-Width="70px" 
                                                            HeaderStyle-Width="40px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                                        </telerik:GridEditCommandColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Nama" HeaderStyle-Width="135px" ItemStyle-Width="225px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>                                                                    
                                                                <telerik:RadLabel runat="server" ID="lbl_nama_keluarga" Width="225px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "FamilyName") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox runat="server" ID="txt_nama_keluarga_edit_temp" Skin="Glow" Width="250px"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "FamilyName") %>'></telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadTextBox runat="server" ID="txt_nama_keluarga_insert_temp" Width="220" Skin="Glow"></telerik:RadTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Hubungan" HeaderStyle-Width="145px" ItemStyle-Width="125px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <telerik:RadLabel runat="server" ID="lbl_jenis_keluarga" Width="125px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "FamilyTypeName") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_jenis_keluarga_edit_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow" Text='<%# DataBinder.Eval(Container.DataItem, "FamilyTypeName") %>'                                                                   
                                                                    HighlightTemplatedItems="true" Width="125px"
                                                                    OnItemsRequested="cb_jenis_keluarga_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jenis_keluarga_edit_temp_SelectedIndexChanged" 
                                                                    OnPreRender="cb_jenis_keluarga_edit_temp_PreRender" >  
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_jenis_keluarga_insert_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"
                                                                    HighlightTemplatedItems="true" Width="125px"
                                                                    OnItemsRequested="cb_jenis_keluarga_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jenis_keluarga_insert_temp_SelectedIndexChanged">  
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Jenis Kelamin" HeaderStyle-Width="145px" ItemStyle-Width="125px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                                    
                                                                <telerik:RadLabel runat="server" ID="lbl_jenis_kelamin" Width="75px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "Gendre") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_jns_kelamin_edit_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow" Text='<%# DataBinder.Eval(Container.DataItem, "Gendre") %>'                                                                   
                                                                    HighlightTemplatedItems="true" Width="125px"
                                                                    OnItemsRequested="cb_jns_kelamin_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jns_kelamin_edit_temp_SelectedIndexChanged" >  
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_jns_kelamin_insert_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"
                                                                    HighlightTemplatedItems="true" Width="125px"
                                                                    OnItemsRequested="cb_jns_kelamin_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jns_kelamin_insert_temp_SelectedIndexChanged">  
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Tgl lahir" HeaderStyle-Width="125px" ItemStyle-Width="105px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <telerik:RadLabel runat="server" ID="lbl_tgl_lahir" Width="105px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "FamilyBirthDate","{0:dd/MM/yyyy}") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadDatePicker ID="dtp_tgl_lahir_edit_temp" runat="server" MinDate="1/1/1900" Width="105px" RenderMode="Auto"
                                                                    TabIndex="4" Skin="Glow" DbSelectedDate='<%# DataBinder.Eval(Container.DataItem, "FamilyBirthDate") %>' > 
                                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" Skin="Glow" LabelWidth="40%">                            
                                                                    </DateInput>                        
                                                                </telerik:RadDatePicker>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadDatePicker ID="dtp_tgl_lahir_insert_temp" runat="server" MinDate="1/1/1900" Width="105px" RenderMode="Auto"
                                                                    TabIndex="4" Skin="Glow" > 
                                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                    <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" Skin="Glow" LabelWidth="40%">                            
                                                                    </DateInput>                        
                                                                </telerik:RadDatePicker>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Keterangan" HeaderStyle-Width="300px" ItemStyle-Width="360px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>                                            
                                                                <telerik:RadLabel runat="server" ID="lbl_keterangan" Width="360px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "Remark") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox runat="server" ID="txt_keterangan_edit_temp" Skin="Glow" Width="360px"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "Remark") %>'></telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadTextBox runat="server" ID="txt_keterangan_insert_temp" Skin="Glow" Width="360px"></telerik:RadTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" ItemStyle-ForeColor="OrangeRed"
                                                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                                                            <HeaderStyle Width="30px"></HeaderStyle>
                                                        </telerik:GridButtonColumn>           
                                                    </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="190" />
                                                        <ClientEvents OnRowDblClick="rowDblClick"/>
                                                    </ClientSettings>
                                                </telerik:RadGrid>             
                                        </div>                                        
                                        
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView4" Height="100%">
                                        <div style="height:300px; overflow:auto; padding:5px 5px 5px 5px; vertical-align:top; ">
                                            <div style="width:27%; padding: 5px 10px 10px 30px; display:inline-block; vertical-align:top; 
                                              font-family:Verdana; font-size:12px; margin-top:7px"> 
                                                Lokasi:
                                                <table style="padding: 10px 0px 10px 10px">                                             
                                                    <tr>
                                                        <td style="width: 100px">
                                                            Costing 
                                                        </td>
                                                        <td >
                                                            <telerik:RadComboBox RenderMode="Auto" ID="cb_costing" runat="server" Width="300px"
                                                                EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.costingName") %>' 
                                                                OnItemsRequested="cb_lokasi_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_costing_SelectedIndexChanged"
                                                                OnPreRender="cb_costing_PreRender" >                                                                                                     
                                                            </telerik:RadComboBox>                                
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Actual 
                                                        </td>
                                                        <td >
                                                            <telerik:RadComboBox RenderMode="Auto" ID="cb_actual" runat="server" Width="300px"
                                                                EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.LocationName") %>' 
                                                                OnItemsRequested="cb_lokasi_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_actual_SelectedIndexChanged"
                                                                OnPreRender="cb_actual_PreRender" >                                                                                                     
                                                            </telerik:RadComboBox>                               
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div>
                                                    Organisasi:
                                                    <table style="padding: 10px 0px 10px 10px">                                             
                                                        <tr>
                                                            <td style="width: 100px">
                                                                Divisi 
                                                            </td>
                                                            <td >
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_divisi" runat="server" Width="300px"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.DivisionName") %>' 
                                                                    OnItemsRequested="cb_divisi_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_divisi_SelectedIndexChanged"
                                                                    OnPreRender="cb_divisi_PreRender" >                                                                                                     
                                                                </telerik:RadComboBox>                                
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td >
                                                                Department 
                                                            </td>
                                                            <td >
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_department" runat="server" Width="300px"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.DepartmentName") %>' 
                                                                    OnItemsRequested="cb_department_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_department_SelectedIndexChanged"
                                                                    OnPreRender="cb_department_PreRender" >                                                                                                     
                                                                </telerik:RadComboBox>                               
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td >
                                                                Section
                                                            </td>
                                                            <td >
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_section" runat="server" Width="300px"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.SubDepartmentName") %>' 
                                                                    OnItemsRequested="cb_department_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_section_SelectedIndexChanged"
                                                                    OnPreRender="cb_section_PreRender" >                                                                                                     
                                                                </telerik:RadComboBox>                               
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                
                                            </div>
                                            <div style="width:25%; padding: 10px 10px 10px 30px; display:inline-block; vertical-align:top; 
                                              font-family:Verdana; font-size:12px; margin-top:7px"> 
                                                Jabatan :
                                                <table style="padding: 5px 0px 10px 10px">                                             
                                                    <tr>
                                                        <td style="width: 150px">
                                                            Posisi 
                                                        </td>
                                                        <td >
                                                            <telerik:RadComboBox RenderMode="Auto" ID="cb_posisi" runat="server" Width="300px"
                                                                EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.PositionName") %>' 
                                                                OnItemsRequested="cb_posisi_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_posisi_SelectedIndexChanged"
                                                                OnPreRender="cb_posisi_PreRender" >
                                                            </telerik:RadComboBox>                                
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td >
                                                            Assign 
                                                        </td>
                                                        <td >
                                                            <telerik:RadComboBox RenderMode="Auto" ID="cb_posisi_assign" runat="server" Width="300px"
                                                                EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.AssignPositionName") %>' 
                                                                OnItemsRequested="cb_posisi_ItemsRequested" 
                                                                OnSelectedIndexChanged="cb_posisi_assign_SelectedIndexChanged"
                                                                OnPreRender="cb_posisi_assign_PreRender" >                                                                                                     
                                                            </telerik:RadComboBox>                               
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div>
                                                    Pangkat:
                                                    <table style="padding: 10px 0px 10px 10px">                                             
                                                        <tr>
                                                            <td style="width: 100px">
                                                                Kategori 
                                                            </td>
                                                            <td >
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_kategori_pangkat" runat="server" Width="150px"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeCategoryName") %>' 
                                                                    OnItemsRequested="cb_kategori_pangkat_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_kategori_pangkat_SelectedIndexChanged"
                                                                    OnPreRender="cb_kategori_pangkat_PreRender" >                                                                                                     
                                                                </telerik:RadComboBox>                                
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td >
                                                                Golongan 
                                                            </td>
                                                            <td >
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_golongan" runat="server" Width="150px"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" Height="90px"
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.GradeCode") %>' 
                                                                    OnItemsRequested="cb_golongan_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_golongan_SelectedIndexChanged"
                                                                    OnPreRender="cb_golongan_PreRender" >                                                                                                     
                                                                </telerik:RadComboBox>                               
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td >
                                                                Sub Golongan 
                                                            </td>
                                                            <td >
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_sub_golongan" runat="server" Width="150px"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                    Text='<%# DataBinder.Eval(Container, "DataItem.SubGradeName") %>' 
                                                                    OnItemsRequested="cb_sub_golongan_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_sub_golongan_SelectedIndexChanged"
                                                                    OnPreRender="cb_sub_golongan_PreRender" >                                                                                                     
                                                                </telerik:RadComboBox>                               
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 100px" >
                                                                Kode Unit 
                                                            </td>
                                                            <td>
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_kode_unit" Width="150px" runat="server" Skin="Glow"
                                                                Text='<%# DataBinder.Eval(Container, "DataItem.UnitCode") %>' >
                                                                </telerik:RadTextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                
                                            </div>
                                            

                                            <div style="width:37%; padding: 0px 10px 10px 30px; display:inline-block; vertical-align:top; 
                                              font-family:Verdana; font-size:12px; margin-top: 0px"> 
                                                <h5>Pergerakan karyawan : </h5>
                                                <telerik:RadGrid  RenderMode="Auto" ID="rg_pergerakan_karyawan"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Glow" 
                                                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="5" CssClass="RadGrid_ModernBrowsers"
                                                OnNeedDataSource="rg_pergerakan_karyawan_NeedDataSource"
                                                OnDeleteCommand="rg_pergerakan_karyawan_DeleteCommand">
                                                <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                                                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                                                <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                                                <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                                                <ItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                                                <SelectedItemStyle Font-Italic="False"/>
                                                <SortingSettings EnableSkinSortStyles="false" />
                                                <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Tahoma" 
                                                    EditMode="EditForms" EditFormSettings-PopUpSettings-Modal="true" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" 
                                                    AllowFilteringByColumn="false" CommandItemSettings-ShowAddNewRecordButton="false" CommandItemSettings-ShowRefreshButton="false" > 
                                                    <Columns>
                                                        <%--<telerik:GridEditCommandColumn UniqueName="EditCommandColumn" ItemStyle-Width="70px" 
                                                            HeaderStyle-Width="40px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                                        </telerik:GridEditCommandColumn>--%>
                                                        <telerik:GridTemplateColumn HeaderText="Tanggal" HeaderStyle-Width="90px" ItemStyle-Width="90px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                            
                                                                <telerik:RadLabel runat="server" ID="lbl_tanggal_pergerakan_temp" Width="90px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "EaDate","{0:dd/MM/yyyy}") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadDatePicker ID="dtp_tanggal_pergerakan_edit_temp" runat="server" MinDate="1/1/1900" Width="90px" RenderMode="Auto"
                                                                    Skin="Glow" DbSelectedDate='<%# DataBinder.Eval(Container.DataItem, "EaDate") %>' > 
                                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                    <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" Skin="Glow" LabelWidth="40%">                            
                                                                    </DateInput>                        
                                                                </telerik:RadDatePicker>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadDatePicker ID="dtp_tanggal_pergerakan_insert_temp" runat="server" MinDate="1/1/1900" Width="90px" 
                                                                    RenderMode="Auto" Skin="Glow" > 
                                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                    <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" Skin="Glow" LabelWidth="40%">                            
                                                                    </DateInput>                        
                                                                </telerik:RadDatePicker>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Jabatan" HeaderStyle-Width="135px" ItemStyle-Width="125px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                                    
                                                                <asp:Label runat="server" ID="lbl_jabatan_temp" Width="125px" 
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "PositionName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_jabatan_edit_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"                                                                    
                                                                    HighlightTemplatedItems="true" Width="125px"
                                                                    OnItemsRequested="cb_jabatan_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jabatan_temp_SelectedIndexChanged"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "PositionName") %>' >  
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_jabatan_insert_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"
                                                                    HighlightTemplatedItems="true" Width="125px"
                                                                    OnItemsRequested="cb_jabatan_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jabatan_temp_SelectedIndexChanged">  
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Golongan" HeaderStyle-Width="75px" ItemStyle-Width="65px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                                    
                                                                <asp:Label runat="server" ID="lbl_golongan_temp" Width="65px" 
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "GradeCode") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_golongan_edit_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"                                                                    
                                                                    HighlightTemplatedItems="true" Width="65px"
                                                                    OnItemsRequested="cb_jabatan_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jabatan_temp_SelectedIndexChanged"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "GradeCode") %>' >  
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_golongan_insert_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"
                                                                    HighlightTemplatedItems="true" Width="65px"
                                                                    OnItemsRequested="cb_jabatan_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jabatan_temp_SelectedIndexChanged">  
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Sub Gol" HeaderStyle-Width="95px" ItemStyle-Width="85px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                                    
                                                                <asp:Label runat="server" ID="lbl_sub_golongan_temp" Width="85px" 
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "SubGradeCode") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_sub_golongan_edit_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"                                                                    
                                                                    HighlightTemplatedItems="true" Width="85px"
                                                                    OnItemsRequested="cb_jabatan_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jabatan_temp_SelectedIndexChanged"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "SubGradeCode") %>'>  
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_sub_golongan_insert_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"
                                                                    HighlightTemplatedItems="true" Width="85px"
                                                                    OnItemsRequested="cb_jabatan_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jabatan_temp_SelectedIndexChanged">  
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Lokasi" HeaderStyle-Width="150px" ItemStyle-Width="140px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                                    
                                                                <asp:Label runat="server" ID="lbl_lokasi_temp" Width="140px"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "LocationName") %>' ></asp:Label>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_lokasi_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"                                                                    
                                                                    HighlightTemplatedItems="true" Width="140px"
                                                                    OnItemsRequested="cb_jabatan_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jabatan_temp_SelectedIndexChanged"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "LocationName") %>' >  
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_lokasi_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"
                                                                    HighlightTemplatedItems="true" Width="140px"
                                                                    OnItemsRequested="cb_jabatan_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jabatan_temp_SelectedIndexChanged">  
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="190" />
                                                        <ClientEvents OnRowDblClick="rowDblClick"/>
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </div>
                                        </div>      
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView5" Height="100%" >
                                        <div style=" height: 300px; overflow: auto; padding: 5px 5px 5px 5px; vertical-align: top">                  
                                            <div style="width:98%; padding: 0px 10px 5px 10px; display:inline-block; vertical-align:top; 
                                                font-family:Verdana; font-size:12px; margin-top:0px"> 
                                                <h5>Pendidikan Formal :</h5>
                                                <telerik:RadGrid  RenderMode="Auto" ID="rg_pendidikan"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Glow" 
                                                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="5" CssClass="RadGrid_ModernBrowsers"
                                                OnNeedDataSource="rg_pendidikan_NeedDataSource" 
                                                    OnItemCommand="rg_pendidikan_ItemCommand"
                                                    OnDeleteCommand="rg_pendidikan_DeleteCommand" 
                                                    OnInsertCommand="rg_pendidikan_InsertCommand" 
                                                    OnUpdateCommand="rg_pendidikan_UpdateCommand" >
                                                <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                                                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                                                <AlternatingItemStyle Font-Names="Tahoma" Font-Size="11px" ForeColor="YellowGreen" />
                                                <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                                                <ItemStyle Font-Names="Tahoma" Font-Size="11px" ForeColor="YellowGreen" />
                                                <SelectedItemStyle Font-Italic="False"/>
                                                <SortingSettings EnableSkinSortStyles="false" />
                                                <MasterTableView CommandItemDisplay="Top" Font-Size="11px" Font-Names="Tahoma" DataKeyNames="ID" 
                                                    EditMode="InPlace" EditFormSettings-PopUpSettings-Modal="true" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" 
                                                    AllowFilteringByColumn="false" CommandItemSettings-ShowAddNewRecordButton="true" 
                                                    CommandItemSettings-ShowRefreshButton="false" > 
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn" ItemStyle-Width="70px" 
                                                            HeaderStyle-Width="40px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                                        </telerik:GridEditCommandColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Jenjang" HeaderStyle-Width="85px" ItemStyle-Width="85px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate> 
                                                                <telerik:RadLabel runat="server" ID="lbl_jenjang_temp" Width="85px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "EducationDescription") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_jenjang_edit_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow" Text='<%# DataBinder.Eval(Container.DataItem, "EducationDescription") %>'                                                                   
                                                                    HighlightTemplatedItems="true" Width="85px"
                                                                    OnItemsRequested="cb_jenjang_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jenjang_temp_SelectedIndexChanged" 
                                                                    OnPreRender="cb_jenjang_temp_PreRender">  
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_jenjang_insert_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"
                                                                    HighlightTemplatedItems="true" Width="85px"
                                                                    OnItemsRequested="cb_jenjang_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jabatan_temp_SelectedIndexChanged" 
                                                                    OnPreRender="cb_jenjang_temp_PreRender">  
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Jurusan" HeaderStyle-Width="205px" ItemStyle-Width="205px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <telerik:RadLabel runat="server" ID="lbl_jurusan_temp" Width="205px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "MajorName") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <%--<telerik:RadTextBox ReadOnly="false" ID="txt_jurusan_edit_temp" Width="205px" runat="server" Skin="Glow"
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "MajorName") %>' >
                                                                </telerik:RadTextBox> --%>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_jurusan_edit_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow" Text='<%# DataBinder.Eval(Container.DataItem, "MajorName") %>'                                                                   
                                                                    HighlightTemplatedItems="true" Width="205px"
                                                                    OnItemsRequested="cb_jurusan_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jurusan_edit_temp_SelectedIndexChanged" 
                                                                    OnPreRender="cb_jurusan_temp_PreRender">  
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <%--<telerik:RadTextBox ReadOnly="false" ID="txt_jurusan_insert_temp" Width="205px" runat="server" Skin="Glow" >
                                                                </telerik:RadTextBox> --%>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_jurusan_insert_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"                                                                 
                                                                    HighlightTemplatedItems="true" Width="205px"
                                                                    OnItemsRequested="cb_jurusan_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_jurusan_insert_temp_SelectedIndexChanged" 
                                                                    OnPreRender="cb_jurusan_temp_PreRender">  
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Lembaga" HeaderStyle-Width="225px" ItemStyle-Width="225px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <telerik:RadLabel runat="server" ID="lbl_lembaga_temp" Width="225px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "InstitutionName") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_lembaga_edit_temp" Width="225px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "InstitutionName") %>'  >
                                                                </telerik:RadTextBox> 
                                                                
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_lembaga_insert_temp" Width="225px" runat="server" Skin="Glow">
                                                                </telerik:RadTextBox>
                                                                
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Kota" HeaderStyle-Width="250px" ItemStyle-Width="240px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate> 
                                                                <telerik:RadLabel runat="server" ID="lbl_kota_temp" Width="240px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "CityName") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_kota_edit_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow" Text='<%# DataBinder.Eval(Container.DataItem, "CityName") %>'                                                                   
                                                                    HighlightTemplatedItems="true" Width="240px"
                                                                    OnItemsRequested="cb_kota_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_kota_edit_temp_SelectedIndexChanged" 
                                                                    OnPreRender="cb_kota_temp_PreRender">  
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_kota_insert_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"
                                                                    HighlightTemplatedItems="true" Width="240px"
                                                                    OnItemsRequested="cb_kota_ItemsRequested"
                                                                    OnSelectedIndexChanged="cb_kota_insert_temp_SelectedIndexChanged" 
                                                                    OnPreRender="cb_kota_temp_PreRender">  
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Status" HeaderStyle-Width="120px" ItemStyle-Width="110px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <telerik:RadLabel runat="server" ID="lbl_status_temp" Width="110px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "EducationStatusDescription") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_status_edit_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow" Text='<%# DataBinder.Eval(Container.DataItem, "EducationStatusDescription") %>'                                                                   
                                                                    HighlightTemplatedItems="true" Width="110px"
                                                                    OnItemsRequested="cb_status_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_status_edit_temp_SelectedIndexChanged" 
                                                                    OnPreRender="cb_status_temp_PreRender">  
                                                                </telerik:RadComboBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadComboBox RenderMode="Auto" runat="server" ID="cb_status_insert_temp" EnableLoadOnDemand="True" 
                                                                    AutoPostBack="true" Skin="Glow"
                                                                    HighlightTemplatedItems="true" Width="110px"
                                                                    OnItemsRequested="cb_status_temp_ItemsRequested" 
                                                                    OnSelectedIndexChanged="cb_status_insert_temp_SelectedIndexChanged" 
                                                                    OnPreRender="cb_status_temp_PreRender">  
                                                                </telerik:RadComboBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>                                                        
                                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" ItemStyle-ForeColor="OrangeRed"
                                                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                                                            <HeaderStyle Width="30px"></HeaderStyle>
                                                        </telerik:GridButtonColumn>  
                                                    </Columns>
                                                    </MasterTableView>
                                                    <ClientSettings>
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="190" />
                                                        <ClientEvents OnRowDblClick="rowDblClick"/>
                                                    </ClientSettings>
                                                </telerik:RadGrid>
                                            </div>
                                        </div>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView6" Height="100%" >
                                        <div style="height: 300px; overflow: auto; padding: 5px 5px 5px 5px; vertical-align:top; "> 
                                            <div style="width:45%; padding: 0px 10px 10px 30px; display:inline-block; vertical-align:top; 
                                                font-family:Verdana; font-size:12px; margin-top:0px"> 
                                                
                                                <h4>Training :</h4>
                                                <telerik:RadGrid  RenderMode="Auto" ID="rg_training"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Glow" 
                                                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="5" CssClass="RadGrid_ModernBrowsers"
                                                OnNeedDataSource="rg_training_NeedDataSource"
                                                OnDeleteCommand="rg_training_DeleteCommand" 
                                                    OnInsertCommand="rg_training_InsertCommand" 
                                                    OnUpdateCommand="rg_training_UpdateCommand" >
                                                <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                                                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" 
                                                    EnableAlternatingItems="false"/>
                                                <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                                                <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="false" ForeColor="DarkOrange"/> 
                                                <ItemStyle Font-Names="Tahoma" Font-Size="11px" ForeColor="YellowGreen" />
                                                <SelectedItemStyle Font-Italic="False"/>
                                                <SortingSettings EnableSkinSortStyles="false" />
                                                <MasterTableView CommandItemDisplay="Top" Font-Size="11px" Font-Names="Tahoma" DataKeyNames="EmployeeNo,ID" 
                                                    EditMode="InPlace" EditFormSettings-PopUpSettings-Modal="true" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" 
                                                    AllowFilteringByColumn="false" CommandItemSettings-ShowAddNewRecordButton="true"  
                                                    CommandItemSettings-ShowRefreshButton="false" > 
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn" ItemStyle-Width="80px" 
                                                            HeaderStyle-Width="40px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                                        </telerik:GridEditCommandColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Training Ke" HeaderStyle-Width="80px" ItemStyle-Width="70px"
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>          
                                                                <telerik:RadLabel runat="server" ID="lbl_training_ke_temp" Width="70px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "TrainingNo") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="txt_training_ke_edit_temp" Width="70px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "TrainingNo") %>' >
                                                                </telerik:RadTextBox> 
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadTextBox ID="txt_training_ke_insert_temp" Width="70px" runat="server" Skin="Glow">
                                                                </telerik:RadTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Nama Training" HeaderStyle-Width="225px" ItemStyle-Width="225px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                          
                                                                <telerik:RadLabel runat="server" ID="lbl_nama_training_temp" Width="225px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "TrainingName") %>' ></telerik:RadLabel> 
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_nama_training_edit_temp" Width="225px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "TrainingName") %>' >
                                                                </telerik:RadTextBox> 
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadTextBox ReadOnly="false" ID="txt_nama_training_insert_temp" Width="225px" runat="server" Skin="Glow" >
                                                                </telerik:RadTextBox> 
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Lembaga" HeaderStyle-Width="225px" ItemStyle-Width="215px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                     
                                                                <telerik:RadLabel runat="server" ID="lbl_lembaga_training_temp" Width="225px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "InstitutionName") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="txt_lembaga_training_edit_temp" Width="225px" runat="server" Skin="Glow"
                                                                     Text='<%# DataBinder.Eval(Container.DataItem, "InstitutionName") %>' >
                                                                </telerik:RadTextBox> 
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadTextBox ID="txt_lembaga_training_insert_temp" Width="225px" runat="server" Skin="Glow" >
                                                                </telerik:RadTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Tanggal" HeaderStyle-Width="110px" ItemStyle-Width="100px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                      
                                                                <telerik:RadLabel runat="server" ID="lbl_tanggal_training_temp" Width="100px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "TrainingDate","{0:dd/MM/yyyy}") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadDatePicker ID="dtp_tanggal_training_edit_temp" runat="server" MinDate="1/1/1900" Width="100px" RenderMode="Auto"
                                                                    TabIndex="4" Skin="Glow" DbSelectedDate='<%# DataBinder.Eval(Container.DataItem, "TrainingDate") %>' > 
                                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                    <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" Skin="Glow" LabelWidth="40%">                            
                                                                    </DateInput>                        
                                                                </telerik:RadDatePicker>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadDatePicker ID="dtp_tanggal_training_insert_temp" runat="server" MinDate="1/1/1900" Width="100px" RenderMode="Auto"
                                                                    TabIndex="4" Skin="Glow" > 
                                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                    <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" Skin="Glow" LabelWidth="40%">                            
                                                                    </DateInput>                        
                                                                </telerik:RadDatePicker>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" ItemStyle-ForeColor="OrangeRed"
                                                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                                                            <HeaderStyle Width="30px"></HeaderStyle>
                                                        </telerik:GridButtonColumn>  
                                                        
                                                    </Columns>
                                                    </MasterTableView>
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="190" />
                                                    <ClientEvents OnRowDblClick="rowDblClick"/>
                                                </ClientSettings>
                                                </telerik:RadGrid>
                                                
                                            </div>
                                            <div style="width:50%; padding: 0px 0px 10px 0px; display:inline-block; vertical-align:top; 
                                                font-family:Verdana; font-size:12px; margin-top:0px"> 

                                                <h4>Lisensi :</h4>
                                                <telerik:RadGrid  RenderMode="Auto" ID="rg_lisensi"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Glow" 
                                                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="5" CssClass="RadGrid_ModernBrowsers"
                                                OnNeedDataSource="rg_lisensi_NeedDataSource"
                                                OnDeleteCommand="rg_lisensi_DeleteCommand" 
                                                    OnInsertCommand="rg_lisensi_InsertCommand" 
                                                    OnUpdateCommand="rg_lisensi_UpdateCommand">
                                                <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                                                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                                                <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                                                <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="false" ForeColor="DarkOrange"/> 
                                                <ItemStyle Font-Names="Tahoma" Font-Size="11px" ForeColor="YellowGreen" />
                                                <SelectedItemStyle Font-Italic="False"/>
                                                <SortingSettings EnableSkinSortStyles="false" />
                                                <MasterTableView CommandItemDisplay="Top" Font-Size="11px" Font-Names="Tahoma" DataKeyNames="EmployeeNo,ID" 
                                                    EditMode="InPlace" EditFormSettings-PopUpSettings-Modal="true" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" 
                                                    AllowFilteringByColumn="false" CommandItemSettings-ShowAddNewRecordButton="true" CommandItemSettings-ShowRefreshButton="false" > 
                                                    <Columns>
                                                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn" ItemStyle-Width="40px" 
                                                            HeaderStyle-Width="40px" UpdateText="Update" HeaderStyle-HorizontalAlign="Center">
                                                        </telerik:GridEditCommandColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Lisensi Ke" HeaderStyle-Width="80px" ItemStyle-Width="65px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                                    
                                                                <telerik:RadLabel runat="server" ID="lbl_lisensi_ke_temp" Width="65px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "LicenseNo") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="txt_lisensi_ke_edit_temp" Width="65px" runat="server" Skin="Glow"
                                                                     Text='<%# DataBinder.Eval(Container.DataItem, "LicenseNo") %>' >
                                                                </telerik:RadTextBox> 
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadTextBox ID="txt_lisensi_ke_insert_temp" Width="65px" runat="server" Skin="Glow">
                                                                </telerik:RadTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Nama Lisensi" HeaderStyle-Width="215px" ItemStyle-Width="215px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <telerik:RadLabel runat="server" ID="lbl_nama_lisensi_temp" Width="215px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "LicenseName") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="txt_nama_lisensi_edit_temp" Width="215px" runat="server" Skin="Glow"
                                                                     Text='<%# DataBinder.Eval(Container.DataItem, "LicenseName") %>' >
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <telerik:RadTextBox ID="txt_nama_lisensi_insert_temp" Width="225px" runat="server" Skin="Glow" >
                                                                </telerik:RadTextBox> 
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Lembaga" HeaderStyle-Width="205px" ItemStyle-Width="205px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <telerik:RadLabel runat="server" ID="txt_lembaga_lisensi_edit_temp" Width="205px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "InstitutionName") %>' ></telerik:RadLabel> 
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="txt_lembaga_lisensi_edit_temp" Width="205px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "InstitutionName") %>'>
                                                                </telerik:RadTextBox> 
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadTextBox ID="txt_lembaga_lisensi_insert_temp" Width="205px" runat="server" Skin="Glow">
                                                                </telerik:RadTextBox>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Tanggal" HeaderStyle-Width="110px" ItemStyle-Width="110px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                            
                                                                <telerik:RadLabel runat="server" ID="lbl_tanggal_lisensi_temp" Width="110px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "LicenseDate","{0:dd/MM/yyyy}") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadDatePicker ID="dtp_tanggal_lisensi_edit_temp" runat="server" MinDate="1/1/1900" Width="100px" RenderMode="Auto"
                                                                    Skin="Glow" DbSelectedDate='<%# DataBinder.Eval(Container.DataItem, "LicenseDate") %>' > 
                                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                    <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" Skin="Glow" LabelWidth="40%">                            
                                                                    </DateInput>                        
                                                                </telerik:RadDatePicker>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>                                                                  
                                                                <telerik:RadDatePicker ID="dtp_tanggal_lisensi_insert_temp" runat="server" MinDate="1/1/1900" Width="100px" 
                                                                    RenderMode="Auto" Skin="Glow" > 
                                                                    <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                        EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                    <DateInput runat="server" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" Skin="Glow" LabelWidth="40%">                            
                                                                    </DateInput>                        
                                                                </telerik:RadDatePicker>
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="No Lisensi" HeaderStyle-Width="100px" ItemStyle-Width="100px" 
                                                            HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>                                                                    
                                                                <telerik:RadLabel runat="server" ID="lbl_no_lisensi_temp" Width="100px" Skin="Glow" 
                                                                   Text='<%# DataBinder.Eval(Container.DataItem, "LicenseCode") %>' ></telerik:RadLabel>
                                                            </ItemTemplate>
                                                            <EditItemTemplate>
                                                                <telerik:RadTextBox ID="txt_no_lisensi_edit_temp" Width="100px" runat="server" Skin="Glow"
                                                                    Text='<%# DataBinder.Eval(Container.DataItem, "LicenseCode") %>'>
                                                                </telerik:RadTextBox>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate> 
                                                                <telerik:RadTextBox ID="txt_no_lisensi_insert_temp" Width="100px" runat="server" Skin="Glow">
                                                                </telerik:RadTextBox>  
                                                            </InsertItemTemplate>
                                                        </telerik:GridTemplateColumn>                                                        
                                                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" ItemStyle-ForeColor="OrangeRed"
                                                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                                                            <HeaderStyle Width="30px"></HeaderStyle>
                                                        </telerik:GridButtonColumn>  
                                                    </Columns>
                                                    </MasterTableView>
                                                <ClientSettings>
                                                    <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="190" />
                                                    <ClientEvents OnRowDblClick="rowDblClick"/>
                                                </ClientSettings>
                                                </telerik:RadGrid>
                                            </div>
                                        </div>
                                    </telerik:RadPageView>
                                </telerik:RadMultiPage>
                            </div>
                        </FormTemplate>
                    </EditFormSettings>
                </MasterTableView>
                <ClientSettings>                         
                    <Selecting AllowRowSelect="true"></Selecting>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
        
        <telerik:RadWindowManager RenderMode="Auto" ID="RadWindowManager1" runat="server" EnableShadow="true">
            <Windows>
                <telerik:RadWindow RenderMode="Auto" ID="PreviewDialog" runat="server"  ReloadOnShow="false" ShowContentDuringLoad="false"
                  Width="1150px" Height="670px" Modal="true">
                </telerik:RadWindow>

            </Windows>
        </telerik:RadWindowManager>
    </div>
</asp:Content>
