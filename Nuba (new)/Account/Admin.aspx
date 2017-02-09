<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Account_Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">


    <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" ;>

        <header>
                                              <div class="icons"><i class="fa fa-edit"></i></div>
                                                <h5>Admin page</h5>
                                                            <!-- .toolbar -->
                                                                    <div class="toolbar">
                                                                    <nav style="padding: 8px;">
                                                                            <a href="javascript:;" class="btn btn-default btn-xs collapse-box">
                                                                             <i class="fa fa-minus"></i>
                                                                                </a>
                                                                        </nav>
                                                                     </div>            <!-- /.toolbar -->
       </header>


<br />
                                          <br />
<asp:GridView ID="GridViewAdmin" runat="server" AutoGenerateColumns="False" OnRowCommand="GridViewAdmin_RowCommand">
        <Columns>
            <asp:BoundField DataField="UserName" HeaderText="Name" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="TwoFactorEnabled" HeaderText="locked" />
            <asp:TemplateField HeaderText="Enable">
                <ItemTemplate>
                    <asp:Button ID="ButtonEnable" enabled="true" CommandArgument='<%# Eval("UserName") %>' runat="server" Text='<%# Convert.ToInt32(Eval("TwoFactorEnabled")) == 0 ? "Enable":"Disable" %>'   />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
        



                                          </div>
                                    </div>
        </div>

</asp:Content>

