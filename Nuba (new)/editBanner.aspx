<%@ Page Language="C#" AutoEventWireup="true" CodeFile="editBanner.aspx.cs" MasterPageFile="~/Site.master" Inherits="Banner_editBanner" %>


<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
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
                <asp:Button ID="uploadImg" runat="server" Text="رفع"  ValidationGroup="img"  />
                <br />
                <br />
                <br />
                

                                                       <!--order--> 
                
                <asp:DropDownList ID="orderlist" runat="server" OnSelectedIndexChanged="orderlist_SelectedIndexChanged">
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
                <asp:DropDownList ID="typelist" runat="server"  AutoPostBack="True" OnSelectedIndexChanged="typelist_SelectedIndexChanged">
                    <asp:ListItem Text="التصنيفات" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="مقالات ودراسات" Value="1"></asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="type" Text="النوع" runat="server"></asp:Label>
                <br />
                <br />
                <br />
                

                                                <!--(optional)category-->
                <asp:DropDownList ID="categorylist" runat="server" Visible="false"  AutoPostBack="True" OnSelectedIndexChanged="categorylist_SelectedIndexChanged">
                    <asp:ListItem Text="مقالات" Value="0" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="أطعمة" Value="1"></asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="Label3" Text="التصنيف" runat="server" Visible="false"></asp:Label>
                <br />
                <br />
                <br />
           


                                                <!--(optional)specific one-->
                <asp:DropDownList ID="departmentlist" runat="server" Visible="false" AutoPostBack="True" 
                     OnSelectedIndexChanged="departmentlist_SelectedIndexChanged" >
                </asp:DropDownList>
                <asp:Label ID="Label4" Text="الاقسام" runat="server" Visible="false"></asp:Label>
                <br />
                <br />
                <br />



                                                        <!--subject-->
                <asp:DropDownList ID="subjectlist" runat="server" AutoPostBack="True" 
                     OnSelectedIndexChanged="subjectlist_SelectedIndexChanged">
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
                <asp:Button ID="update" runat="server" Text="حفظ" OnClick="update_Click"/>
    <asp:Button id="btnCancel" runat="server" text="رجوع" OnClientClick="JavaScript:window.history.back(1); return false;" />
    </asp:Content>