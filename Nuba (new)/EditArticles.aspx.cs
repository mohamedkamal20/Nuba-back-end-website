using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EditArticles : System.Web.UI.Page
{

   

    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            String artID = null;
            if (Request.QueryString["artID"] != null)
            {
                artID = General.b64decode(Request.QueryString["artID"]);
            }
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login.aspx");
            }
            if (!string.IsNullOrEmpty(artID))
            {
                LoadArticle(int.Parse(artID));
                lbl_ID.Text = artID;
            
            }

        }
        PhotosList.DataBind();
        if (PhotosList.Items.Count == 0)
        {
            div_show.Visible = false;
        }
        else
        {
            div_show.Visible = true;
        }

    }

    protected void DataPagerProducts_PreRender(object sender, EventArgs e)
    {
        
    }
    

    private void LoadArticle(int ID)
    {
        
        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        SqlDataReader rd;
        using (SqlConnection Conn = new SqlConnection(con))
        {

            SqlCommand cmd = new SqlCommand("dbo.getArticle", Conn);
            //Conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@aID", ID);
            Conn.Open();
            rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                txt_ART_name.Text = rd[0].ToString();
                txt_ART_Desc.Text= rd[1].ToString();
                Cat_List.Text = rd[2].ToString();
            }
            rd.Close();
            Conn.Close();


        }
        
    }
    protected void PhotosList_ItemCommand(object sender, ListViewCommandEventArgs e)
    {   
        txt_Photo_cap.Text =( (TextBox)e.Item.FindControl("txt_cap")).Text;
    }
    protected void ADD_Click(object sender, EventArgs e)
    {
        String artID = null;
        if (Request.QueryString["artID"] != null)
        {
            artID = General.b64decode(Request.QueryString["artID"]);
        }
        HttpPostedFile pf = File_AddImage.PostedFile;
        System.Drawing.Image bm = System.Drawing.Image.FromStream(pf.InputStream);
        bm = General.ResizeBitmap((Bitmap)bm, 200, 200); /// new width, height
        bm.Save(Server.MapPath("/Images/Articles/" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + File_AddImage.FileName)); 
        //if (File_AddImage.FileName != null)
        //    File_AddImage.PostedFile.SaveAs(Server.MapPath("/Images/Articles/"+ DateTime.Now.ToString("yyyyMMdd_HHmmss")+File_AddImage.FileName));
        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection Conn = new SqlConnection(con))
        {

            SqlCommand cmd = new SqlCommand("dbo.AddPhoto", Conn);
            //Conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Art_ID", artID);
            cmd.Parameters.AddWithValue("@Caption", txt_img_caption.Text);
            cmd.Parameters.AddWithValue("@Path", DateTime.Now.ToString("yyyyMMdd_HHmmss")+File_AddImage.FileName);
            Conn.Open();
            cmd.ExecuteNonQuery();
            Conn.Close();


        }
        txt_img_caption.Text = "";
        PhotosList.DataBind();
        PhotosList.DataBind();
        if (PhotosList.Items.Count == 0)
        {
            div_show.Visible = false;
        }
        else
        {
            div_show.Visible = true;
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('تم إضافة صورة')", true);

        }
    }

    protected void Delete_Click(object sender, EventArgs e)
    {
        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection Conn = new SqlConnection(con))
        {

            SqlCommand cmd = new SqlCommand("dbo.DeletePhoto", Conn);
            //Conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ID", ((Button)sender).CommandArgument);

            Conn.Open();
            cmd.ExecuteNonQuery();
            Conn.Close();


        }
        PhotosList.DataBind();
        if (PhotosList.Items.Count == 0)
        {
            div_show.Visible = false;
        }
        else
        {
            div_show.Visible = true;

        }
        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('تم مسح الصورة')", true);
    }
    protected void Edit_CAP(object sender, EventArgs e)
    {

        int index = int.Parse(((Button)sender).CommandArgument.Substring(((Button)sender).CommandArgument.IndexOf("#") + 1));
        txt_Photo_cap.Text=((TextBox)PhotosList.Items[index].FindControl("txt_cap")).Text;
        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection Conn = new SqlConnection(con))
        {

            SqlCommand cmd = new SqlCommand("dbo.UpdatePhotoCaption", Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ID", ((Button)sender).CommandArgument.Substring(0, ((Button)sender).CommandArgument.IndexOf("#")));
            cmd.Parameters.AddWithValue("@Caption", txt_Photo_cap.Text);
            Conn.Open();
            cmd.ExecuteNonQuery();
            Conn.Close();


        }

        PhotosList.DataBind();
        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('تم تعديل النبذة')", true);
    }
    protected void MakeItMain(object sender, EventArgs e)
    {
        int i = int.Parse(((Button)sender).CommandArgument.Substring(((Button)sender).CommandArgument.IndexOf("#")+1));
        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection Conn = new SqlConnection(con))
        {

            SqlCommand cmd = new SqlCommand("dbo.UpdateArticleMainPhoto", Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ID", ((Button)PhotosList.Items[i].FindControl("btn_EditCap")).CommandArgument.Substring(0, ((Button)PhotosList.Items[i].FindControl("btn_EditCap")).CommandArgument.IndexOf("#")));
            if (((Button)PhotosList.Items[i].FindControl("btn_MainPhoto")).CommandArgument.Substring(0,
            ((Button)PhotosList.Items[i].FindControl("btn_MainPhoto")).CommandArgument.IndexOf("#")) == "False")
            {
                cmd.Parameters.AddWithValue("@Main", 1);
            }
            else
            {
                cmd.Parameters.AddWithValue("@Main", 0);
            }
            Conn.Open();
            cmd.ExecuteNonQuery();
            Conn.Close();


        }
        PhotosList.DataBind();

        // EditMainbutton();

    }
  
    protected void btn_EditArt_Click(object sender, EventArgs e)
    {
        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection Conn = new SqlConnection(con))
        {

            SqlCommand cmd = new SqlCommand("dbo.UpdateArticle", Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ID", lbl_ID.Text);
            cmd.Parameters.AddWithValue("@Cat_ID", Cat_List.SelectedValue);
            cmd.Parameters.AddWithValue("@Art_Title", txt_ART_name.Text);
            cmd.Parameters.AddWithValue("@Description", txt_ART_Desc.Text);
            Conn.Open();
            cmd.ExecuteNonQuery();
            Conn.Close();


        }
        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('تم تعديل بيانات المقال')", true);
    }


    protected void PhotosList_DataBound(object sender, ListViewItemEventArgs e)
    {
        
    }

    protected void PhotosList_ItemDataBound(object sender, ListViewItemEventArgs e)
    {
        if (e.Item.ItemType == ListViewItemType.DataItem)
        {
            Button btn;
            btn = (Button)e.Item.FindControl("btn_MainPhoto");
            if (btn.CommandArgument.Substring(0,
               btn.CommandArgument.IndexOf("#")) == "False")
            {
                ((Button)e.Item.FindControl("btn_MainPhoto")).Text = "الصورة الرئيسية";
            }
            else
            {
                ((Button)e.Item.FindControl("btn_MainPhoto")).Text = " إلغاءالصورة الرئيسية";
            }
        }
    }

    //protected void Button1_Click(object sender, EventArgs e)
    //{
    //    String artID = null;
    //    if (Request.QueryString["artID"] != null)
    //    {
    //        artID = General.b64decode(Request.QueryString["artID"]);
    //    }
    //    HttpPostedFile pf = File_AddImage.PostedFile;
    //    System.Drawing.Image bm = System.Drawing.Image.FromStream(pf.InputStream);
    //    bm = ResizeBitmap((Bitmap)bm, 200, 200); /// new width, height
    //    bm.Save(Server.MapPath("/Images/Articles/" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + File_AddImage.FileName));
    //    //if (File_AddImage.FileName != null)
    //    //    File_AddImage.PostedFile.SaveAs(Server.MapPath("/Images/Articles/"+ DateTime.Now.ToString("yyyyMMdd_HHmmss")+File_AddImage.FileName));
    //    string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
    //    using (SqlConnection Conn = new SqlConnection(con))
    //    {

    //        SqlCommand cmd = new SqlCommand("dbo.AddPhoto", Conn);
    //        //Conn.Open();
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@Art_ID", artID);
    //        cmd.Parameters.AddWithValue("@Caption", txt_img_caption.Text);
    //        cmd.Parameters.AddWithValue("@Path", DateTime.Now.ToString("yyyyMMdd_HHmmss") + File_AddImage.FileName);
    //        Conn.Open();
    //        cmd.ExecuteNonQuery();
    //        Conn.Close();


    //    }
    //    txt_img_caption.Text = "";
    //    PhotosList.DataBind();
    //}
}