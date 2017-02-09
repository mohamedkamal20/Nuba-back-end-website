using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Banners : System.Web.UI.Page
{
    private string ImgName;
    private string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void BannersListView_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (BannersListView.EditIndex == (e.Item as ListViewDataItem).DataItemIndex)
        {
            Label typeLabel = e.Item.FindControl("TypeLabel") as Label;
            Label recordIDLabel = e.Item.FindControl("RecordIDLabel") as Label;
            DropDownList childCategoryDDL = e.Item.FindControl("childCategoryDropDownList") as DropDownList;
            DropDownList subjectDDL = e.Item.FindControl("subjectDropDownList") as DropDownList;

            childCategoryDDL.SelectedValue = getCatID(typeLabel.Text, recordIDLabel.Text);

            subjectDDL.SelectedValue.ToString();
            getArticlesOrFood(typeLabel.Text, childCategoryDDL.SelectedValue.ToString(), e);
        }
    }

    protected void subjectDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList subjectListdDDL = (DropDownList)sender;
        ListViewItem lv = (ListViewItem)subjectListdDDL.NamingContainer;
        Label typeLabel = lv.FindControl("TypeLabel") as Label;
        

        TextBox URLTextBox = lv.FindControl("URLTextBox") as TextBox;

        string encID = HttpUtility.UrlEncode(Encrypt(subjectListdDDL.SelectedValue.ToString()));
        
        if (typeLabel.Text.Equals("Food"))
        {
            URLTextBox.Text = string.Format("Food.aspx?id={0}", encID);
        }
        else
        {
            URLTextBox.Text = string.Format("Article.aspx?id={0}", encID);
        }
    }

    protected void childCategoryDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList childCategoryDDL = (DropDownList)sender;
        ListViewItem lv = (ListViewItem)childCategoryDDL.NamingContainer;
        DropDownList subjectListdDDL = lv.FindControl("subjectDropDownList") as DropDownList;
        Label typeLabel = lv.FindControl("TypeLabel") as Label;
        TextBox URLTextBox = lv.FindControl("URLTextBox") as TextBox;
        Label recordIDLabel = lv.FindControl("RecordIDLabel") as Label;

        int childCatSelectedVal = Convert.ToInt32(childCategoryDDL.SelectedValue.ToString());
        string food = getFoodFromCat(childCatSelectedVal);
        string isFood;
        if (food.Equals("False"))
        {
            isFood = "Article";
        }
        else
        {
            isFood = "Food";
        }

        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getArticlesOrFood", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter typeParam = new SqlParameter()
            {
                ParameterName = "@type",
                Value = typeLabel.Text
            };
            SqlParameter idParam = new SqlParameter()
            {
                ParameterName = "@id",
                Value = childCatSelectedVal
            };

            cmd.Parameters.Add(idParam);
            cmd.Parameters.Add(typeParam);

            con.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter adp = new SqlDataAdapter();
            adp.SelectCommand = cmd;

            adp.Fill(ds);

            subjectListdDDL.DataSource = ds;
            subjectListdDDL.DataTextField = "Title";
            subjectListdDDL.DataValueField = "ID";
            subjectListdDDL.DataBind();

        }

       
        string encID = HttpUtility.UrlEncode(Encrypt(subjectListdDDL.SelectedValue.ToString()));
        if (isFood.Equals("Food"))
        {
            URLTextBox.Text = string.Format("Food.aspx?id={0}", encID);
        }
        else
        {
            URLTextBox.Text = string.Format("Article.aspx?id={0}", encID);
        }
    }

    protected void BannersListView_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName.Equals("uploadImage"))
        {
            FileUpload fu = (FileUpload)e.Item.FindControl("imgupload");
            if (fu.HasFile)
            {
                Label DE = (Label)e.Item.FindControl("diemnsionError");
                Label SE = (Label)e.Item.FindControl("sizeErrorImg");
                Image image = (Image)e.Item.FindControl("Image1");
                Label imagPathLabel = (Label)e.Item.FindControl("imagPathLabel");

                if ((fu.PostedFile.ContentLength / (1024 * 1024)) > .5)
                {
                    SE.Visible = true;
                    return;
                }
                else
                {
                    Stream stream = fu.PostedFile.InputStream;
                    System.Drawing.Image uploadedImage = System.Drawing.Image.FromStream(stream);
                    int w = uploadedImage.Width;
                    int h = uploadedImage.Height;

                    if (w != 1583 || h != 500)
                    {
                        DE.Visible = true;
                    }
                    else
                    {
                        DE.Visible = false;
                        SE.Visible = false;
                        string ext = Path.GetExtension(fu.PostedFile.FileName);
                        string filename = Path.GetFileNameWithoutExtension(fu.PostedFile.FileName);
                        ImgName = rename(filename, ext);

                        fu.PostedFile.SaveAs(Server.MapPath("Images/Banners/") + ImgName);
                        image.ImageUrl = "Images/Banners/" + ImgName;
                        imagPathLabel.Text = ImgName;
                    }
                }
            }
        }
        else if (e.CommandName.Equals("Update"))
        {
            DropDownList orderListDDL = e.Item.FindControl("orderlist") as DropDownList;
            DropDownList subjectDDL = e.Item.FindControl("subjectDropDownList") as DropDownList;
            DropDownList childCategoryDDL = e.Item.FindControl("childCategoryDropDownList") as DropDownList;

            Label oldOrderLabel = e.Item.FindControl("oldOrderLabel") as Label;
            Label recordIDLabel = e.Item.FindControl("RecordIDLabel") as Label;
            Label typeLabel = e.Item.FindControl("TypeLabel") as Label;

            string food = getFoodFromCat(Convert.ToInt32(childCategoryDDL.SelectedValue));
            if (food.Equals("False"))
            {
                typeLabel.Text = "Article";
            }
            else
            {
                typeLabel.Text = "Food";
            }

            recordIDLabel.Text = subjectDDL.SelectedValue;

            if (!oldOrderLabel.Text.Equals(orderListDDL.SelectedValue.ToString()))
            {
                int newOrder = Convert.ToInt32(orderListDDL.SelectedValue.ToString());
                int oldOrder = Convert.ToInt32(oldOrderLabel.Text);
                string catID =  getBannerByID(newOrder);
                updateAnthorBannerOrder(catID, oldOrder);
            }
        }
    }


    private string getCatID(string type, string recordID)
    {
        string catID;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getCatID", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter typeParam = new SqlParameter()
            {
                ParameterName = "@type",
                Value = type
            };

            SqlParameter recordIDParam = new SqlParameter()
            {
                ParameterName = "@recordID",
                Value = Convert.ToInt32(recordID)
            };

            cmd.Parameters.Add(typeParam);
            cmd.Parameters.Add(recordIDParam);

            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            sdr.Read();
            catID = sdr["Cat_ID"].ToString();
            con.Close();
            return catID;

        }
    }

    private void getArticlesOrFood(string type, string catId, ListViewItemEventArgs banners)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getArticlesOrFood", con);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlParameter typeParam = new SqlParameter()
            {
                ParameterName = "@type",
                Value = type
            };
            SqlParameter idParam = new SqlParameter()
            {
                ParameterName = "@id",
                Value = Convert.ToInt32(catId)
            };

            cmd.Parameters.Add(idParam);
            cmd.Parameters.Add(typeParam);

            con.Open();

            DataSet ds = new DataSet();
            SqlDataAdapter adp = new SqlDataAdapter();
            adp.SelectCommand = cmd;

            adp.Fill(ds);
            DropDownList subjectDDL = banners.Item.FindControl("subjectDropDownList") as DropDownList;
            subjectDDL.DataSource = ds;
            subjectDDL.DataTextField = "Title";
            subjectDDL.DataValueField = "ID";
            subjectDDL.SelectedValue = ((Label)banners.Item.FindControl("RecordIDLabel")).Text;
            subjectDDL.DataBind();

        }
    }

    private string getFoodFromCat(int catID)
    {
        string food;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getFoodFromCategory", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter catIDParam = new SqlParameter()
            {
                ParameterName = "@catID",
                Value = catID
            };
            cmd.Parameters.Add(catIDParam);
            con.Open();
            SqlDataReader sdr = cmd.ExecuteReader();
            sdr.Read();

            food = sdr["Food"].ToString();
            con.Close();
            return food;

        }
    }

    private string getBannerByID(int newOrder)
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
            return ID;
            //updateAnthorBannerOrder(ID, order);
        }
    }

    private void updateAnthorBannerOrder(string id, int newOrder)
    {
        int bannerID = Convert.ToInt32(id);
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
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

    private string rename(string fileName, string ext)
    {
        fileName = fileName.Replace("[", "");
        fileName = fileName.Replace("]", "");
        fileName = fileName.Replace("+", "");
        fileName = fileName.Replace("-", "");
        fileName = fileName.Replace(" ", "");
        fileName = fileName.Replace("/", "");
        fileName = fileName.Replace(":", "");

        string date = DateTime.Now.ToString();
        if (date.Contains("م"))
        {
            date = date.Replace("م", "");
        }
        else if (date.Contains("ص"))
        {
            date = date.Replace("ص", "");
        }
        date = date.Replace(" ", "");
        date = date.Replace("/", "");
        date = date.Replace(":", "");

        string fullName = fileName + date + ext;

        return fullName;
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
}