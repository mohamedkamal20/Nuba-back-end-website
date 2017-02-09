using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Security.Cryptography;
using System.Text;

public partial class Banner_editBanner : System.Web.UI.Page
{
    
    private string bannerID;
    private string ImgName;
    private int oldOrder;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if(Request.IsAuthenticated)
            {
              bannerID = Decrypt(HttpUtility.UrlDecode(Request.QueryString["bannerID"]));
              getBannerInfo(bannerID);
            }
            else
            {
                Response.Redirect("~/Account/Login");
            }
                
            
            //bannerID = (string)Session["bannerID"];
            //getBannerInfo(bannerID);
            
        }
    }
    //to decode the coming id inorder to security
    private string Decrypt(string cipherText)
    {
        string EncryptionKey = "MAKV2SPBNI99212";
        cipherText = cipherText.Replace(" ", "+");
        byte[] cipherBytes = Convert.FromBase64String(cipherText);
        using (Aes encryptor = Aes.Create())
        {
            Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
            encryptor.Key = pdb.GetBytes(32);
            encryptor.IV = pdb.GetBytes(16);
            using (MemoryStream ms = new MemoryStream())
            {
                using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                {
                    cs.Write(cipherBytes, 0, cipherBytes.Length);
                    cs.Close();
                }
                cipherText = Encoding.Unicode.GetString(ms.ToArray());
            }
        }
        return cipherText;
    }

    //listner to the type list in case of changing like تصنيفات or مقالات ودراسات
    //protected void typelist_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (typelist.SelectedValue == "1")
    //    {
    //        categorylist.Visible = false;
    //        departmentlist.Visible = false;
    //        Label3.Visible = false;
    //        Label4.Visible = false;

    //        getStudies();

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
    //        }
    //        else
    //        {
    //            getArticlesOrFood("food", departmentlist.SelectedValue);
    //        }


    //    }

    //}

    protected void typelist_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (typelist.SelectedValue == "1")
        {
            categorylist.Visible = false;
            departmentlist.Visible = false;
            Label3.Visible = false;
            Label4.Visible = false;


            getStudies();
            string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
            HyperLink1.NavigateUrl = string.Format("Study.aspx?id={0}", encID);

            url.Text = string.Format("Study.aspx?id={0}", encID);

        }
        else
        {
            subjectlist.Items.Clear();
            categorylist.Visible = true;
            departmentlist.Visible = true;
            Label3.Visible = true;
            Label4.Visible = true;

            if (categorylist.SelectedItem.Text.Equals("مقالات"))
            {
                getArticlesCategories();
                getArticlesOrFood("article", departmentlist.SelectedValue);
                //new
                string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
                HyperLink1.NavigateUrl = string.Format("Article.aspx?id={0}", encID);
                url.Text = string.Format("Article.aspx?id={0}", encID);

            }
            else
            {
                getFoodCategories();
                getArticlesOrFood("food", departmentlist.SelectedValue);
                //new
                string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
                HyperLink1.NavigateUrl = string.Format("Food.aspx?id={0}", encID);
                url.Text = string.Format("Food.aspx?id={0}", encID);
            }


        }

    }

    //listner to the category list in case of changing like مقال or طعام
    //protected void categorylist_SelectedIndexChanged(object sender, EventArgs e)
    //{

    //    if (categorylist.SelectedValue == "0")
    //    {
    //        getArticlesCategories();
    //        getArticlesOrFood("article", departmentlist.SelectedValue);
    //    }
    //    else
    //    {
    //        departmentlist.Items.Clear();
    //        getFoodCategories();
    //        getArticlesOrFood("food", departmentlist.SelectedValue);
    //    }
    //}

    protected void categorylist_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (categorylist.SelectedValue == "0")
        {
            getArticlesCategories();
            getArticlesOrFood("article", departmentlist.SelectedValue);
            //new
            string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
            HyperLink1.NavigateUrl = string.Format("Article.aspx?id={0}", encID);
            url.Text = string.Format("Article.aspx?id={0}", encID);
        }
        else
        {
            departmentlist.Items.Clear();
            getFoodCategories();
            getArticlesOrFood("food", departmentlist.SelectedValue);
            //new
            string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
            HyperLink1.NavigateUrl = string.Format("Food.aspx?id={0}", encID);
            url.Text = string.Format("Food.aspx?id={0}", encID);
        }
    }

    //listner to the department list according to food or articles and get all the categories
    //protected void departmentlist_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (categorylist.SelectedItem.Text.Equals("أطعمة"))
    //    {

    //        getArticlesOrFood("food", departmentlist.SelectedValue);
    //    }
    //    else
    //    {

    //        getArticlesOrFood("article", departmentlist.SelectedValue);
    //    }
    //}

    protected void departmentlist_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (categorylist.SelectedItem.Text.Equals("أطعمة"))
        {

            getArticlesOrFood("food", departmentlist.SelectedValue);
            string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
            HyperLink1.NavigateUrl = string.Format("Food.aspx?id={0}", encID);
            url.Text = string.Format("Food.aspx?id={0}", encID);
        }
        else
        {
            getArticlesOrFood("article", departmentlist.SelectedValue);
            string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
            HyperLink1.NavigateUrl = string.Format("Article.aspx?id={0}", encID);
            url.Text = string.Format("Article.aspx?id={0}", encID);
        }
    }


    protected void subjectlist_SelectedIndexChanged(object sender, EventArgs e)
    {
        string encID = HttpUtility.UrlEncode(Encrypt(subjectlist.SelectedValue.ToString()));
        if (typelist.SelectedValue.Equals("1"))
        {
            HyperLink1.NavigateUrl = string.Format("Study.aspx?id={0}", encID);
            url.Text = string.Format("Study.aspx?id={0}", encID);
        }
        else if (typelist.SelectedValue.Equals("0"))
        {
            if (categorylist.SelectedValue.Equals("0"))
            {
                HyperLink1.NavigateUrl = string.Format("Article.aspx?id={0}", encID);
                url.Text = string.Format("Article.aspx?id={0}", encID);

            }
            else
            {
                HyperLink1.NavigateUrl = string.Format("Food.aspx?id={0}", encID);
                url.Text = string.Format("Food.aspx?id={0}", encID);
            }
        }
    }


    private void getBannerInfo(string id)
    {
        
        int theId = Convert.ToInt32(id);
        try {
            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("getBannerInfo", con);
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

                title.Text = sdr["Title"].ToString();
                Image1.ImageUrl = "images/Banners/" + sdr["Img_Path"].ToString();
                orderlist.SelectedValue = sdr["Order"].ToString();

                if (sdr["Type"].ToString().Equals("مقالات ودراسات"))
                {
                    typelist.SelectedValue = "1";
                }
                else if (sdr["Type"].ToString().Equals("التصنيفات"))
                {
                    typelist.SelectedValue = "0";
                }
                //typelist.SelectedItem.Text = sdr["Type"].ToString();


                if (typelist.SelectedItem.Text.Equals("التصنيفات"))
                {
                    categorylist.Visible = true;
                    departmentlist.Visible = true;
                    Label3.Visible = true;
                    Label4.Visible = true;
                    getSpecificCat(sdr["RecordID"].ToString(), theId, sdr["URL"].ToString());
                    subjectlist.SelectedValue = sdr["RecordID"].ToString();


                }
                //getArticlesCategories();
                //getArticlesOrFood("article", departmentlist.SelectedValue);
                else
                {
                    getStudies();
                    subjectlist.SelectedValue = sdr["RecordID"].ToString();
                }
                url.Text = sdr["URL"].ToString();
            }
        }catch(SqlException ex)
        {
            Response.Write("SQL ERROR" + ex.Message.ToString());
        }
    }
    //this function is to check the banner is related to food 1 or  article 0
    private void getSpecificCat(string recordID,int bannerID,string url)
    {
        //string food;
        //int theID = Convert.ToInt32(id);
        //string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        //using (SqlConnection con = new SqlConnection(cs))
        //{
        //    SqlCommand cmd = new SqlCommand("getCategory", con);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    SqlParameter idParam = new SqlParameter()
        //    {
        //        ParameterName = "@id",
        //        Value = theID
        //    };
        //    SqlParameter bannerIDParam = new SqlParameter()
        //    {
        //        ParameterName = "@bannerID",
        //        Value = bannerID
        //    };
        //    cmd.Parameters.Add(idParam);
        //    cmd.Parameters.Add(bannerIDParam);
        //    con.Open();
        //    //food = cmd.ExecuteReader().ToString();
        //    SqlDataReader sdr = cmd.ExecuteReader();
        //    sdr.Read();
        //    if(sdr.HasRows)
        //    {
        //        food = sdr["Food"].ToString();
        //        departmentlist.Items.Clear();
        //        if (food.Equals("False"))
        //        {
        //            categorylist.SelectedValue = "0";
        //            getArticlesCategories();
        //            subjectlist.Items.Clear();
        //            string departselectedval = getCatID(id, "article");
        //            getArticlesOrFood("article", departselectedval);
        //        }
        //        else
        //        {
        //            categorylist.SelectedValue = "1";
        //            getFoodCategories();
        //            subjectlist.Items.Clear();
        //            string departselectedval = getCatID(id, "food");
        //            getArticlesOrFood("food", departselectedval);

        //        }
        //    }

        //}
        if (url.Contains("Food"))
        {
            categorylist.SelectedValue = "1";
            getFoodCategories();
            subjectlist.Items.Clear();
            string departselectedval = getCatID(recordID, "food");
            getArticlesOrFood("food", departselectedval);
        }
        else if (url.Contains("Article"))
        {
            categorylist.SelectedValue = "0";
            getArticlesCategories();
            subjectlist.Items.Clear();
            string departselectedval = getCatID(recordID, "article");
            getArticlesOrFood("article", departselectedval);
        }
    }

    //this to get all the categories that have only articles 
    private void getArticlesCategories()
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getCategories", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = cmd;
            DataSet ds = new DataSet();
            adapter.Fill(ds);
            departmentlist.DataSource = ds;
            departmentlist.DataTextField = "Category";
            departmentlist.DataValueField = "ID";
            departmentlist.DataBind();
        }
    }

    //this to get all the categories that have only food
    private void getFoodCategories()
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getFoodCategories", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter adapter = new SqlDataAdapter();
            adapter.SelectCommand = cmd;
            DataSet ds = new DataSet();
            adapter.Fill(ds);
            departmentlist.DataSource = ds;
            departmentlist.DataTextField = "Category";
            departmentlist.DataValueField = "ID";
            departmentlist.DataBind();
        }
    }

    //this is to get all the aricles or all food according to the selected category
    private void getArticlesOrFood(string type, string id)
    {
        int catID = Convert.ToInt32(id);
        
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
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

    //this is to get the id of the category that have the article or food
    private string getCatID(string id,string type)
    {
        int theID = Convert.ToInt32(id);
        string catID;
        try {
            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("getCatID", con);
                cmd.CommandType = CommandType.StoredProcedure;
                SqlParameter idParam = new SqlParameter()
                {
                    ParameterName = "@id",
                    Value = theID
                };
                SqlParameter typeParam = new SqlParameter()
                {
                    ParameterName = "@type",
                    Value = type
                };
                cmd.Parameters.Add(idParam);
                cmd.Parameters.Add(typeParam);
                con.Open();
                SqlDataReader sdr = cmd.ExecuteReader();
                sdr.Read();
                //catID = cmd.ExecuteReader().ToString();
                catID = sdr["Cat_ID"].ToString();
                //return getSpecificDepart(catID);
                return departmentlist.SelectedValue = catID;
            }
        }catch(SqlException ex)
        {
            Response.Write("SQL ERROR" + ex.Message.ToString());
            return null;
        }
    }

    //mybe useless
    //this is to set the seleceted category in the deaprtment list
    private string getSpecificDepart(string id)
    {
        int theID = Convert.ToInt32(id);
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getSpecificDepart", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter idParam = new SqlParameter()
            {
                ParameterName = "@id",
                Value = theID
            };
            cmd.Parameters.Add(idParam);
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            sdr.Read();

            //departmentlist.SelectedItem.Text = cmd.ExecuteReader().ToString();
            //departmentlist.SelectedItem.Text = sdr["Category"].ToString();
            departmentlist.SelectedValue = id;
            return departmentlist.SelectedValue;


        }

    }
    
    //this is to get all the studies and set it to the subject list
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
                File.Delete(Server.MapPath(Image1.ImageUrl));
                string ext = Path.GetExtension(imgupload.PostedFile.FileName);
                string filename = Path.GetFileNameWithoutExtension(imgupload.PostedFile.FileName);
                ImgName = rename(filename, ext);
                imgupload.PostedFile.SaveAs(Server.MapPath("images/Banners/") + ImgName);
                Image1.ImageUrl = "images/Banners/" + ImgName;
            }
        }
    }

    
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
        string fullName = fileName + dateWithoutCol + ext;

        return fullName;
    }

    private void updateBanner(string id,string title,string imgPath,string order,string type,string recordID,string url)
    {
        int theId = Convert.ToInt32(id);
        int theOrder = Convert.ToInt32(order);
        int theRecordID = Convert.ToInt32(recordID);
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using(SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("editBanner", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter idParam = new SqlParameter()
            {
                ParameterName = "@id",
                Value = theId
            };
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
                Value = theOrder
            };
            SqlParameter typeParam = new SqlParameter()
            {
                ParameterName = "@type",
                Value = type
            };
            SqlParameter recordIDParam = new SqlParameter()
            {
                ParameterName = "@recordID",
                Value = theRecordID
            };
            SqlParameter urlParam = new SqlParameter()
            {
                ParameterName = "@url",
                Value = url
            };
            cmd.Parameters.Add(idParam);
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

    protected void update_Click(object sender, EventArgs e)
    {
        bannerID = Decrypt(HttpUtility.UrlDecode(Request.QueryString["bannerID"]));
        int theId = Convert.ToInt32(bannerID);
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getBannerInfo", con);
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
            
            oldOrder = Convert.ToInt32(sdr["Order"].ToString());
            con.Close();
        }
       string Title = title.Text;
        string ImgPath = Image1.ImageUrl.Replace("images/Banners/", "");
        string Order = orderlist.SelectedValue;
        if(Convert.ToInt32(Order) != oldOrder)
        {
            getBannerByID(Convert.ToInt32(Order), oldOrder);
        }
        string Type = typelist.SelectedItem.Text;
        string RecordID = subjectlist.SelectedValue;
        string URL = url.Text;
        bannerID = Decrypt(HttpUtility.UrlDecode(Request.QueryString["bannerID"]));
        updateBanner(bannerID, Title, ImgPath, Order, Type, RecordID, URL);
        Response.Redirect("Banner");
    }

    private void getBannerByID(int newOrder,int order)
    {
        string ID;
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getBannerByOrder", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter orderParam = new SqlParameter()
            {
                ParameterName = "@order",
                Value = newOrder
            };
            cmd.Parameters.Add(orderParam);
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            sdr.Read();
            ID = sdr["ID"].ToString();
            con.Close();
            updateAnthorBannerOrder(ID, order);
        }

    }

    private void updateAnthorBannerOrder(string id,int newOrder)
    {
        int bannerID = Convert.ToInt32(id);
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using(SqlConnection con = new SqlConnection(cs))
        {
            
            SqlCommand cmd = new SqlCommand("updateBannerOrder", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter idParam = new SqlParameter()
            {
                ParameterName = "@id",
                Value = bannerID

            };
            SqlParameter orderParam = new SqlParameter()
            {
                ParameterName = "@order",
                Value = newOrder
            };

            cmd.Parameters.Add(idParam);
            cmd.Parameters.Add(orderParam);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
    }

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

    protected void orderlist_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}