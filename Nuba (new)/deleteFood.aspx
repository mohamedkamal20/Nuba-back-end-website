<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="deleteFood.aspx.cs" Inherits="deleteFood" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

                            
                               
                                <div class="col-lg-8" dir="rtl" style="float:right;">

                               <asp:DropDownList ID="DropDownListCategory" class="form-control"  runat="server" DataTextField="Category"
                                 DataValueField="ID" OnSelectedIndexChanged="DropDownListCategory_SelectedIndexChanged" AutoPostBack="True">
                                </asp:DropDownList>
                            
                                <br />
                                <asp:DropDownList ID="DropDownListFood" runat="server" class="form-control" Visible="false"
                                    DataTextField="Title" DataValueField="ID">
                                </asp:DropDownList>   
                                  <br />
                                    <asp:Button ID="ButtonDelete" runat="server" Text="ازالة" Height="10%" Visible="false" Width="10%" OnClick="ButtonDelete_Click" CausesValidation="False" />
                                    <asp:Label ID="Label1" runat="server" Text="Done" Visible="False" Width="80px"></asp:Label>
                                    </div>


</asp:Content>

