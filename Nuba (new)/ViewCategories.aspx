<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" EnableEventValidation="false" ValidateRequest="false" AutoEventWireup="true" CodeFile="ViewCategories.aspx.cs" Inherits="ViewCategories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" Runat="Server">
     
    <title>عرض التصنيفات</title>
    <script>
     function Confirm() {
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            if (confirm("هذا التصنيف يحتوى على عدة مقالات هل تريد مسح الكل ؟")) {
                confirm_value.value = "لا";
            } else {
                confirm_value.value = "نعم";
            }
            document.forms[0].appendChild(confirm_value);
        }
    </script>
    <!-- Bootstrap -->
    <link rel="stylesheet" href="../assets/lib/bootstrap/css/bootstrap.rtl.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="../assets/lib/font-awesome/css/font-awesome.css">

    <!-- Metis core stylesheet -->
    <link rel="stylesheet" href="../assets/css/main.rtl.css">

    <!-- metisMenu stylesheet -->
    <link rel="stylesheet" href="../assets/lib/metismenu/metisMenu.css">

    <!-- animate.css stylesheet -->
    <link rel="stylesheet" href="../assets/lib/animate.css/animate.css">

    <style media="screen">
        body {
            direction: rtl;
        }
    </style>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.12/css/dataTables.bootstrap.min.css">

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


    <!-- metisMenu stylesheet -->
    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/metisMenu/1.1.3/metisMenu.min.css">
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">
   <div class="row">
     <div class="col-lg-9" ">
        <div class="box dark" style=" margin:30px auto;">
            <header>
                <div class="icons">
                    <i class="fa fa-edit"></i></div>
                <h5>التصنيفات</h5>
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
            <div id="defaultTable" class="body collapse in" style="height: auto">
                    <asp:ListView  ID="CategoriesList" runat="server" DataSourceID="Ds_getCategories"  class="table responsive-table">
                        <ItemTemplate>
                            <span style="">
                                <div class="form-group">
                                    <div class="col-lg-12">           
                                       <div class="form-group"></div>
                                         <asp:label class="control-label col-lg-4"  Text='<%# Eval("Expr1") %>' runat="server" ID="lbl1" Visible="false" /><br />
                                        <asp:Label class="control-label col-lg-4" Text='<%# Eval("Image_Path") %>' runat="server" ID="lbl2" Visible="false" /><br />
                                        <asp:Label ID="lbl_Category" class="control-label col-lg-12" Font-Size="Large" Font-Bold="true" runat="server" Text='<%# Eval("Category") %>' />
                                        <div class="form-group" style="margin-top:20px"></div><br /><br />
                                       <asp:Label ID="Label" class="control-label " Font-Bold="true" runat="server" Text="التصنيف الأم : "   />
                                        <asp:Label ID="lbl_Parent" class="control-label " runat="server" Text='<%# Eval("Expr1") %>' />
                                         <div class="form-group" style="margin-bottom:10px"></div><br />
                                         <asp:Image ID="img" Class="bgimage" runat="server" Width="200" Height="200" src='<%# "/Images/Categories/" + Eval("Image_Path") %>' />

                                        <div class="form-group" style="margin-bottom:10px"></div><br />
                                        
                                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" Text="مسح" CausesValidation="false" OnClick="btn_Delete_Click" CommandArgument='<%# Eval("ID") %>' runat="server"/>
                                        
                                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="btn_Edit" runat="server" Text="تعديل" CausesValidation="false" OnClick="btn_Edit_Click" CommandArgument='<%# Eval("ID") %>' />
                                       
                                         <div class="form-group" style="margin-bottom:10px"></div>
                                    </div>
                                </div>
                            </span>
                        </ItemTemplate>
                    </asp:ListView>
                   <asp:DataPager ID="DataPagerProducts" Class="dataTables_paginate paging_simple_numbers" runat="server" PagedControlID="CategoriesList"
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
    </div>

 <asp:SqlDataSource ID="Ds_getCategories" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="getCategories" SelectCommandType="StoredProcedure"></asp:SqlDataSource>

</asp:Content>

