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
using System.Security.Cryptography;
using System.Text;

public partial class Studies_editStudy : System.Web.UI.Page
{
    private string PDFFileName;
    private string ImgName;
    private string studyID;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //studyID = (string)Session["studyID"];

            //getStudyInfo(studyID);
            if (Request.IsAuthenticated)
            {
                studyID = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));
                getStudyInfo(studyID);
            }
            else
            {
                Response.Redirect("~/Account/Login");
            }



        }
    }

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

    private void getStudyInfo(string id)
    {
        int theId = Convert.ToInt32(id);

        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            string pdfPath;
            string imgPath;
            string date;
            SqlCommand cmd = new SqlCommand("getAllInfoStudy", con);
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
    
            title.Text            = sdr["Title"].ToString();
            desc.Text             = sdr["Description"].ToString();
            pdfurl.Text           = sdr["PDF_Path"].ToString();
            Image1.ImageUrl       = "~/Studies/ImgUploads/" + sdr["Img_Path"].ToString();
            caption.Text          = sdr["Caption"].ToString();
            author.Text           = sdr["Author"].ToString();
            DateTime selectedDate = Convert.ToDateTime(sdr["Publish_Date"].ToString());
            DateTextBox.Text      = selectedDate.ToString("yyyy-MM-dd");
            
        }
    }
    protected void uploadPDF_Click(object sender, EventArgs e)
    {

        if (pdfupload.HasFile)
        {
            //File.Delete(Server.MapPath("~/Studies/PDFUploads/") + pdfurl.Text);
            File.Delete(Server.MapPath("files/Studies/") + pdfurl.Text);
            string ext = Path.GetExtension(pdfupload.PostedFile.FileName);
            string filename = Path.GetFileNameWithoutExtension(pdfupload.PostedFile.FileName);
            PDFFileName = rename(filename, ext);
            //pdfupload.PostedFile.SaveAs(Server.MapPath("~/Studies/PDFUploads/") + PDFFileName);
            pdfupload.PostedFile.SaveAs(Server.MapPath("files/Studies/") + PDFFileName);
            pdfurl.Text = PDFFileName;
            //RegularExpressionValidator1.Visible = false;
            pdfurl.Visible = false;
        }

    }

    protected void uploadImg_Click(object sender, EventArgs e)
    {
        if (imgupload.HasFile)
        {
            File.Delete(Server.MapPath(Image1.ImageUrl));

            string ext = Path.GetExtension(imgupload.PostedFile.FileName);
            string filename = Path.GetFileNameWithoutExtension(imgupload.PostedFile.FileName);
            ImgName = rename(filename, ext);
            //imgupload.PostedFile.SaveAs(Server.MapPath("~/Studies/ImgUploads/") + ImgName);
            imgupload.PostedFile.SaveAs(Server.MapPath("images/Studies/") + ImgName);
            //Image1.ImageUrl = "~/Studies/ImgUploads/" + ImgName;
            Image1.ImageUrl = "images/Studies/" + ImgName;
            //RegularExpressionValidator2.Visible = false;
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

    protected void update_Click(object sender, EventArgs e)
    {
        //studyID = (string)Session["studyID"];
        studyID = Decrypt(HttpUtility.UrlDecode(Request.QueryString["id"]));
        string Title = title.Text;
        string Desc = desc.Text;
        string PdfPath = pdfurl.Text;
        string ImgPath = Image1.ImageUrl.Replace("images/Studies/", "");
        string Caption = caption.Text;
        string Author = author.Text;
        string date = DateTextBox.Text;
        DateTime selectedDate;
        DateTime.TryParse(date, out selectedDate);
        
        
        updateStudy(studyID, Title, Desc, PdfPath, ImgPath, Caption, Author, selectedDate);
        Response.Redirect("studies.aspx");
    }

    private void updateStudy(string id, string title, string desc, string pdfPath, string imgPath, string caption,
                                                string author, DateTime publishDate)
    {
        
        int theId = Convert.ToInt32(id);
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            
            SqlCommand cmd = new SqlCommand("editStudy", con);
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
            SqlParameter descParam = new SqlParameter()
            {
                ParameterName = "@desc",
                Value = desc
            };
            SqlParameter pdfPathParam = new SqlParameter()
            {
                ParameterName = "@pdfPath",
                Value = pdfPath
            };
            SqlParameter imgPathParam = new SqlParameter()
            {
                ParameterName = "@imgPath",
                Value = imgPath
            };
            SqlParameter captionParam = new SqlParameter()
            {
                ParameterName = "@caption",
                Value = caption
            };
            SqlParameter authorParam = new SqlParameter()
            {
                ParameterName = "@author",
                Value = author
            };
            SqlParameter publishDateParam = new SqlParameter()
            {
                ParameterName = "@publishDate",
                Value = publishDate
            };
            

            cmd.Parameters.Add(idParam);
            cmd.Parameters.Add(titleParam);
            cmd.Parameters.Add(descParam);
            cmd.Parameters.Add(pdfPathParam);
            cmd.Parameters.Add(imgPathParam);
            cmd.Parameters.Add(captionParam);
            cmd.Parameters.Add(authorParam);
            cmd.Parameters.Add(publishDateParam);

            con.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            con.Close();
           
        }
    }

    
}