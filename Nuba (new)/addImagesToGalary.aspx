<%@ Page Title="Add Images To Gallery" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="addImagesToGalary.aspx.cs" Inherits="addImagesToGalary" %>

<asp:Content ID="content" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row" style="height: 100%" dir="rtl">
        <div class="col-lg-9" style="height: 700px; float: right">
            <div class="box dark" style="margin-right: 1%; margin-top: 3%; width: 100%; height: 80%">
                <header style="text-align: right; font-size: xx-large; padding-right: 1%">
                    اضافه صور للمعرض 
                </header>
                <asp:SqlDataSource ID="GalaryDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT [Title], [id] FROM [Gallery]"></asp:SqlDataSource>
                <div class="form-group" style="margin-top: 5%; float: right">
                    <asp:Label for="text1" class="control-label col-lg-4" ID="Label4" runat="server" Font-Size="Large">اسم المعرض </asp:Label>
                    <div class="col-lg-8">
                        <asp:DropDownList class="form-control chzn-select" ID="DropDownList1" runat="server" DataSourceID="GalaryDataSource" DataTextField="Title" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" DataValueField="id"></asp:DropDownList>
                    </div>
                </div>
                <div class="form-group" style="margin-top: 3%; clear: both; float: right">
                    <asp:Label for="text1" class="control-label col-lg-4" ID="Label5" runat="server" Font-Size="Large" Style="clear: both; text-align: right">اضافه صوره للمعرض</asp:Label>
                    <div class="col-lg-8">
                        <asp:FileUpload ID="FileUpload1" runat="server" />
                        <asp:Label ID="LabelSizeInfo" runat="server" Text="  *يجب الا يتعدى حجم الصورة 100كيلو بايت" ForeColor="#339933"></asp:Label>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.jpg|.JPG|.jpeg|.JPEG|.bmp|.BMP|.tif|.TIF|.gif|GIF)$"
                            ControlToValidate="FileUpload1" runat="server" ErrorMessage="Please select an image to upload." Style="color: red" />
                    </div>
                </div>

                <div class="form-group" style="margin-top: 3%; clear: both; float: right">
                    <asp:Label for="text1" class="control-label col-lg-4" ID="Label6" runat="server" Font-Size="Large">نبذه مختصره</asp:Label>
                    <div class="col-lg-8">
                        <asp:TextBox class="validate[required] form-control" ID="addCaption" runat="server" TextMode="MultiLine" data-placement="top"></asp:TextBox>
                    </div>
                </div>

                <div class="form-group" style="margin-top: 3%; clear: both; float: right">
                    <asp:Label for="text1" class="control-label col-lg-4" ID="Label1" runat="server" Font-Size="Large">صوره رئيسيه؟</asp:Label>
                    <div class="col-lg-8">
                        <div class="checkbox">
                            <label>
                                <asp:RadioButton ID="RadioButton2" class="uniform" GroupName="h" runat="server" Text="لا" Checked="True" />
                            </label>
                            <!-- /.checkbox -->
                            <label>
                                <asp:RadioButton ID="RadioButton1" class="uniform" GroupName="h" runat="server" Text="نعم" />
                            </label>
                        </div>
                    </div>
                </div>
                <br />
                <%--<asp:Label for="text1" class="control-label col-lg-4" ID="errorMessage" runat="server" style="color:red"></asp:Label>--%>
                <div class="" style="margin-top: 5%; clear: both; float: right; margin-right: 5%; margin-left: 1%; width: 80%">
                    <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="Button4" runat="server" Text="حفظ" OnClick="Save" />
                    <asp:Button class="btn btn-metis-5 btn-lg btn-round" ID="Button3" runat="server" Text="اعاده ملئ" OnClick="ToEmpty" />
                    <%--<asp:Label ID="CheckInsertion" runat="server" Style="color:blue" Text=""></asp:Label>  --%>
                </div>
        </div>
    </div>
    </div>

</asp:Content>

