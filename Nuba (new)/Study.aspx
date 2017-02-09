<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Study.aspx.cs" MasterPageFile="~/Site.master" Inherits="Studies_showStudy" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="box dark">
        <header>
            <div class="icons">
                 <span aria-hidden="true" class="glyphicon glyphicon-eye-open"></span>  
            </div>
            <h5><asp:Label runat="server" ID="headerTitle"></asp:Label></h5>
        </header>
        <div id="div-1" class="body collapse in" aria-expanded="true">

            <asp:Label ID="title" runat="server"></asp:Label>
            <asp:Label ID="Label1" runat="server" CssClass="control-label col-lg-1" Font-Bold="true">العنوان</asp:Label>
            <br />
  
            <asp:Label ID="desc" runat="server" rows="2" TextMode="MultiLine"></asp:Label>
            <asp:Label ID="Label2" runat="server" CssClass="control-label col-lg-1" Font-Bold="true">الوصف</asp:Label>
            <br />
    
         
             <asp:Label ID="pdf" runat="server" CssClass="control-label col-lg-1" Font-Bold="true">المقال</asp:Label>
             <asp:HyperLink ID="Hyperlink1" runat="server" NavigateUrl="">
                <asp:Label ID="pdfurl" runat="server" Text=""></asp:Label>
             </asp:HyperLink>

             <br />

             
             <asp:Label ID="img" runat="server" CssClass="control-label col-lg-5" Font-Bold="true">الصورة</asp:Label>
             <span class="fileinput-new thumbnail" style="width: 200px; height: 150px">
               <asp:Image runat="server" ImageUrl="" data-src="holder.js/100%x100%" alt="..." ID="Image1" />
             </span>  
              
        
              
              <asp:Label ID="caption" runat="server" TextMode="MultiLine" ></asp:Label>
              <asp:Label ID="Label3" runat="server" CssClass="control-label col-lg-1" Font-Bold="true">النبذة</asp:Label>
              <br />
              
              <asp:Label ID="Label4" runat="server" CssClass="control-label col-lg-1" Font-Bold="true"> المؤلف</asp:Label>
              <asp:Label ID="author" runat="server" ></asp:Label>
              <br />
              

              <asp:Label ID="DateTextBox" runat="server" TextMode="Date"></asp:Label>
              <asp:Label ID="label5" runat="server" CssClass="control-label col-lg-1" Font-Bold="true">التاريخ</asp:Label>
              <br />
              
              
              
        <asp:Button id="btnCancel" CssClass="btn btn-metis-5 btn-lg btn-round" runat="server" text="رجوع" OnClientClick="JavaScript:window.history.back(1); return false;" />
    </div>
  </div>
</asp:Content>