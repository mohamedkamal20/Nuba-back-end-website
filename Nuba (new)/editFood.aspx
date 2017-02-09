<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="editFood.aspx.cs" Inherits="editFood" %>

            

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">


    <div class="row" >
             <div class="col-lg-9">
                      <div class="box dark">

        <header>
                                              <div class="icons"><i class="fa fa-edit"></i></div>
                                                <h5>إزالة او تعديل طعام</h5>
                                                            <!-- .toolbar -->
                                                                    <div class="toolbar">
                                                                    <nav style="padding: 8px;">
                                                                            <a href="javascript:;" class="btn btn-default btn-xs collapse-box">
                                                                             <i class="fa fa-minus"></i>
                                                                                </a>
                                                                        </nav>
                                                                     </div>            <!-- /.toolbar -->
                     </header>
       
                          
        <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="ID"  OnItemCommand="ListView1_ItemCommand">
            <AlternatingItemTemplate>
                
     <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" ">
                <span style="background-color: #DCDCDC; color: #000000;"> 
                    <asp:Label Text='<%# Eval("ID") %>'   runat="server" Visible="false" ID="IDLabel" /><br />
                    
                     <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                    <div class="col-lg-8" >
                        <h2 dir="rtl" style="float:right;">العنوان:</h2>  
                        
                             <asp:TextBox ID="TitleLabel" class="form-control" TextMode="SingleLine" dir="rtl" ReadOnly="true"  style="float:right;" width= "100%" runat="server" text= '<%# Eval("Title") %>' ></asp:TextBox>
                    </div>
                    <div class="col-lg-8">
                            <h4 dir="rtl" style="float:right;">شرح مفصل:</h4> 
                    
                         <asp:TextBox ID="DescriptionLabel" class="form-control" TextMode="MultiLine" dir="rtl"  style="float:right;" width="200%"  Height="40%" Readonly="true" runat="server" text= '<%# Eval("Description") %>'></asp:TextBox>
                    
                    </div>
                    
                    <div class="col-lg-8">
                        
                            <h4 dir="rtl" style="float:right;">صورة الطعام:</h4>   
                         <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;"> 
                        <asp:Image ID="Img_PathLabe1" ImageUrl='<%# "~/images/food/" + Eval("Img_Path") %>' AlternateText="صورة" width="100px" Height="100px" runat="server" />
                     <!-- <asp:Label Text='<%# Eval("Img_Path") %>' runat="server" ID="Img_PathLabe" /><br /> -->
                    </div>
                                </div>
                             </div>
                    </div>
                                    </div>
                                </div>
                         </div>
                    
                    <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                     <div >
                       
                    <asp:Button runat="server" CommandName="Edit" class="btn btn-metis-6 btn-lg btn-round" Text="تعديل" ID="EditButton" />
                    <asp:Button runat="server" CommandName="Delete" class="btn btn-metis-6 btn-lg btn-round" Text="إزالة" ID="DeleteButton" />
                    <asp:Button ID="ButtonMore" runat="server"  CommandName="More" class="btn btn-metis-5 btn-lg btn-round" Text="المزيد" />
                    </div> 
            </div>
                                </div>
                        </div>
                    <!-- __________________________________________________________________________________ -->
                    
                        <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                        <div class="col-lg-8" >
                       
                        <asp:Label Text="المقادير:" ID="lable1Quantities" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                        <br />
                         <asp:TextBox TextMode="MultiLine" ReadOnly="true" ID="QuantitiesLabel" Visible="false" Width="200%" Height="40%" class="form-control" dir="rtl"  style="float:right;"  runat="server" Text= '<%# Eval("Quantities") %>'></asp:TextBox>
                     
                        <!--   <asp:Label Text='<%# Eval("Quantities") %>'  runat="server"  Visible="false" ID="QuantitiesLabe" /><br />-->
                     </div>
                                    </div>
                                </div>
                            </div>

                    
                        <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                        <div class="col-lg-8" >
                       
                            <asp:Label Text="طريقة التحضير:" ID="Label1Method" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                           
                             <asp:TextBox TextMode="MultiLine" ReadOnly="true" Width="200%" Height="40%" ID="MethodLabel" Visible="false" class="form-control" dir="rtl"  style="float:right;"  runat="server" Text= '<%# Eval("Method") %>'></asp:TextBox>
                            </div>
                                    </div>
                                </div>
                            </div>
                   
                    
                         <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                        <div class="col-lg-8">
                        <asp:Label Text="معلومات طبيعية :" ID="Label1NaturalInfo" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                            
                            <asp:TextBox TextMode="MultiLine" ReadOnly="true" Width="200%" Height="40%" ID="NaturalInfoLabel" Visible="false" class="form-control" dir="rtl"  style="float:right;"  runat="server" Text= '<%# Eval("NaturalInfo") %>'></asp:TextBox>
                            </div>
