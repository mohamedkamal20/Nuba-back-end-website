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

public partial class addFood : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!HttpContext.Current.User.Identity.IsAuthenticated)
        {
            Response.Redirect("Account//Login");
        }
    }

    protected void ButtonSave_Click(object sender, EventArgs e)
    {

        string TitleImgPath = "";
        string QuantityImgPath = "";
        if (LabelTitleSavedPath.Text != "")
        {
            TitleImgPath = LabelTitleSavedPath.Text.Substring(12);
        }
        if (LabelQuantitySavedPath.Text != "")
        {
            QuantityImgPath = LabelQuantitySavedPath.Text.Substring(12);
        }

        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        int Cat_ID = int.Parse(DropDownListCat.Text);
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("addNewFood", con);
            cmd.Parameters.Add("@Title", SqlDbType.NVarChar).Value = Convert.ToString(TextBoxTitle.Text);
            cmd.Parameters.Add("@Description", SqlDbType.NVarChar).Value = Convert.ToString(TextBoxDesc.Text);
            cmd.Parameters.Add("@Img_Path", SqlDbType.NVarChar).Value = TitleImgPath;
            cmd.Parameters.Add("@Quantities", SqlDbType.NText).Value = Convert.ToString(TextBoxQuantities.Text);
            cmd.Parameters.Add("@Method", SqlDbType.NText).Value = Convert.ToString(TextBoxMethod.Text);
            cmd.Parameters.Add("@NaturalInfo", SqlDbType.NText).Value = Convert.ToString(TextBoxNaturalInfo.Text);
            cmd.Parameters.Add("@OldInfo", SqlDbType.NText).Value = Convert.ToString(TextBoxOldInfo.Text);
            cmd.Parameters.Add("@Quantity_ImgPath", SqlDbType.NVarChar).Value = QuantityImgPath;
            cmd.Parameters.Add("@Quantity_ImgCaption", SqlDbType.NVarChar).Value = Convert.ToString(TextBoxQuantitiesCaption.Text);
            cmd.Parameters.Add("@Cat_ID", SqlDbType.Int).Value = Cat_ID;

            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();

            if (cmd.ExecuteNonQuery() == 1)
            {
                // Response.Redirect(Request.Url.PathAndQuery, true);
                
                string message = "تم الحفظ بنجاح";
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload=function(){");
                sb.Append("alert('");
                sb.Append(message);
                sb.Append("')};");
                sb.Append("</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('تم الحفظ بنجاح')", true);
                //Response.Redirect(Request.Url.PathAndQuery, true);
               // ButtonReset_Click(sender, e);
            }
            else
            {
                string message = "حدث خظأ ما يرجى المحاولة مرة اخرى";
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script type = 'text/javascript'>");
                sb.Append("window.onload=function(){");
                sb.Append("alert('");
                sb.Append(message);
                sb.Append("')};");
                sb.Append("</script>");
                ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('تم الحفظ بنجاح')", true);
                //Response.Redirect(Request.Url.PathAndQuery, true);
            }

            con.Close();

        }



    }

    /// <summary>
    /// check ext.
    /// check size
    /// rename image
    /// save in folder food
    /// </summary>
    private string SaveImage(FileUpload obj)
    {
        String path = "";
        if (obj.PostedFile != null)
        {

            String fileName = Path.GetFileName(obj.PostedFile.FileName);
            path = DateTime.Now.ToString("yyyyMMddHHmmssfff") + fileName;
            obj.SaveAs(Server.MapPath("images/food/" + path));
            return "images/food/" + path;
        }
        else return path;

    }

    protected void ButtonReset_Click(object sender, EventArgs e)
    {
        Response.Redirect(Request.Url.PathAndQuery, true);
    }


    protected void CheckFileSizeQuantity(object sender, ServerValidateEventArgs args)
    {
        if (FileUploadQuantities.HasFile)
        {
            if (FileUploadQuantities.FileBytes.Length >= 102400)
            {
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }
    }


    protected void ButtonUoload_Click(object sender, EventArgs e)
    {

        if (FileUploadTitle.HasFile)
        {
            ImageTitle.ImageUrl = SaveImage(FileUploadTitle);
            ImageTitle.Visible = true;
            LabelTitleSavedPath.Text = ImageTitle.ImageUrl;
            RequiredFieldValidatorTimagePath.Visible = false;
        }



    }

    protected void ButtonQuantityImage_Click(object sender, EventArgs e)
    {

        if (FileUploadQuantities.HasFile)
        {
            ImageQuantity.ImageUrl = SaveImage(FileUploadQuantities);
            ImageQuantity.Visible = true;
            LabelQuantitySavedPath.Text = ImageQuantity.ImageUrl;

        }
    }
}