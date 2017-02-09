<%@ Page Language="C#" AutoEventWireup="true" CodeFile="studies.aspx.cs" MasterPageFile="~/Site.master" Inherits="Studies_studies" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>


    
    <%--<script type="text/javascript">
        function checkFileSize(sender,args) {
            var maxFileSize = 1;
            var fileUploaded = document.getElementById("<%=pdfupload.ClientID%>");
            var fileSize = parseFloat(pdfupload.files[0].size / (1024*1024)).toFixed(2);
            if (fileSize > maxFileSize) {
                args.IsValid = false;
            }
            else {
                args.IsValid = true;
            }
        }
        function checkImgSize(sender,args) {
            var maxFileSize = .5;
            var fileUploaded = document.getElementById("<%=imgupload.ClientID%>");
            var fileSize = parseFloat(imgupload.files[0].size / (1024 * 1024)).toFixed(2);
            if (fileSize > maxFileSize) {
                args.IsValid = false;
            }
            else {
                args.IsValid = true;
            }
        }
    </script>--%>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
                    
                        <asp:SqlDataSource ID="getAllStudiesSqlDataSource" runat="server"
                            ConnectionString='<%$ ConnectionStrings:DefaultConnection %>'
                            SelectCommand="getAllStudies" SelectCommandType="StoredProcedure"
                             DeleteCommand="removeStudy" DeleteCommandType="StoredProcedure" 
                            UpdateCommand="editStudy" UpdateCommandType="StoredProcedure">
                            <DeleteParameters>
                                <asp:Parameter Name="id" Type="Int32"></asp:Parameter>
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                                <asp:Parameter Name="Title" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Desc" Type="String"></asp:Parameter>
                                <asp:Parameter Name="PDF_Path" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Img_Path" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Caption" Type="String"></asp:Parameter>
                                <asp:Parameter Name="Author" Type="String"></asp:Parameter>
                                <asp:Parameter DbType="Date" Name="Publish_Date"></asp:Parameter>
                            </UpdateParameters>
                        </asp:SqlDataSource>
    
                        <asp:ListView ID="ListView1" runat="server" OnItemCommand="ListView1_ItemCommand" DataKeyNames="ID"
                             DataSourceID="getAllStudiesSqlDataSource" OnItemDataBound="ListView1_ItemDataBound">
                            <EditItemTemplate>
                              <div class="box dark">
                                    <header>
                                          <div class="icons">
                                            <span aria-hidden="true" class="glyphicon glyphicon-edit"></span>   
                                          </div>
                                        <h5>
                                            تعديل
                                            <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="headerTitle" />
                                        </h5>
                                    </header>
                                  <div id="div-1" class="body collapse in" aria-expanded="true">
                                   <div class="form-horizontal">
                                    <asp:Label Text='<%# Eval("ID") %>' runat="server" Visible="false" ID="IDLabel" />

                                                               <!--Title-->
                                    <div class="form-group">
                                       <asp:Label runat="server" CssClass="control-label col-lg-2" Font-Bold="true">العنوان</asp:Label>
                                        <div class="col-lg-6">
                                        <asp:TextBox CssClass="form-control" Text='<%# Bind("Title") %>' runat="server"
                                                 ID="TitleTextBox" />
                                        </div>
                                        <asp:RequiredFieldValidator CssClass="reqformError parentFormpopup-validation formError "
                                         style="opacity: 0.87; position: absolute; top: 30px; right: 300px; margin-top: 0px;" 
                                        runat="server" ControlToValidate="TitleTextBox" >
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



                                                                    <!--Desc-->
                                    <div class="form-group">
                                        <asp:Label CssClass="control-label col-lg-2" runat="server" Font-Bold="true">الوصف</asp:Label>
                                        <div class="col-lg-6">
                                        <asp:TextBox CssClass="form-control" TextMode="MultiLine" Rows="2" 
                                                Text='<%# Bind("Desc") %>' runat="server" ID="DescTextBox" />
                                            </div>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="DescTextBox" 
                                            CssClass="reqformError parentFormpopup-validation formError" 
                                            style="opacity: 0.87; position: absolute; top: 80px; right: 300px;">
                                            <div class="formErrorContent">
                                                * الوصف مطلوب
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

                                                                <!--pdf-->
                                       
                                    <div class="form-group">   
                                    <asp:label class="control-label col-lg-2" runat="server" ID="pdf" Font-Bold="true">المقال</asp:label> 
                                    <div class="col-lg-6">
                                        <div class="fileinput fileinput-new" data-provides="fileinput">
                                            <div>
                                                <span class="btn btn-default btn-file col-lg-12">
                                                    <span class="fileinput-new">
                                                       إختار ملف لايزيد حدمه عن 1 ميجا بايت
                                                    </span>
                                                    <asp:FileUpload ID="pdfupload" runat="server"/>
                                                 </span>   
                                                <asp:HyperLink ID="HyperLink1"
                                                             NavigateUrl='<%#string.Format("files/Studies/{0}",Eval("PDF_Path")) %>'
                                                             runat="server">
                                                     <asp:Label ID="existpdfurl" runat="server" Text='<%#Bind("PDF_Path") %>'></asp:Label>
                                                </asp:HyperLink>
                                                <asp:Button ID="uploadPDF" CommandName="uploadPDFCommand" Style="margin:5px"
                                                            runat="server" Class="btn btn-metis-6 btn-round" Text="رفع" 
                                                     ValidationGroup="pdf" />
                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                                    ValidationExpression="([a-zA-Z0-9\u0621-\u064A\u0660-\u0669\s_\\.\-:])+(.pdf|.fdf|.xfdf|.xfa|.PDF|.FDF|.XFDF|.XFA)$" 
                                                    ErrorMessage="please upload pdf only" ControlToValidate="pdfupload"
                                                     ValidationGroup="pdf">
                                                </asp:RegularExpressionValidator>
                                        
                                    
                                                <asp:Label ID="sizeErrorPDF" runat="server" Text="لقد تخطيت الحد الأقصى" Visible="False"></asp:Label>
                                               <%-- <asp:Label Text='<%# Bind("PDF_Path") %>' runat="server" ID="PDFLabel" Visible="false" />--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                   
                                                                <!--Img-->
                                    <div class="form-group">
                                <asp:label runat="server" ID="img" Class="control-label col-lg-2" Font-Bold="true">الصورة</asp:label>
                                <div class="col-lg-6">
                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                        <div class="btn btn-default btn-file col-lg-6">
                                                <span class="fileinput-new">
                                                    اختار صورة لايزيد الحجم عن 500 كيلو بايت
                                                </span>
                                                <asp:FileUpload ID="imgupload" runat="server" />
                                         </div>                    
                                        
                                        <div class="fileinput-new thumbnail col-lg-6" style="width: 200px; height: 150px;">
                                            <asp:Image runat="server" ImageUrl='<%#string.Format("Images/Studies/{0}",Eval("Img_Path")) %>'
                                                data-src="holder.js/100%x100%" alt="..." ID="Image1" />
                                            <asp:Label runat="server" ID="imagPathLabel" Text='<%#Bind("Img_path") %>' Visible="false"></asp:Label>
                                        </div>

                                        <asp:Button ID="uploadImg" CommandName="uploadImgCommand" runat="server" 
                                                Class="btn btn-metis-6 btn-round" Text="رفع" ValidationGroup="img" />

                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                                ValidationExpression="([a-zA-Z0-9\u0621-\u064A\u0660-\u0669\s_\\.\-:])+(.bmp|.gif|.png|.jpg|.jpeg|.BMB|.GIF|.PNG|.JPG|.JPEG)$" 
                                                ErrorMessage="please upload images only" ControlToValidate="imgupload"
                                                         ValidationGroup="img">

                                            </asp:RegularExpressionValidator>
                                            <asp:Label ID="sizeErrorImg" runat="server" Text="Exceed max size" Visible="False"></asp:Label>
                                            
                                          
                                            <asp:TextBox runat="server" Visible="false" ID="Img_PathTextBox"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                                 
                                                                <!--Caption-->
                        
                                    <div class="form-group">
                                       <asp:Label runat="server" CssClass="control-label col-lg-2" Font-Bold="true">النبذة</asp:Label>
                                        <div class="col-lg-6">
                                            <asp:TextBox Text='<%# Bind("Caption") %>'  TextMode="MultiLine" Rows="2"
                                                CssClass="form-control" runat="server" ID="CaptionTextBox" />
                                        </div>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="CaptionTextBox"
                                        CssClass="reqformError parentFormpopup-validation formError" 
                                        style="opacity: 0.87; position: absolute; top: 480px; right: 315px;">
                                        <div class="formErrorContent">
                                              *  النبذة مطلوبة
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


                                                                 <!--Author-->
                                   <div class="form-group">
                                       <asp:Label runat="server" CssClass="control-label col-lg-2" Font-Bold="true"> المؤلف</asp:Label>
                                       <div class="col-lg-6"> 
                                           <asp:TextBox Text='<%# Bind("Author") %>' CssClass="form-control" runat="server" ID="AuthorTextBox" />
                                        </div>
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="AuthorTextBox" 
                                        CssClass="reqformError parentFormpopup-validation formError" 
                                        style="opacity: 0.87; position: absolute; top: 555px; right: 315px;">
                                            <div class="formErrorContent">
                                                  * إسم المؤلف مطلوب
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
                                   
                                    <div class="form-group">
                                        <asp:Label ID="Label5" runat="server" CssClass="control-label col-lg-2" Font-Bold="true">التاريخ</asp:Label>
                                        <asp:Label runat="server" ID="dateLable" Text='<%#Bind("Publish_Date") %>' Visible="false"></asp:Label>
                                        <div class="col-lg-6">
                                            <asp:TextBox Text='<%# Convert.ToDateTime(Eval("Publish_Date")).ToString("yyyy-MM-dd") %>' 
                                                CssClass="form-control" runat="server" ID="Publish_DateTextBox"
                                                             TextMode="Date" OnTextChanged="Publish_DateTextBox_TextChanged" />
                                        </div>
                                        
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Publish_DateTextBox"
                                         CssClass="reqformError parentFormpopup-validation formError" 
                                            style="opacity: 0.87; position: absolute; top: 604px; right: 315px;" >
                                            <div class="formErrorContent">
                                                  * تاريخ النشر مطلوب
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
                                    <asp:Button CssClass="btn btn-metis-6 btn-round btn-lg" runat="server" CommandName="Update" Text="تحديث" ID="UpdateButton" />
                                    <asp:Button CssClass="btn btn-metis-5 btn-round btn-lg" runat="server" CommandName="Cancel" Text="إلغاء" ID="CancelButton" />
                                   </div>
                                 </div>
                              </div> 
                            </EditItemTemplate>
                            <EmptyDataTemplate>
                                <span>No data was returned.</span>
                            </EmptyDataTemplate>
                            <InsertItemTemplate>
                                <span style="">Title:
                                    <asp:TextBox Text='<%# Bind("Title") %>' runat="server" ID="TitleTextBox" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="TitleTextBox" CssClass="text-danger"
                                            ErrorMessage="  العنوان مطلوب ."  />
                                    <br />
                                    Desc:
                                    <asp:TextBox Text='<%# Bind("Desc") %>' runat="server" ID="DescTextBox" Rows="2" TextMode="MultiLine" />
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="DescTextBox" CssClass="text-danger"
                                            ErrorMessage="الوصف مطلوب."  />
                                    <br />
                                    PDF_Path:
                                    <asp:TextBox Text='<%# Bind("PDF_Path") %>' runat="server" ID="PDF_PathTextBox" /><br />
                                    Img_Path:
                                    <asp:TextBox Text='<%# Bind("Img_Path") %>' runat="server" ID="Img_PathTextBox" /><br />
                                    Caption:
                                    <asp:TextBox Text='<%# Bind("Caption") %>' runat="server" ID="CaptionTextBox" /><br />
                                    Author:
                                    <asp:TextBox Text='<%# Bind("Author") %>' runat="server" ID="AuthorTextBox" /><br />
                                    Publish_Date:
                                    <asp:TextBox Text='<%# Bind("Publish_Date") %>' runat="server" ID="Publish_DateTextBox" /><br />
                                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" /><asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" /><br />
                                    <br />
                                </span>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <div class="row">
                                <div class="col-lg-12">
                                <div class="box">
                                    <header>
                                        <h5><asp:Label Text='<%# Eval("Title") %>' runat="server" ID="Label1" /></h5>
                                        <div class="toolbar">
                                            <nav style="padding:8px">
                                                <a href="javascript:;" class="btn btn-default btn-xs collapse-box"></a>
                                            </nav>
                                        </div>
                                    </header>
                                    <div id="div-1" class="body collapse in" aria-expanded="true">
                                        <asp:Label Text='<%# Eval("ID") %>' runat="server" Visible="false" ID="IDLabel" /><br />

                                        <asp:Label runat="server" CssClass="control-label col-lg-2" Font-Bold="true">العنوان:</asp:Label>
                                        <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /><br />
                                       
                                        <asp:Label runat="server" CssClass="control-label col-lg-2" Font-Bold="true"> ملف المقال والدراسة:</asp:Label>
                                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl=
                                                                    '<%#string.Format("files/Studies/{0}",Eval("PDF_Path")) %>'>
                                        <asp:Label Text='<%# Eval("PDF_Path") %>' runat="server" ID="PDF_PathLabel" /><br />
                                        </asp:HyperLink>
                                       
                                        
                                        <asp:Label runat="server" CssClass="control-label col-lg-2" Font-Bold="true">النبذة:</asp:Label>
                                        <asp:Label Text='<%# Eval("Caption") %>' runat="server" ID="CaptionLabel" /><br />
                                        

                                        <asp:Button runat="server" CssClass="btn btn-metis-6 btn-lg btn-round" CommandName="Edit" Text="تعديل" ID="EditButton" />
                                        <asp:Button runat="server" CssClass="btn btn-metis-5 btn-lg btn-round" CommandName="Delete" Text="إزالة" ID="DeleteButton" />
                                        <asp:Button runat="server" CssClass="btn btn-metis-6 btn-lg btn-round" CommandName="Show" Text="عرض " ID="ShowButton" />
                                        <br />
                                  </div>
                                </div>
                                    </div>
                                    </div>
                                      
                                <br />

                            </ItemTemplate>
                            <LayoutTemplate>
                                <div runat="server" id="itemPlaceholderContainer" style="">
                                    <span runat="server" id="itemPlaceholder" />
                                </div>
                                <div style="">
                                    <asp:DataPager runat="server" ID="DataPager1" PageSize="4" >
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" 
                                                ShowNextPageButton="False" ShowPreviousPageButton="False">
                                            </asp:NextPreviousPagerField>
                                            <asp:NumericPagerField></asp:NumericPagerField>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True"
                                                 ShowNextPageButton="False" ShowPreviousPageButton="False">
                                            </asp:NextPreviousPagerField>
                                        </Fields>
                                    </asp:DataPager>

                                </div>
                            </LayoutTemplate>
                        </asp:ListView>
    </asp:Content>