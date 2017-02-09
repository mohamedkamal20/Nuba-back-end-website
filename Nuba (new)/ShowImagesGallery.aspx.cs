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

public partial class ShowImagesGallery : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    protected void update_title(String title, int id)
    {
        SqlCommand cmd = new SqlCommand("Edit_Title", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@title", SqlDbType.NVarChar).Value = title;
        cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;
        cmd.ExecuteNonQuery();
    }
    protected void update_Desc(String description, int id)
    {
        SqlCommand cmd = new SqlCommand("Edit_Desc", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@description", SqlDbType.NText).Value = description;
        cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;
        cmd.ExecuteNonQuery();
    }
    protected void update_Caption(String Caption, int id)
    {
        SqlCommand cmd = new SqlCommand("Edit_Caption", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@Caption", SqlDbType.NVarChar).Value = Caption;
        cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;
        cmd.ExecuteNonQuery();
    }
    protected void delete_photo(int id)
    {
        SqlCommand cmd = new SqlCommand("delete_photo", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;
        cmd.ExecuteNonQuery();
    }
    protected void delete_Galary(int id)
    {
        SqlCommand cmd = new SqlCommand("Delete_Galary", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@ID", SqlDbType.Int).Value = id;
        cmd.ExecuteNonQuery();
    }
    protected void DoTheCommand(object sender, ListViewCommandEventArgs e)
    {
        if (e.CommandName == "Edit_title")
        {
            ((TextBox)e.Item.FindControl("Editt_Desc")).Visible = false;
            ((Button)e.Item.FindControl("saveEditing1")).Visible = false;
            ((TextBox)e.Item.FindControl("Edit_title")).Visible = true;
             String title = Convert.ToString(((Label)e.Item.FindControl("Title")).Text);
            ((TextBox)e.Item.FindControl("Edit_title")).Text = title; 
            ((Button)e.Item.FindControl("saveEditing")).Visible = true;
            ((Button)e.Item.FindControl("Canccel")).Visible = true;
        }
        else if (e.CommandName == "savingtitle")
        {
            String title = ((TextBox)e.Item.FindControl("Edit_title")).Text;
            int itemindex = Convert.ToInt32(((Button)e.Item.FindControl("Edit_Name")).CommandArgument);
            con.Open();
            update_title(title, itemindex);
            con.Close();
            Response.Redirect("ShowImagesGallery.aspx");
        }
        else if (e.CommandName == "Edit_Description")
        {
            ((Button)e.Item.FindControl("saveEditing")).Visible = false;
            ((TextBox)e.Item.FindControl("Edit_title")).Visible = false;
            ((TextBox)e.Item.FindControl("Editt_Desc")).Visible = true;
            String Desc = Convert.ToString(((Label)e.Item.FindControl("MoreText")).Text);
            ((TextBox)e.Item.FindControl("Editt_Desc")).Text = Desc;
            ((Button)e.Item.FindControl("saveEditing1")).Visible = true;
            ((Button)e.Item.FindControl("Canccel")).Visible = true;
        }
        else if (e.CommandName == "savingdesc")
        {
            String Desc = ((TextBox)e.Item.FindControl("Editt_Desc")).Text;
            int itemindex = Convert.ToInt32(((Button)e.Item.FindControl("Edit_Desc")).CommandArgument);
            con.Open();
            update_Desc(Desc, itemindex);
            con.Close();
            Response.Redirect("ShowImagesGallery.aspx");
        }
        else if (e.CommandName == "ShwImages")
        {
            Show_Gallery.Visible = false;
            ListPhotos.Visible = true;
            hidePhotos.Visible = true;
            ListPager.Visible = false;
            Tittle.Visible = true;
            Tittle.Text = "اسم المعرض"+": "+((Label)e.Item.FindControl("Title")).Text;
            String Data_id = ((Button)e.Item.FindControl("showPhotos")).CommandArgument;
            lb1_ID.Text = Data_id;
        }
        else if (e.CommandName == "Delete_Galary")
        {
            int ID = Convert.ToInt32(((Button)e.Item.FindControl("deleteGalary")).CommandArgument);
            con.Open();
            delete_Galary(ID);
            con.Close();
            Response.Redirect("ShowImagesGallery.aspx");
        }
        else if (e.CommandName == "canccel")
        {
            Response.Redirect("ShowImagesGallery.aspx");
        }
        else if (e.CommandName == "MMore")
        {
             String FullText=((Label)e.Item.FindControl("MoreText")).Text;
            ((Label)e.Item.FindControl("Description")).Text = FullText;
            ((LinkButton)e.Item.FindControl("Less")).Visible = true;
            ((LinkButton)e.Item.FindControl("More")).Visible = false;
        }
        else if (e.CommandName == "MLess")
        {
            Response.Redirect("ShowImagesGallery.aspx");
        }

    }
    protected void ListPhotos_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
  
        if (e.CommandName == "EditCap")
        {
            String Caption = Convert.ToString(((Label)e.Item.FindControl("MMore")).Text);
            ((TextBox)e.Item.FindControl("Edit_Text")).Visible = true;
            ((TextBox)e.Item.FindControl("Edit_Text")).Text = Caption;
            ((Button)e.Item.FindControl("saveEditing2")).Visible = true;
            ((Button)e.Item.FindControl("Canccel")).Visible = true;
        }
        else if (e.CommandName == "savingCap")
        {
            int Id = Convert.ToInt32(((Button)e.Item.FindControl("Edit_Caption")).CommandArgument);
            String FullCaption = ((TextBox)e.Item.FindControl("Edit_Text")).Text;
            con.Open();
            update_Caption(FullCaption, Id);
            con.Close();
            ((TextBox)e.Item.FindControl("Edit_Text")).Visible = false;
            ((Button)e.Item.FindControl("saveEditing2")).Visible = false;
            ((Button)e.Item.FindControl("Canccel")).Visible = false;
            ListPhotos.DataBind();
        }
        else if (e.CommandName == "deletingPhoto")
        {
            int Id = Convert.ToInt32(((Button)e.Item.FindControl("removephoto")).CommandArgument);
            con.Open();
            delete_photo(Id);
            String img_Name = ((Image)e.Item.FindControl("Image1")).ImageUrl;
            File.Delete(Server.MapPath(img_Name));
            con.Close();
            Response.Redirect("ShowImagesGallery.aspx");
        }
        else if (e.CommandName == "canccel")
        {
            ((TextBox)e.Item.FindControl("Edit_Text")).Visible = false;
            ((Button)e.Item.FindControl("saveEditing2")).Visible = false;
            ((Button)e.Item.FindControl("Canccel")).Visible = false;
        }
        else if (e.CommandName == "MMMore")
        {
             String FullText = ((Label)e.Item.FindControl("MMore")).Text;
             ((Label)e.Item.FindControl("Caption")).Text = FullText;
             ((LinkButton)e.Item.FindControl("Lesss")).Visible = true;
             ((LinkButton)e.Item.FindControl("Moree")).Visible = false;
        }
        else if (e.CommandName == "MMLess")
        {
            String partOfText = Convert.ToString(((Label)e.Item.FindControl("Caption")).Text);
            ((Label)e.Item.FindControl("Caption")).Text =partOfText.Substring(0, (partOfText.Length) / 2);
            ((LinkButton)e.Item.FindControl("Lesss")).Visible = false;
            ((LinkButton)e.Item.FindControl("Moree")).Visible = true;
        }

    }
    protected void hidePhotos_Click(object sender, EventArgs e)
    {
        Response.Redirect("ShowImagesGallery.aspx");
    }


}