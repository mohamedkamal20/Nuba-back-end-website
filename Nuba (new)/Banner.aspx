<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Banner.aspx.cs" MasterPageFile="~/Site.master" Inherits="Banner_Banner" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="ajaxToolkit" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <ajaxToolkit:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
        <ajaxToolkit:TabPanel runat="server" HeaderText="TabPanel1" ID="TabPanel1">
            <HeaderTemplate>
                إضافة
            </HeaderTemplate>
            <ContentTemplate>
                                   <!--Title-->
                <asp:TextBox ID="title" runat="server"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="العنوان"></asp:Label>
                <br />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="title"
                        CssClass="text-danger" ErrorMessage="العنوان مطلوب." />
                <br />
                <br />
                <br />
                <br />

                                    <!--imgupload-->
                <asp:FileUpload ID="imgupload" runat="server" />
                <asp:Label ID="img" runat="server" Text="الصورة"></asp:Label>
                <br />
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                    ValidationExpression="([a-zA-Z0-9\s_\\.\-:])+(.bmp|.gif|.png|.jpg|.jpeg)$" 
                    ErrorMessage="please upload images only" ControlToValidate="imgupload" ValidationGroup="img"></asp:RegularExpressionValidator>
                <br />
                <asp:Label ID="sizeErrorImg" runat="server" Text="Exceed max size" Visible="False"></asp:Label>
                <br />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="imgupload"
                 CssClass="text-danger" ErrorMessage="الصورة مطلوب" ValidationGroup="img" />
                <br />
                <asp:HyperLink ID="HyperLink1" NavigateUrl="" runat="server">
                     <asp:Image ID="Image1" runat="server" Width="100px" Height="100px" />
                </asp:HyperLink>
                <br />
                <asp:Button ID="uploadImg" runat="server" Text="رفع"  ValidationGroup="img" OnClick="uploadImg_Click" />
                <br />
                <br />
                <br />
                

                                                       <!--order--> 
                
                <asp:DropDownList ID="orderlist" runat="server">
                    <asp:ListItem Text="1" Value="1" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="order" Text="الترتيب" runat="server"></asp:Label>
                <br />
                <br />
                <br />
               
                                                    <!--type-->
                <%--<asp:DropDownList ID="typelist" runat="server" OnSelectedIndexChanged="typelist_SelectedIndexChanged"
                     AutoPostBack="True">
                    <asp:ListItem Text="التصنيفات" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="مقالات ودراسات" Value="1"></asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="type" Text="النوع" runat="server"></asp:Label>
                <br />
                <br />
                <br />--%>
                

                                                <!--(optional)category-->
                <%--<asp:DropDownList ID="categorylist" runat="server" OnSelectedIndexChanged="categorylist_SelectedIndexChanged" 
                    AutoPostBack="True">
                    <asp:ListItem Text="مقالات" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="أطعمة" Value="1"></asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="Label3" Text="التصنيف" runat="server"></asp:Label>
                <br />
                <br />
                <br />--%>

                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                    SelectCommand="getAllParentCategories" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <asp:DropDownList ID="parentCategorylist" runat="server" 
                    AutoPostBack="True" DataSourceID="SqlDataSource2" DataTextField="Category" DataValueField="ID">
                </asp:DropDownList>
                <asp:Label ID="Label3" Text="التصنيفات الرئيسية" runat="server"></asp:Label>
                <br />
                <br />
                <br />


               
                
                <br />
                <br />
                <br />
        
                <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:DefaultConnection %>' 
                    SelectCommand="getChildCategories" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="parentCategorylist" PropertyName="SelectedValue" Name="parentID"
                             Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                </asp:SqlDataSource>

                <asp:DropDownList ID="childCategorylist" runat="server" DataSourceID="SqlDataSource1" DataTextField="Category"
                     DataValueField="ID"  AutoPostBack="True">
                </asp:DropDownList>
                <asp:Label ID="Label4" Text="التصنيف" runat="server"></asp:Label>


                                                <!--(optional)specific one-->
                <%--<asp:DropDownList ID="departmentlist" runat="server" AutoPostBack="True" 
                    OnSelectedIndexChanged="departmentlist_SelectedIndexChanged">
                </asp:DropDownList>
                <asp:Label ID="Label4" Text="الاقسام" runat="server"></asp:Label>
                <br />
                <br />
                <br />--%>



                <!--subject-->
                
                <asp:DropDownList ID="subjectlist" runat="server"  
                    AutoPostBack="true">
                </asp:DropDownList>
                <asp:Label ID="sub" Text="الموضوع" runat="server"></asp:Label>
                <br />
                <br />
                <br />
                                                <!--path-->
                <asp:TextBox ID="url" runat="server" Enabled="false"></asp:TextBox>
                <asp:Label ID="Label2" runat="server" Text="المسار"></asp:Label>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="url"
                        CssClass="text-danger" ErrorMessage="المسار مطلوب." />
                <br />
                <asp:Button ID="addButton" runat="server" Text="حفظ" OnClick="addButton_Click" />
                     
            </ContentTemplate>
            
        </ajaxToolkit:TabPanel>
        <ajaxToolkit:TabPanel runat="server" HeaderText="TabPanel2" ID="TabPanel2" TabIndex="1">
            <HeaderTemplate>
                عرض
            </HeaderTemplate>
            <ContentTemplate>
                <asp:ListView ID="ListView1" runat="server" OnItemCommand="ListView1_ItemCommand">
                    <ItemTemplate>
                        <asp:Label runat="server" ID="bannertitle" ValidationGroup="tab2" Text='<%#Eval("Title") %>' ></asp:Label>
                        <asp:Label ID="Label5" runat="server" Text="العنوان" ></asp:Label>
                        <br />                                                                              
                        <asp:HyperLink ID="HyperLink1" NavigateUrl='<%#Eval("URL") %>' runat="server">
                            <asp:Image ID="banner" runat="server" ValidationGroup="tab2" ImageUrl= 
                                '<%#string.Format("images/Banners/{0}",Eval("Img_Path")) %>'/>
                        </asp:HyperLink>
                        <asp:Label ID="Label6" runat="server" Text="الصورة" ></asp:Label>
                        <br />
                        <asp:Label ID="bannerorder" runat="server" ValidationGroup="tab2" Text='<%#Eval("Order") %>'></asp:Label>
                        <asp:Label ID="Label7" runat="server" Text="الترتيب" ></asp:Label>
                        <br />
                        <asp:Label ID="bannertype" runat="server" ValidationGroup="tab2" Text='<%#Eval("Type") %>' ></asp:Label>
                        <asp:Label ID="Label8" runat="server" Text="النوع" ></asp:Label>
                        <br />

                        <asp:Button ID="edit" runat="server" Text="تعديل" ValidationGroup="tab2" CommandName="edit" 
                            CommandArgument='<%#Eval("ID") %>' />
                        <asp:Button ID="remove" runat="server" Text="إزالة" ValidationGroup="tab2" CommandName="remove"
                            CommandArgument='<%#Eval("ID") %>' />
                    </ItemTemplate>
                </asp:ListView>
            </ContentTemplate>
            </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>

    </asp:Content>
