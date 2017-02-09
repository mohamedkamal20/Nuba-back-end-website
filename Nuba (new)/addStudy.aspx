<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="addStudy.aspx.cs" Title="Add new Study" Inherits="addStudy" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <%--<div class="row">--%>
    <div class="box dark">
        <header>
            <div class="icons">
                <span aria-hidden="true" class="glyphicon glyphicon-plus"></span>   
            </div>
            <h5>إضافة دراسة جديدة</h5>
        </header>
        <div id="div-1" class="body collapse in" aria-expanded="true">
          <div class="form-horizontal">
            
                                                   <!--Title-->
                    <div class="form-group">
                        <asp:Label runat="server" CssClass="control-label col-lg-2" Font-Bold="true">العنوان</asp:Label>
                        <div class="col-lg-3">
                            <asp:TextBox Class="form-control" ID="title" runat="server"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator CssClass="reqformError parentFormpopup-validation formError "
                             style="opacity: 0.87; position: absolute; top: 30px; right: 300px; margin-top: 0px;" 
                            runat="server" ControlToValidate="title" >
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
                    
                                            <!--Description-->
                    <div class="form-group">
                        <asp:Label CssClass="control-label col-lg-2" runat="server" Font-Bold="true">الوصف</asp:Label>
                        <div class="col-lg-3">
                            <asp:TextBox Class="form-control" runat="server" id="desc" rows="2" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="desc" 
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
                   

                                            <!--Uploading pdf-->   
                    <div class="form-group">   
                        <asp:label class="control-label col-lg-2" runat="server" ID="pdf" Font-Bold="true">المقال</asp:label> 
                        <div class="col-lg-6">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div>
                                    <span class="btn btn-default btn-file col-lg-8">
                                        <span class="fileinput-new">
                                           إختار ملف لايزيد حدمه عن 1 ميجا بايت
                                        </span>
                                        <asp:FileUpload ID="pdfupload" runat="server"/>
                                     </span>   
                                    <asp:Button ID="uploadPDF" runat="server" Class="btn btn-metis-6 btn-lg btn-round" Style="margin:10px;"  Text="رفع"
                                         OnClick="uploadPDF_Click" ValidationGroup="pdf" />

                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                        ValidationExpression="([a-zA-Z0-9\u0621-\u064A\u0660-\u0669\s_\\.\-:])+(.pdf|.fdf|.xfdf|.xfa|.PDF|.FDF|.XFDF|.XFA)$" 
                                        ControlToValidate="pdfupload" ValidationGroup="pdf" 
                                        CssClass="reqformError parentFormpopup-validation formError" 
                                        style="opacity: 0.87; position: absolute; top: -20px; right: 200px;">
                                            <div class="formErrorContent">
                                               * من فضلك أختار ملف فقط
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
                                    </asp:RegularExpressionValidator>
                                    
                                    
                                    
                                    <asp:Label ID="sizeError" runat="server" Text="Exceed max size" Visible="False"></asp:Label>
                                    
                                    <asp:HyperLink ID="PDFHyperLink" runat="server">
                                        <asp:Label ID="pdfurl" runat="server" Visible="False"></asp:Label>
                                    </asp:HyperLink>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="pdfupload" ValidationGroup="pdf"
                                        CssClass="reqformError parentFormpopup-validation formError" 
                                        style="opacity: 0.87; position: absolute; top: -20px; right: 200px;">
                                        <div class="formErrorContent">
                                              * الملف مطلوب
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
                            </div>
                        </div>
                    </div>
                   
                                
                                          <!--Uploading image-->
                    <div class="form-group">
                        <asp:label runat="server" ID="img" Class="control-label col-lg-2" Font-Bold="true">الصورة</asp:label>
                        <div class="col-lg-6">
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div>
                                    <span class="btn btn-default btn-file col-lg-8">
                                        <span class="fileinput-new">
                                            اختار صورة لايزيد الحجم عن 500 كيلو بايت
                                        </span>
                                        <asp:FileUpload ID="imgupload" runat="server" />
                                    </span>     
                                    <span class="fileinput-new thumbnail col-lg-2" style="width: 200px; height: 150px;margin:auto">
                                        <asp:Image runat="server" src='<%#string.Format("images/Banners/{0}",Eval("Img_Path")) %>' 
                                            data-src="holder.js/100%x100%" alt="..." ID="Image1" />
                                    </span>  
                                    <asp:Button ID="uploadImg" runat="server" class="btn btn-metis-6 btn-lg btn-round" Text="رفع" 
                                                Style="margin:10px" OnClick="uploadImg_Click" 
                                        ValidationGroup="img" />             
                                    
                                    
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                        ValidationExpression="([a-zA-Z0-9\u0621-\u064A\u0660-\u0669\s_\\.\-:])+(.bmp|.gif|.png|.jpg|.jpeg|.BMB|.GIF|.PNG|.JPG|.JPEG)$" 
                                        ControlToValidate="imgupload" ValidationGroup="img" CssClass="reqformError parentFormpopup-validation formError" 
                                        style="opacity: 0.87; position: absolute; top: -20px; right: 200px;">
                                        <div class="formErrorContent">
                                               * من فضلك أختار صورة فقط
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
                                    </asp:RegularExpressionValidator>
                                    
                                    <asp:Label ID="sizeErrorImg" runat="server" Text="حجك الصورة تخطى الحجم المطلوب" Visible="False"></asp:Label>
                                    
                                </div>
                            </div>
                        </div>
                    </div>

                                            <!--Caption-->
                    <div class="form-group">
                        <asp:Label runat="server" CssClass="control-label col-lg-2" Font-Bold="true">النبذة</asp:Label>
                        <div class="col-lg-3">
                            <asp:TextBox CssClass="form-control" ID="caption" runat="server" Rows="2" TextMode="MultiLine"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="caption"
                            CssClass="reqformError parentFormpopup-validation formError" 
                            style="opacity: 0.87; position: absolute; top: 450px; right: 315px;">
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
                        <asp:Label runat="server" CssClass="control-label col-lg-2" Font-Bold="true">إسم المؤلف</asp:Label>
                        <div class="col-lg-3">
                            <asp:TextBox CssClass="form-control" ID="author" runat="server"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="author" 
                            CssClass="reqformError parentFormpopup-validation formError" 
                            style="opacity: 0.87; position: absolute; top: 520px; right: 315px;">
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
         
                                            <!--Date-->
                    <div class="form-group">
                        <asp:Label ID="Label5" runat="server" CssClass="control-label col-lg-2" Font-Bold="true">التاريخ</asp:Label>
                        <div class="col-lg-3">
                            <asp:TextBox CssClass="form-control" ID="DateTextBox" runat="server" TextMode="Date"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="DateTextBox"
                         CssClass="reqformError parentFormpopup-validation formError" 
                            style="opacity: 0.87; position: absolute; top: 570px; right: 315px;" >
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

                    <asp:Button ID="add" runat="server" CssClass="btn btn-metis-6 btn-lg btn-round" Text="اضافة" OnClick="add_Click" />
                    <asp:Button ID="reset" runat="server" CssClass="btn btn-metis-5 btn-lg btn-round" Text="إعادة ملئ" OnClick="reset_Click" />
                </div>
            </div> 

    </div>
    <%--</div>--%>
    </asp:Content>