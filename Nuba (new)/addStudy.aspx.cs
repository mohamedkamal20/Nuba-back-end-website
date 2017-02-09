using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class addStudy : System.Web.UI.Page
{
    private string PDFFileName;
    private string ImgName;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //add button when fired 
    protected void add_Click(object sender, EventArgs e)
    {

        string Title = title.Text;
        string Desc = desc.Text;
        string PdfPath = pdfurl.Text;
        string ImgPath = Image1.ImageUrl.Replace("Images/Studies/", "");
        string Caption = caption.Text;
        string Author = author.Text;
        string date = DateTextBox.Text;
        DateTime selectedDate;
        DateTime.TryParse(date, out selectedDate);

        addStudie(Title, Desc, PdfPath, ImgPath, Caption, Author, selectedDate);
        showSuccessfulMsg();
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    private void addStudie(string title, string desc, string pdfPath, string imgPath, string caption,
                                                string author, DateTime publishDate)
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("addStudies", con);
            cmd.CommandType = CommandType.StoredProcedure;
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
            cmd.Parameters.Add(titleParam);
            cmd.Parameters.Add(descParam);
            cmd.Parameters.Add(pdfPathParam);
            cmd.Parameters.Add(imgPathParam);
            cmd.Parameters.Add(captionParam);
            cmd.Parameters.Add(authorParam);
            cmd.Parameters.Add(publishDateParam);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

        }
    }

    protected void uploadPDF_Click(object sender, EventArgs e)
    {
        if (pdfupload.HasFile)
        {
            if ((pdfupload.PostedFile.ContentLength / (1024 * 1024)) > .5)
            {
                sizeError.Visible = true;
                //RegularExpressionValidator1.Visible = false;
            }
            else
            {
                sizeError.Visible = false;
                string ext = Path.GetExtension(pdfupload.PostedFile.FileName);
                string filename = Path.GetFileNameWithoutExtension(pdfupload.PostedFile.FileName);
                PDFFileName = rename(filename, ext);
                pdfupload.PostedFile.SaveAs(Server.MapPath("files/Studies/") + PDFFileName);
                pdfurl.Text = PDFFileName;
                PDFHyperLink.NavigateUrl = "files/Studies/" + PDFFileName;
                pdfurl.Visible = true;
                sizeError.Visible = false;
                //RegularExpressionValidator1.Visible = false;
            }
        }
    }

    protected void uploadImg_Click(object sender, EventArgs e)
    {
        if (imgupload.HasFile)
        {
            if ((imgupload.PostedFile.ContentLength / (1024 * 1024)) > .5)
            {
                sizeErrorImg.Visible = true;
                //RegularExpressionValidator1.Visible = false;
            }
            else
            {
                string ext = Path.GetExtension(imgupload.PostedFile.FileName);
                string filename = Path.GetFileNameWithoutExtension(imgupload.PostedFile.FileName);
                ImgName = rename(filename, ext);
                imgupload.PostedFile.SaveAs(Server.MapPath("Images/Studies/") + ImgName);
                Image1.ImageUrl = "Images/Studies/" + ImgName;
                //sizeError.Visible = false;
            }
        }
    }

    private string rename(string fileName, string ext)
    {

        //Regex pattern = new Regex("[]+- /:");
        //pattern.Replace(fileName,"");
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

    protected void reset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.AbsoluteUri);
    }

    private void showSuccessfulMsg()
    {
        string message = "تم إضافة مقال ودراسة جديدة بنجاح";
        System.Text.StringBuilder sb = new System.Text.StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.onload=function(){");
        sb.Append("alert('");
        sb.Append(message);
        sb.Append("')};");
        sb.Append("</script>");
        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
    }

}