</div>
                                </div>
                             </div>
                   
                     <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                         <div class="col-lg-8">
                        <asp:Label Text="معلومات قديمة:" ID="Label1OldInfo" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                            
                             <asp:TextBox TextMode="MultiLine" ReadOnly="true" Width="200%" Height="40%" ID="OldInfoLabel" Visible="false" class="form-control" dir="rtl"  style="float:right;"  runat="server" Text= '<%# Eval("OldInfo") %>'></asp:TextBox>
                            </div>

                               </div>
                                </div></div>        
                        
                         
                            <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                                    <div >
                        <asp:Label Text="صورة المقادير :" ID="Label1QuantityImg" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                             <div >
                                <asp:Image ID="Quantity_ImgPathLabe"   ImageUrl='<%# "~/images/food/" + Eval("Quantity_ImgPath") %>' Visible="false"  AlternateText="صورة" width="100px" Height="100px" runat="server" />
                            </div>
                             </div>
                          </div>

             </div>
                           
                         </div>

                    <!--<asp:Label Text='<%# Eval("Quantity_ImgPath") %>'   runat="server" Visible="false" ID="Quantity_ImgPathLabe1" /><br />-->
                 
                         <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">   
                        <div class="col-lg-8">
                          
                        <asp:Label Text="شرح الصورة :" ID="Label1QuantityImgCaption" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                           
                             <asp:TextBox TextMode="MultiLine" ReadOnly="true" Width="200%" Height="40%" ID="Quantity_ImgCaptionLabel" Visible="false" class="form-control" dir="rtl"  style="float:right;"  runat="server" Text= '<%# Eval("Quantity_ImgCaption") %>'></asp:TextBox>
                        </div>
                        </div>
                                </div>
                             </div>
                                      
                    <asp:Label Text='<%# Eval("Cat_ID") %>'   runat="server"  Visible="false" ID="Cat_IDLabel" /><br />
                        
                    
             </span>
                                 </div>
                 </div>
                    </div> 

            </AlternatingItemTemplate>
            <EditItemTemplate>
                 <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" ">
                <span style="background-color: #008A8C; color:black">
                    <asp:Label Text='<%# Eval("ID") %>' runat="server" Visible="false" ID="IDLabel1" /><br />

                     
                  <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" style="border-color:white;">
                        <h2 dir="rtl" style="float:right;">العنوان:</h2>  
                        <br /><br />
                         <asp:TextBox Text='<%# Bind("Title") %>'  class="form-control" runat="server" style="float:right;"  dir="rtl" ID="TitleTextBox" /><br /> 
                    </div>
                 </div>
                      </div>

                     
                     
                  <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" style="border-color:white;">
                            <h4 dir="rtl" style="float:right;">شرح مفصل:</h4>
  
                             <asp:TextBox Text='<%# Bind("Description") %>' runat="server" TextMode="MultiLine" Height="30%" class="form-control" style="float:right;"  dir="rtl" ID="DescriptionTextBox" /><br />
                    </div>
                 </div>
                      </div>
                     
                    
                  <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" style="border-color:white;">
                        
                            <h4 dir="rtl" style="float:right;">صورة الطعام:</h4> 
                            <asp:Image ID="FoodImg_Path" ImageUrl='<%# "~/images/food/" + Eval("Img_Path") %>' AlternateText="صورة"  width="100px" Height="100px" runat="server" />
                         
           <asp:FileUpload ID="FileUpload1" runat="server" />
          <br />
                                          <asp:Button runat="server" class="btn btn-metis-6 btn-sm btn-round" CommandName="Delete1" Text="حذف" ID="FoodPicDelete" />
                          <asp:Button runat="server" class="btn btn-metis-6 btn-sm btn-round" CommandName="Update1" ValidationGroup="FImg" Text="حفظ" ID="FoodPicUpdate" />
                       <asp:Label ID="LabelSizeInfo1" runat="server" Text="  *يجب الا يتعدى حجم الصورة 100كيلو بايت" Font-Size="Large" ForeColor="#339933"></asp:Label>
                          <asp:Label ID="LabelFImgPath" runat="server" Text='<%# Eval("Img_Path") %>' Visible="false" ></asp:Label>


                           <asp:RegularExpressionValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left: -20%; margin-top: -1%;" ID="RegularExpressionValidator1"  runat="server"
                       ControlToValidate="FileUpload1"  ValidationExpression="(.*png$)|(.*jpg$)|(.*jpeg$)|(.*PNG$)|(.*JPEG$)|(.*JPG$)|(.*gif$)|(.*GIF$)|(.*bmap$)|(.*BMAP$)|(.*BITMAP$)|(.*bitmap$)" ValidationGroup="FImg">
                            <div class="formErrorContent">* يجب ان تكون صيغة الصورة من الاتى (jpg,png,gif,bitmap)<br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                                 </asp:RegularExpressionValidator >   
                <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left: 25%; margin-top: -1%;" ID="RequiredFieldValidator1" ValidationGroup="FImg"  runat="server"  ControlToValidate="FileUpload1">
                            <div class="formErrorContent">* يجب ادحال صورة للاكلة<br></div>
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
                    
                   
                  <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" style="border-color:white;">
                            <h4 dir="rtl"  style="float:right;">المقادير:</h4>
                           <asp:TextBox Text='<%# Bind("Quantities") %>' runat="server" class="form-control" TextMode="MultiLine" Height="30%"  style="float:right;"  dir="rtl" ID="QuantitiesTextBox" /><br />
                      </div>
                 </div>
                      </div>
                       
                    
                     
                  <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" style="border-color:white;">
                            <h4 dir="rtl" style="float:right;">طريقة التحضير:</h4>
                            <asp:TextBox Text='<%# Bind("Method") %>' runat="server" TextMode="MultiLine"  Height="30%" class="form-control"  style="float:right;"  dir="rtl" ID="MethodTextBox" /><br />   
                    </div>
                 </div>
                      </div>
                    
                    
                     
                  <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" style="border-color:white;">
                      <h4 dir="rtl" style="float:right;">معلومات طبيعيه:</h4>  
                         <asp:TextBox Text='<%# Bind("NaturalInfo") %>' runat="server" class="form-control" TextMode="MultiLine" Height="30%"  style="float:right;"  dir="rtl" ID="NaturalInfoTextBox" /><br />
                        </div>
                 </div>
                      </div>
                   
                    
                      
                  <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" style="border-color:white;">
                       <h4 dir="rtl" style="float:right;">معلومات قديمة:</h4>
                    
                         <asp:TextBox Text='<%# Bind("OldInfo") %>' runat="server" class="form-control" TextMode="MultiLine" Height="30%"  style="float:right;"  dir="rtl" ID="OldInfoTextBox" /><br />
                    </div>
                 </div>
                      </div>
                    
                     
                  <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" style="border-color:white;">
                       <h4 dir="rtl" style="float:right;">صورة المقادير:</h4> 
                         
                           <asp:Image ID="QuantityImg_Path" ImageUrl='<%# "~/images/food/" + Eval("Quantity_ImgPath") %>' AlternateText="صورة"  width="100px" Height="100px" runat="server" />
                          <asp:FileUpload ID="FileUpload2" runat="server"></asp:FileUpload>
                         <br />
                           <asp:Button runat="server" class="btn btn-metis-6 btn-sm btn-round" CommandName="Delete2" Text="حذف" ID="quantityPicDelete" />
                          <asp:Button runat="server" class="btn btn-metis-6 btn-sm btn-round" CommandName="Update2" Text="حفظ" ValidationGroup="QImg" ID="quantityPicUpdate" />
                         <asp:Label ID="LabelSizeInfo2" runat="server" Text="  *يجب الا يتعدى حجم الصورة 100كيلو بايت" Font-Size="Large" ForeColor="#339933"></asp:Label>
                          <asp:Label ID="LabelQImgPath" runat="server" Text='<%# Eval("Quantity_ImgPath") %>' Visible="false" ></asp:Label>
                          
                           <asp:RegularExpressionValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left: -20%; margin-top: -1%;" ID="RegularExpressionValidatorTimgExtention2"  runat="server"
                       ControlToValidate="FileUpload2"  ValidationExpression="(.*png$)|(.*jpg$)|(.*jpeg$)|(.*PNG$)|(.*JPEG$)|(.*JPG$)|(.*gif$)|(.*GIF$)|(.*bmap$)|(.*BMAP$)|(.*BITMAP$)|(.*bitmap$)" ValidationGroup="QImg">
                            <div class="formErrorContent">* يجب ان تكون صيغة الصورة من الاتى (jpg,png,gif,bitmap)<br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                                 </asp:RegularExpressionValidator >   
                <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left: 25%; margin-top: -1%;" ID="RequiredFieldValidatorTimagePath2" ValidationGroup="QImg"  runat="server"  ControlToValidate="FileUpload2">
                            <div class="formErrorContent">* يجب ادحال صورة المقادير<br></div>
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

                      
                  <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" style="border-color:white;">
                        <h4 dir="rtl" style="float:right;">وصف صورة المقادير:</h4> 
                    <asp:TextBox Text='<%# Bind("Quantity_ImgCaption") %>' runat="server" class="form-control" TextMode="MultiLine" Height="30%"  style="float:right;"  dir="rtl" ID="Quantity_ImgCaptionTextBox" /><br />
                    </div>
                 </div>
                      </div>

                    <asp:TextBox Text='<%# Bind("Cat_ID") %>' Visible="false" runat="server" ID="Cat_IDTextBox" /><br />
                  
                  <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" style="border-color:white;">
                        <asp:Button runat="server" class="btn btn-metis-6 btn-lg btn-round" CommandName="Update" Text="حفظ" ID="UpdateButton" />
                        <asp:Button runat="server" class="btn btn-metis-5 btn-lg btn-round" CommandName="Cancel" Text="إلغاء" ID="CancelButton" /><br />
                    
                          </div>
                 </div>
                      </div>
                </span>
                 </div>
                     </div>
                </div>
            </EditItemTemplate>
            <EmptyDataTemplate>
                <span>لا يوجد بيانات</span>
            </EmptyDataTemplate>
            <InsertItemTemplate>
                <span style="">Title:
                    <asp:TextBox Text='<%# Bind("Title") %>' runat="server" ID="TitleTextBox" /><br />
                    Description:
                    <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /><br />
                    Img_Path:
                    <asp:TextBox Text='<%# Bind("Img_Path") %>' runat="server" ID="Img_PathTextBox" /><br />
                    Quantities:
                    <asp:TextBox Text='<%# Bind("Quantities") %>' runat="server" ID="QuantitiesTextBox" /><br />
                    Method:
                    <asp:TextBox Text='<%# Bind("Method") %>' runat="server" ID="MethodTextBox" /><br />
                    NaturalInfo:
                    <asp:TextBox Text='<%# Bind("NaturalInfo") %>' runat="server" ID="NaturalInfoTextBox" /><br />
                    OldInfo:
                    <asp:TextBox Text='<%# Bind("OldInfo") %>' runat="server" ID="OldInfoTextBox" /><br />
                    Quantity_ImgPath:
                    <asp:TextBox Text='<%# Bind("Quantity_ImgPath") %>' runat="server" ID="Quantity_ImgPathTextBox" /><br />
                    Quantity_ImgCaption:
                    <asp:TextBox Text='<%# Bind("Quantity_ImgCaption") %>' runat="server" ID="Quantity_ImgCaptionTextBox" /><br />
                    Cat_ID:
                    <asp:TextBox Text='<%# Bind("Cat_ID") %>' runat="server" ID="Cat_IDTextBox" /><br />
                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" /><asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" /><br />
                    <br />
                </span>
            </InsertItemTemplate>
            <ItemTemplate>
               
                <div class="row" >
             <div class="col-lg-9" >
                      <div class="box dark" ">
                <span style="background-color: #DCDCDC; color: #000000;"> 
                    <asp:Label Text='<%# Eval("ID") %>'   runat="server" Visible="false" ID="IDLabel" /><br />
                    
                     <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                    <div class="col-lg-8" >
                        <h2 dir="rtl" style="float:right;">العنوان:</h2>  
                        
                             <asp:TextBox ID="TitleLabel" class="form-control" TextMode="SingleLine" dir="rtl" ReadOnly="true"  style="float:right;" width= "100%" runat="server" text= '<%# Eval("Title") %>' ></asp:TextBox>
                    </div>
                    <div class="col-lg-8">
                            <h4 dir="rtl" style="float:right;">شرح مفصل:</h4> 
                    
                         <asp:TextBox ID="DescriptionLabel" class="form-control" TextMode="MultiLine" dir="rtl"  style="float:right;" width="200%"  Height="40%" Readonly="true" runat="server" text= '<%# Eval("Description") %>'></asp:TextBox>
                    
                    </div>
                    
                    <div class="col-lg-8">
                        
                            <h4 dir="rtl" style="float:right;">صورة الطعام:</h4>   
                         <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;"> 
                        <asp:Image ID="Img_PathLabe1" ImageUrl='<%# "~/images/food/" + Eval("Img_Path") %>' AlternateText="صورة" width="100px" Height="100px" runat="server" />
                     <!-- <asp:Label Text='<%# Eval("Img_Path") %>' runat="server" ID="Img_PathLabe" /><br /> -->
                    </div>
                                </div>
                             </div>
                    </div>
                                    </div>
                                </div>
                         </div>
                    
                    <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                     <div >
                       
                    <asp:Button runat="server" CommandName="Edit" class="btn btn-metis-6 btn-lg btn-round" Text="تعديل" ID="EditButton" />
                    <asp:Button runat="server" CommandName="Delete" class="btn btn-metis-6 btn-lg btn-round" Text="إزالة" ID="DeleteButton" />
                    <asp:Button ID="ButtonMore" runat="server"  CommandName="More" class="btn btn-metis-5 btn-lg btn-round" Text="المزيد" />
                    </div> 
            </div>
                                </div>
                        </div>
                    <!-- __________________________________________________________________________________ -->
                    
                        <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                        <div class="col-lg-8" >
                       
                        <asp:Label Text="المقادير:" ID="lable1Quantities" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                        <br />
                         <asp:TextBox TextMode="MultiLine" ReadOnly="true" ID="QuantitiesLabel" Visible="false" Width="200%" Height="40%" class="form-control" dir="rtl"  style="float:right;"  runat="server" Text= '<%# Eval("Quantities") %>'></asp:TextBox>
                     
                        <!--   <asp:Label Text='<%# Eval("Quantities") %>'  runat="server"  Visible="false" ID="QuantitiesLabe" /><br />-->
                     </div>
                                    </div>
                                </div>
                            </div>

                    
                        <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                        <div class="col-lg-8" >
                       
                            <asp:Label Text="طريقة التحضير:" ID="Label1Method" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                           
                             <asp:TextBox TextMode="MultiLine" ReadOnly="true" Width="200%" Height="40%" ID="MethodLabel" Visible="false" class="form-control" dir="rtl"  style="float:right;"  runat="server" Text= '<%# Eval("Method") %>'></asp:TextBox>
                            </div>
                                    </div>
                                </div>
                            </div>
                   
                    
                         <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                        <div class="col-lg-8">
                        <asp:Label Text="معلومات طبيعية :" ID="Label1NaturalInfo" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                            
                            <asp:TextBox TextMode="MultiLine" ReadOnly="true" Width="200%" Height="40%" ID="NaturalInfoLabel" Visible="false" class="form-control" dir="rtl"  style="float:right;"  runat="server" Text= '<%# Eval("NaturalInfo") %>'></asp:TextBox>
                            </div>
