using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



public partial class Articles : System.Web.UI.Page
{
  
    protected void Page_Load(object sender, EventArgs e)
    {
        
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login.aspx");
            }

    }

    protected void Restore(object sender, EventArgs e)
    {
        txt_NAME.Text= "";
        DropDownList_categories.DataBind();
        txt_DESC.Text = "";
    }

    protected void Save(object sender, EventArgs e)
    {
        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection Conn = new SqlConnection(con))
       {
            
            SqlCommand cmd = new SqlCommand("dbo.AddArticles", Conn);
            cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Cat_ID", DropDownList_categories.SelectedValue);
                cmd.Parameters.AddWithValue("@Art_Title", txt_NAME.Text);
                cmd.Parameters.AddWithValue("@Description", txt_DESC.Text);

                    Conn.Open();
                cmd.ExecuteNonQuery();
                Conn.Close();

            
        }
        txt_NAME.Text = "";
        DropDownList_categories.DataBind();
        txt_DESC.Text= "";
    }

    protected void Del(object sender, EventArgs e)
    {

        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection Conn = new SqlConnection(con))
        {

            SqlCommand cmd = new SqlCommand("dbo.DeleteArticles", Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ID", ((Button)sender).CommandArgument);

            Conn.Open();
            cmd.ExecuteNonQuery();
            Conn.Close();


        }
    }
    protected void ArticlesList_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void edit(object sender, EventArgs e)
    {
        Response.Redirect("EditArticles.aspx");
    }


    protected void ADDPhoto_Click(object sender, EventArgs e)
    {
        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection Conn = new SqlConnection(con))
        {

            SqlCommand cmd = new SqlCommand("dbo.AddArticles", Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Cat_ID", DropDownList_categories.SelectedValue);
            cmd.Parameters.AddWithValue("@Art_Title", txt_NAME.Text);
            cmd.Parameters.AddWithValue("@Description", txt_DESC.Text);

            Conn.Open();
            cmd.ExecuteNonQuery();
            Conn.Close();


        }
        string ARTID = null;
        using (SqlConnection Conn = new SqlConnection(con))
        {
            SqlDataReader rd;

            SqlCommand cmd = new SqlCommand("dbo.getLastArticleID", Conn);
            cmd.CommandType = CommandType.StoredProcedure;
            Conn.Open();
            rd = cmd.ExecuteReader();
            while (rd.Read())
            {
                ARTID = rd[0].ToString();
            }
            Conn.Close();

        }
        Response.Redirect("EditArticles.aspx?artID=" + General.b64encode(ARTID));
    }
}