<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="addFood.aspx.cs" Inherits="addFood" %>


<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">


    <script type="text/javascript" >
        function checkFileSize(source, args)
        {
            var maxFileSize = 1;
            var fileUploaded = document.getElementById("<%=FileUploadTitle.ClientID%>");
            var fileSize = parseFloat(FileUploadTitle.files[0].size / (1024 * 1024)).toFixed(2);
            if (fileSize > maxFileSize)
            {
                confirm(fileSize);
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

    </script>

    <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark">

        <header>
                                              <div class="icons"><i class="fa fa-edit"></i></div>
                                                <h5>Add new Food</h5>
                                                            <!-- .toolbar -->
                                                                    <div class="toolbar">
                                                                    <nav style="padding: 8px;">
                                                                            <a href="javascript:;" class="btn btn-default btn-xs collapse-box">
                                                                             <i class="fa fa-minus"></i>
                                                                                </a>
                                                                        </nav>
                                                                     </div>            <!-- /.toolbar -->
                     </header>

            <div>
                
    
        <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" style="border-color:white;">
        <div>
            <p style="font-size:150%;float:right;" dir="rtl" > <b>اختر التصنيف </b></p>
            &nbsp;
            <asp:DropDownList ID="DropDownListCat" runat="server" style="float:right;"  dir="rtl" class="form-control" DataSourceID="SqlDataSource1" DataTextField="Category" DataValueField="ID" Height="10%" Width="30%"></asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="getFoodCategories" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
    </div>
                                          </div>
                                    </div>
            </div>
        
           
                <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" style="border-color:white;">
                 <div>
                
            <p style="font-size:150%;float:right;" dir="rtl" >
                    <b>
                    العنوان
                </b>
                        </p>
                     &nbsp;
                <asp:TextBox ID="TextBoxTitle" runat="server" style="float:right;" dir="rtl" class="form-control" Height="10%" Width="40%" ></asp:TextBox>
                
                 <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left:32%; margin-top: -7%;" ID="RequiredFieldValidatorTitle"  runat="server"  ControlToValidate="TextBoxTitle">
                            <div class="formErrorContent">* يجب ادخال عنوان للطعام<br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                                 </asp:RequiredFieldValidator>
               
            </div>  
                                          </div>
                                    </div>
                    </div>
          
            <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" style="border-color:white;">
                <div>
                
                    <p style="font-size:150%;float:right;" dir="rtl" >
                        <b>
                        شرح مفصل
                    </b>
                            </p>
                    <br /><br />
                
                    <asp:TextBox ID="TextBoxDesc" runat="server" Height="100px" style="float:right;" dir="rtl" class="form-control" TextMode="MultiLine" Width="80%"></asp:TextBox>
                <div>   
                    
                     <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left: 2%; margin-top: 0.5%;" ID="RequiredFieldValidatorDescription"  runat="server"  ControlToValidate="TextBoxDesc">
                            <div class="formErrorContent">* يجب ادخال وصف للطعام<br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                                 </asp:RequiredFieldValidator>         
                    <!-- <asp:RequiredFieldValidator ID="RequiredFieldValidatorDescription1" runat="server" ControlToValidate="TextBoxDesc" ErrorMessage="يجب ادخال وصف للطعام" ForeColor="#FF3300"></asp:RequiredFieldValidator>-->
                     
                </div>    

                </div>
                                          </div>
                                    </div>
                </div>
                
                
        
                <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" style="border-color:white;">
            <div>
              
                <p style="font-size:150%;float:right;" dir="rtl" >
                    <b>صورة الطعام</b>
                        </p>
                <br /><br />
               
                <asp:FileUpload ID="FileUploadTitle"  width="60%" class="form-control" style="float:right;" dir="rtl" runat="server" />
                <asp:Image ID="ImageTitle" runat="server" class="form-control" ImageAlign="Right" width="200px" Height="200px" Visible="False"/>
                <asp:Button ID="ButtonUoload" runat="server" width="60%"   class="form-control" style="font-size:150%;background-color:antiquewhite" Text="تحميل الصورة" OnClick="ButtonUoload_Click" ValidationGroup="Title" /> 
                <asp:Label ID="LabelSizeInfo" runat="server" Text="  *يجب الا يتعدى حجم الصورة 100كيلو بايت" Font-Size="Large" ForeColor="#339933"></asp:Label>
                <asp:Label ID="LabelTitleSavedPath" runat="server" Visible="False"></asp:Label>
                
                <!--<asp:RegularExpressionValidator ID="RegularExpressionValidatorTimgExtention1"  runat="server" ControlToValidate="FileUploadTitle" 
                    ErrorMessage="يجب ان تكون صيغة الصورة من الاتى *(jpg,png,gif,bitmap)" 
                    ForeColor="#FF3300" ValidationExpression="(.*png$)|(.*jpg$)|(.*jpeg$)|(.*PNG$)|(.*JPEG$)|(.*JPG$)|(.*gif$)|(.*GIF$)|(.*bmap$)|(.*BMAP$)|(.*BITMAP$)|(.*bitmap$)" 
                    ValidationGroup="Title"></asp:RegularExpressionValidator> -->
                
                 <asp:RegularExpressionValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left: 22%; margin-top: 1%;" ID="RegularExpressionValidatorTimgExtention"  runat="server"
                       ControlToValidate="FileUploadTitle"  ValidationExpression="(.*png$)|(.*jpg$)|(.*jpeg$)|(.*PNG$)|(.*JPEG$)|(.*JPG$)|(.*gif$)|(.*GIF$)|(.*bmap$)|(.*BMAP$)|(.*BITMAP$)|(.*bitmap$)" ValidationGroup="Title">
                            <div class="formErrorContent">* يجب ان تكون صيغة الصورة من الاتى (jpg,png,gif,bitmap)<br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                                 </asp:RegularExpressionValidator >   
                <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left: 22%; margin-top: 1%;" ID="RequiredFieldValidatorTimagePath"  runat="server"  ControlToValidate="FileUploadTitle">
                            <div class="formErrorContent">* يجب ادحال صورة للاكلة<br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                                 </asp:RequiredFieldValidator>    
                    <!--<asp:RequiredFieldValidator ID="RequiredFieldValidatorTimagePath1"  runat="server" ControlToValidate="FileUploadTitle" ErrorMessage="يجب ادحال صورة للاكلة" ForeColor="#FF3300"></asp:RequiredFieldValidator> -->
                
                    
            </div>
    
                                          </div>
                                    </div>
                    </div>

       
                <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" style="border-color:white;">
                 <div>
            
            <p style="font-size:150%;float:right;" dir="rtl" >
                <b>
                المقادير 
                    </b>
            </p>
             <br /><br />

            <asp:TextBox ID="TextBoxQuantities" runat="server" class="form-control" style="float:right;" dir="rtl" Height="100px" width="80%" TextMode="MultiLine"></asp:TextBox>
            </div>
               </div>
                                    </div>
                    </div>  

            
                <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" style="border-color:white;">
                <div>      
            <p style="font-size:150%;float:right;" dir="rtl" >
                <b>
                طريقة التحضير
            </b>
                    </p>
                 <br /><br />

            <asp:TextBox ID="TextBoxMethod" runat="server" class="form-control" style="float:right;" dir="rtl" Height="100px" width="80%"  TextMode="MultiLine"></asp:TextBox>
             </div>
              
                                          </div>
                                    </div>
                    </div>

              <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" style="border-color:white;">
                <div>
            <p style="font-size:150%;float:right;" dir="rtl" >
                <b>
                معلومات طبيعية
            </b>
                    </p>
                   <br /><br />

            <asp:TextBox ID="TextBoxNaturalInfo" runat="server" class="form-control" style="float:right;" dir="rtl" Height="100px" width="80%"  TextMode="MultiLine"></asp:TextBox>
            
             </div>
                                          </div>
                                    </div>
                  </div>
         
                
                <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" style="border-color:white;">
                                       
        <div>
            <p style="font-size:150%;float:right;" dir="rtl" >
                <b>
                معلومات قديمة
            </b>
                    </p>
             <br /><br />

            <asp:TextBox ID="TextBoxOldInfo" runat="server" class="form-control" style="float:right;" dir="rtl" Height="100px" width="80%"  TextMode="MultiLine"></asp:TextBox>
           
            </div>
                
                                          </div>
                                    </div>
                    </div>

                <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" style="border-color:white;">
        <div>
            
                <p style="font-size:150%;float:right;" dir="rtl" >
                    <b>صورة المقادير</b>
                         </p>
             <br />
                <br />
            <asp:FileUpload ID="FileUploadQuantities" class="form-control" width="60%" style="float:right;"  dir="rtl" runat="server" />
            <asp:Image ID="ImageQuantity" runat="server" class="form-control" ImageAlign="Right" width="200px" Height="200px" Visible="False"/>
             <asp:Button ID="ButtonQuantityImage" runat="server" width="60%" class="form-control"  style="font-size:150%;background-color:antiquewhite" Text="تحميل الصورة" OnClick="ButtonQuantityImage_Click" ValidationGroup="Quantity" />
            <asp:Label ID="Label1" runat="server" Text="  *يجب الا يتعدى حجم الصورة 100كيلو بايت" Font-Size="Large" ForeColor="#339933"></asp:Label>

            <asp:Label ID="LabelQuantitySavedPath" runat="server" Visible="False"></asp:Label>

            
            <div>
              <!--  <asp:CustomValidator ID="CustomValidatorQuantity" runat="server" ControlToValidate="FileUploadQuantities" ErrorMessage="File must not exceds 100kb" ForeColor="Red" OnServerValidate="CheckFileSizeQuantity" ValidationGroup="Quantity"></asp:CustomValidator> -->
                
               <asp:RegularExpressionValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left: -5%; margin-top: 1%;" ID="RegularExpressionValidatorQuantity"  runat="server"
                       ControlToValidate="FileUploadQuantities"  ValidationExpression="(.*png$)|(.*jpg$)|(.*jpeg$)|(.*PNG$)|(.*JPEG$)|(.*JPG$)|(.*gif$)|(.*GIF$)|(.*bmap$)|(.*BMAP$)|(.*BITMAP$)|(.*bitmap$)" ValidationGroup="Quantity">
                            <div class="formErrorContent">* يجب ان تكون صيغة الصورة من الاتى (jpg,png,gif,bitmap)<br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                                 </asp:RegularExpressionValidator >  
                 </div>
            
            </div>
               
                                          </div>
                                    </div>
                    </div>

                <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" style="border-color:white;">
        <div>
            <p style="font-size:150%;float:right;" dir="rtl" >
                <b>
             شرح صورة المقادير
            </b>
                    </p>
            <br />
                <br />
            <asp:TextBox ID="TextBoxQuantitiesCaption" style="float:right;" dir="rtl" runat="server" class="form-control" Height="100px" Width="80%" TextMode="MultiLine"></asp:TextBox>
            </div>
        </div>
                                    </div>
                    </div>
                
                <div class="row" >
                                <div class="col-lg-9" >
                                      <div class="box dark" style="border-color:white;">
                <div style="float:right;">
            
            <asp:Button ID="ButtonSave" runat="server"  class="btn btn-metis-6 btn-lg btn-round" Text="احفظ"  OnClick="ButtonSave_Click" />
            &nbsp;&nbsp;
            <asp:Button ID="ButtonReset" runat="server"  class="btn btn-metis-5 btn-lg btn-round" Text="إعادة ملئ" OnClick="ButtonReset_Click" CausesValidation="False" />
          <br />
                    <br />
                 <!-- <div><asp:Label ID="message" runat="server" Height="25px"  Text="تم اضافة طعام جديد بنجاح" Visible="False" Width="300px"></asp:Label></div> -->
             </div>
                                          </div>
                                    </div>
                    </div>
                
            
        </div>
                                          </div>
                                    </div>
        </div>
    
</asp:Content>

