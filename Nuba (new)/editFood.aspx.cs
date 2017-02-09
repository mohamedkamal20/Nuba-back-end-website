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

public partial class editFood : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         if (!HttpContext.Current.User.Identity.IsAuthenticated)
        {
            Response.Redirect("Account//Login.aspx");
        }
    }
   

    protected void clearListViewButtons(ListViewItem i)
    {
        foreach (ListViewItem item in ListView1.Items)
        {
            if(item != i)
            {
                ((Label)item.FindControl("lable1Quantities")).Visible = false;
                ((TextBox)item.FindControl("QuantitiesLabel")).Visible = false;
                ((Label)item.FindControl("Label1Method")).Visible = false;
                ((TextBox)item.FindControl("MethodLabel")).Visible = false;
                ((Label)item.FindControl("Label1NaturalInfo")).Visible = false;
                ((TextBox)item.FindControl("NaturalInfoLabel")).Visible = false;
                ((Label)item.FindControl("Label1OldInfo")).Visible = false;
                ((TextBox)item.FindControl("OldInfoLabel")).Visible = false;
                ((Label)item.FindControl("Label1QuantityImg")).Visible = false;
                ((Image)item.FindControl("Quantity_ImgPathLabe")).Visible = false;
                ((Label)item.FindControl("Label1QuantityImgCaption")).Visible = false;
                ((TextBox)item.FindControl("Quantity_ImgCaptionLabel")).Visible = false;
                if(((Button)item.FindControl("ButtonMore")).Text.Equals("إخفاء"))
                {
                    ((Button)item.FindControl("ButtonMore")).Text = "المزيد";
                }
            }
            else
            {
                continue;
            }
            
 
        }

    }

    private string SaveImage(FileUpload obj)
    {
        String path = "";
        if (obj.PostedFile != null)
        {

            String fileName = Path.GetFileName(obj.PostedFile.FileName);
            path = DateTime.Now.ToString("yyyyMMddHHmmssfff") + fileName;
            obj.SaveAs(Server.MapPath("images/food/" + path));
            return  path;
        }
        else return path;

    }

    protected void ListView1_ItemCommand(object sender, ListViewCommandEventArgs e)
    {
        

        if(e.CommandName == "More")
        {
            clearListViewButtons(e.Item);
            if (((Button)e.Item.FindControl("ButtonMore")).Text.Equals("المزيد"))
            {
                if(!((TextBox)e.Item.FindControl("QuantitiesLabel")).Text.Equals(""))
                {
                    ((Label)e.Item.FindControl("lable1Quantities")).Visible = true;
                    ((TextBox)e.Item.FindControl("QuantitiesLabel")).Visible = true;
                }

                if (!((TextBox)e.Item.FindControl("MethodLabel")).Text.Equals(""))
                {
                    ((Label)e.Item.FindControl("Label1Method")).Visible = true;
                    ((TextBox)e.Item.FindControl("MethodLabel")).Visible = true;
                }

                if (!((TextBox)e.Item.FindControl("NaturalInfoLabel")).Text.Equals(""))
                {
                    ((Label)e.Item.FindControl("Label1NaturalInfo")).Visible = true;
                    ((TextBox)e.Item.FindControl("NaturalInfoLabel")).Visible = true;
                }

                if (!((TextBox)e.Item.FindControl("OldInfoLabel")).Text.Equals(""))
                {
                    ((Label)e.Item.FindControl("Label1OldInfo")).Visible = true;
                    ((TextBox)e.Item.FindControl("OldInfoLabel")).Visible = true;
                }
                if (!((Image)e.Item.FindControl("Quantity_ImgPathLabe")).ImageUrl.Equals("~/images/food/"))
                {
                    ((Label)e.Item.FindControl("Label1QuantityImg")).Visible = true;
                    ((Image)e.Item.FindControl("Quantity_ImgPathLabe")).Visible = true;
                }
                if (!((TextBox)e.Item.FindControl("Quantity_ImgCaptionLabel")).Text.Equals(""))
                {
                    ((Label)e.Item.FindControl("Label1QuantityImgCaption")).Visible = true;
                    ((TextBox)e.Item.FindControl("Quantity_ImgCaptionLabel")).Visible = true;
                }

                ((Button)e.Item.FindControl("ButtonMore")).Text = "إخفاء";

            }
            else
            {
                ((Label)e.Item.FindControl("lable1Quantities")).Visible = false;
                ((TextBox)e.Item.FindControl("QuantitiesLabel")).Visible = false;
                ((Label)e.Item.FindControl("Label1Method")).Visible = false;
                ((TextBox)e.Item.FindControl("MethodLabel")).Visible = false;
                ((Label)e.Item.FindControl("Label1NaturalInfo")).Visible = false;
                ((TextBox)e.Item.FindControl("NaturalInfoLabel")).Visible = false;
                ((Label)e.Item.FindControl("Label1OldInfo")).Visible = false;
                ((TextBox)e.Item.FindControl("OldInfoLabel")).Visible = false;
                ((Label)e.Item.FindControl("Label1QuantityImg")).Visible = false;
                ((Image)e.Item.FindControl("Quantity_ImgPathLabe")).Visible = false;
                ((Label)e.Item.FindControl("Label1QuantityImgCaption")).Visible = false;
                ((TextBox)e.Item.FindControl("Quantity_ImgCaptionLabel")).Visible = false;

                ((Button)e.Item.FindControl("ButtonMore")).Text = "المزيد";
            }
            

        }
        else if(e.CommandName == "Update1")
        {
         
            if(((FileUpload)e.Item.FindControl("FileUpload1")).PostedFile != null)
            {
                string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                string imgPath = SaveImage(((FileUpload)e.Item.FindControl("FileUpload1")));
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("addFoodAndQuantityImg", con);
                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = Convert.ToInt32(((Label)e.Item.FindControl("IDLabel1")).Text);
                    cmd.Parameters.Add("@Path", SqlDbType.NVarChar).Value = imgPath;
                    cmd.Parameters.Add("@bit", SqlDbType.Int).Value = 1;

                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                }
                ((Image)e.Item.FindControl("FoodImg_Path")).ImageUrl = "images/food/" + imgPath;
            }
        }
        else if (e.CommandName == "Update2")
        {
            if (((FileUpload)e.Item.FindControl("FileUpload1")).PostedFile != null)
            {
                string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                string imgPath = SaveImage(((FileUpload)e.Item.FindControl("FileUpload2")));
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("addFoodAndQuantityImg", con);
                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = Convert.ToInt32(((Label)e.Item.FindControl("IDLabel1")).Text);
                    cmd.Parameters.Add("@Path", SqlDbType.NVarChar).Value = imgPath;
                    cmd.Parameters.Add("@bit", SqlDbType.Int).Value = 0;

                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                }
               ((Image)e.Item.FindControl("QuantityImg_Path")).ImageUrl = "images/food/" + imgPath;
            }
        }
        else if (e.CommandName == "Delete1")
        {
            if (((Label)e.Item.FindControl("LabelFImgPath")).Text != null && ((Label)e.Item.FindControl("LabelFImgPath")).Text != "")
            {
                string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("deleteFoodAndQuantityImg", con);
                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = Convert.ToInt32(((Label)e.Item.FindControl("IDLabel1")).Text);
                    cmd.Parameters.Add("@bit", SqlDbType.Int).Value = 1;

                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                }
                ((Image)e.Item.FindControl("FoodImg_Path")).ImageUrl = null;
            }


        }
        else if (e.CommandName == "Delete2")
        {
            if (((Label)e.Item.FindControl("LabelQImgPath")).Text != null && ((Label)e.Item.FindControl("LabelQImgPath")).Text != "")
            {
                string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("deleteFoodAndQuantityImg", con);
                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = Convert.ToInt32(((Label)e.Item.FindControl("IDLabel1")).Text);
                    cmd.Parameters.Add("@bit", SqlDbType.Int).Value = 0;

                    cmd.CommandType = CommandType.StoredProcedure;

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                }
            }
            ((Image)e.Item.FindControl("QuantityImg_Path")).ImageUrl = null;
        }

    }
}


   
       