<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" EnableEventValidation="false" ValidateRequest="false" CodeFile="EditArticles.aspx.cs" Inherits="EditArticles" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder" runat="server">

    <title>تعديل المقالات</title>




    <!-- Metis core stylesheet -->
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


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="col-lg-9">
        <div class="box dark" style="margin: 30px auto;padding-right:20px">
            <header>
                <div class="icons">
                    <i class="fa fa-edit"></i>
                </div>
                <h5>تعديل المقال</h5>
                <!-- .toolbar -->
                <div class="toolbar">
                    <nav style="padding: 8px;">
                        <a href="javascript:;" class="btn btn-default btn-xs collapse-box">
                            <i class="fa fa-minus"></i>

                        </a>
                    </nav>
                </div>
                <!-- /.toolbar -->

            </header>
            <div  style="min-height: 300px;">
                <div class="form-horizontal">
                    <div class="form-group">
                        <div class="col-lg-8">
                            <asp:TextBox class="form-control" ID="txt_Photo_cap" runat="server" Text="" Visible="false"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-8">
                            <asp:Label class="control-label" ID="lbl_ID" runat="server" Text="" Visible="false"></asp:Label>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-lg-12">
                            <label for="text1" id="lbl_AName" runat="server" class="control-label">عنوان المقال</label>
                        </div>
                        <div class="col-lg-8">

                            <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" Style="opacity: 0.87; position: absolute; top: 0px; left: -85px; margin-top: -35px;" ID="vald_RequiredName" runat="server" ControlToValidate="txt_ART_name">
                            <div class="formErrorContent">* This field is required<br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                            </asp:RequiredFieldValidator>
                            <asp:TextBox type="text" ID="txt_ART_name" runat="server" class="validate[required] form-control" placeholder="عنوان المقال">
                            </asp:TextBox>

                        </div>
                    </div>
                    <div class="form-group col-lg-12"></div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <label id="lbl_ADesc" runat="server" class="control-label">تصنيف المقال</label>
                        </div>
                        <div class="col-lg-8">

                            <asp:DropDownList runat="server" DataTextField="Category" DataValueField="ID" DataSourceID="Ds_getCategories" ID="Cat_List" class="form-control chzn-select" TabIndex="2">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group col-lg-12"></div>
                    <!-- /.form-group -->
                    <div class="form-group">
                        <div class="form-group col-lg-12">
                            <label for="autosize" style="margin-right:20px" id="lbl_ACategory" class="control-label ">الوصف</label>
                        </div>
                        <div class="col-lg-8">
                            <asp:TextBox Style="min-height: 200px" ID="txt_ART_Desc" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group col-lg-12"></div>
                    <!-- /.form-group -->

                    <div class="form-group" style="margin-bottom: 50px">
                        <div class="col-lg-12">
                            <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="btn_EditArt" runat="server" Text="تعديل بيانات المقال" OnClick="btn_EditArt_Click" />
                        </div>
                    </div>
                    <div class="form-group col-lg-12"></div>

                </div>
            </div>
        </div>
    </div>
    <div class="row">
    <div class="col-lg-9">
        <div class="box dark" style="margin: 30px 15px;">
            <header>
                <div class="icons">
                    <i class="fa fa-edit"></i>
                </div>
                <h5>إضافة صورة للمقال</h5>
                <!-- .toolbar -->
                <div class="toolbar">
                    <nav style="padding: 8px;">
                        <a href="javascript:;" class="btn btn-default btn-xs collapse-box">
                            <i class="fa fa-minus"></i>

                        </a>
                    </nav>
                </div>
                <!-- /.toolbar -->

            </header>
            <div style="min-height: 250px; padding-right: 10px;margin-right:15px">
                <div class="form-horizontal">
                    <div class="form-group"></div>

                    <div class="form-group col-lg-12">
                        <asp:RegularExpressionValidator class="reqformError parentFormpopup-validation formError"  Style="opacity: 0.87; position: absolute; top: 0px; left: 650px; margin-top: -35px;" ID="RegularExpressionValidator1" runat="server" ValidationGroup="upload" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.jpg|.gif|.png|.bmp|.jpeg|tif|.JPEG|.GIF|.JPG|.PNG|.BMP|.TIF)$" ControlToValidate="File_AddImage">
       <div class="formErrorContent">* تأكد من صيغة الفايل المضاف<br></div>
                            <div class="formErrorArrow">
                                <div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                        </asp:RegularExpressionValidator>
                        <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError"  Style="opacity: 0.87; position: absolute; top: 0px; left: 650px; margin-top: -35px;" ID="RequiredFieldValidator1" ControlToValidate="File_AddImage" runat="server" ValidationGroup="upload">
         <div class="formErrorContent">* يجب ادخال الصورة اولا<br></div>
                            <div class="formErrorArrow">
                                <div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                        </asp:RequiredFieldValidator>

                        <asp:FileUpload class="validate[required] fileinput fileinput-new" ID="File_AddImage"  ValidationGroup="upload" runat="server" />

                    </div>
                    <div class="form-group"></div>

                    <div class="row form-group">
                        <div class="col-lg-12">
                            <label for="autosize" id="lbl_Caption" class="control-label ">نبذة عن الصورة</label>
                        </div>
                        <div class="col-lg-6">
                            <asp:TextBox Style="min-height: 100px" ID="txt_img_caption" runat="server" class="form-control" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group col-lg-12"></div>
                    <div class="form-group" style="margin-bottom: 50px">
                        
                        <div class="col-lg-12">
                            <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="btn_Add" runat="server" CausesValidation="true" ValidationGroup="upload" Text="أضف" OnClick="ADD_Click"  />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        </div>
    <div class="row">
        <div class="col-lg-9" style="margin-right: 15px" id="div_show" runat="server">
            <div class="box">
                <header>
                    <div class="icons"><i class="fa fa-table"></i></div>
                    <h5>صور المقالة </h5>
                    <div class="btn-group" style="float: left">
                        <a href="#defaultTable" data-toggle="collapse" class="btn btn-sm btn-default minimize-box">
                            <i class="fa fa-angle-up"></i>
                        </a>
                    </div>
                </header>
                <div id="defaultTable" class="body collapse in" style="height: auto;margin-right:15px">
                    <asp:ListView ID="PhotosList" OnItemDataBound="PhotosList_ItemDataBound" runat="server" DataKeyNames="ID" DataSourceID="Ds_Photos" OnItemCommand="PhotosList_ItemCommand" class="table responsive-table">
                        <ItemTemplate>
                            <span style="">
                                <div class="form-group">
                                    <div class="col-lg-12">

                                        <div class="form-group"></div>

                                        <asp:Image Class="bgimage" ID="img" runat="server" Width="200" Height="200" src='<%# "/Images/Articles/" + Eval("path") %>' /><br />
                                        <div class="form-group"></div>
                                        <asp:TextBox Style="min-height: 150px" runat="server" class="form-control col-lg-6" TextMode="MultiLine" ID="txt_cap" Text='<%# Eval("Caption")%>' />
                                        <div class="form-group"></div>
                                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="btn_EditCap" runat="server" CausesValidation="false" Text="تعديل النبذة" OnClick="Edit_CAP" CommandArgument='<%# Eval("ID")+"#"+ Container.DataItemIndex%>' />
                                        <div class="form-group"></div>
                                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="Delete" runat="server" Text="مسح الصورة" CausesValidation="false" OnClick="Delete_Click" CommandArgument='<%# Eval("ID") %>' />
                                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="btn_MainPhoto" runat="server" CausesValidation="false" Text="Button" OnClick="MakeItMain" CommandArgument='<%# Eval("Main")+"#"+ Container.DataItemIndex%>' />

                                    </div>
                                </div>
                            </span>
                        </ItemTemplate>
                    </asp:ListView>

                </div>
                 <div class="form-group" style="margin-top:30px">
                   <asp:DataPager ID="DataPagerProducts" Class="dataTables_paginate paging_simple_numbers" runat="server" PagedControlID="PhotosList"
                        PageSize="3" OnPreRender="DataPagerProducts_PreRender">
                       <Fields>
                            <asp:NextPreviousPagerField ButtonCssClass="paginate_button" ShowFirstPageButton="True" ShowNextPageButton="False" />
                            <asp:NumericPagerField CurrentPageLabelCssClass="paginate_button" NextPreviousButtonCssClass="paginate_button"  />
                            <asp:NextPreviousPagerField ButtonCssClass="paginate_button" ShowLastPageButton="True" ShowPreviousPageButton="False" />
                        </Fields>
                       </asp:DataPager>
                     </div>
            </div>
        </div>
    </div>
     
    <asp:SqlDataSource ID="Ds_Photos" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SelectPhotos" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="lbl_ID" PropertyName="Text" Name="ART_ID" Type="Int32" DefaultValue="0"></asp:ControlParameter>
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="Ds_getCategories" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="SELECT ID, Category FROM Categories"></asp:SqlDataSource>


</asp:Content>

