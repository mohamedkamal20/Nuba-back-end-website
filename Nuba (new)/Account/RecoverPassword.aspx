<%@ Page Title="" Language="C#" MasterPageFile="~/Account/Account.master" AutoEventWireup="true" CodeFile="RecoverPassword.aspx.cs" Inherits="Account_RecoverPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AccountHead" Runat="Server">
    <title> password recovery</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="form-signin">
    <div class="text-center">
        <img src="../assets/img/logo.png" alt="Wellcome" style="background-color: #000000" >
    </div>
    <hr>
    
        
        <div id="forgot" class="tab-pane">
            
                <p class="text-muted text-center">ادخل بريدك الالكترونى</p>
                <asp:TextBox runat="server" ID="recoverPasswordTextBox" placeholder="mail@domain.com" class="form-control" TextMode="Email"/>
                
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ErrorMessage="يجب إدخال بريد الكتروني" ControlToValidate="recoverPasswordTextBox" ForeColor="#FF3300"></asp:RequiredFieldValidator>
                <br>
                <asp:Button class="btn btn-lg btn-danger btn-block" OnClick="Recover"  runat="server"  type="submit" text="ارسال رسالة" />
            
        </div>
        
    
    <hr>
    <div class="text-center">
        <ul class="list-inline">
            <li><a class="text-muted" href="Login.aspx" >دخول</a></li>
            <li><a class="text-muted" href="Register.aspx">تسجيل</a></li>
        </ul>
    </div>
  </div>

</asp:Content>

