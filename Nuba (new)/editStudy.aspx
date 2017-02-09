<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeFile="editStudy.aspx.cs" Inherits="Studies_editStudy" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
            <asp:TextBox ID="title" runat="server" Width="128px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="العنوان"></asp:Label>
            <br />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="title" CssClass="text-danger"
                           ErrorMessage="العنوان مطلوب." />
            <br />
  

            <asp:TextBox ID="desc" runat="server" rows="2" TextMode="MultiLine"></asp:TextBox>
            <asp:Label ID="Label2" runat="server" Text="الوصف"></asp:Label>
            <br />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="desc" CssClass="text-danger"
                    ErrorMessage="الوصف مطلوب."  />
            <br />
    
            <asp:FileUpload ID="pdfupload" runat="server" />
            <asp:Button ID="uploadPDF" runat="server" OnClick="uploadPDF_Click" Text="رفع" ValidationGroup="pdf" />
            <asp:Label ID="pdf" runat="server" Text="المقال"></asp:Label>
            <br />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationGroup="pdf"  runat="server" 
                    ControlToValidate="pdfupload" ErrorMessage="please upload pdf only" CssClass="text-danger"
                    ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.pdf|.fdf|.xfdf|xfa)$"> </asp:RegularExpressionValidator>
            <br />
            <asp:CustomValidator ID="PDFFileSizeValidator" runat="server" ClientValidationFunction="checkFileSize" 
                  ControlToValidate="pdfupload" ErrorMessage="File Size Exceed the size" 
                  ToolTip="File Size cant exceed 1024kb" > </asp:CustomValidator>
             <br />
             <asp:RequiredFieldValidator runat="server" ID="pdfvalidate" ControlToValidate="pdfupload" CssClass="text-danger" 
                   ErrorMessage="المقال مطلوب" ValidationGroup="pdf" />
             <br />  
             <asp:Label ID="pdfurl" runat="server" Text=""></asp:Label>
             <br />

             <asp:FileUpload ID="imgupload" runat="server" />
             <asp:Button ID="uploadImg" runat="server" OnClick="uploadImg_Click" Text="رفع" ValidationGroup="img" />
             <asp:Label ID="img" runat="server" Text="الصورة"></asp:Label>
             <br />
             <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                  ControlToValidate="imgupload" ErrorMessage="please upload images only" ValidationGroup="img"
                  ValidationExpression="^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.bmp|.gif|.png|.jpg|.jpeg)$"> </asp:RegularExpressionValidator>
             <br />
             <asp:CustomValidator ID="ImgFileValidator" runat="server" ClientValidationFunction="checkImgSize" 
                  ControlToValidate="imgupload" ErrorMessage="Img Size Exceed the size" 
                  ToolTip="Img Size cant exceed 1024kb"> </asp:CustomValidator>
              <br />
              <asp:Image ID="Image1" runat="server" Height="100px" ImageUrl="" Width="100px" />
              <br />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="imgupload" CssClass="text-danger" 
                   ErrorMessage="الصورة مطلوبة" ID="imgvalidate" ValidationGroup="img"  />
                      
              <br />
              <asp:TextBox ID="caption" runat="server" Width="128px" TextMode="MultiLine"></asp:TextBox>
              <asp:Label ID="Label3" runat="server" Text="النبذة"></asp:Label>
              <br />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="caption" CssClass="text-danger"
                   ErrorMessage="النبذة مطلوبة"   />
              <br />

              <asp:TextBox ID="author" runat="server" Width="128px"></asp:TextBox>
              <asp:Label ID="Label4" runat="server" Text="إسم المؤلف"></asp:Label>
              <br />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="author" CssClass="text-danger" 
                   ErrorMessage="اسم المؤلف مطلوب"  />
              <br />
              <asp:TextBox ID="DateTextBox" runat="server" TextMode="Date"></asp:TextBox>
              <asp:Label ID="label5" runat="server" Text="التاريخ"></asp:Label>
              <br />
              <asp:RequiredFieldValidator runat="server" ControlToValidate="DateTextBox" CssClass="text-danger" 
                   ErrorMessage="التاريخ مطلوب" />
              <br />  
              
              <asp:Button ID="update"  runat="server" Text="حفظ" OnClick="update_Click" />
              
              <asp:Button id="btnCancel" runat="server" text="رجوع" OnClientClick="JavaScript:window.history.back(1); return false;" />
    </div>
</asp:Content>