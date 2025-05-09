﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="fa-as001.aspx.cs" Inherits="PRIMA_HRIS.Page.FA.ASSET.fa_as001" %>
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
    <style type="text/css">      
       div.RadGrid .rgPager .rgAdvPart     
       {     
        display:none;        
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

    <telerik:RadAjaxLoadingPanel ID="gridLoadingPanel" runat="server">
    </telerik:RadAjaxLoadingPanel>

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
                                OnItemsRequested="cb_project_prm_ItemsRequested" OnSelectedIndexChanged="cb_project_prm_SelectedIndexChanged" 
                                OnPreRender="cb_project_prm_PreRender" BorderStyle="NotSet"></telerik:RadComboBox>
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
                                EnableLoadOnDemand="True" Skin="Glow"  OnItemsRequested="cb_status_prm_ItemsRequested" EnableVirtualScrolling="true" 
                                Filter="Contains" MarkFirstMatch="true" ChangeTextOnKeyBoardNavigation="false" Width="320px"
                                OnSelectedIndexChanged="cb_status_prm_SelectedIndexChanged" BorderStyle="NotSet"
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
                <%--<td style="vertical-align: bottom; margin-left: 10px; padding-left: 8px">
                    <asp:ImageButton runat="server" ID="ImageButton1" AlternateText="New" OnClick="btnNew_Click" ToolTip="Add New" Visible="true"
                        Height="26px" Width="27px" ImageUrl="~/Images/tambah.png" ImageAlign="Bottom" ></asp:ImageButton>
                </td>                
                <td style="vertical-align: bottom; margin-left: 0px; padding: 0px 0px 0px 0px;">
                    <asp:ImageButton runat="server" ID="btnFilter" OnClientClick="openWinFiterTemplate(); return false;" ToolTip="Filter" 
                        Height="29px" Width="30px" ImageUrl="~/Images/search.png"></asp:ImageButton>
                </td>--%>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 7px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_add" Skin="Glow" BackColor="YellowGreen" AutoPostBack="true" OnClick="btn_new_Click"
                        runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbAdd" PrimaryIconTop="7" PrimaryIconLeft="6"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 7px">
                    <telerik:RadButton RenderMode="Auto" ID="btn_filter" Skin="Glow" AutoPostBack="false" OnClientClicked ="openWinFiterTemplate" 
                        runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbSearch" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="RadButton2" Skin="Glow" AutoPostBack="false" Enabled="false" runat="server" Width="30px" Height="30px">
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
                <td style="vertical-align: middle; margin-left: 10px; padding:6px 0px 5px 5px">
                    <telerik:RadButton RenderMode="Auto" ID="RadButton1" Skin="Glow" AutoPostBack="false" Enabled="false" runat="server" Width="30px" Height="30px">
                        <Icon PrimaryIconCssClass="rbHelp" PrimaryIconTop="7" PrimaryIconLeft="5"></Icon>
                    </telerik:RadButton>
                </td>
                <td style="vertical-align:bottom; margin-left: 0px; padding: 0px 0px 5px 20px; width:70px">                   
                    <asp:Label runat="server" Text="Show Filter" Font-Size="13px" Width="70px" ForeColor="#336699" Visible="false"></asp:Label>                
                </td>
                <td style="vertical-align:bottom;">
                    <%--<asp:CheckBox ID="chk_filter" OnCheckedChanged="chk_filter_CheckedChanged" AutoPostBack="true" 
                        runat="server" TextAlign="Right" />--%>
                    <%--<telerik:RadCheckBox OnCheckedChanged="chk_filter_CheckedChanged" AutoPostBack="true" ID="chk_filter"
                        runat="server" TextAlign="Right" />--%>
                </td>
                <td style="width: 96%; text-align: right">
                    <telerik:RadLabel ID="lbl_form_name" runat="server" Style="font-weight:normal; font-size: 10px; font-variant: small-caps; padding-left: 10px; 
                        padding-bottom: 0px; font-size: x-large; color:deepskyblue; font-family:Mistral">
                    </telerik:RadLabel>
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
                OnItemDataBound="RadGrid1_ItemDataBound">
                <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
                <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
                <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
                <ItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
                <SelectedItemStyle Font-Italic="False"/>
                <SortingSettings EnableSkinSortStyles="false" />
                <MasterTableView CommandItemDisplay="None" Font-Size="11px" Font-Names="Tahoma" DataKeyNames="asset_id" EditMode="EditForms" EditFormSettings-PopUpSettings-Modal="true"
                EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" CommandItemSettings-ShowAddNewRecordButton="false"
                     CommandItemSettings-ShowRefreshButton="false" >  
                    <ColumnGroups>
                        <telerik:GridColumnGroup HeaderText="Book Depreciation" Name="BookDepreciation" HeaderStyle-HorizontalAlign="Center">
                        </telerik:GridColumnGroup>
                    </ColumnGroups>                  
                    <Columns>
                        <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                            <HeaderStyle Width="40px"/>
                            <ItemStyle Width="40px" />
                        </telerik:GridEditCommandColumn>
                        <telerik:GridBoundColumn UniqueName="asset_id" HeaderText="Asset Number" DataField="asset_id">
                            <HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="AssetName" HeaderText="Asset Name" DataField="AssetName" 
                                ItemStyle-Width="330px" FilterControlWidth="330px">
                            <HeaderStyle Width="330px" HorizontalAlign="Center"></HeaderStyle>
                            <ItemStyle Wrap="true" Width="330px" />
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn UniqueName="status" HeaderText="Status" DataField="status" 
                                ItemStyle-Width="130px" FilterControlWidth="130px">
                            <HeaderStyle Width="130px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridBoundColumn>
                        <telerik:GridDateTimeColumn UniqueName="tgl_beli" HeaderText="Order Date" DataField="tgl_beli" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridDateTimeColumn UniqueName="lastupdate" HeaderText="Last Update" DataField="lastupdate" ItemStyle-Width="70px" 
                                EnableRangeFiltering="false" FilterControlWidth="80px" PickerType="DatePicker" ItemStyle-HorizontalAlign="Center"
                            DataFormatString="{0:d}" >
                            <HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
                        </telerik:GridDateTimeColumn>
                        <telerik:GridBoundColumn UniqueName="region_code" HeaderText="Project Area" DataField="region_code" ItemStyle-HorizontalAlign="Center"
                            FilterControlWidth="80px" >
                            <HeaderStyle Width="80px"></HeaderStyle>
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
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="Asset Code" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadTextBox ID="txt_doc_code" runat="server" Width="250px" ReadOnly="true" RenderMode="Auto"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.asset_id") %>' Skin="Glow" >
                                                        </telerik:RadTextBox>
                                       
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="Asset Class *" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_asset_class" runat="server" Width="300px"  ReadOnly="true" Height="350px" ShowMoreResultsBox="true"
                                                        DropDownWidth="700px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="true" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.AK_NAME") %>' 
                                                            OnItemsRequested="cb_asset_class_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_asset_class_SelectedIndexChanged"
                                                            OnPreRender="cb_asset_class_PreRender">
                                                            <HeaderTemplate>
                                                                <table style="width: 700px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 120px; text-align:left">
                                                                            Code
                                                                        </td>
                                                                        <td style="width: 250px; text-align:left">
                                                                            Asset Class
                                                                        </td>
                                                                        <td style="width: 70px; text-align:center">
                                                                            Useful Life
                                                                        </td>
                                                                        <td style="width: 250px; text-align:left">
                                                                            Methode
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>                                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 700px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 120px; text-align:left">
                                                                            <%# DataBinder.Eval(Container, "DataItem.AK_CODE")%>
                                                                        </td>
                                                                        <td style="width: 250px; text-align:left">
                                                                            <%# DataBinder.Eval(Container, "DataItem.AK_NAME")%>
                                                                        </td>
                                                                        <td style="width: 70px; text-align:center">
                                                                            <%# DataBinder.Eval(Container, "DataItem.exp_life_year")%>
                                                                        </td>
                                                                        <td style="width: 250px; text-align:left">
                                                                            <%# DataBinder.Eval(Container, "DataItem.Method")%>
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>

                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                            </FooterTemplate> 

                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator7" ControlToValidate="cb_asset_class" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator> 
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel" style="width:100px">
                                                        <telerik:RadLabel Text="Reff Code" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadTextBox ID="txt_reff_code" runat="server" Width="250px" ReadOnly="false" RenderMode="Auto"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.ak_id") %>' Skin="Glow">
                                                        </telerik:RadTextBox>

                                                       <%-- <telerik:RadComboBox RenderMode="Auto" ID="cb_ur_number" runat="server" Width="250px"  ReadOnly="true" Height="350px" ShowMoreResultsBox="true"
                                                        DropDownWidth="900px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Silk" EnableVirtualScrolling="true" AutoPostBack="false" CausesValidation="false" 
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.ur_no") %>'  >
                                                            <HeaderTemplate>
                                                                <table style="width: 900px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px; text-align:left">
                                                                            UR Number
                                                                        </td>
                                                                        <td style="width: 150px; text-align:left">
                                                                            Part Code
                                                                        </td>
                                                                        <td style="width: 350px; text-align:left">
                                                                            Description
                                                                        </td>
                                                                        <td style="width: 50px; text-align:left">
                                                                            Qty
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>                                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 900px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px; text-align:left">
                                                                            <%# DataBinder.Eval(Container, "DataItem.doc_code")%>
                                                                        </td>
                                                                        <td style="width: 150px; text-align:left">
                                                                            <%# DataBinder.Eval(Container, "DataItem.part_code")%>
                                                                        </td>
                                                                        <td style="width: 350px; text-align:left">
                                                                            <%# DataBinder.Eval(Container, "DataItem.part_desc")%>
                                                                        </td>
                                                                        <td style="width: 50px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.qty_Sisa")%>
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>

                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                            </FooterTemplate>                                                        
                                                        </telerik:RadComboBox>                                                        
                                                       <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ControlToValidate="cb_ur_number" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator">
                                                        </asp:RequiredFieldValidator>    --%>                                   
                                                    </td>
                                                </tr>                     
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="Asset Number" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadTextBox ID="txt_asset_number" runat="server" Width="250px" ReadOnly="false" RenderMode="Auto"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.asset_number") %>' Skin="Glow">
                                                        </telerik:RadTextBox>
                                       
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td class="tdLabel">                                    
                                                        <telerik:RadLabel Text="Asset Name *" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadTextBox ID="txt_asset_name" runat="server" Width="330px" Enabled="true" RenderMode="Auto" Skin="Glow"
                                                          Text='<%# DataBinder.Eval(Container, "DataItem.AssetName") %>'   ReadOnly="false" AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txt_asset_name" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="Specification " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadTextBox ID="txt_spec" runat="server" Width="430px" Enabled="true" RenderMode="Auto" ReadOnly="false" 
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.AssetSpec") %>' Skin="Glow" AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr >
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="Material Code " runat="server" ForeColor="YellowGreen" Skin="Glow" Visible="false"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadTextBox ID="txt_material_code" ReadOnly="true" runat="server" Width="180px" Visible="false" Enabled="true" RenderMode="Auto"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.prod_code") %>' Skin="Glow" AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                    <td style="padding-left:10px">
                                                        <telerik:RadLabel Text="Qty " runat="server" Visible="false" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadNumericTextBox  RenderMode="Auto" runat="server" ID="txt_qty" Width="70px" NumberFormat-AllowRounding="true"
                                                            NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ReadOnly="true"  Visible="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.Qty", "{0:#,###,###0.00}") %>' Skin="Glow"
                                                            onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" >
                                                        </telerik:RadNumericTextBox>
                                                    </td>
                                                    <td style="padding-left:10px">
                                                        <telerik:RadLabel Text="UoM " runat="server"  Visible="false" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_uom" runat="server" Width="100px" ReadOnly="true" 
                                                            AutoPostBack="true" ShowMoreResultsBox="true" EnableLoadOnDemand="True" Skin="Glow" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.SatQty") %>'  Visible="false"
                                                             OnItemsRequested="cb_uom_ItemsRequested" OnSelectedIndexChanged="cb_uom_SelectedIndexChanged" OnPreRender="cb_uom_PreRender">
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr> 
                                                
                                            </table>
                                        </td>
                                        <td style="vertical-align: top; padding-left:35px">
                                            <table id="Table3" border="0" class="module">
                                                
                                                
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="Asset Type" runat="server" ForeColor="YellowGreen" Visible="false" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_asset_type" runat="server" Width="250px"  Visible="false" ReadOnly="true"
                                                        ShowMoreResultsBox="true"  EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="false" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.AK_GROUP_NAME") %>' 
                                                            OnItemsRequested="cb_asset_type_ItemsRequested" OnSelectedIndexChanged="cb_asset_type_SelectedIndexChanged"
                                                             OnPreRender="cb_asset_type_PreRender">
                                                        </telerik:RadComboBox>
                                                        <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator6" ControlToValidate="cb_asset_type" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator> --%>
                                    
                                                    </td>
                                                </tr> 
                                                <tr>
                                                    <td class="tdLabel">
                                                         <telerik:RadLabel Text="Asset Status " runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_asset_status" runat="server" Width="250px"  ReadOnly="true"
                                                        DropDownWidth="300px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="False" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.status_name") %>' 
                                                            OnItemsRequested="cb_asset_status_ItemsRequested" OnSelectedIndexChanged="cb_asset_status_SelectedIndexChanged"
                                                            OnPreRender="cb_asset_status_PreRender"></telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="Tax Group:" runat="server" ForeColor="YellowGreen" Visible="false" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_taxx_group" runat="server" Visible="false" Width="250px"  ReadOnly="true"
                                                        DropDownWidth="300px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="False" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.taxGroupName") %>' 
                                                            OnItemsRequested="cb_taxx_group_ItemsRequested" OnSelectedIndexChanged="cb_taxx_group_SelectedIndexChanged"
                                                            OnPreRender="cb_taxx_group_PreRender">
                                                        </telerik:RadComboBox>
                                                        <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="cb_taxx_group" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>--%>
                                                    </td>
                                                </tr>           
                                                <tr>
                                                    <td class="tdLabel" style="width:100px">
                                                       <telerik:RadLabel Text=" Serial Number" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td colspan="5">
                                                        <telerik:RadTextBox ID="txt_serial_number" runat="server" Width="250px" RenderMode="Auto" Skin="Glow"
                                                           Text='<%# DataBinder.Eval(Container, "DataItem.SerialNumber") %>'  AutoPostBack="false">
                                                        </telerik:RadTextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                         <telerik:RadLabel Text="Project *" runat="server" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td>   
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_project" runat="server" Width="350px" ReadOnly="true"
                                                        DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="true" CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.LocationName") %>' 
                                                            OnItemsRequested="cb_project_ItemsRequested" 
                                                            OnSelectedIndexChanged="cb_project_SelectedIndexChanged"
                                                            OnPreRender="cb_project_PreRender">
                                                            <HeaderTemplate>
                                                                <table style="width: 400px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            Project Code
                                                                        </td>
                                                                        <td style="width: 250px;">
                                                                            Project Name
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>                                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 400px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.LocationCode")%>
                                                                        </td>
                                                                        <td style="width: 250px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.LocationName")%>
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>

                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                            </FooterTemplate>                                                        
                                                        </telerik:RadComboBox>
                                                        <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="cb_project" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>   
                                                    </td>
                                                </tr>
                                                <tr >
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="Cost Center" runat="server" Visible="true" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td >                                   
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_cost_center" runat="server" Width="250px" 
                                                        DropDownWidth="250px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="true"  CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.CostCenterName") %>' 
                                                            OnItemsRequested="cb_cost_center_ItemsRequested" OnSelectedIndexChanged="cb_cost_center_SelectedIndexChanged"
                                                            OnPreRender="cb_cost_center_PreRender" Visible="true">
                                                            <HeaderTemplate>
                                                                <table style="width: 400px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            Cost Center Code
                                                                        </td>
                                                                        <td style="width: 250px;">
                                                                            Cost Center Name
                                                                        </td>
                                                                    </tr>
                                                                </table>                                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 400px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 150px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.CostCenter")%>
                                                                        </td>
                                                                        <td style="width: 250px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.CostCenterName")%>
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>

                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                            </FooterTemplate>                                                        
                                                        </telerik:RadComboBox>
                                                        <%--<asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ControlToValidate="cb_cost_center" ForeColor="Red" 
                                                        Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>--%>
                                                    </td>
                                                </tr>
                                                <tr >
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="Unit Code" runat="server" Visible="false" ForeColor="YellowGreen" Skin="Glow"></telerik:RadLabel>
                                                    </td>
                                                    <td style="vertical-align:top; text-align:left">                                   
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_unit" runat="server" Width="350px"  ReadOnly="true"
                                                        DropDownWidth="650px" EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" AutoPostBack="true"  CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.unit_code") %>' 
                                                            OnItemsRequested="cb_unit_ItemsRequested" Visible="false">
                                                            <HeaderTemplate>
                                                                <table style="width: 550px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 80px;">
                                                                            Unit Code
                                                                        </td>
                                                                        <td style="width: 300px;">
                                                                            Unit Name
                                                                        </td>
                                                                        <td style="width: 120px;">
                                                                            Model No.
                                                                        </td>
                                                                        <td style="width: 50px;">
                                                                            Project
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>                                                       
                                                            </HeaderTemplate>
                                                            <ItemTemplate>
                                                                <table style="width: 550px; font-size:smaller">
                                                                    <tr>
                                                                        <td style="width: 80px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.unit_code")%>
                                                                        </td>
                                                                        <td style="width: 300px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.unit_name")%>
                                                                        </td>
                                                                        <td style="width: 120px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.model_no")%>
                                                                        </td>
                                                                        <td style="width: 50px;">
                                                                            <%# DataBinder.Eval(Container, "DataItem.region_code")%>
                                                                        </td>                                                                
                                                                    </tr>
                                                                </table>

                                                            </ItemTemplate>
                                                            <FooterTemplate>
                                                            </FooterTemplate>                                                        
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="tdLabel">
                                                        <telerik:RadLabel Text="PIC" runat="server" ForeColor="YellowGreen" Skin="Glow"  Visible="false"></telerik:RadLabel>
                                                    </td>
                                                    <td style="vertical-align:top; text-align:left">
                                                        <telerik:RadComboBox RenderMode="Auto" ID="cb_pic" runat="server" Width="250px"  ReadOnly="true"  Visible="false"
                                                        EnableLoadOnDemand="True" HighlightTemplatedItems="true" 
                                                            MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true"  CausesValidation="false"
                                                            Text='<%# DataBinder.Eval(Container, "DataItem.pic_name") %>' 
                                                            OnItemsRequested="cb_pic_ItemsRequested" OnSelectedIndexChanged="cb_pic_SelectedIndexChanged"
                                                            OnPreRender="cb_pic_PreRender" >                                                                                                     
                                                        </telerik:RadComboBox>
                                                    </td>
                                                </tr>                           
                                            </table>           
                                        </td>                    
                                    </tr>                       
                                </table>
                            </div>
                            <%--<div style=" width:100%; padding-top: 25px;" class="table_trx">
                                <telerik:RadTabStrip RenderMode="Auto" runat="server" ID="RadTabStrip1"  Orientation="HorizontalTop" Width="97%" AutoPostBack="false"
                                SelectedIndex="0" MultiPageID="RadMultiPage1" Skin="Glow">
                                <Tabs>
                                    <telerik:RadTab Text="Purchase Detail" Height="15px"> 
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Book Depreciation" Height="15px">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Account Setting" Height="15px">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Selling Detail" Height="15px">
                                    </telerik:RadTab>
                                    <telerik:RadTab Text="Depreciation (Fiskal)" Height="15px">
                                    </telerik:RadTab>
                                </Tabs>
                                </telerik:RadTabStrip>
                                <telerik:RadMultiPage runat="server" ID="RadMultiPage1"  SelectedIndex="0" Width="97%">
                                    <telerik:RadPageView runat="server" ID="RadPageView1" Height="358px" >
                                        <div style="width:99%; padding: 10px 10px 10px 10px;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <table style="padding: 10px 0px 0px 10px">
                                                            <tr >
                                                                <td style="width:100px">
                                                                    Currency 
                                                                </td>
                                                                <td>
                                                                    <telerik:RadComboBox RenderMode="Auto" ID="cb_currency" runat="server" Width="120px"
                                                                        EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                        MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.cur_name") %>' 
                                                                        OnItemsRequested="cb_currency_ItemsRequested" 
                                                                        OnPreRender="cb_currency_PreRender">                                                                                                     
                                                                    </telerik:RadComboBox>
                                                                </td>
                                                                <td style="padding-left:10px" >
                                                                    
                                                                </td>
                                                                <td>
                                                                    <telerik:RadTextBox  RenderMode="Auto" runat="server" ID="txt_tax_kurs" Width="100px" NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  ReadOnly="true" Visible="false"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.KursTax") %>' Skin="Glow"
                                                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" BorderStyle="None">
                                                                        </telerik:RadTextBox>  
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Purchase Cost 
                                                                </td>
                                                                <td colspan="3">
                                                                    <telerik:RadNumericTextBox  RenderMode="Auto" runat="server" ID="txt_pur_cost" Width="150px" NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Harga", "{0:#,###,###0.00}") %>'
                                                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" 
                                                                        Value="0" EnabledStyle-HorizontalAlign="Right" AutoPostBack="true"
                                                                        OnTextChanged="txt_pur_cost_TextChanged" >
                                                                        </telerik:RadNumericTextBox>                                
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    
                                                                </td>
                                                                <td colspan="3">
                                                                    <telerik:RadNumericTextBox Visible="false" RenderMode="Auto" runat="server" ID="txt_pur_cost_valas" Width="150px" NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  ReadOnly="true" EnabledStyle-HorizontalAlign="Right"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.jumlah", "{0:#,###,###0.00}") %>'
                                                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" Value="0" >
                                                                        </telerik:RadNumericTextBox>                                
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    Order Number
                                                                </td>
                                                                <td colspan="3">
                                                                    <telerik:RadTextBox ID="txt_order_no" Width="150px" runat="server"  Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ordernumber") %>' >
                                                                        </telerik:RadTextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    Order Date
                                                                </td>
                                                                <td colspan="3">
                                                                    <telerik:RadDatePicker ID="dtp_order_date"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.tgl_beli") %>' TabIndex="4" Skin="Glow"> 
                                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                        </DateInput>
                                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                                                    </telerik:RadDatePicker>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>                            
                                                </tr>
                                            </table>                    
                                        </div>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView2" Height="358px">
                                        <div style="width:99%; padding: 10px 10px 10px 10px;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <table style="padding: 10px 0px 0px 10px">
                                                            <tr >
                                                                <td style="width:125px" >
                                                                    Useful Life (Year)
                                                                </td>
                                                                <td>
                                                                    <telerik:RadNumericTextBox ReadOnly="true" ID="txt_use_life_year" Width="70px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.exp_life_year") %>' EnabledStyle-HorizontalAlign="Center" >
                                                                        </telerik:RadNumericTextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    Depreciation Method
                                                                </td>
                                                                <td>
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_dep_method" Width="150px" runat="server" Skin="Glow"
                                                                       Text='<%# DataBinder.Eval(Container, "DataItem.mtd") %>' >
                                                                        </telerik:RadTextBox> 
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Appreciation
                                                                </td>
                                                                <td >
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_appreciation" Width="70px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.mtd_per") %>' EnabledStyle-HorizontalAlign="Center">
                                                                        </telerik:RadTextBox>                              
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    
                                                                </td>
                                                                <td >
                                                                    <telerik:RadNumericTextBox Visible="false" RenderMode="Auto" runat="server" ID="txt_pre_depre_month" Width="70px" NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0" EnabledStyle-HorizontalAlign="Center"
                                                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="0" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.susut_month", "{0:#,###,###0.00}") %>'>
                                                                        </telerik:RadNumericTextBox>                               
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    
                                                                </td>
                                                                <td >
                                                                    <telerik:RadNumericTextBox  Visible="false" RenderMode="Auto" runat="server" ID="txt_pre_depre_val" Width="150px" NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0" EnabledStyle-HorizontalAlign="Right" 
                                                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.Susut", "{0:#,###,###0.00}") %>'>
                                                                        </telerik:RadNumericTextBox>  
                                                                </td>
                                                            </tr>
                                                                <tr>
                                                                <td >
                                                                    Acquisition Value
                                                                </td>
                                                                <td >
                                                                    <telerik:RadNumericTextBox  RenderMode="Auto" runat="server" ID="txt_acq_val" Width="150px" NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" Value="0" EnabledStyle-HorizontalAlign="Right" 
                                                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.aquis_value", "{0:#,###,###0.00}") %>'>
                                                                        </telerik:RadNumericTextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    Salvage Value
                                                                </td>
                                                                <td >
                                                                    <telerik:RadNumericTextBox  RenderMode="Auto" runat="server" ID="txt_salvage_val" Width="150px" NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  Value="0" EnabledStyle-HorizontalAlign="Right"
                                                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.harga_min", "{0:#,###,###0.00}") %>'>
                                                                        </telerik:RadNumericTextBox>
                                                                </td>
                                                            </tr>
                                   
                                                        </table>
                                                    </td>
                                                    <td style="vertical-align:top">
                                                        <table style="padding: 10px 0px 0px 40px">
                                                            <tr >
                                                                <td style="width:100px" >
                                                                    Useful Life (Hour)
                                                                </td>
                                                                <td>                                           
                                                                    <telerik:RadNumericTextBox  RenderMode="Auto" runat="server" ID="txt_uselife_hour" Width="100px" NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  Value="0" EnabledStyle-HorizontalAlign="Right"
                                                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.exp_life_hour", "{0:#,###,###0.00}") %>'>
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                            </tr>
                                                            
                                                            <tr >
                                                                <td >
                                                                    HM Min
                                                                </td>
                                                                <td>
                                                                    <telerik:RadNumericTextBox  RenderMode="Auto" runat="server" ID="txt_hm_min" Width="100px" NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  Value="0" EnabledStyle-HorizontalAlign="Right"
                                                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.hm_min", "{0:#,###,###0.00}") %>'>
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                            </tr>
                                                            <tr >
                                                                <td >
                                                                    HM Rate:
                                                                </td>
                                                                <td>
                                                                    <telerik:RadNumericTextBox  RenderMode="Auto" runat="server" ID="txt_hm_rate" Width="150px" NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false"  Value="0" EnabledStyle-HorizontalAlign="Right" 
                                                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" Skin="Glow"
                                                                        OnTextChanged="txt_hm_rate_TextChanged" >
                                                                    </telerik:RadNumericTextBox>
                                                                </td>
                                                            </tr>
                                                                <tr>
                                                                <td>
                                                                    Status
                                                                </td>
                                                                <td >
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_status" Width="150px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.status") %>' >
                                                                    </telerik:RadTextBox>
                                                                                                
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    Depre Start
                                                                </td>
                                                                <td colspan="3">
                                                                    <telerik:RadDatePicker ID="dtp_depre_start"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Depstart") %>' TabIndex="4" Skin="Glow"> 
                                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                        </DateInput>
                                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                                                    </telerik:RadDatePicker>
                                                                    <asp:RequiredFieldValidator runat="server" ID="dtp_depre_start_validator" ControlToValidate="dtp_depre_start" ForeColor="Red" 
                                                                    Font-Size="X-Small" Text="Required!" CssClass="required_validator"></asp:RequiredFieldValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    
                                                                </td>
                                                                <td colspan="3">
                                                                    <telerik:RadDatePicker Visible="false" ID="dtp_depre_last_post"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.Depstart") %>' TabIndex="4" Skin="Glow"> 
                                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                        </DateInput>
                                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                                                    </telerik:RadDatePicker>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>                            
                                                </tr>
                                            </table>
                                        </div>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView3" Height="358px">
                                        <div style="width:99%; padding: 10px 10px 10px 10px;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <table style="padding: 3px 0px 0px 10px">
                                                            <tr >
                                                                <td style="width:90px">
                                                                    Acc. Depr
                                                                </td>
                                                                <td>
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_acc_depre_no" Width="180px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ak_rek") %>'>
                                                                        </telerik:RadTextBox>
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_acc_depre_desc" Width="450px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ak_rek_name") %>'>
                                                                        </telerik:RadTextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    Cost. Depr
                                                                </td>
                                                                <td>
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_cost_depre_no" Width="180px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ak_cum_rek") %>'>
                                                                        </telerik:RadTextBox>
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_cost_depre_desc" Width="450px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ak_cum_rek_name") %>'>
                                                                        </telerik:RadTextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Acc. Lost
                                                                </td>
                                                                <td >
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_acc_lost_no" Width="180px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ak_ex_rek") %>'>
                                                                        </telerik:RadTextBox>
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_acc_lost_desc" Width="450px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ak_ex_rek_name") %>'>
                                                                        </telerik:RadTextBox>                        
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    Acc. Gain
                                                                </td>
                                                                <td >
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_acc_gain_no" Width="180px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ak_gain") %>'>
                                                                        </telerik:RadTextBox>
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_acc_gain_desc" Width="450px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ak_gain_name") %>'>
                                                                        </telerik:RadTextBox>                             
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    Acc. Disposal
                                                                </td>
                                                                <td >
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_acc_disposal_no" Width="180px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ak_disposal") %>'>
                                                                        </telerik:RadTextBox>
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_acc_disposal_desc" Width="450px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.ak_disposal_name") %>'>
                                                                        </telerik:RadTextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    Cost. Accu
                                                                </td>
                                                                <td >
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_cost_accu_no" Width="180px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.asset_rek") %>'>
                                                                        </telerik:RadTextBox>
                                                                    <telerik:RadTextBox ReadOnly="true" ID="txt_cost_accu_desc" Width="450px" runat="server" Skin="Glow"
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.asset_rek_name") %>'>
                                                                        </telerik:RadTextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>                            
                                                </tr>
                                            </table>
                                        </div>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView4" Height="358px">                                        
                                        <div style="width:99%; padding: 10px 10px 10px 10px;">
                                            <table>
                                                <tr>
                                                    <td>
                                                        <table style="padding: 3px 0px 0px 10px">
                                                            <tr >
                                                                <td style="width:110px">
                                                                    Sold Date
                                                                </td>
                                                                <td>
                                                                    <telerik:RadDatePicker ID="dtp_sold_date"  runat="server" MinDate="1/1/1900" Width="150px" RenderMode="Auto"
                                                                        DbSelectedDate='<%# DataBinder.Eval(Container, "DataItem.tgl_jual") %>' 
                                                                        TabIndex="4" Skin="Glow" DateInput-ReadOnly="true" Enabled="false"> 
                                                                        <Calendar runat="server" UseRowHeadersAsSelectors="False" UseColumnHeadersAsSelectors="False" Skin="Glow" 
                                                                            EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;"></Calendar>
                                                                        <DateInput runat="server" TabIndex="4" DisplayDateFormat="dd/MM/yyyy" DateFormat="dd/MM/yyyy" LabelWidth="40%">                            
                                                                        </DateInput>
                                                                        <DatePopupButton ImageUrl="" HoverImageUrl="" TabIndex="4"></DatePopupButton>                            
                                                                    </telerik:RadDatePicker>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td >
                                                                    Actual Resale Value
                                                                </td>
                                                                <td>
                                                                    <telerik:RadNumericTextBox  RenderMode="Auto" runat="server" ID="txt_actual_resale_val" Width="220px" NumberFormat-AllowRounding="true"
                                                                        NumberFormat-KeepNotRoundedValue="true" AllowOutOfRangeAutoCorrect="false" ReadOnly="true" Skin="Glow"
                                                                        onkeydown="blurTextBox(this, event)" Type="Number" NumberFormat-DecimalDigits="2" 
                                                                        Text='<%# DataBinder.Eval(Container, "DataItem.jumlah_jual", "{0:#,###,###0.00}") %>'>
                                                                        </telerik:RadNumericTextBox>  
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>                            
                                                </tr>
                                            </table>
                                        </div>
                                    </telerik:RadPageView>
                                    <telerik:RadPageView runat="server" ID="RadPageView5" Height="358px" >
                                        <div style="width:99%; padding: 10px 10px 10px 10px;">
                                                    <table>
                                                        <tr>
                                                            <td >
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_depre_by_prm" runat="server" Width="120px" Visible="false"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" AutoPostBack="true"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" Text="Monthly" 
                                                                    OnItemsRequested="cb_depre_prm_ItemsRequested" OnSelectedIndexChanged="cb_depre_by_prm_SelectedIndexChanged">                                                                                                     
                                                                </telerik:RadComboBox>
                                                            </td>
                                                            <td >
                                    
                                                                <telerik:RadComboBox RenderMode="Auto" ID="cb_years_depre_prm" runat="server" Width="120px" Visible="false"
                                                                    EnableLoadOnDemand="True" HighlightTemplatedItems="true" Label="Year :" ShowMoreResultsBox="true"
                                                                    MarkFirstMatch="true" Skin="Glow" EnableVirtualScrolling="true" 
                                                                    OnItemsRequested="cb_years_depre_prm_ItemsRequested" >                                                                                                     
                                                                </telerik:RadComboBox>
                                        
                                                            </td>
                                                            <td style="width:150px; padding-bottom:5px">
                                                                <asp:Button ID="btn_retrive_depre" runat="server" OnClick="btn_retrive_depre_Click" Text="Retrieve" 
                                                                    BorderStyle="None" BackColor="Orange" ForeColor="White" Width="90px" Height="25px" />                            
                                                            </td>
                               
                                                        </tr>
                                                    </table>
                                                <div style= " padding: 10px 10px 10px 10px;">
                                                    <telerik:RadGrid  RenderMode="Auto" ID="RadGrid2"  runat="server" AllowPaging="false" ShowFooter="false" Skin="Glow" Width="600px"
                                                        AllowSorting="True" AutoGenerateColumns="False" ShowStatusBar="true" PageSize="6" OnNeedDataSource="RadGrid2_NeedDataSource" >
                                                        <PagerStyle ShowPagerText="false" />                         
                                                        <MasterTableView CommandItemDisplay="Top" DataKeyNames="YearMonth" Font-Size="11px" Font-Names="Arial"
                                                        EditFormSettings-PopUpSettings-KeepInScreenBounds="true" AllowFilteringByColumn="false" 
                                                            CommandItemSettings-ShowAddNewRecordButton="false"
                                                                CommandItemSettings-ShowRefreshButton="false" >                                          
                                                            <Columns>
                               
                                                                <telerik:GridBoundColumn UniqueName="bulan_tahun" HeaderText="Year-Month" DataField="YearMonth"
                                                                    ItemStyle-Width="40px" FilterControlWidth="60px">                                    
                                                                    <HeaderStyle Width="40px" HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle Width="40px" HorizontalAlign="Left"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn UniqueName="Depre_Value" HeaderText="Depreciation Value" DataField="Depre_Value" 
                                                                    FilterControlWidth="60px" DataFormatString="{0:#,###,###0.00}" >
                                                                    <HeaderStyle Width="60px" HorizontalAlign ="Center"></HeaderStyle>
                                                                    <ItemStyle Width="60px" HorizontalAlign="Center"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn UniqueName="Depre_Value_com" HeaderText="Acumulated Depre." DataField="Depre_Value_com" 
                                                                    FilterControlWidth="60px" DataFormatString="{0:#,###,###0.00}" >
                                                                    <HeaderStyle Width="60px"  HorizontalAlign ="Center"></HeaderStyle>
                                                                    <ItemStyle Width="60px" HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn UniqueName="book_value" HeaderText="Book Value" DataField="book_value" 
                                                                        ItemStyle-Width="60px" FilterControlWidth="80px" DataFormatString="{0:#,###,###0.00}">
                                                                    <HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
                                                                    <ItemStyle Width="60px" HorizontalAlign="Right"></ItemStyle>
                                                                </telerik:GridBoundColumn>
                                                        
                                                            </Columns>
                   
                                                        </MasterTableView>
                                                    <ClientSettings>  
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="230" />                       
                                                        <Selecting AllowRowSelect="true"></Selecting>
                                                    </ClientSettings>
                                                    </telerik:RadGrid>
                                                </div>
                                        </div>
                    
                                    </telerik:RadPageView>
                                </telerik:RadMultiPage>
                            </div>--%>
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
    
    <telerik:RadNotification RenderMode="Auto" ID="notif" Text="Data telah disimpan" runat="server" Position="BottomRight" Skin="Silk"
                AutoCloseDelay="10000" Width="350" Height="110" Title="Confirmation" EnableRoundedCorners="true">
    </telerik:RadNotification>
</asp:Content>
