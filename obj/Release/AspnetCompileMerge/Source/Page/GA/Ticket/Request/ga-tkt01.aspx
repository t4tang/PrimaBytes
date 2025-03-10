<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ga-tkt01.aspx.cs" Inherits="PRIMA_HRIS.Page.GA.Ticket.Request.ga_tkt01" %>
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

        </script>
    </telerik:RadCodeBlock>
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
                             <telerik:RadLabel runat="server" Text="Begin Date " Skin="Glow"></telerik:RadLabel>
                         </td>                         
                         <td style="width:220px">
                              <telerik:RadDatePicker ID="dtp_from" runat="server" RenderMode="Auto" Width="150px"  Skin="Glow" DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy">
                            </telerik:RadDatePicker>
                         </td>
                     </tr>
                     <tr>        
                         
                         <td>                             
                             <telerik:RadLabel runat="server" Text="End Date " Skin="Glow"></telerik:RadLabel>
                         </td>                   
                         <td style="width:220px">
                              <telerik:RadDatePicker ID="dtp_to" runat="server" RenderMode="Auto" Width="150px"  Skin="Glow"  DateInput-CausesValidation="false"
                                DateInput-ReadOnly="false" DateInput-DateFormat="dd/MM/yyyy"></telerik:RadDatePicker>
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
                <%--<td style="vertical-align:bottom; margin-left: 0px; padding: 0px 0px 5px 20px; width:70px">                   
                    <telerik:RadLabel Skin="Glow" runat="server" Text="Show Filter" Font-Size="13px" Width="70px" ForeColor="#336699"></telerik:RadLabel>                
                </td>
                <td style="vertical-align:bottom;">
                    <asp:CheckBox ID="chk_filter" OnCheckedChanged="chk_filter_CheckedChanged" AutoPostBack="true" 
                        runat="server" TextAlign="Right" />
                </td>--%>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 7px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_add" Skin="Glow" BorderColor="DarkOrange" AutoPostBack="true" OnClick="btn_add_Click"
                        runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbAdd" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 7px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_filter" Skin="Glow" BorderColor="DarkOrange" AutoPostBack="false" OnClientClicked ="openWinFiterTemplate" 
                        runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbSearch" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_refresh" Skin="Glow" AutoPostBack="true" OnClick="btn_refresh_Click"
                        Enabled="true" runat="server" Width="30px" Height="30px" BorderColor="DarkOrange">
                        <Icon PrimaryIconCssClass="rbRefresh" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="RadButton3" Skin="Glow" AutoPostBack="false" Enabled="false" runat="server" Width="30px" Height="30px">
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
    <div  class="scroller" runat="server" style="overflow-y:auto; height:575px; font-size:small; font-family:Tahoma; background-color:#303d3f">
        <div runat="server" style="width:100%; overflow-y:hidden; background-color:#303d3f"> 
            <telerik:RadGrid  RenderMode="Auto" ID="RadGrid1"  runat="server" AllowPaging="true" ShowFooter="false" Skin="Glow" 
                AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="12" CssClass="RadGrid_ModernBrowsers"
                OnNeedDataSource="RadGrid1_NeedDataSource" 
                OnDeleteCommand="RadGrid1_DeleteCommand"
                OnItemCommand="RadGrid1_ItemCommand" 
                OnItemDataBound="RadGrid1_ItemDataBound" >
                <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                <ItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                <SelectedItemStyle Font-Italic="False"/>
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Tahoma" DataKeyNames="trCode" EditMode="EditForms" 
                    EditFormSettings-PopUpSettings-Modal="true" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" 
                    CommandItemSettings-ShowAddNewRecordButton="false" CommandItemSettings-ShowRefreshButton="false" >
                <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            <HeaderStyle Width="40px"/>
                            <ItemStyle Width="40px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="tr_code" HeaderText="Kode Transaksi" DataField="trCode"
                            ItemStyle-Width="80px" FilterControlWidth="80" ItemStyle-HorizontalAlign="Center">
                            <HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="trDate" HeaderText="Tanggal" DataField="trDate" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="70px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn> 
                        <telerik:GridBoundColumn UniqueName="EmployeeNo" HeaderText="NIK" DataField="EmployeeNo"
                            ItemStyle-Width="80px" FilterControlWidth="80" ItemStyle-HorizontalAlign="Center">
                            <HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>  
                        <telerik:GridBoundColumn UniqueName="employeeName" HeaderText="Nama Karyawan" DataField="employeeName"
                            ItemStyle-Width="120px" FilterControlWidth="120px" ItemStyle-HorizontalAlign="Left">
                            <HeaderStyle Width="140px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>   
                        <telerik:GridBoundColumn UniqueName="DepartmentName" HeaderText="Departemen" DataField="DepartmentName"
                            ItemStyle-Width="120px" FilterControlWidth="120px" ItemStyle-HorizontalAlign="Left">
                            <HeaderStyle Width="140px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn> 
                        <telerik:GridBoundColumn UniqueName="PositionName" HeaderText="Jabatan" DataField="PositionName" 
                                ItemStyle-Width="320px" FilterControlWidth="320px">
                            <HeaderStyle Width="350px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="location" HeaderText="Lokasi Kerja" DataField="location" 
                                ItemStyle-Width="130px" FilterControlWidth="130px">
                            <HeaderStyle Width="150px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>                        
                        <telerik:GridBoundColumn UniqueName="route" HeaderText="Rute" DataField="route" 
                                ItemStyle-Width="100px" FilterControlWidth="100px">
                            <HeaderStyle Width="120px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="DepartureDate" HeaderText="Tgl Keberangkatan" DataField="DepartureDate" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="70px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>                                   
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Hapus" CommandName="Delete" ItemStyle-ForeColor="OrangeRed"
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
                                                    <td colspan="2" style="padding: 5px 0px 10px 0px; text-align:left">
                                                        <asp:Button ID="btnSave" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" 
                                                            Height="25px" OnClick="btnSave_Click"
                                                            Text='<%# (Container is GridEditFormInsertItem) ? "Save" : "Update" %>' runat="server" 
                                                            CssClass="btn-entryFrm" >
                                                        </asp:Button>&nbsp;
                            
                                                        <asp:Button ID="btnCancel" BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" 
                                                            Text='<%# (Container is GridEditFormInsertItem) ? "Cancel" : "Close" %>' 
                                                            runat="server" CausesValidation="False" CommandName="Cancel" CssClass="btn-entryFrm"></asp:Button>
                                                    </td>
                                                    <%--<td class="tdLabel" style="font-size:larger; padding-left:25px">
                                                        <telerik:RadLabel Text="Transaction" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td class="tdLabel" style="font-size:larger;">:</td>--%>
                                                    <td style="font-size:25px; padding-left:55px; vertical-align:top">
                                                        <telerik:RadLabel ID="lbl_tr_code" Text='<%# DataBinder.Eval(Container, "DataItem.trCode") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow" Font-Underline="true" ></telerik:RadLabel>
                                                        <%--<telerik:RadTextBox ID="txt_tr_code" runat="server" Width="150px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.trCode") %>' ReadOnly="true" ForeColor="Orange" >
                                                        </telerik:RadTextBox>--%>
                                                    </td>
                                                </tr>                                                
                                            </table>
                                        </td>
                                                            
                                    </tr>
                                    <tr style="vertical-align: top">                                        
                                        <td style="margin-bottom:5px; width:500px">
                                            <table id="Table3" border="0" class="module">      
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Tanggal" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="dtp_trDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.trDate") %>' TabIndex="4" Skin="Glow"> 
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                Visible="true" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" 
                                                               Enabled="true"  LabelWidth="40%">                            
                                                            </DateInput>                                                                        
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel Text="Status User" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_jns_user" runat="server" Width="150px"  ReadOnly="false"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="true" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.userType") %>' 
                                                            OnItemsRequested="cb_jns_user_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_jns_user_SelectedIndexChanged"
                                                            OnPreRender="cb_jns_user_PreRender" ></telerik:RadComboBox>
                                                    </td>
                                                </tr>                                     
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel Text="NIK" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_nik" runat="server" Width="150px"  ReadOnly="false"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="true" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeNo") %>' 
                                                            OnItemsRequested="cb_nik_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_nik_SelectedIndexChanged"
                                                            OnPreRender="cb_nik_PreRender" ></telerik:RadComboBox>
                                                        <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="cb_nik" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator> --%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel Text="Nama " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <%--<telerik:RadLabel ID="lbl_EmployeeName" Text='<%# DataBinder.Eval(Container, "DataItem.employeeName") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>--%>
                                                        <telerik:RadTextBox ID="txt_EmployeeName" ReadOnly="true" runat="server" Width="250px" RenderMode="Auto" Skin="Glow"
                                                          Text='<%# DataBinder.Eval(Container, "DataItem.employeeName") %>' ForeColor="Orange"  AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                    
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td>
                                                         <telerik:RadLabel Text="Jabatan " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <%--<telerik:RadLabel ID="lbl_posisi" Text='<%# DataBinder.Eval(Container, "DataItem.PositionName") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>--%>
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_posisi" runat="server" Width="350px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.PositionName") %>' ForeColor="Orange" AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>    
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Lokasi" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <%--<telerik:RadLabel ID="lbl_lokasi" Text='<%# DataBinder.Eval(Container, "DataItem.LocationName") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>--%>
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_lokasi" runat="server" Width="350px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.location") %>'  ForeColor="Orange" AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>    
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Telp" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <%--<telerik:RadLabel ID="lbl_telp" Text='<%# DataBinder.Eval(Container, "DataItem.Hp1") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>--%>
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_telp" runat="server" Width="350px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.phone") %>'  ForeColor="Orange" AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>      
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Tanggal Lahir" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <%--<telerik:RadLabel ID="lbl_BirthDate" Text='<%# DataBinder.Eval(Container, "DataItem.BirthDate") %>' 
                                                             runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>--%>
                                                        <telerik:RadDatePicker ID="rdp_birthDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.BirthDate") %>' TabIndex="4" Skin="Glow"> 
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                Enabled="false" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" 
                                                               Enabled="false"  LabelWidth="40%">                            
                                                            </DateInput>                                                                        
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>  
                                                                                                          
                                            </table>           
                                        </td>
                                        <td style="margin-bottom:5px; padding-left:30px">
                                            <table id="Table4" border="0" class="module">                                                
                                                
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel Text="Rute" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_route" runat="server" Width="350px"  ReadOnly="false"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="False" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.Route") %>' 
                                                            OnItemsRequested="cb_route_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_route_SelectedIndexChanged"
                                                            OnPreRender="cb_route_PreRender" ></telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                         <telerik:RadLabel Text="Tanggal Keberangkatan " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadDatePicker ID="dtp_tgl_berangkat"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.departureDate") %>' TabIndex="4" Skin="Glow"> 
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                            </DateInput>                                                                        
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td>
                                                         <telerik:RadLabel Text="Keterangan " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadTextBox ReadOnly="false" ID="txt_remark" runat="server" Width="350px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.remark") %>' TextMode="MultiLine"  AutoPostBack="false">
                                                        </telerik:RadTextBox>
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
            <telerik:RadWindowManager RenderMode="Auto" ID="RadWindowManager1" runat="server" Skin="Glow" EnableShadow="true">
                <Windows>
                    <telerik:RadWindow RenderMode="Auto" ID="PreviewDialog" runat="server" Skin="Glow" ReloadOnShow="false" ShowContentDuringLoad="false"
                      Width="1150px" Height="670px" Modal="true">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
            <telerik:RadWindowManager RenderMode="Auto" ID="RadWindowManager2" runat="server" EnableShadow="true" Skin="Glow">
            </telerik:RadWindowManager>
            <telerik:RadNotification RenderMode="Auto" ID="notif" runat="server" Position="BottomRight" Skin="Glow" Text="Saved"
                AutoCloseDelay="10000" Width="350" Height="110" Title="Confirmation" EnableRoundedCorners="true">
            </telerik:RadNotification>  
    </div>
    
</asp:Content>
