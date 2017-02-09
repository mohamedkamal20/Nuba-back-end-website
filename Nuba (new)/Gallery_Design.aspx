<%@ Page Title="Add Gallery" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Gallery_Design.aspx.cs" Inherits="Gallery_Design" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<%--<asp:Content ContentPlaceHolderID="Header" runat="server">--%>

<%--</asp:Content>--%>

<asp:Content ID="content" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row" style="height:100%" dir="rtl">
        <div class="col-lg-9" style="height: 700px; float: right">
            <div class="box dark" style="margin-right: 1%; margin-top: 3%; width: 100%; height: 55%">
                <header style="text-align: right; font-size: xx-large; padding-right: 1%">
                    اضافه معرض 
                </header>
                <%-- <div style="margin-top: 5%; text-align: right; height: 80%; width: 60%; float: right" dir="rtl">--%>
                <div class="form-group" style="margin-top: 5%; float: right" dir="rtl">
                    <asp:Label for="text1" class="control-label col-lg-8" ID="Label1" runat="server" Font-Size="Large" Style="float: right">اسم المعرض</asp:Label>
                    <div class="col-lg-12">
                         <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left: -85px; margin-top: -35px;" ID="RequiredFieldValidator1" runat="server"  ControlToValidate="TextBox1">
                            <div class="formErrorContent">*يجب إدخال اسم المعرض <br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                                 </asp:RequiredFieldValidator>
                        <asp:TextBox class="validate[required] form-control" ID="TextBox1" runat="server" data-placement="top"></asp:TextBox>
                    </div>
                </div>
                <br />
                <div class="form-group" style="margin-top: 2%; clear: both; float: right">
                    <asp:Label for="text2" class="control-label col-lg-8" ID="Label2" runat="server" Font-Size="Large" Style="float: right">وصف المعرض</asp:Label>
                    <div class="col-lg-12">
                         <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" style="opacity: 0.87; position: absolute; top: 0px; left: -85px; margin-top: -35px;" ID="vald_RequiredName" runat="server"  ControlToValidate="Lbl_Desc">
                            <div class="formErrorContent">*يجب إدخال وصف المعرض <br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                                 </asp:RequiredFieldValidator>
                        <asp:TextBox class="validate[required] form-control" ID="Lbl_Desc" runat="server" TextMode="MultiLine" data-placement="top" Height="80px"></asp:TextBox>
                    </div>
                </div>
                <div class="" style="margin-top: 5%; clear: both; float: right; margin-right: 5%; margin-left: 1%; width: 80%">
                    <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="Button1" runat="server" Text="حفظ" Style="text-align: center" OnClick="Button1_Click" />
                    <asp:Button class="btn btn-metis-5 btn-lg btn-round" ID="Button2" runat="server" Text="اعاده ملئ" Style="text-align: center" OnClick="Button2_Click" />
                    <%-- <asp:Label ID="CheckInsertion" runat="server" Text="" Style="color: blue"></asp:Label>--%>
                </div>
            </div>
        </div>
    </div>
    <%-- </div>--%>
</asp:Content>


