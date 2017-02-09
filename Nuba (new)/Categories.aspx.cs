using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;


public partial class Categories : System.Web.UI.Page
{
   
    SqlConnection Conn = new SqlConnection(ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        String CatID = null;
        if (Request.QueryString["ID"] !="0")
        {
            CatID = General.b64decode(Request.QueryString["ID"]);
            btn.Text = "تعديل";
            Page.Title = "تعديل التصنيف";
            h.InnerText = "تعديل التصنيف";
                
        }
        else 
        {
            btn.Text = "إضافة";
            Page.Title = "إضافة تصنيف";
            h.InnerText = "إضافة تصنيف";
            img_CatImg.Visible = false;
           
        }
        if (!Page.IsPostBack)
        {
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
        {
            Response.Redirect("~/Account/Login.aspx");

        }
            if (!string.IsNullOrEmpty(CatID))
            {
                LoadCategory(int.Parse(CatID));
            }
            else
            {

            }
            DropDownList_CatParents.DataBind();
            DropDownList_CatParents.Items.Insert(0, new ListItem("اختر", "-1"));
        }
        
 
    }
    private void LoadCategory(int ID)
    {

        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        SqlDataReader rd;
        using (SqlConnection Conn = new SqlConnection(con))
        {

            SqlCommand cmd = new SqlCommand("dbo.getCategory", Conn);
            //Conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ID", ID);
            Conn.Open();
            rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                txt_AddName.Text = rd[1].ToString();
                if (rd[3].ToString() == "0")
                {
                    DropDownList_CatParents.DataBind();
                    DropDownList_CatParents.Items.Insert(0, new ListItem("تصنيف رئيسى", "-1"));
                }
                else
                    DropDownList_CatParents.SelectedValue = rd[2].ToString();
                img_CatImg.ImageUrl = "/Images/Categories/" + rd[4].ToString();
                lbl_imgPath.Text = rd[4].ToString();
                if(lbl_imgPath.Text==null|| lbl_imgPath.Text == "")
                {
                    img_CatImg.Visible = false;
                    btn_DeleteCatPhoto.Visible = false;
                }
                else
                {
                    img_CatImg.Visible = true;
                    btn_DeleteCatPhoto.Visible = true;
                }
                    if (rd[5].ToString() == "False" || rd[5].ToString() == "false" || rd[5].ToString() == "0")
                    CheckBox_Food.Checked = false;
                else
                    CheckBox_Food.Checked = true;
            }
            rd.Close();
            Conn.Close();
        }

    }
    
    protected void btn_Click(object sender, EventArgs e)
    {
        if (btn.Text == "تعديل")
        {
            String CatID = null;
            if (Request.QueryString["ID"] != null)
            {
                CatID = General.b64decode(Request.QueryString["ID"]);
            }
            string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            int level = 1;
            if (DropDownList_CatParents.SelectedValue != "-1")
            {
                SqlDataReader rd;
                using (SqlConnection Conn1 = new SqlConnection(con))
                {

                    SqlCommand cmd = new SqlCommand("dbo.selectLevel", Conn1);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ID", DropDownList_CatParents.SelectedValue);
                    Conn1.Open();
                    rd = cmd.ExecuteReader();
                    while (rd.Read())
                    {
                        level += int.Parse(rd[0].ToString());
                    }
                    Conn1.Close();

                }
            }
            else
            {
                level = 0;
            }

            using (SqlConnection Conn = new SqlConnection(con))
            {

                SqlCommand cmd = new SqlCommand("dbo.UpdateCategory", Conn);
                //Conn.Open();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", CatID);
                cmd.Parameters.AddWithValue("@Category", txt_AddName.Text);
                if (DropDownList_CatParents.SelectedValue != "-1")
                    cmd.Parameters.AddWithValue("@ParentID", DropDownList_CatParents.SelectedValue);

                else
                    cmd.Parameters.AddWithValue("@ParentID", DBNull.Value);

                cmd.Parameters.AddWithValue("@Level", level);
                if (File_CatImage.FileName.Equals(lbl_imgPath.Text) || File_CatImage.FileName == ""|| File_CatImage.FileName == null)
                {
                    cmd.Parameters.AddWithValue("@Image_Path", lbl_imgPath.Text);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Image_Path", DateTime.Now.ToString("yyyyMMdd_HHmmss") + File_CatImage.FileName);
                    HttpPostedFile pf = File_CatImage.PostedFile;
                    System.Drawing.Image bm = System.Drawing.Image.FromStream(pf.InputStream);
                    bm = General.ResizeBitmap((Bitmap)bm, 1583, 500); // new width, height
                    bm.Save(Server.MapPath("/Images/Categories/" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + File_CatImage.FileName));
                    lbl_imgPath.Text = DateTime.Now.ToString("yyyyMMdd_HHmmss") + File_CatImage.FileName;
                    img_CatImg.ImageUrl= "/Images/Categories/" + lbl_imgPath.Text;
                }
                cmd.Parameters.AddWithValue("@Food", CheckBox_Food.Checked);
                Conn.Open();
                cmd.ExecuteNonQuery();
                Conn.Close();


            }
            if (lbl_imgPath.Text == null || lbl_imgPath.Text == "")
            {
                img_CatImg.Visible = false;
                btn_DeleteCatPhoto.Visible = false;

            }
            else
            {
                img_CatImg.Visible = true;
                btn_DeleteCatPhoto.Visible = true;

            }
            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('تم تعديل التصنيف')", true);
        }
        else
        {
            int lvl = 0;
            string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            if (DropDownList_CatParents.SelectedValue != "-1")
            {
                SqlDataReader rd;
                using (SqlConnection Conn1 = new SqlConnection(con))
                {

                    SqlCommand cmd = new SqlCommand("dbo.selectLevel", Conn1);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ID", DropDownList_CatParents.SelectedValue);
                    Conn1.Open();
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        lvl = int.Parse(rd[0].ToString()) + 1;
                    }
                    Conn1.Close();

                }
            }

            using (SqlConnection Conn = new SqlConnection(con))
            {

                SqlCommand cmd = new SqlCommand("dbo.AddCategory", Conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Category", txt_AddName.Text);
                if (DropDownList_CatParents.SelectedValue != "-1")
                {
                    cmd.Parameters.AddWithValue("@ParentID", DropDownList_CatParents.SelectedValue);

                }
                else
                {
                    cmd.Parameters.AddWithValue("@ParentID", DBNull.Value);
                }
                cmd.Parameters.AddWithValue("@Level", lvl);
                cmd.Parameters.AddWithValue("@Image_Path", File_CatImage.FileName);
                cmd.Parameters.AddWithValue("@Food", CheckBox_Food.Checked);
                Conn.Open();
                cmd.ExecuteNonQuery();
                Conn.Close();


            }
            if (File_CatImage.HasFile)
            {
                HttpPostedFile pf = File_CatImage.PostedFile;
                System.Drawing.Image bm = System.Drawing.Image.FromStream(pf.InputStream);
                bm = General.ResizeBitmap((Bitmap)bm, 1583, 500); /// new width, height
                bm.Save(Server.MapPath("/Images/Categories/" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + File_CatImage.FileName));
                //File_CatImage.PostedFile.SaveAs(Server.MapPath("/Images/Categories/" + DateTime.Now.ToString("yyyyMMdd_HHmmss") + File_CatImage.FileName));

            }
            DropDownList_CatParents.DataBind();
            DropDownList_CatParents.Items.Insert(0, new ListItem("اختر", "-1"));
            txt_AddName.Text = "";
        }
        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('تم إضافة التصنيف')", true);
    }

    protected void btn_DeleteCatPhoto_Click(object sender, EventArgs e)
    {
        String CatID = null;
        if (Request.QueryString["ID"] != null)
        {
            CatID = General.b64decode(Request.QueryString["ID"]);
        }
        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection Conn = new SqlConnection(con))
        {

            SqlCommand cmd = new SqlCommand("dbo.DeleteCategoryPhoto", Conn);
            //Conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ID", CatID);
            Conn.Open();
            cmd.ExecuteNonQuery();
            Conn.Close();


        }
        img_CatImg.Visible = false;
        btn_DeleteCatPhoto.Visible = false;
        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('تم مسح الصورة')", true);
    }

}