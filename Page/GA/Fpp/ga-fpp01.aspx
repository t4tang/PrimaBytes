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
                window.radopen("acc00d22.aspx?asset_id=" + id, "PreviewDialog");
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
                        <telerik:GridBoundColumn UniqueName="doc_no" HeaderText="Nomor FPP" DataField="doc_no"
                            ItemStyle-Width="80px" FilterControlWidth="80" ItemStyle-HorizontalAlign="Center">
                            <HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="doc_date" HeaderText="Date" DataField="doc_date" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="70px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="90px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn> 
                        <telerik:GridBoundColumn UniqueName="objek" HeaderText="Object" DataField="objek"
                                ItemStyle-Width="320px" FilterControlWidth="320px">
                            <HeaderStyle Width="350px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="site_code" HeaderText="Jobsite" DataField="site_code" 
                                ItemStyle-Width="80px" FilterControlWidth="80px">
                            <HeaderStyle Width="100px" HorizontalAlign="Left"></HeaderStyle>
                        </telerik:GridBoundColumn>     
                        <telerik:GridDateTimeColumn UniqueName="amount" HeaderText="Amount" DataField="amount" ItemStyle-Width="100px" Visible="true" 
                                EnableRangeFiltering="false" FilterControlWidth="100px" DataFormatString="{0:#,###,##0.00}" DataType="System.Decimal" ItemStyle-HorizontalAlign="Right" >
                            <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>      
                        <telerik:GridBoundColumn UniqueName="STATUS" HeaderText="Status" DataField="STATUS" Visible="true" 
                                ItemStyle-Width="100px" FilterControlWidth="100">
                            <HeaderStyle Width="120px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>              
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
                                                    <%--</td>
                                                    <td style="font-size:25px; padding-left:15px; vertical-align:top; width:200px">--%>
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                        <telerik:RadLabel ID="lbl_tr_code" Text='<%# DataBinder.Eval(Container, "DataItem.trCode") %>' 
                                                            runat="server" Font-Size="25px" ForeColor="YellowGreen" Skin="Glow" Font-Underline="true" ></telerik:RadLabel>                                                        
                                                    </td>
                                                </tr>                                                
                                            </table>
                                        </td>
                                                            
                                    </tr>
                                    <tr style="vertical-align: top">
                                        <td style="margin-bottom:5px;width:450px">
                                            <table border="0" > 
                                                <tr>
                                                    <td style="width:150px">
                                                       <telerik:RadLabel Text="Date" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
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
                                                        <telerik:RadLabel Text="Refference" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_reff" runat="server" Width="150px"  ReadOnly="false"
                                                            EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="true" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.reffNo") %>' 
                                                            OnItemsRequested="cb_reff_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_reff_SelectedIndexChanged">
                                                        </telerik:RadComboBox>
                                                        <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="cb_reff" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator> --%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel Text="Amount" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadNumericTextBox ID="txt_amount" runat="server" Width="150px" RenderMode="Auto" Skin="Glow"
                                                          DbValue='<%# DataBinder.Eval(Container, "DataItem.amount") %>' DataType="Decimal" Type="Number" >
                                                        </telerik:RadNumericTextBox>
                                    
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td style="width:100px">
                                                         <telerik:RadLabel Text="Invoice No. " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadTextBox ID="txt_invoice_no" runat="server" Width="150px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.invNo") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>    
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Billing Date" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadDatePicker ID="dtp_billing_date" runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                            DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.billingDate") %>' TabIndex="4" Skin="Glow"> 
                                                            <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                            <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" 
                                                                LabelWidth="40%">                            
                                                            </DateInput>                                                                        
                                                        </telerik:RadDatePicker>
                                                    </td>
                                                </tr>    
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Travel" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadTextBox ReadOnly="false" ID="txt_travel" runat="server" Width="150px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.travel") %>'>
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                         <telerik:RadLabel Text="Remark" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadTextBox ReadOnly="false" ID="txt_remark" runat="server" Width="350px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.remarkIssued") %>' TextMode="MultiLine"  AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                                                                          
                                            </table>           
                                        </td>                                        
                                        <td style="margin-bottom:5px;width:300px">
                                            <table id="Table3" border="0" class="module">                                                  
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel Text="Reff No." runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadLabel ID="lbl_reff_code" Text='<%# DataBinder.Eval(Container, "DataItem.reffNo") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow" ></telerik:RadLabel>
                                                    </td>
                                                </tr>     
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Date" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadLabel ID="lbl_reff_date" Text='<%# DataBinder.Eval(Container, "DataItem.reffDate","{0:dd-MM-yyyy}") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel Text="Route" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>                                                        
                                                        <telerik:RadLabel ID="lbl_route" Text='<%# DataBinder.Eval(Container, "DataItem.Route") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                         <telerik:RadLabel Text="Depart. Date " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadLabel ID="lbl_depart_date" Text='<%# DataBinder.Eval(Container, "DataItem.departureDate","{0:dd-MM-yyyy}") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td>
                                                         <telerik:RadLabel Text="Remark " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadLabel ID="lbl_remark" Text='<%# DataBinder.Eval(Container, "DataItem.remarkOrder") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                </tr>
                                                                                                          
                                            </table>           
                                        </td>
                                        <td style="margin-bottom:5px; padding-left:20px">
                                            <table id="Table4" border="0" class="module">
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel Text="NIK" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadLabel ID="lbl_nik" Text='<%# DataBinder.Eval(Container, "DataItem.EmployeeNo") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow" ></telerik:RadLabel>
                                                         
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <telerik:RadLabel Text="Nama Karyawan" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadLabel ID="lbl_EmployeeName" Text='<%# DataBinder.Eval(Container, "DataItem.FirstName") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>                                                        
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td>
                                                         <telerik:RadLabel Text="Jabatan " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td >
                                                        <telerik:RadLabel ID="lbl_posisi" Text='<%# DataBinder.Eval(Container, "DataItem.PositionName") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                </tr>    
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Lokasi" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td><telerik:RadLabel ID="lbl_lokasi" Text='<%# DataBinder.Eval(Container, "DataItem.LocationName") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                </tr>    
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Telp" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadLabel ID="lbl_telp" Text='<%# DataBinder.Eval(Container, "DataItem.Hp1") %>' 
                                                            runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                </tr>      
                                                <tr>
                                                    <td style="width:100px">
                                                       <telerik:RadLabel Text="Birth Date" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>:</td>
                                                    <td>
                                                        <telerik:RadLabel ID="lbl_BirthDate" Text='<%# DataBinder.Eval(Container, "DataItem.BirthDate","{0:dd-MM-yyyy}") %>' 
                                                             runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
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
