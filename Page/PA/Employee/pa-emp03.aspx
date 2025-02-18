<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="pa-emp03.aspx.cs" Inherits="PRIMA_HRIS.Page.PA.Employee.pa_emp03" %>
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
                                OnSelectedIndexChanged="cb_status_prm_SelectedIndexChanged"
                                  OnItemsRequested="cb_status_prm_ItemsRequested"     
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
                    <telerik:RadButton RenderMode="Auto" ID="btn_add" Skin="Glow" Enabled="true" AutoPostBack="true" BorderColor="Orange" OnClick="btn_add_Click"
                        runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbAdd" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 7px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_filter" Skin="Glow" Enabled="true" AutoPostBack="false" BorderColor="Orange" 
                        OnClientClicked ="openWinFiterTemplate" 
                        runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbSearch" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_refresh" Skin="Glow" AutoPostBack="true"
                        Enabled="false" runat="server" Width="30px" Height="30px" >
                        <Icon PrimaryIconCssClass="rbRefresh" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_upload" Skin="Glow" AutoPostBack="false"
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
                OnItemCommand="RadGrid1_ItemCommand">
                <PagerStyle Mode="NumericPages" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
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
                        <telerik:GridBoundColumn UniqueName="trCode" HeaderText="Kode" DataField="trCode"
                            ItemStyle-Width="80px" FilterControlWidth="80">
                            <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="trDate" HeaderText="Tanggal" DataField="trDate" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="90px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="EmployeeNo" HeaderText="NIK" DataField="EmployeeNo"
                            ItemStyle-Width="80px" FilterControlWidth="80">
                            <HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="EmployeeName" HeaderText="Nama Karyawan" DataField="EmployeeName" 
                                ItemStyle-Width="230px" FilterControlWidth="230px">
                            <HeaderStyle Width="250px" HorizontalAlign="Left"></HeaderStyle>
                            <ItemStyle Wrap="true" Width="230px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="EaDate" HeaderText="Tanggal Perubahan" DataField="EaDate" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="90px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="PositionName" HeaderText="Jabatan" DataField="PositionName" 
                                ItemStyle-Width="180px" FilterControlWidth="180px">
                            <HeaderStyle Width="2000px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="GradeCode" HeaderText="Golongan" DataField="GradeCode" 
                                ItemStyle-Width="90px" FilterControlWidth="90px">
                            <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="SubGradeCode" HeaderText="Sub Gol." DataField="SubGradeCode" 
                                ItemStyle-Width="90px" FilterControlWidth="90px">
                            <HeaderStyle Width="110px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="LocationName" HeaderText="Lokasi Kerja" DataField="LocationName" 
                                ItemStyle-Width="130px" FilterControlWidth="130px">
                            <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="EmpStatusName" HeaderText="Satus Karyawan" DataField="EmpStatusName" 
                                ItemStyle-Width="100px" FilterControlWidth="100px">
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>                                      
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" ItemStyle-ForeColor="OrangeRed"
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                            <HeaderStyle Width="30px"></HeaderStyle>
                        </telerik:GridButtonColumn>                     
                    </Columns>
                     <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <div style="padding: 15px 0px 0px 25px; color:white">
                                <table id="Table1" border="0" >    
                                    <tr style="vertical-align: top">
                                        <td style="vertical-align: top">
                                            <table id="Table2" border="0" >
                                                <tr>
                                                    <td colspan="2" style="padding: 0px 0px 10px 0px; text-align:left">
                                                        <asp:Button ID="btnSave" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" 
                                                            Height="25px" OnClick="btnSave_Click"
                                                            Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' runat="server" 
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
                                                    <td class="tdLabel" style="width:150px">
                                                        <telerik:RadLabel Text="Kode" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadTextBox ID="txt_tr_code" runat="server" Width="110px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.trCode") %>'  AutoPostBack="false" ReadOnly="true">
                                                        </telerik:RadTextBox>
                                    
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel Text="Tanggal" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadDatePicker ID="dtp_tgl_transaksi"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.trDate") %>' TabIndex="4" Skin="Glow"> 
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                            </DateInput>                                                                        
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>                                               
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="NIK" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_nik" runat="server" Width="300px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeNo") %>' 
                                                            OnItemsRequested="cb_nik_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_nik_SelectedIndexChanged" >
                                                        </telerik:RadComboBox> 
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="cb_nik" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator> 
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
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="txt_EmployeeName" ForeColor="Red" 
                                                            Font-Size="X-Small" Text="Required!" CssClass="required_validator">
                                                        </asp:RequiredFieldValidator>
                                    
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel Text="Tanggal Perubahan" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadDatePicker ID="dtp_tgl_perubahan"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.EaDate") %>' TabIndex="4" Skin="Glow"> 
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                            </DateInput>                                                                        
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>  
                                                <tr>
                                                    <td class="tdLabel">    
                                                         <telerik:RadLabel Text="Jabatan " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
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
                                                    <td class="tdLabel">    
                                                         <telerik:RadLabel Text="Golongan " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_golongan" runat="server" Width="150px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" Height="90px"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.GradeCode") %>' 
                                                            OnItemsRequested="cb_golongan_ItemsRequested"  >                                                                                                     
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr> 
                                                    <td class="tdLabel">    
                                                         <telerik:RadLabel Text="Sub Golongan " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td >
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_sub_golongan" runat="server" Width="150px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.SubGradeCode") %>' 
                                                            OnItemsRequested="cb_sub_golongan_ItemsRequested" >                                                                                                     
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>   
                                                <tr>
                                                    <td class="tdLabel" style="width:100px">
                                                       <telerik:RadLabel Text="Lokasi" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_lokasi" runat="server" Width="300px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.LocationName") %>' 
                                                            OnItemsRequested="cb_lokasi_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_lokasi_SelectedIndexChanged"
                                                            OnPreRender="cb_lokasi_PreRender" >                                                                                                     
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>                                                          
                                            </table>           
                                        </td>
                                    </tr>                       
                                </table>
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
