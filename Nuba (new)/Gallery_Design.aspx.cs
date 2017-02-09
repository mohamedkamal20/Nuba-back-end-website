using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Data;
using System.IO;

public partial class Gallery_Design : System.Web.UI.Page
{
    //
    SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
    SqlDataReader rdr = null;
    String img_path = "", img_name = "", img_createdName = "", img_ext = "", ISMain = "";
    int counter = 0;
    /// <summary>
    /// 
    /// </summary>
    /// <param name="Name"></param>
    /// <returns></returns>
     protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected bool CheckGalleryName(String Name)
    {
        SqlCommand command = new SqlCommand("checkGallery", con);
        con.Open();
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.Add("@Title", SqlDbType.NVarChar).Value = Name;
        rdr = command.ExecuteReader();
        while (rdr.Read())
        {
            counter++;
        }
        rdr.Close();
        con.Close();
        if (counter != 0){return true;}
        return false;
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand command = new SqlCommand("GalleryInsertion", con);
            command.CommandType = CommandType.StoredProcedure;
            bool Check = CheckGalleryName(TextBox1.Text);
            if (Check == false)
            {
                con.Open();
                command.Parameters.Add("@Title", SqlDbType.NVarChar).Value = TextBox1.Text;
                command.Parameters.Add("@Desc", SqlDbType.NText).Value = Lbl_Desc.Text;
                command.ExecuteNonQuery();
                con.Close();
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('تم اضافه المعرض بنجاح')", true);
            }
            else
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('اسم المعرض بالفعل موجود!')", true);
             //   CheckInsertion.Text = "Name of Galary is already exists !";
            }
          //Response.Redirect(Request.Url.PathAndQuery, true);
        }
        catch (SqlException ex)
        {
            Console.WriteLine("SQL Error" + ex.Message.ToString());
        }

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.PathAndQuery, true);
    }
    
  
}