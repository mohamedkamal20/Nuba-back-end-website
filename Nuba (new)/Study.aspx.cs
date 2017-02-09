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


public partial class Studies_showStudy : System.Web.UI.Page
{
    private string studyID;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //studyID = (string)Session["studyID"];

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

            headerTitle.Text = sdr["Title"].ToString();
            title.Text = sdr["Title"].ToString();
            desc.Text = sdr["Desc"].ToString();
            pdfurl.Text = sdr["PDF_Path"].ToString();
            Hyperlink1.NavigateUrl = "files/Studies/" + pdfurl.Text;
            Image1.ImageUrl = "Images/Studies/" + sdr["Img_Path"].ToString();
            caption.Text = sdr["Caption"].ToString();
            author.Text = sdr["Author"].ToString();
            DateTime selectedDate = Convert.ToDateTime(sdr["Publish_Date"].ToString());
            DateTextBox.Text = selectedDate.ToString("yyyy-MM-dd");

        }
    }
}