<%@ Page Title="" Language="C#" MasterPageFile="~/Account/Account.master" AutoEventWireup="true" CodeFile="AccessDenied.aspx.cs" Inherits="Account_AccessDenied" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AccountHead" Runat="Server">
    <title> access denied</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
     <div>
    <br />
     <br />
                <asp:Label ID="LabelAccessDenied" runat="server" ForeColor="#FF3300" Text="Access Denied" Width="100%" Height="200%" style="font-size: xx-large;"></asp:Label>
    </div>
</asp:Content>

