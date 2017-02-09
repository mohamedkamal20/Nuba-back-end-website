using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text.RegularExpressions;
using System.Text;
using System.Security.Cryptography;



public partial class Studies_studies : System.Web.UI.Page
{
    private string PDFFileName;
    private string ImgName;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!Request.IsAuthenticated)
            {
                //getAllStudies();
                Response.Redirect("~/Account/Login");

            }
            
        }
    }

   
    //private void removeStudy(string id)
    //{
    //    int theId = Convert.ToInt32(id);

    //    string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
    //    using (SqlConnection con = new SqlConnection(cs))
    //    {
    //        SqlCommand cmd = new SqlCommand("removeStudy", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        SqlParameter IDParam = new SqlParameter()
    //        {
    //            ParameterName = "@id",
    //            Value = theId
    //        };
    //        cmd.Parameters.Add(IDParam);
    //        con.Open();
    //        cmd.ExecuteNonQuery();
    //        con.Close();

    //    }
    //}

    private void removeUploadFiles(string id)
    {
        int theId = Convert.ToInt32(id);

        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            string pdfPath;
            string imgPath;
            SqlCommand cmd = new SqlCommand("getPDFandImgPathByID", con);
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
            pdfPath = sdr["PDF_Path"].ToString();
            imgPath = sdr["Img_Path"].ToString();
            File.Delete(Server.MapPath("files/Studies/") + pdfPath);
            File.Delete(Server.MapPath("Images/Studies/") + imgPath);
            con.Close();
        }

    }

    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        Label IDLabel = (Label)e.Item.FindControl("IDLabel");
        string studyID = IDLabel.Text;

        if (e.CommandName.Equals("Delete"))
        {   
            removeUploadFiles(studyID);   
        }
        else if (e.CommandName.Equals("Show"))
        {
            string encID = HttpUtility.UrlEncode(Encrypt(studyID));
            Response.Redirect(string.Format("Study.aspx?id={0}", encID));
        }

        else if (e.CommandName.Equals("uploadPDFCommand"))
        {
            uploadPDF(e);
            
        }
        else if (e.CommandName.Equals("uploadImgCommand"))
        {
            uploadImg(e);
        }
        //else if (e.CommandName.Equals("Edit"))
        //{
        //    Label imagPathLabel = e.Item.FindControl("imagPathLabel") as Label;
        //    Image Image1 = e.Item.FindControl("Image1") as Image;
        //    if (imagPathLabel.Text.Equals(""))
        //    {
        //        Image1.Visible = false;
        //    }
        //}
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

 

    private void uploadPDF(ListViewCommandEventArgs e)
    {
        FileUpload fu = e.Item.FindControl("pdfupload") as FileUpload;
        Label pdfurl = e.Item.FindControl("existpdfurl") as Label;
        if (fu.HasFile)
        {
            
            Label SE = (Label)e.Item.FindControl("sizeErrorPDF");
            if ((fu.PostedFile.ContentLength / (1024 * 1024)) > .5)
            {
                SE.Visible = true;
            }
            else
            {
                File.Delete(Server.MapPath("files/Studies/") + pdfurl.Text);
                SE.Visible = false;
                string ext = Path.GetExtension(fu.PostedFile.FileName);
                string filename = Path.GetFileNameWithoutExtension(fu.PostedFile.FileName);
                PDFFileName = rename(filename, ext);
                fu.PostedFile.SaveAs(Server.MapPath("files/Studies/") + PDFFileName);
                Label PDFLabel = (Label)e.Item.FindControl("PDFLabel");
                PDFLabel.Text = PDFFileName;
            }
        }
    }

    private void uploadImg(ListViewCommandEventArgs e)
    {
        FileUpload fu = (FileUpload)e.Item.FindControl("imgupload");
        if (fu.HasFile)
        {
            Label SE = (Label)e.Item.FindControl("sizeErrorImg");

            Image image = (Image)e.Item.FindControl("Image1");
            
            if ((fu.PostedFile.ContentLength / (1024 * 1024)) > .5)
            {
                SE.Visible = true;
            }
            else
            {
                Label imgPath = (Label)e.Item.FindControl("imagPathLabel");
                File.Delete(Server.MapPath("Images/Studies/") + imgPath.Text);
                string ext = Path.GetExtension(fu.PostedFile.FileName);
                string filename = Path.GetFileNameWithoutExtension(fu.PostedFile.FileName);
                ImgName = rename(filename, ext);
                fu.PostedFile.SaveAs(Server.MapPath("Images/Studies/") + ImgName);
                Image myImage = (Image)e.Item.FindControl("Image1");
                myImage.ImageUrl = "Images/Studies/" + ImgName;
                
                imgPath.Text = ImgName;
            }
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


    protected void Publish_DateTextBox_TextChanged(object sender, EventArgs e)
    {
        TextBox date = (TextBox)sender;
        ListViewItem lv = (ListViewItem)date.NamingContainer;
        Label dateLabel = lv.FindControl("dateLable") as Label;
        dateLabel.Text = date.Text;

    }

    protected void ListView1_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        
        if (ListView1.EditIndex == (e.Item as ListViewDataItem).DataItemIndex)
        {
            Label imagPathLabel = e.Item.FindControl("imagPathLabel") as Label;
            Image Image1 = e.Item.FindControl("Image1") as Image;
            if (imagPathLabel.Text.Equals(""))
            {
                Image1.Visible = false;
            }
        }
    }
}