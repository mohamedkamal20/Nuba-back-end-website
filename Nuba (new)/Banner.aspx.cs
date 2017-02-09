using System;
using System.Web;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;
using System.Security.Cryptography;

public partial class Banner_Banner : System.Web.UI.Page
{
    private string ImgName;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //to ensure that the user is loggedin
            if (Request.IsAuthenticated)
            {
                AjaxControlToolkit.TabPanel activeTab = TabContainer1.ActiveTab;

                if (TabPanel2.TabIndex.ToString() == "1")
                {
                    getAllBanners();
                }

                //if (typelist.SelectedValue == "0")
                //{
                //    getArticlesCategories();
                //    if (checkNumCategories() != 0 && getArticlesCategories())
                //    {

                //        getArticlesOrFood("article", departmentlist.SelectedValue);
                //        //new
                //        string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
                //        HyperLink1.NavigateUrl = string.Format("Article.aspx?id={0}", encID);
                //        url.Text = string.Format("Article.aspx?id={0}", encID);

                //    }
                //}

                //else
                //{
                //    getStudies();
                //}
                //if (getParentCategories())
                //{
                //    int parentID = Convert.ToInt32(parentCategorylist.SelectedValue);
                //    if (!getChildCategories(parentID).Equals(null))
                //    {
                //        if (getChildCategories(parentID).Equals("0"))
                //        {
                //            getArticlesOrFood("article", childCategorylist.SelectedValue);
                //        }
                //        else
                //        {
                //            getArticlesOrFood("food", childCategorylist.SelectedValue);
                //        }
                //    }
                    
                //}
                
            }
            else
            {
                Response.Redirect("~/Account/Login");
            }
        }
    }

    //protected void typelist_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (typelist.SelectedValue == "1")
    //    {
    //        categorylist.Visible = false;
    //        departmentlist.Visible = false;
    //        Label3.Visible = false;
    //        Label4.Visible = false;

           
    //        getStudies();
    //        string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
    //        HyperLink1.NavigateUrl = string.Format("Study.aspx?id={0}", encID);
            
    //        url.Text = string.Format("Study.aspx?id={0}", encID);

    //    }
    //    else
    //    {
    //        subjectlist.Items.Clear();
    //        categorylist.Visible = true;
    //        departmentlist.Visible = true;
    //        Label3.Visible = true;
    //        Label4.Visible = true;
 
    //        if (categorylist.SelectedItem.Text.Equals("مقالات"))
    //        {
    //            getArticlesOrFood("article", departmentlist.SelectedValue);
    //            //new
    //            string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
    //            HyperLink1.NavigateUrl = string.Format("Article.aspx?id={0}", encID);
    //            url.Text = string.Format("Article.aspx?id={0}", encID);

    //        }
    //        else
    //        {
    //            getArticlesOrFood("food", departmentlist.SelectedValue);
    //            //new
    //            string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
    //            HyperLink1.NavigateUrl = string.Format("Food.aspx?id={0}", encID);
    //            url.Text = string.Format("Food.aspx?id={0}", encID);
    //        }
            

    //    }

    //}
    //private bool getParentCategories()
    //{
    //    string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
    //    using (SqlConnection con = new SqlConnection(cs))
    //    {
    //        SqlCommand cmd = new SqlCommand("getAllParentCategories", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        bool row = false;
    //        con.Open();
    //        SqlDataReader sdr = cmd.ExecuteReader();
    //        sdr.Read();
            
    //        if (sdr.HasRows)
    //        {
    //            row = sdr.HasRows;
    //            con.Close();
    //            SqlDataAdapter adapter = new SqlDataAdapter();
    //            adapter.SelectCommand = cmd;
    //            DataSet ds = new DataSet();
    //            adapter.Fill(ds);
    //            parentCategorylist.DataSource = ds;
    //            parentCategorylist.DataTextField = "Category";
    //            parentCategorylist.DataValueField = "ID";
    //            parentCategorylist.DataBind();
    //        }

    //        return row;
    //    }
    //}

    //private string getChildCategories(int parentID)
    //{
    //    string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
    //    using (SqlConnection con = new SqlConnection(cs))
    //    {
    //        SqlCommand cmd = new SqlCommand("getChildCategories", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        SqlParameter parentIDParam = new SqlParameter()
    //        {
    //            ParameterName = "@parentID",
    //            Value = parentID
    //        };
    //        cmd.Parameters.Add(parentIDParam);
    //        con.Open();
    //        SqlDataReader sdr = cmd.ExecuteReader();
    //        sdr.Read();
           
    //        if (sdr.HasRows)
    //        {
    //            string food = sdr["Food"].ToString();
    //            con.Close();
    //            SqlDataAdapter adapter = new SqlDataAdapter();
    //            adapter.SelectCommand = cmd;
    //            DataSet ds = new DataSet();
    //            adapter.Fill(ds);
    //            childCategorylist.DataSource = ds;
    //            childCategorylist.DataTextField = "Category";
    //            childCategorylist.DataValueField = "ID";
    //            childCategorylist.DataBind();
    //            return food;
    //        }

    //        return null;
    //    }
    //}

    //protected void categorylist_SelectedIndexChanged(object sender, EventArgs e)
    //{
        
    //    if(categorylist.SelectedValue == "0")
    //    {
    //        getArticlesCategories();
    //        getArticlesOrFood("article", departmentlist.SelectedValue);
    //        //new
    //        string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
    //        HyperLink1.NavigateUrl = string.Format("Article.aspx?id={0}", encID);
    //        url.Text = string.Format("Article.aspx?id={0}", encID);
    //    }
    //    else
    //    {
    //        departmentlist.Items.Clear();
    //        getFoodCategories();
    //        getArticlesOrFood("food", departmentlist.SelectedValue);
    //        //new
    //        string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
    //        HyperLink1.NavigateUrl = string.Format("Food.aspx?id={0}", encID);
    //        url.Text = string.Format("Food.aspx?id={0}", encID);
    //    }
    //}

    //protected void departmentlist_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (categorylist.SelectedItem.Text.Equals("أطعمة"))
    //    {

    //        getArticlesOrFood("food", departmentlist.SelectedValue);
    //        string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
    //        HyperLink1.NavigateUrl = string.Format("Food.aspx?id={0}", encID);
    //        url.Text = string.Format("Food.aspx?id={0}", encID);
    //    }
    //    else
    //    {
    //        getArticlesOrFood("article", departmentlist.SelectedValue);
    //        string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
    //        HyperLink1.NavigateUrl = string.Format("Article.aspx?id={0}", encID);
    //        url.Text = string.Format("Article.aspx?id={0}", encID);
    //    }
    //}

    //protected void subjectlist_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
    //    if (typelist.SelectedValue.Equals("1"))
    //    {
    //        HyperLink1.NavigateUrl = string.Format("Study.aspx?id={0}", encID);
    //        url.Text = string.Format("Study.aspx?id={0}", encID);
    //    }
    //    else if (typelist.SelectedValue.Equals("0"))
    //    {
    //        if (categorylist.SelectedValue.Equals("0"))
    //        {
    //            HyperLink1.NavigateUrl = string.Format("Article.aspx?id={0}", encID);
    //            url.Text = string.Format("Article.aspx?id={0}", encID);

    //        }
    //        else
    //        {
    //            HyperLink1.NavigateUrl = string.Format("Food.aspx?id={0}", encID);
    //            url.Text = string.Format("Food.aspx?id={0}", encID);
    //        }
    //    }
    //}

    //to upload image and save its name to the db
    protected void uploadImg_Click(object sender, EventArgs e)
    {
        if (imgupload.HasFile)
        {
            if ((imgupload.PostedFile.ContentLength / (1024 * 1024)) > .5)
            {
                sizeErrorImg.Visible = true;

                return;

            }
            else
            {
                string ext = Path.GetExtension(imgupload.PostedFile.FileName);
                string filename = Path.GetFileNameWithoutExtension(imgupload.PostedFile.FileName);
                ImgName = rename(filename, ext);
                //imgupload.PostedFile.SaveAs(Server.MapPath("~/Banner/ImgUploads/") + ImgName);
                imgupload.PostedFile.SaveAs(Server.MapPath("images/Banners/") + ImgName);
                Image1.ImageUrl = "images/Banners/" + ImgName;
            }
        }
    }

    //new//
    //to check the number of categories in order to handle exception
    private int checkNumCategories()
    {
        int num;
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using(SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("checkNumCat",con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            sdr.Read();

            num = Convert.ToInt32(sdr["NUMBERS"].ToString());
            con.Close();
        }
        return num;
    }

    //rename the the file name to appropriate form
    private string rename(string fileName, string ext)
    {

        fileName = fileName.Replace("[", "");
        fileName = fileName.Replace("]", "");
        fileName = fileName.Replace("+", "");
        fileName = fileName.Replace("-", "");
        string fileNameWithoutSpaces = fileName.Replace(" ", "");
        string fileNameWithoutSlash = fileNameWithoutSpaces.Replace("/", "");
        string fileNameWithoutCol = fileNameWithoutSlash.Replace(":", "");
        string date = DateTime.Now.ToString();
        string dateWihoutSpace = date.Replace(" ", "");
        string dateWithoutSlash = dateWihoutSpace.Replace("/", "");
        string dateWithoutCol = dateWithoutSlash.Replace(":", "");
        string fullName = fileNameWithoutCol + dateWithoutCol + ext;

        return fullName;
    }
    
    //to get all the studies from db to show in dropdown list
    private void getStudies()
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getAllStudies", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = cmd;
            DataSet ds = new DataSet();
            adapter.Fill(ds);
            subjectlist.DataSource = ds;
            subjectlist.DataTextField = "Title";
            subjectlist.DataValueField = "ID";
            subjectlist.DataBind();
        }
    }

    //get all the categories of the articles
    //private bool getArticlesCategories()
    //{
    //    string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
    //    using (SqlConnection con = new SqlConnection(cs))
    //    {
    //        SqlCommand cmd = new SqlCommand("getCategories", con);
    //        cmd.CommandType = CommandType.StoredProcedure;

    //        con.Open();
    //        SqlDataReader sdr = cmd.ExecuteReader();
    //        sdr.Read();
    //        if (sdr.HasRows)
    //        {
    //            SqlDataAdapter adapter = new SqlDataAdapter();
    //            adapter.SelectCommand = cmd;
    //            DataSet ds = new DataSet();
    //            adapter.Fill(ds);
    //            departmentlist.DataSource = ds;
    //            departmentlist.DataTextField = "Category";
    //            departmentlist.DataValueField = "ID";
    //            departmentlist.DataBind();
    //        }

    //        return sdr.HasRows;
            
    //    }
        
    //}

    //get all the categories of the food
    //private void getFoodCategories()
    //{
    //    string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
    //    using (SqlConnection con = new SqlConnection(cs))
    //    {
    //        SqlCommand cmd = new SqlCommand("getFoodCategories", con);
    //        cmd.CommandType = CommandType.StoredProcedure;

    //        SqlDataAdapter adapter = new SqlDataAdapter();
    //        adapter.SelectCommand = cmd;
    //        DataSet ds = new DataSet();
    //        adapter.Fill(ds);
    //        departmentlist.DataSource = ds;
    //        departmentlist.DataTextField = "Category";
    //        departmentlist.DataValueField = "ID";
    //        departmentlist.DataBind();
    //    }
    //}

    //get all the articles or the food of specific category(department)
    private void getArticlesOrFood(string type,string id)
    {
        int catID = Convert.ToInt32(id);
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using(SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getArticlesOrFood", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter idParam = new SqlParameter()
            {
                ParameterName = "@id",
                Value = catID
            };
            SqlParameter typeParam = new SqlParameter()
            {
                ParameterName = "@type",
                Value = type
            };

            
            cmd.Parameters.Add(idParam);
            cmd.Parameters.Add(typeParam);
            con.Open();

            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = cmd;
            DataSet ds = new DataSet();
            adapter.Fill(ds);
            subjectlist.DataSource = ds;
            if (type.Equals("article"))
            {
                subjectlist.DataTextField = "Art_Title";
            }
            else
            {
                subjectlist.DataTextField = "Title";
            }
            subjectlist.DataValueField = "ID";
            subjectlist.DataBind();


        }
    }

    //add new image banner  
    private void addBanner(string title,string imgPath,string order,string type,string recordID,string url)
    {
        int theOrder = Convert.ToInt32(order);
        int theRecordID = Convert.ToInt32(recordID);

        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using(SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("addBanner",con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter titleParam = new SqlParameter()
            {
                ParameterName = "@title",
                Value = title
            };
            SqlParameter imgPathParam = new SqlParameter()
            {
                ParameterName = "@imgPath",
                Value = imgPath
            };
            SqlParameter orderParam = new SqlParameter()
            {
                ParameterName = "@order",
                Value = order
            };
            SqlParameter typeParam = new SqlParameter()
            {
                ParameterName = "@type",
                Value = type
            };
            SqlParameter recordIDParam = new SqlParameter()
            {
                ParameterName = "@recordID",
                Value = @recordID
            };
            SqlParameter urlParam = new SqlParameter()
            {
                ParameterName = "@url",
                Value = url
            };
            cmd.Parameters.Add(titleParam);
            cmd.Parameters.Add(imgPathParam);
            cmd.Parameters.Add(orderParam);
            cmd.Parameters.Add(typeParam);
            cmd.Parameters.Add(recordIDParam);
            cmd.Parameters.Add(urlParam);
            

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }


    protected void addButton_Click(object sender, EventArgs e)
    {
        string Title = title.Text;
        string ImgPath = Image1.ImageUrl.Replace("images/Banners/", "");
        string Order = orderlist.SelectedValue;
        //string Type = typelist.SelectedItem.Text;
        string RecordID = subjectlist.SelectedValue;
        string URL = url.Text;
        //bool food = false;
        //HyperLink1.NavigateUrl = URL;
        //if (typelist.SelectedItem.Text.Equals("التصنيفات"))
        //{
        //    if (categorylist.SelectedItem.Text.Equals("أطعمة"))
        //    {
        //        food = true;
        //    }
        //}

        //addBanner(Title, ImgPath, Order, Type, RecordID, URL);
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    //////////////////////
    //retrive all the images banner to show
    private void getAllBanners()
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using(SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getAllBanners", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = cmd;
            adapter.Fill(ds);
            ListView1.DataSource = ds;
            ListView1.DataBind();
            con.Close();
        }
    }

    //listeners to the edit button
    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName.Equals("edit"))
        {
            //Session["bannerID"] = e.CommandArgument.ToString();
            //Response.Redirect("~/Banner/editBanner");
            string bannerID = e.CommandArgument.ToString();
            string encID = HttpUtility.UrlEncode(Encrypt(bannerID));
            Response.Redirect(string.Format("editBanner?bannerID={0}", encID));
        }
        else if (e.CommandName.Equals("remove"))
        {
            removeUploadedImg(e.CommandArgument.ToString());
            removeBanner(e.CommandArgument.ToString());
        }
    }

    //encrypt the image banner id
    private string Encrypt(string clearText)
    {
        string EncryptionKey = "MAKV2SPBNI99212";
        byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(clearBytes, 0, clearBytes.Length);
                    cs.Close();
                }
                clearText = Convert.ToBase64String(ms.ToArray());
            }
        }
        return clearText;
    }

    //not used
    private void removeUploadedImg(string id)
    {
        int theId = Convert.ToInt32(id);

        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            string imgPath;
            SqlCommand cmd = new SqlCommand("getImgPath", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter IDParam = new SqlParameter()
            {
                ParameterName = "@id",
                Value = theId
            };
            cmd.Parameters.Add(IDParam);
            con.Open();

            SqlDataReader sdr = cmd.ExecuteReader();
            sdr.Read();
            imgPath = sdr["Img_Path"].ToString();
            File.Delete(Server.MapPath("images/Banners/") + imgPath);
            con.Close();
        }
    }
    //not used
    private void removeBanner(string id)
    {
        int theId = Convert.ToInt32(id);

        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("removeBanner", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter IDParam = new SqlParameter()
            {
                ParameterName = "@id",
                Value = theId
            };
            cmd.Parameters.Add(IDParam);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

        }
        getAllBanners();
    }


    //protected void parentCategorylist_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    int parentID = Convert.ToInt32(parentCategorylist.SelectedValue);
    //    if (!getChildCategories(parentID).Equals(null))
    //    {
    //        if (getChildCategories(parentID).Equals("0"))
    //        {
    //            getArticlesOrFood("article", childCategorylist.SelectedValue);
    //        }
    //        else
    //        {
    //            getArticlesOrFood("food", childCategorylist.SelectedValue);
    //        }
    //    }
    //}

    //protected void childCategorylist_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    int parentID = Convert.ToInt32(parentCategorylist.SelectedValue);
    //    if (!getChildCategories(parentID).Equals(null))
    //    {
    //        if (getChildCategories(parentID).Equals("0"))
    //        {
    //            getArticlesOrFood("article", childCategorylist.SelectedValue);
    //        }
    //        else
    //        {
    //            getArticlesOrFood("food", childCategorylist.SelectedValue);
    //        }
    //    }
    //}
}