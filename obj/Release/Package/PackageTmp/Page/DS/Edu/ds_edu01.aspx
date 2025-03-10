<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ds_edu01.aspx.cs" Inherits="PRIMA_HRIS.Page.DS.Edu.ds_edu01" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../../styles/custom-cs.css" rel="stylesheet" />    
    <link href="../../../styles/mail.css" rel="stylesheet" />
    <script src="../../../script/scripts.js"></script>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
            
            function rowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }
            
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

    <div  class="scroller" runat="server" style="overflow-y:auto; height:575px; font-size:small; font-family:Tahoma; background-color:#303d3f">
        <telerik:RadGrid ID="RadGrid1" runat="server" RenderMode="Auto" AllowPaging="True" PageSize="10" 
            ShowFooter ="False" CssClass="RadGrid_ModernBrowsers" AllowFilteringByColumn="false"
            AutoGenerateColumns="False" MasterTableView-AutoGenerateColumns="False"
            
            Skin ="Glow" AllowSorting="True">
            <PagerStyle Mode="NextPrevNumericAndAdvanced" Position="Top" ForeColor="#0099CC" VerticalAlign="Middle"></PagerStyle> 
            <ClientSettings EnablePostBackOnRowClick="true" EnableRowHoverStyle="true" Selecting-AllowRowSelect="true" EnableAlternatingItems="false"/>
            <AlternatingItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
            <HeaderStyle Font-Names="Tahoma" Font-Size="11px" Font-Bold="true" ForeColor="DarkOrange"/> 
            <ItemStyle Font-Names="Tahoma" Font-Size="12px" ForeColor="YellowGreen" />
            <SelectedItemStyle Font-Italic="False"/>
            <SortingSettings EnableSkinSortStyles="false" />
            <MasterTableView CommandItemDisplay="Bottom" Font-Size="11px" Font-Names="Tahoma" DataKeyNames="" EditMode="EditForms" 
            EditFormSettings-PopUpSettings-Modal="true" AllowFilteringByColumn="false" EditFormSettings-PopUpSettings-KeepInScreenBounds="true" >
                <CommandItemStyle ForeColor="YellowGreen" />                
            <Columns>
                <telerik:GridEditCommandColumn UniqueName ="EditCommandColumn">
                    <HeaderStyle Width ="40px" ></HeaderStyle>
                    <ItemStyle Width="40px" />
                </telerik:GridEditCommandColumn>
                <telerik:GridBoundColumn HeaderText ="Code" DataField ="LocationCode" >
                    <HeaderStyle Width ="70px" > </HeaderStyle>
                    <ItemStyle Width="70px" />
                </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText ="Project Area" DataField ="LocationName" >
                    <HeaderStyle Width ="520px" > </HeaderStyle>
                    <ItemStyle Width="520px" />
                </telerik:GridBoundColumn>               
                <telerik:GridButtonColumn UniqueName ="DeleteColumn" Text ="Delete" HeaderText="Delete" CommandName="Delete" HeaderStyle-Width="30px" 
                    ItemStyle-ForeColor="OrangeRed" ConfirmText="Delete This Location?" ConfirmDialogType="RadWindow" ConfirmTitle="Delete" ButtonType="FontIconButton">
                    <HeaderStyle Width="30px"></HeaderStyle>
                </telerik:GridButtonColumn>
            </Columns>
            <EditFormSettings EditFormType="Template">
                <FormTemplate>
                    <div style="padding: 15px 5px 25px 15px; background: none repeat scroll 0 0;">
                        <table id="Table2" border="0" >
                            <tr >
                                <td colspan="2" style=" padding-bottom:20px">
                                    <asp:Button ID="btnUpdate" Text='<%# (Container is GridEditFormInsertItem) ? "Insert" : "Update" %>' 
                                            runat="server" CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                        BorderStyle="Solid" BorderWidth="1px" BorderColor="YellowGreen" 
                                        ForeColor="White" BackColor="OrangeRed" Width="100px" Height="25px" />                                                                               
                                    <asp:Button ID="btnCancel" Text="Cancel" runat="server" CausesValidation="false" CommandName="Cancel"
                                        BorderStyle="Solid" BorderWidth="1px" BorderColor="YellowGreen" 
                                    ForeColor="White" BackColor="OrangeRed" Width="100px" Height="25px" />
                                </td>
                            </tr>
                            <tr class="EditFormHeader">
                                <td colspan="2">
                                    <b style="font-weight: bold; font-variant: small-caps; text-decoration: underline; color: #ff6a00;">Project</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Code:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_region_code" runat="server" Width="70px" Enabled="true"
                                        RenderMode="Auto" Text='<%# DataBinder.Eval(Container, "DataItem.LocationCode") %>' AutoPostBack="false"></telerik:RadTextBox>

                                </td>
                            </tr>
                            <tr>
                                <td style="width:100px">
                                    Project Area:
                                </td>
                                <td>
                                    <telerik:RadTextBox ID="txt_region_name" runat="server" Width="350px" Enabled="true"
                                        RenderMode="Auto" Text='<%# DataBinder.Eval(Container, "DataItem.LocationName") %>'  AutoPostBack="false"></telerik:RadTextBox>
                                </td>
                            </tr>
                            <tr>
                        </table> 
                    </div>
                </FormTemplate>
            </EditFormSettings>     
        </MasterTableView>
        </telerik:RadGrid>
    </div>
</asp:Content>
