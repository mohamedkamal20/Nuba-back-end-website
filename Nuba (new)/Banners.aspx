<%@ Page Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Banners.aspx.cs"
     EnableEventValidation="false" ValidateRequest="false" Inherits="Banners" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <asp:SqlDataSource ID="GetAllBannersSqlDataSource" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                    SelectCommand="getAllBanners" SelectCommandType="StoredProcedure" UpdateCommand="Update_Banner" 
                    UpdateCommandType="StoredProcedure">
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Title" Type="String"></asp:Parameter>
            <asp:Parameter Name="Img_Path" Type="String"></asp:Parameter>
            <asp:Parameter Name="Order" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="Type" Type="String"></asp:Parameter>
            <asp:Parameter Name="RecordID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="URL" Type="String"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:ListView ID="BannersListView" runat="server" DataSourceID="GetAllBannersSqlDataSource" DataKeyNames="ID"
             OnItemDataBound="BannersListView_ItemDataBound" OnItemCommand="BannersListView_ItemCommand">
        <EditItemTemplate>
            <div class="row">
                <div class="col-lg-6">
                    <div class="box dark">
                        <header>
                            <div class="icons">
                                <span aria-hidden="true" class="glyphicon glyphicon-edit"></span>
                            </div>
                            <h5>
                               تعديل <asp:Label Text='<%# Bind("Title") %>' runat="server" ID="TextBox1" />
                            </h5>
                        </header>
                        <div id="div-1" class="body collapse in" aria-expanded="true">
                                <div class="form-horizontal">

                                    <asp:Label Text='<%# Eval("ID") %>' runat="server" ID="IDLabel1" Visible="false" />

                                                                        <!--Title-->
                                    <div class="form-group">
                                        <asp:Label runat="server" CssClass="control-label col-lg-2" Font-Bold="true">العنوان</asp:Label>
                                        <div class="col-lg-6">
                                            <asp:TextBox Text='<%# Bind("Title") %>' runat="server" CssClass="form-control" ID="TitleTextBox" />
                                        </div>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="TitleTextBox" 
                                            CssClass="reqformError parentFormpopup-validation formError" 
                                            style="opacity: 0.87; position: absolute; top: 35px; right: 250px;">
                                            <div class="formErrorContent">
                                                * العنوان مطلوب
                                                <br>
                                            </div>
                                            <div class="formErrorArrow">
                                                <div class="line10"><!-- --></div>
                                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                                <div class="line1"><!-- --></div>
                                            </div>
                                        </asp:RequiredFieldValidator>
                                    </div>
                                    
                                                                        <!--Img-->
                                    <div class="form-group">
                                        <asp:label runat="server" ID="img" Class="control-label col-lg-2" Font-Bold="true">الصورة</asp:label>
                                        <div class="col-lg-6">
                                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                                <span class="btn btn-default btn-file">
                                                       <span class="fileinput-new">
                                                           اختار صورة لايزيد الحجم عن 500 kb والابعاد يجب ان تكون 1583*500
                                                       </span>
                                                     <asp:FileUpload ID="imgupload" runat="server" />
                                                </span>

                                                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;margin:auto">
                                                    <asp:Image runat="server" ImageUrl='<%#string.Format("Images/Banners/{0}",Eval("Img_Path")) %>'
                                                        data-src="holder.js/100%x100%" alt="..." ID="Image1" />
                                                    <asp:Label runat="server" ID="imagPathLabel" Text='<%#Bind("Img_Path") %>' Visible="false"></asp:Label>
                                                </div>

                                                <asp:Button ID="uploadImg" CommandName="uploadImage" runat="server" Text="رفع"
                                                    ValidationGroup="img" Class="btn btn-metis-6 btn-lg btn-round" />

                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                    ValidationExpression="([a-zA-Z0-9\u0621-\u064A\u0660-\u0669\s_\\.\-:])+(.bmp|.gif|.png|.jpg|.jpeg|.BMP|.GIF|.PNG|.JPG|.JPEG)$"
                                                    ErrorMessage="please upload images only" ControlToValidate="imgupload" ValidationGroup="img">
                                                </asp:RegularExpressionValidator>

                                                <asp:Label ID="sizeErrorImg" runat="server" Text="Exceed max size" Visible="False"></asp:Label>
                                                <asp:Label ID="diemnsionError" runat="server" Text="الأبعد غير متوافقة" Visible="False"></asp:Label>

                                                <asp:RequiredFieldValidator runat="server" ControlToValidate="imgupload"
                                                    CssClass="text-danger" ErrorMessage="الصورة مطلوب" ValidationGroup="img" />
                                             </div>
                                        </div>
                                    </div>

                                   
                                                                        <!--Order-->
                                    <div class="form-group">
                                        <asp:label runat="server" ID="Label1" Class="control-label col-lg-2" Font-Bold="true">الترتيب</asp:label>
                                        <div class="col-lg-6">
                                            <asp:DropDownList CssClass="form-control" ID="orderlist" runat="server" 
                                                    SelectedValue='<%#Bind("Order") %>'>
                                                <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                                <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                        <asp:Label runat="server" ID="oldOrderLabel" Text='<%#Eval("Order") %>' Visible="false"></asp:Label>
                                    </div>

                                    <asp:Label Text='<%# Bind("Type") %>' runat="server" ID="TypeLabel" Visible="false"/>
                                    <asp:Label Text='<%# Bind("RecordID") %>' runat="server" ID="RecordIDLabel" Visible="false" />

                                                                        <!--Category-->
                                    <div class="form-group">
                                        <asp:label runat="server" ID="Label2" Class="control-label col-lg-2" Font-Bold="true">التصنيفات</asp:label>
                                        <asp:SqlDataSource ID="ChildCategoriesSqlDataSource" runat="server"
                                             ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                                                    SelectCommand="getChildCategories" SelectCommandType="StoredProcedure">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="RecordIDLabel" PropertyName="Text" Name="recordID" Type="Int32"></asp:ControlParameter>
                                                <asp:ControlParameter ControlID="TypeLabel" PropertyName="Text" Name="type" Type="String"></asp:ControlParameter>
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <div class="col-lg-6">
                                            <asp:DropDownList ID="childCategoryDropDownList" OnSelectedIndexChanged="childCategoryDropDownList_SelectedIndexChanged"
                                                 CssClass="form-control" runat="server" DataSourceID="ChildCategoriesSqlDataSource" AutoPostBack="true"
                                                DataTextField="Category" DataValueField="ID">
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                                                      <!--Subject-->                                                                    
                                    <div class="form-group">
                                        <asp:label runat="server" ID="Label3" Class="control-label col-lg-2" Font-Bold="true">الموضوع</asp:label>
                                        <div class="col-lg-6">
                                            <asp:DropDownList ID="subjectDropDownList" OnSelectedIndexChanged="subjectDropDownList_SelectedIndexChanged"
                                                 CssClass="form-control" runat="server" AutoPostBack="true">
                                            </asp:DropDownList>
                                        </div>
                                    </div>

                                                                        <!--URL-->
                                    <div class="form-group">
                                        <asp:Label runat="server" CssClass="control-label col-lg-2" Font-Bold="true">المسار</asp:Label>
                                        <div class="col-lg-6">
                                            <asp:TextBox Text='<%# Bind("URL") %>' CssClass="form-control" Enabled="false" runat="server" ID="URLTextBox" /><br />
                                        </div>
                                    </div>
                                   
                                    
                                    <asp:Button runat="server" CssClass="btn btn-metis-6 btn-lg btn-round"  CommandName="Update" Text="تحديث" ID="UpdateButton" />
                                    <asp:Button runat="server" CssClass="btn btn-metis-6 btn-lg btn-round"  CommandName="Cancel" Text="إلغاء" ID="CancelButton" />
                                    <br />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>
        <ItemTemplate>
            <div class="row">
                <div class="col-lg-6">
                    <div class="box">
                        <header>
                            <div class="icons">
                                <span aria-hidden="true" class="glyphicon glyphicon-picture"></span>
                            </div>
                            <h5>
                                <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" />
                            </h5>
                            <div class="toolbar">
                                <nav style="padding:8px">
                                    <a href="javascript:;" class="btn btn-default btn-xs collapse-box"></a>
                                </nav>
                            </div>
                        </header>
                        <div id="div-1" class="body collapse in" aria-expanded="true"> 

                            <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;margin:auto">
                                <asp:HyperLink ID="BannerHyperLink" NavigateUrl='<%#Eval("URL") %>' runat="server">
                                    <asp:Image ID="banner" runat="server" ImageUrl='<%#string.Format("Images/Banners/{0}",Eval("Img_Path")) %>' />
                                </asp:HyperLink>
                            </div>
                            <asp:Label Text='<%# Eval("ID") %>' runat="server" ID="IDLabel" Visible="false" />
                            <asp:Label runat="server" CssClass="control-label" Font-Bold="true">النوع:</asp:Label>   
                            <asp:Label Text='<%# Eval("Type") %>' runat="server" ID="TypeLabel" />
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-metis-6 btn-lg btn-round"
                                             CommandName="Edit" Text="تعديل" ID="EditButton" />
                        
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
            <div style="">
                <asp:DataPager runat="server" ID="DataPager1">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                        <asp:NumericPagerField></asp:NumericPagerField>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                    </Fields>
                </asp:DataPager>

            </div>
        </LayoutTemplate>
    </asp:ListView>
</asp:Content>

