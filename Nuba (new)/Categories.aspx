<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" EnableEventValidation="false" ValidateRequest="false" AutoEventWireup="true" CodeFile="Categories.aspx.cs" Inherits="Categories" %>
<%@ Import Namespace="System.Data" %>
<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder" runat="server">

      <script type = "text/javascript">
          function Confirm() {
              var confirm_value = document.createElement("INPUT");
              confirm_value.type = "hidden";
              confirm_value.name = "confirm_value";
              if (confirm("هل تريد مسح التصنيف والمقالات التى يحتوى عليها؟")) {
                  confirm_value.value = "لا";
              } else {
                  confirm_value.value = "نعم";
              }
              document.forms[0].appendChild(confirm_value);
          }
    </script>
    <link rel="stylesheet" href="../assets/css/main.rtl.css">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="../assets/lib/bootstrap/css/bootstrap.rtl.css">
        <link rel="stylesheet" href="/assets/lib/inputlimiter/jquery.inputlimiter.css">
        <link rel="stylesheet" href="/assets/lib/bootstrap-daterangepicker/daterangepicker-bs3.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/Uniform.js/2.1.2/themes/default/css/uniform.default.min.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/chosen/1.1.0/chosen.min.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jquery-tagsinput/1.3.3/jquery.tagsinput.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jasny-bootstrap/3.1.3/css/jasny-bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/3.3.2/css/bootstrap3/bootstrap-switch.min.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.1/css/datepicker3.min.css">
        <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-colorpicker/2.0.1/css/bootstrap-colorpicker.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

    <!--For Development Only. Not required -->
    <script>
        less = {
            env: "development",
            relativeUrls: false,
            rootpath: "/assets/"
        };
    </script>
    <link rel="stylesheet" href="../assets/css/style-switcher.css">
    <link rel="stylesheet/less" type="text/css" href="../assets/less/theme.less">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/less.js/2.7.1/less.js"></script>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.2.0/css/font-awesome.min.css">
       <script src="//cdnjs.cloudflare.com/ajax/libs/less.js/2.2.0/less.min.js"></script>

    <!--Modernizr-->
    <script src="//cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>

      <!-- metisMenu stylesheet -->
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/metisMenu/1.1.3/metisMenu.min.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.2/jquery-ui.theme.min.css">
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/jQuery-Validation-Engine/2.6.4/validationEngine.jquery.min.css">
   <!--jQuery -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jQuery-Validation-Engine/2.6.4/jquery.validationEngine.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jQuery-Validation-Engine/2.6.4/languages/jquery.validationEngine-en.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.13.1/jquery.validate.min.js"></script>
     <!--Bootstrap -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.1/js/bootstrap.min.js"></script>

    <!-- MetisMenu -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/metisMenu/1.1.3/metisMenu.min.js"></script>

    <!-- Screenfull -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/screenfull.js/2.0.0/screenfull.min.js"></script>

    <!-- Metis core scripts -->
    <script src="assets/js/core.min.js"></script>

    <!-- Metis demo scripts -->
    <script src="assets/js/app.js"></script>
    <script>
        $(function () {
            Metis.formValidation();
        });
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">

    <div class="col-lg-9" ">
        <div class="box dark" style=" margin:30px auto;">
            <header>
                <div class="icons">
                    <i class="fa fa-edit"></i></div>
                <h5 runat="server" id="h"></h5>
                <!-- .toolbar -->
                <div class="toolbar">
                    <nav style="padding: 8px;">
                        <a href="javascript:;" class="btn btn-default btn-xs collapse-box">
                            <i class="fa fa-minus">
                            </i>
                           
                        </a>
                    </nav>
                </div>
                <!-- /.toolbar -->
                
            </header>
            <div id="body collapse in"   style="min-height:300px;padding-right:10px" >
                <div class="form-horizontal" id="form" >

                    <asp:Label ID="lbl_imgPath" runat="server" Text="" Visible="false"></asp:Label> 
                    <div class="form-group col-lg-12">
                        <div class="form-group col-lg-12"></div> 
                        <label ID="lbl_ParentCat" runat="server"  class="control-label">التصنيف الام</label>
                        <div class="form-group col-lg-12"> 
                            <asp:DropDownList runat="server" ID="DropDownList_CatParents" DataSourceID="Ds_Categories" DataTextField="Category" DataValueField="ID" class="form-control chzn-select" TabIndex="2">
                            </asp:DropDownList>
                            <asp:SqlDataSource runat="server" ID="Ds_Categories" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT ID , Category  FROM Categories"></asp:SqlDataSource>
                        </div>
                   </div>
                    <div class="form-group col-lg-12"></div> 
                    <div class="form-group col-lg-12">
                        <label for="text1"  ID="lbl_CatName" runat="server"  class="control-label">اسم التصنيف</label>
                        <div class="form-group col-lg-12">
                            <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left: -85px; margin-top: -35px;" ID="vald_RequiredName" runat="server"  ControlToValidate="txt_AddName">
                            <div class="formErrorContent">*يجب إدخال اسم التصنيف <br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                                 </asp:RequiredFieldValidator>
                            <asp:TextBox type="text" ID="txt_AddName" runat="server" class="validate[required] form-control" placeholder="إسم التصنيف">
                                </asp:TextBox>
                            
                        </div>
                    </div>
                    <div class="form-group col-lg-12"></div>
                    
                    <!-- /.form-group -->
                    <div class="form-group">
                        <div class="col-lg-8">
                           <asp:CheckBox ID="CheckBox_Food" runat="server" Text="تصنيف خاص بالطعام"/>
                        </div>
                    </div>
                    <div class="form-group col-lg-12"></div>
                    <!-- /.form-group -->
                   
                    <div class="form-group" style="margin-bottom:50px">
                        <div class="col-lg-12">  
                       <asp:Image ID="img_CatImg" runat="server" Width="200" Height="200" class="bgimage"/><br />
                            <br />
                            <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="btn_DeleteCatPhoto" runat="server" Visible="false" OnClick="btn_DeleteCatPhoto_Click" Text="مسح صورة التصنيف" />
                    </div>
                   </div>
                   <div class="form-group col-lg-12"></div>
                    <div class="form-group" style="margin-top:50px">
                        <div class="col-lg-3">
                            <asp:RegularExpressionValidator class="reqformError parentFormpopup-validation formError" ID="RegularExpressionValidator2" runat="server" ValidationGroup="upload" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.jpg|.gif|.png|.bmp|.jpeg|tif|.JPEG|.GIF|.JPG|.PNG|.BMP|.TIF)$" ControlToValidate="File_CatImage">
       <div class="formErrorContent">* تأكد من صيغة الفايل المضاف<br></div>
                            <div class="formErrorArrow">
                                <div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                        </asp:RegularExpressionValidator>
                            <asp:FileUpload class="validate[required] fileinput fileinput-new" ID="File_CatImage" runat="server" />

                        </div>
                    </div>
                        <div class="form-group col-lg-12"></div>
                    <div class="form-group">
                        <div class="col-lg-3">
                            <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="btn" runat="server" OnClick="btn_Click"/>
                                
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
        
   
</asp:Content>