</div>
                                </div>
                             </div>
                   
                     <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                         <div class="col-lg-8">
                        <asp:Label Text="معلومات قديمة:" ID="Label1OldInfo" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                            
                             <asp:TextBox TextMode="MultiLine" ReadOnly="true" Width="200%" Height="40%" ID="OldInfoLabel" Visible="false" class="form-control" dir="rtl"  style="float:right;"  runat="server" Text= '<%# Eval("OldInfo") %>'></asp:TextBox>
                            </div>

                               </div>
                                </div></div>        
                        
                         
                            <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">
                                    <div >
                        <asp:Label Text="صورة المقادير :" ID="Label1QuantityImg" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                             <div >
                                <asp:Image ID="Quantity_ImgPathLabe"   ImageUrl='<%# "~/images/food/" + Eval("Quantity_ImgPath") %>' Visible="false"  AlternateText="صورة" width="100px" Height="100px" runat="server" />
                            </div>
                             </div>
                          </div>

             </div>
                           
                         </div>

                    <!--<asp:Label Text='<%# Eval("Quantity_ImgPath") %>'   runat="server" Visible="false" ID="Quantity_ImgPathLabe1" /><br />-->
                 
                         <div class="row" >
                            <div class="col-lg-9" >
                                <div class="box dark" style="border-color:white;">   
                        <div class="col-lg-8">
                          
                        <asp:Label Text="شرح الصورة :" ID="Label1QuantityImgCaption" dir="rtl"  style="float:right;font-size:100%;" Visible="false" runat="server"></asp:Label>
                           
                             <asp:TextBox TextMode="MultiLine" ReadOnly="true" Width="200%" Height="40%" ID="Quantity_ImgCaptionLabel" Visible="false" class="form-control" dir="rtl"  style="float:right;"  runat="server" Text= '<%# Eval("Quantity_ImgCaption") %>'></asp:TextBox>
                        </div>
                        </div>
                                </div>
                             </div>
                                      
                    <asp:Label Text='<%# Eval("Cat_ID") %>'   runat="server"  Visible="false" ID="Cat_IDLabel" /><br />
                        
                    
             </span>
                                 </div>
                 </div>
                    </div>           
                
             
            </ItemTemplate>
            <LayoutTemplate>
                <div runat="server" id="itemPlaceholderContainer" style="font-family: Verdana, Arial, Helvetica, sans-serif;"><span runat="server" id="itemPlaceholder" /></div>
                <div style="text-align: center; background-color: #CCCCCC; font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;">
                    <asp:DataPager runat="server" ID="DataPager2" PageSize="3">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                            <asp:NumericPagerField></asp:NumericPagerField>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                        </Fields>
                    </asp:DataPager>

                </div>
            </LayoutTemplate>
            <SelectedItemTemplate>
                <span style="background-color: #008A8C; font-weight: bold; color: #FFFFFF;">ID:
                    <asp:Label Text='<%# Eval("ID") %>' runat="server" ID="IDLabel" /><br />
                    Title:
                    <asp:Label Text='<%# Eval("Title") %>' runat="server" ID="TitleLabel" /><br />
                    Description:
                    <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /><br />
                    Img_Path:
                    <asp:Label Text='<%# Eval("Img_Path") %>' runat="server" ID="Img_PathLabel" /><br />
                    Quantities:
                    <asp:Label Text='<%# Eval("Quantities") %>' runat="server" ID="QuantitiesLabel" /><br />
                    Method:
                    <asp:Label Text='<%# Eval("Method") %>' runat="server" ID="MethodLabel" /><br />
                    NaturalInfo:
                    <asp:Label Text='<%# Eval("NaturalInfo") %>' runat="server" ID="NaturalInfoLabel" /><br />
                    OldInfo:
                    <asp:Label Text='<%# Eval("OldInfo") %>' runat="server" ID="OldInfoLabel" /><br />
                    Quantity_ImgPath:
                    <asp:Label Text='<%# Eval("Quantity_ImgPath") %>' runat="server" ID="Quantity_ImgPathLabel" /><br />
                    Quantity_ImgCaption:
                    <asp:Label Text='<%# Eval("Quantity_ImgCaption") %>' runat="server" ID="Quantity_ImgCaptionLabel" /><br />
                    Cat_ID:
                    <asp:Label Text='<%# Eval("Cat_ID") %>' runat="server" ID="Cat_IDLabel" /><br />
                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                    <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                    <br />
                    <br />
                </span>
            </SelectedItemTemplate>
        </asp:ListView>
       
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' DeleteCommand="deleteFoodByID" DeleteCommandType="StoredProcedure" SelectCommand="getAllFoods" SelectCommandType="StoredProcedure" UpdateCommand="updateFoodByID" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="ID" Type="Int32"></asp:Parameter>
                <asp:Parameter Name="Title" Type="String"></asp:Parameter>
                <asp:Parameter Name="Description" Type="String"></asp:Parameter>
                <asp:Parameter Name="Img_Path" Type="String"></asp:Parameter>
                <asp:Parameter Name="Quantities" Type="String"></asp:Parameter>
                <asp:Parameter Name="Method" Type="String"></asp:Parameter>
                <asp:Parameter Name="NaturalInfo" Type="String"></asp:Parameter>
                <asp:Parameter Name="OldInfo" Type="String"></asp:Parameter>
                <asp:Parameter Name="Quantity_ImgPath" Type="String"></asp:Parameter>
                <asp:Parameter Name="Quantity_ImgCaption" Type="String"></asp:Parameter>
                <asp:Parameter Name="Cat_ID" Type="Int32"></asp:Parameter>
            </UpdateParameters>
        </asp:SqlDataSource>
                    


                  </div>
        
            </div>
      </div>
                                          
</asp:Content>

