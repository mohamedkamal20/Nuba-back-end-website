<%@ Page Title="Show Galleries" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="ShowImagesGallery.aspx.cs" Inherits="ShowImagesGallery" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row" dir="rtl">
        <div class="col-lg-9 box dark" style="float: right; margin: auto; width: 100%">
            <%--<div class="box dark" style="margin-right: 1%; width: 100%">--%>
            <header style="text-align: right; font-size: xx-large; padding-right: 2%">
                المعارض و الصور الخاصه  
            </header>
              <br />
            <asp:Button class="btn btn-metis-5 btn-lg btn-round" ID="hidePhotos" runat="server" Text="عوده" CommandName="HideImages" OnClick="hidePhotos_Click" Visible="false" Style="float: left" />
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>"
                SelectCommand="show_Gallery" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
            <br />
            <asp:Label ID="lb1_ID" runat="server" Text="" Visible="false"></asp:Label>
            <br />
            <asp:Label ID="Tittle" runat="server" Visible="false" Text="" Font-Size="XX-Large" Font-Bold="true"></asp:Label>
            <br />
            <asp:ListView ID="Show_Gallery" runat="server" DataSourceID="SqlDataSource1" OnItemCommand="DoTheCommand">
                <%--GroupTemplate>
                <div class="row">
                    <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                </div>
            </GroupTemplate>--%>
                <ItemTemplate>
                    <div class="form-group" style="margin-bottom: 5%; margin-left: 2%; clear: both; float: right; width: 80%; height: 50%">
                        <asp:Label ID="Title" runat="server" Text='<%#Eval("Title") %>' Visible="True" Font-Size="XX-Large" Font-Bold="true"></asp:Label>
                        <br />
                        <br />
                        <asp:Image ID="MainPhoto" runat="server" ImageUrl='<%# string.Format("Images/GalaryImages/{0}",Eval("Img_Path")) %>' Width="200px" Height="200px" Visible="True" />
                        <br />
                        <asp:Label ID="MoreText" runat="server" Text='<%# Eval("Description")%>' Visible="false" />
                        <asp:Label ID="Description" runat="server" Text='<%# Convert.ToString(Eval("Description")).Substring(0,(Convert.ToString(Eval("Description")).Length)/4)%>' Style="text-align: right; font-size: medium" Visible="True" />
                        <asp:LinkButton ID="More" runat="server" CommandName="MMore">أقرأ المزيد</asp:LinkButton>
                        <asp:LinkButton ID="Less" runat="server" CommandName="MLess" Visible="false">رجوع</asp:LinkButton>
                        <br />
                        <br />
                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="Edit_Name" runat="server" Text="تعديل اسم المعرض" CommandName="Edit_title" CommandArgument='<%#Eval("id") %>' />
                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="Edit_Desc" runat="server" Text="تعديل الوصف" CommandName="Edit_Description" CommandArgument='<%#Eval("id") %>' />
                        <br />
                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="showPhotos" runat="server" Text="عرض الصور" CommandName="ShwImages" CommandArgument='<%#Eval("id") %>' />
                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="deleteGalary" runat="server" Text="حذف المعرض" CommandName="Delete_Galary" CommandArgument='<%#Eval("id") %>' OnClientClick="return fnConfirmDelete();" />
                        <script type="text/javascript">
                            function fnConfirmDelete() {
                                return confirm("هل انت متأكد من حذفك للمعرض باكمله؟ ");
                            }
                        </script>
                        <br />
                        <br />
                        <div class="col-lg-12" dir="rtl" style="float: right">
                            <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" Style="opacity: 0.87; position: absolute; top: 0px; left: -85px; margin-top: -35px;" ID="RequiredFieldValidator4" runat="server" ValidationGroup='<%#Eval("ID") %>' ControlToValidate="Edit_title">
                            <div class="formErrorContent">*يجب إدخال اسم المعرض <br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                            </asp:RequiredFieldValidator>
                            <asp:TextBox class="validate[required] form-control" ID="Edit_title" runat="server" Visible="false" data-placement="top"></asp:TextBox>
                        </div>

                        <div class="col-lg-12" dir="rtl">
                            <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" Style="opacity: 0.87; position: absolute; top: 0px; left: -85px; margin-top: -35px;" ID="RequiredFieldValidator1" runat="server" ValidationGroup='<%#Eval("ID") %>' ControlToValidate="Editt_Desc">
                            <div class="formErrorContent">*يجب إدخال وصف المعرض <br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                            </asp:RequiredFieldValidator>
                            <asp:TextBox class="validate[required] form-control" ID="Editt_Desc" runat="server" Visible="false" TextMode="MultiLine" data-placement="top" Width="100%"></asp:TextBox>

                        </div>

                        <div style="clear: both; float: right">
                            <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="saveEditing" runat="server" ValidationGroup='<%#Eval("ID") %>' Text="حفظ التعديلات" CommandName="savingtitle" Visible="false" />
                            <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="saveEditing1" runat="server" ValidationGroup='<%#Eval("ID") %>' Text="حفظ التعديلات" CommandName="savingdesc" Visible="false" />
                            <asp:Button class="btn btn-metis-5 btn-lg btn-round" ID="Canccel" runat="server" Text="عوده" CommandName="canccel" Visible="false" />
                        </div>

                        <br />
                    </div>
                </ItemTemplate>
            </asp:ListView>
            <div style="clear: both; float: left; margin-bottom: 2%">
                <asp:DataPager ID="ListPager" PagedControlID="Show_Gallery" runat="server" PageSize="3">
                    <Fields>
                        <asp:NumericPagerField />
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True"
                            ShowLastPageButton="True" />
                    </Fields>
                </asp:DataPager>
            </div>

            <asp:ListView ID="ListPhotos" runat="server" Visible="false" DataSourceID="SqlDataSource2" OnItemCommand="ListPhotos_ItemCommand">
                <ItemTemplate>
                    <div class="form-group" style="margin-bottom: 5%; margin-left: 2%; clear: both; float: right; width: 80%; height: 50%">
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# string.Format("Images/GalaryImages/{0}",Eval("Img_Path")) %>' Width="200px" Height="200px" Visible="True" />
                        <br />
                        <asp:Label ID="MMore" runat="server" Text='<%# Eval("Caption") %>' Visible="false"></asp:Label>
                        <asp:Label ID="Caption" runat="server" Text='<%# Convert.ToString(Eval("Caption")).Substring(0,(Convert.ToString(Eval("Caption")).Length)/8)%>' Style="text-align: right; font-size: medium" Visible="True" />
                        <asp:LinkButton ID="Moree" runat="server" CommandName="MMMore">أقرأ المزيد</asp:LinkButton>
                        <asp:LinkButton ID="Lesss" runat="server" CommandName="MMLess" Visible="false">رجوع</asp:LinkButton>
                        <br />
                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="removephoto" runat="server" Text="حذف الصوره" CommandName="deletingPhoto" CommandArgument='<%#Eval("ID") %>' OnClientClick="return ConfirmDeletePhoto();" />
                        <script type="text/javascript">
                            function ConfirmDeletePhoto() {
                                return confirm("هل تريد حذف الصوره؟");
                            }
                        </script>
                        <br />
                        <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="Edit_Caption" runat="server" Text="تعديل النُبذه" CommandName="EditCap" CommandArgument='<%#Eval("ID")%>' />
                        <br />
                        <asp:Label ID="Lbl_Deleteing" runat="server" Text="" Visible="false" Style="color: #FF0000"></asp:Label>
                        <br />
                        <div class="col-lg-8">
                            <asp:RequiredFieldValidator class="reqformError parentFormpopup-validation formError" Style="opacity: 0.87; position: absolute; top: 0px; left: -85px; margin-top: -35px;" ID="RequiredFieldValidator1" runat="server" ValidationGroup='<%#Eval("ID") %>' ControlToValidate="Edit_Text">
                            <div class="formErrorContent">*يجب إدخال النبُذه <br></div>
                            <div class="formErrorArrow"><div class="line10"><!-- --></div>
                                <div class="line9"><!-- --></div><div class="line8"><!-- --></div>
                                <div class="line7"><!-- --></div><div class="line6"><!-- --></div>
                                <div class="line5"><!-- --></div><div class="line4"><!-- --></div>
                                <div class="line3"><!-- --></div><div class="line2"><!-- --></div>
                                <div class="line1"><!-- --></div></div>
                            </asp:RequiredFieldValidator>
                            <asp:TextBox class="validate[required] form-control" ID="Edit_Text" runat="server" TextMode="MultiLine" data-placement="top" Visible="false"></asp:TextBox>
                        </div>
                        <br />
                        <div style="clear: both; float: right">
                            <asp:Button class="btn btn-metis-6 btn-lg btn-round" ID="saveEditing2" runat="server" Text="حفظ التعديلات" ValidationGroup='<%#Eval("ID") %>' Visible="false" CommandName="savingCap" />
                            <asp:Button class="btn btn-metis-5 btn-lg btn-round" ID="Canccel" runat="server" Text="عوده" ValidateRequestMode="Disabled" CommandName="canccel" Visible="false" />
                        </div>
                    </div>

                </ItemTemplate>
            </asp:ListView>
            <div style="clear: both; float: left; margin-bottom: 2%">
                <asp:DataPager ID="DataPager1" PagedControlID="ListPhotos" runat="server" PageSize="3">
                    <Fields>
                        <asp:NumericPagerField />
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True"
                            ShowLastPageButton="True" />
                    </Fields>
                </asp:DataPager>
            </div>
            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' SelectCommand="showImagesGallary" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="lb1_ID" PropertyName="Text" DefaultValue="0" Name="id" Type="Int32"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>

        </div>
    </div>
</asp:Content>

