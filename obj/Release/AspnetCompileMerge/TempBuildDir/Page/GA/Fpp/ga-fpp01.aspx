<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ga-fpp01.aspx.cs" Inherits="PRIMA_HRIS.Page.GA.Fpp.ga_fpp01" %>
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
                window.radopen("preview.aspx?doc_no=" + id, "PreviewDialog");
                return false;
            }

            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
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
                OnItemCreated="RadGrid1_ItemCreated" 
                OnItemDataBound="RadGrid1_ItemDataBound" >
                <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                <ItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                <SelectedItemStyle Font-Italic="False"/>
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Tahoma" DataKeyNames="doc_no" EditMode="EditForms" 
                    EditFormSettings-PopUpSettings-Modal="true" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="true" 
                    CommandItemSettings-ShowAddNewRecordButton="false" CommandItemSettings-ShowRefreshButton="false" >
                <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            <HeaderStyle Width="40px"/>
                            <ItemStyle Width="40px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="doc_no" HeaderText="FPP Number" DataField="doc_no"
                            ItemStyle-Width="150px" FilterControlWidth="150px" ItemStyle-HorizontalAlign="Center">
                            <HeaderStyle Width="170px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="doc_date" HeaderText="Date" DataField="doc_date" ItemStyle-Width="90px" 
                                EnableRangeFiltering="false" FilterControlWidth="90px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="110px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn> 
                        <telerik:GridBoundColumn UniqueName="objek" HeaderText="Object" DataField="objek"
                                ItemStyle-Width="320px" FilterControlWidth="320px">
                            <HeaderStyle Width="350px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn> 
                        <telerik:GridBoundColumn UniqueName="pay_to" HeaderText="Payment To" DataField="pay_to"
                                ItemStyle-Width="120px" FilterControlWidth="120px">
                            <HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="site_code" HeaderText="Jobsite" DataField="site_code" 
                                ItemStyle-Width="80px" FilterControlWidth="80px">
                            <HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>      
                        <telerik:GridBoundColumn UniqueName="DepartmentName" HeaderText="Department" DataField="DepartmentName"
                                ItemStyle-Width="120px" FilterControlWidth="120px" Visible="true" >
                            <HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="amount" HeaderText="Amount" DataField="amount" ItemStyle-Width="100px" Visible="true" 
                                EnableRangeFiltering="false" FilterControlWidth="100px" DataFormatString="{0:#,###,##0.00}" DataType="System.Decimal" ItemStyle-HorizontalAlign="Right" >
                            <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>      
                        <telerik:GridBoundColumn UniqueName="status" HeaderText="Status" DataField="status" Visible="true" 
                                ItemStyle-Width="80px" FilterControlWidth="80">
                            <HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn UniqueName="TemplatePrintColumn" HeaderStyle-Width="25px" ItemStyle-Width="25px" ItemStyle-HorizontalAlign="Right"
                                AllowFiltering="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="PrintLink" runat="server" Height="20px" Width="20px" ImageUrl="~/images/cetak.png" ToolTip="Print" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>              
                        <telerik:GridButtonColumn UniqueName="DeleteColumn" Text="Delete" CommandName="Delete" ItemStyle-ForeColor="OrangeRed"
                            ConfirmText="Are You Sure ?" ConfirmTitle="Delete" ConfirmDialogType="RadWindow" ButtonType="FontIconButton">
                            <HeaderStyle Width="30px"></HeaderStyle>
                        </telerik:GridButtonColumn>                     
                    </Columns>
                     <EditFormSettings EditFormType="Template">
                        <FormTemplate>
                            <div style="padding: 15px 0px 30px 25px; color:white">
                                <table id="Table1" border="0" >    
                                    <tr style="vertical-align: top">
                                        <td style="vertical-align: top">
                                            <table id="Table2" border="0" >
                                                <tr>
                                                    <td colspan="2" style="padding: 5px 30px 10px 0px; width:500px; text-align:left">
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
                                        <td style="margin-bottom:5px;width:500px">
                                            <table border="0" >  
                                                <tr>
                                                    <td style="width:120px">
                                                         <telerik:RadLabel Text="Doc No. " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadTextBox ID="txt_docNo" runat="server" Width="250px" RenderMode="Auto" Skin="Glow" ReadOnly="true"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.doc_no") %>' EmptyMessage="Auto Generate">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width:120px">
                                                       <telerik:RadLabel Text="Date" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="dtp_docDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.doc_date") %>' TabIndex="4" Skin="Glow"> 
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                Visible="true" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" 
                                                               Enabled="true"  LabelWidth="40%">                            
                                                            </DateInput>                                                                        
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>                                                
                                                    <td style="width:120px">
                                                       <telerik:RadLabel Text="Due Date" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="dtp_dueDate"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.exp_date") %>' TabIndex="4" Skin="Glow"> 
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                Visible="true" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" 
                                                               Enabled="true"  LabelWidth="40%">                            
                                                            </DateInput>                                                                        
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width:120px">
                                                        <telerik:RadLabel Text="Payment Description" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadTextBox ReadOnly="false" ID="txt_description" runat="server" Width="300px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.objek") %>' TextMode="MultiLine"  AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel Text="Amount" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadNumericTextBox ID="txt_amount" runat="server" Width="250px" RenderMode="Auto" Skin="Glow"
                                                          DbValue='<%# DataBinder.Eval(Container, "DataItem.amount") %>' DataType="Decimal" Type="Number" >
                                                        </telerik:RadNumericTextBox>
                                    
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td style="width:100px">
                                                         <telerik:RadLabel Text="Job Site" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_project" runat="server" Width="300px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.LocationName") %>' 
                                                            OnItemsRequested="cb_lokasi_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_lokasi_SelectedIndexChanged"
                                                            OnPreRender="cb_lokasi_PreRender" >                                                                                                     
                                                        </telerik:RadComboBox>  
                                                    </td>
                                                </tr>    
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Department" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
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
                                                                                         
                                            </table>           
                                        </td>                                        
                                        <td style="margin-bottom:5px;width:550px; padding-left:25px">
                                            <table id="Table5" border="0" class="module">  
                                                <tr>
                                                    <td style="width:120px">
                                                       <telerik:RadLabel Text="Payment To" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadTextBox ReadOnly="false" ID="txt_partner" runat="server" Width="350px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.pay_to") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>                                                    
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Payment Method" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_pay_method" runat="server" Width="250px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.payMethod") %>' 
                                                            OnItemsRequested="cb_pay_method_ItemsRequested" >                                                                                                     
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>                                                    
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Bank Name" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_bank" runat="server" Width="250px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.BankName") %>' 
                                                            OnItemsRequested="cb_bank_name_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_bank_name_SelectedIndexChanged"
                                                            OnPreRender="cb_bank_name_PreRender" >                                                                                                     
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr >
                                                    <td style="width:120px">
                                                         <telerik:RadLabel Text="Bank Account No" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_norek" runat="server" Width="250px" RenderMode="Auto" Skin="Glow"
                                                          Text='<%# DataBinder.Eval(Container, "DataItem.BankAccNo") %>' InputType="Number"  >
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td >
                                                        <telerik:RadLabel Text="Bank Account Name" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadTextBox ReadOnly="false" ID="txt_nama_rekening" Width="250px" runat="server" Skin="Glow"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.BankAccName") %>' >
                                                            </telerik:RadTextBox>

                                                    </td>
                                                </tr>   
                                                <tr>
                                                    <td>
                                                         <telerik:RadLabel Text="Remark" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadTextBox ReadOnly="true" ID="txt_remark" runat="server" Width="350px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.pay_metod") %>' TextMode="MultiLine"  AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                                                                          
                                            </table>           
                                        </td>                                        
                                        <td style="margin-bottom:5px;width:450px; padding-left:25px">
                                            <table id="Table3" border="0" class="module">                                                  
                                                <tr>
                                                    <td style="width:90px">
                                                        <telerik:RadLabel Text="Request By" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_requestBy1" runat="server" Width="250px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.createBy1_name") %>'
                                                            OnItemsRequested="cb_employee_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_requestBy1_SelectedIndexChanged" 
                                                            OnPreRender="cb_requestBy1_PreRender" >                                                                                                     
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>     
                                                <tr style="height:50px">
                                                    <td >
                                                       
                                                    </td>
                                                    <td></td>
                                                    <td style="vertical-align:top">
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_requestBy2" runat="server" Width="250px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.createBy2_name") %>'
                                                            OnItemsRequested="cb_employee_ItemsRequested"
                                                            OnSelectedIndexChanged="cb_requestBy2_SelectedIndexChanged"
                                                            OnPreRender="cb_requestBy2_PreRender" >                                                                                                     
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr >
                                                    <td >
                                                        <telerik:RadLabel Text="Approve By" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>                                                        
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_approveBy1" runat="server" Width="250px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.approveBy1_name") %>'
                                                            OnItemsRequested="cb_employee_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_approveBy1_SelectedIndexChanged" 
                                                            OnPreRender="cb_approveBy1_PreRender" >                                                                                                     
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr style="height:50px">
                                                    <td>
                                                         
                                                    </td>
                                                    <td></td>
                                                    <td style="vertical-align:top" >
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_approveBy2" runat="server" Width="250px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.approveBy2_name") %>'
                                                            OnItemsRequested="cb_employee_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_approveBy2_SelectedIndexChanged"
                                                            OnPreRender="cb_approveBy2_PreRender" >                                                                                                     
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td>
                                                         <telerik:RadLabel Text="Status " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_statusDoc" runat="server" Width="250px"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="false"
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.status") %>'
                                                            OnItemsRequested="cb_statusDoc_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_statusDoc_SelectedIndexChanged" 
                                                            OnPreRender="cb_statusDoc_PreRender">                                                                                                     
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
            <telerik:RadWindowManager RenderMode="Auto" ID="RadWindowManager1" runat="server" Skin="Glow" EnableShadow="true">
                <Windows>
                    <telerik:RadWindow RenderMode="Auto" ID="PreviewDialog" runat="server" ReloadOnShow="true" ShowContentDuringLoad="false"
                    Width="1160px" Height="690px" Modal="true" AutoSize="False" Animation="FlyIn" Behaviors="Close">
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
