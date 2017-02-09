using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.IO;

public partial class addImagesToGalary : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
    SqlDataReader rdr = null;
    String img_path = "", img_name = "", img_createdName = "", img_ext = "", ISMain = "";
    int counter = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void InsertIntoDataBase(int MainValue, String img_name)
    {
        SqlCommand command2 = new SqlCommand("AddImagestoG", con);
        con.Open();
        command2.CommandType = CommandType.StoredProcedure;
        command2.Parameters.Add("@Caption", SqlDbType.NVarChar).Value = addCaption.Text;
        command2.Parameters.Add("@gallery_ID", SqlDbType.Int).Value = DropDownList1.Text;
        command2.Parameters.Add("@main", SqlDbType.Bit).Value = MainValue;
        command2.Parameters.Add("@image_Path", SqlDbType.NVarChar).Value = img_name;
        command2.ExecuteNonQuery();
        con.Close();
    }

    protected void Save(object sender, EventArgs e)
    {
        img_path = FileUpload1.PostedFile.FileName;
        if (FileUpload1.FileBytes.Length> 100000)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('لايمكن رفع هذه الصوره بهذا الحجم')", true);
        }
         else
          {
            img_name = Path.GetFileName(img_path);
            img_createdName = string.Format(File.GetCreationTime(img_path).ToString(), img_name);
            img_ext = Path.GetExtension(img_name);
            FileUpload1.PostedFile.SaveAs(Server.MapPath("/Images/GalaryImages/") + img_name);
            if (RadioButton2.Checked)
            {
                InsertIntoDataBase(0, img_name);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('! تم حفظ البيانات بنجاح')", true);
            }
            else
            {
                SqlCommand command2 = new SqlCommand("CheckMainPho", con);
                con.Open();
                command2.CommandType = CommandType.StoredProcedure;
                command2.Parameters.Add("@GalleryID", SqlDbType.Int).Value = DropDownList1.Text;
                rdr = command2.ExecuteReader();
                while (rdr.Read())
                {
                    ISMain = rdr["Main"].ToString();
                    if (ISMain == "True") { counter++; }
                }
                rdr.Close();
                con.Close();
                if (counter == 0)
                {
                    InsertIntoDataBase(1, img_name);
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('! تم حفظ البيانات بنجاح')", true);
                }
                else
                {
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('! لا يمكن جعل هذه الصوره ك صوره رئيسيه')", true);
                    // errorMessage.Text = "Cannot make this as a Main photo"; 
                }
            }
            // Response.Redirect(Request.Url.PathAndQuery, true);
        }
     }
    protected void ToEmpty(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.PathAndQuery, true);
    }
}