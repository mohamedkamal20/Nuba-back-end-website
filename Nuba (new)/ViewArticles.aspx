<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" EnableEventValidation="false" ValidateRequest="false" AutoEventWireup="true" CodeFile="ViewArticles.aspx.cs" Inherits="ViewArticles" %>

<asp:Content ID="content" ContentPlaceHolderID="ContentPlaceHolder" runat="server">

    <title>عرض المقالات</title>

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
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

    <div class="form-group" style="margin-top:30px;">
        <label id="lbl_Cat_Choose" runat="server" class="control-label col-lg-4">اختر تصنيف المقال</label>

        <div class="col-lg-9">

            <asp:DropDownList runat="server" DataTextField="Category" DataValueField="ID" DataSourceID="Ds_getCategories" ID="DropDownList_Categories" AutoPostBack="True" class="form-control chzn-select" TabIndex="2">
            </asp:DropDownList>
        </div>
    </div>
    <div class="form-group col-lg-12"></div>
    <div class="form-group col-lg-12"></div>

    <div class="row">
        <div class="col-lg-9" style="margin-right: 15px" id="div_show" runat="server">
            <div class="box">
                <header>
                    <div class="icons"><i class="fa fa-table"></i></div>
                    <h5>المقالات</h5>
                    <div class="btn-group" style="float: left">
                        <a href="#defaultTable" data-toggle="collapse" class="btn btn-sm btn-default minimize-box">
                            <i class="fa fa-angle-up"></i>
                        </a>
                    </div>
                </header>
                <div id="defaultTable" class="body collapse in" style="height: auto">
                    <asp:ListView ID="ArticlesList" runat="server" DataSourceID="Ds_Articles" class="table responsive-table">
                        <ItemTemplate>
                            <span style="">
                                <div class="form-group">
                                    <div class="col-lg-12">
                                        <asp:label class="control-label col-lg-4" Text='<%# Eval("path") %>' runat="server" ID="lbl1" Visible="false" /><br />
                                        <asp:Label class="control-label col-lg-4" Text='<%# Eval("ID") %>' runat="server" ID="lbl_ID" Visible="false" /><br />
                                        <asp:Label style="font-size:large" class="control-label col-lg-12" runat="server" ID="lbl_Art_Title" Font-Bold="true" Text='<%# Eval("Art_Title") %>' />
                                       <div class="form-group"></div>
                                        <asp:Image Class="bgimage" ID="MainImg" runat="server" Width="200" Height="200" src='<%# "/Images/Articles/" + Eval("path") %>' /><br />
                                        <div class="form-group"></div>
                                        <asp:TextBox Style="min-height: 150px" class="form-control" TextMode="MultiLine" ReadOnly="true" runat="server" ID="txt_Description" Text='<%# Eval("Description") %>' />

                                        <div class="form-group"></div>
                                        
                                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="btn_Delete" runat="server" OnClick="Del" Text="مسح" CommandArgument='<%# Eval("ID") %>' />
                                        
                                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="btn_Edit" runat="server" OnClick="edit" Text="تعديل" CommandArgument='<%# Eval("ID") %>' />
                                       
                                   
                                    </div>
                                </div>
                            </span>
                        </ItemTemplate>
                    </asp:ListView>

                </div>
                <div class="form-group" style="margin-top:30px">
                   <asp:DataPager ID="DataPagerProducts" Class="dataTables_paginate paging_simple_numbers" runat="server" PagedControlID="ArticlesList"
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

                    
                
    <asp:SqlDataSource ID="Ds_Articles" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="ViweArticles" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList_Categories" DefaultValue="0" Name="Cat_ID" PropertyName="SelectedValue" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="Ds_getCategories" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT ID, Category FROM Categories"></asp:SqlDataSource>

</asp:Content>

