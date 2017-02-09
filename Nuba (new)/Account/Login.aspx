<%@ Page Title="" Language="C#" MasterPageFile="~/Account/Account.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Account_Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AccountHead" Runat="Server">
    <title> login page</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="form-signin">
    <div class="text-center">
        <img src="../assets/img/logo.png" alt="Wellcome" style="background-color: #000000" >
    </div>
    <hr>
    <div class="tab-content">
        <div id="login" class="tab-pane active">
            
                <p class="text-muted text-center">
                   ادخل الاسم و الرقم السري
                </p>
                
                <asp:TextBox runat="server" ID="UserName" placeholder="الاسم" class="form-control top" />
                <asp:TextBox runat="server" ID="Password" placeholder="الرقم السري"  class="form-control bottom" TextMode="Password" />
                <!-- <input type="text" placeholder="Username" ID="UserName" class="form-control top"> 
                <input type="password" ID="Password" placeholder="Password" class="form-control bottom">-->
                <div class="checkbox">
		          &nbsp &nbsp <asp:CheckBox runat="server" ID="RememberMe" Text="Remember me" />
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorUserName" runat="server" ErrorMessage="يجب إدخال اسم" ControlToValidate="UserName" ForeColor="#FF3300"></asp:RequiredFieldValidator>
                    <br />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPass" runat="server" ErrorMessage="يجب إدخال الرقم السري" ControlToValidate="Password" ForeColor="#FF3300"></asp:RequiredFieldValidator>
		        </div>
                <asp:Button class="btn btn-lg btn-primary btn-block" OnClick="LogIn"  runat="server"  type="submit" text="تسجيل الدخول" />
            
        </div>  
    </div>
    <hr>
    <div class="text-center">
        <ul class="list-inline">
            <li><a class="text-muted" href="RecoverPassword.aspx" >نسيت كلمت السر</a></li>
            <li><a class="text-muted" href="Register.aspx">تسجيل</a></li>
        </ul>
    </div>
  </div>

</asp:Content>

