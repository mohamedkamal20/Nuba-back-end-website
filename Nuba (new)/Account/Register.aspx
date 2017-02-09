<%@ Page Title="" Language="C#" MasterPageFile="~/Account/Account.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Account_Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AccountHead" Runat="Server">
    <title> register page</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

     <div class="form-signin">
    <div class="text-center">
        <img src="../assets/img/logo.png" alt="Wellcome" style="background-color: #000000" >
    </div>
       <hr>
    
        <div id="signup" class="tab-pane">
            
                <!--
                <input type="text" placeholder="الاسم" class="form-control top">
                <input type="email" placeholder="mail@domain.com" class="form-control middle">
                <input type="password" placeholder="كلمة السر" class="form-control middle">
                <input type="password" placeholder="اعد كتابة كلمة السر" class="form-control bottom"> -->
                <asp:TextBox runat="server" ID="UserName2" placeholder="الاسم" class="form-control top" />
                <asp:TextBox runat="server" ID="Email2" placeholder="mail@domain.com" class="form-control middle" TextMode="Email"/>
                <asp:TextBox runat="server" ID="Password2" placeholder="كلمة السر" class="form-control middle" TextMode="Password"/>
                <asp:TextBox runat="server" ID="ConfirmPassword2" placeholder="اعد كتابة كلمة السر" class="form-control bottom" TextMode="Password"/>
            
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorUserName" runat="server" ErrorMessage="يجب إدخال اسم" ControlToValidate="UserName2" ForeColor="#FF3300"></asp:RequiredFieldValidator>
                 <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ErrorMessage="يجب إدخال البريد الالكتروني" ControlToValidate="Email2" ForeColor="#FF3300"></asp:RequiredFieldValidator>
                 <br />
                 <asp:RequiredFieldValidator ID="RequiredFieldValidatorPass" runat="server" ErrorMessage="يجب إدخال الرقم السري" ControlToValidate="Password2" ForeColor="#FF3300"></asp:RequiredFieldValidator>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorConfirmPass" runat="server" ErrorMessage="يجب إدخال الرقم السري مرة اخرى" ControlToValidate="ConfirmPassword2" ForeColor="#FF3300"></asp:RequiredFieldValidator>
                <br />
                <asp:CompareValidator ID="CompareValidatorPassword" runat="server" ErrorMessage="يجب ان يكون الرقمان متطابقان" ControlToCompare="Password2" ControlToValidate="ConfirmPassword2" ForeColor="#FF3300"></asp:CompareValidator>
                
                <asp:Button class="btn btn-lg btn-success btn-block" OnClick="CreateUser_Click" runat="server" type="submit" Text="تسجيل"/>
          
        </div>
        
    <hr>
    <div class="text-center">
        <ul class="list-inline">
            <li><a class="text-muted" href="Login.aspx" >دخول</a></li>
            <li><a class="text-muted" href="RecoverPassword.aspx" >نسيت كلمت السر</a></li>
        </ul>
    </div>
  </div>

</asp:Content>

