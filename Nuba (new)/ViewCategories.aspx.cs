using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewCategories : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!HttpContext.Current.User.Identity.IsAuthenticated)
        {
            Response.Redirect("~/Account/Login.aspx");
        }
        CategoriesList.DataBind();
        hideNullINList();
    }

    protected void hideNullINList()
    {
        for (int i = 0; i < CategoriesList.Items.Count; i++)
        {
            if (((Label)CategoriesList.Items[i].FindControl("lbl2")).Text == "" || ((Label)CategoriesList.Items[i].FindControl("lbl2")).Text == null)
            {
                ((System.Web.UI.WebControls.Image)CategoriesList.Items[i].FindControl("img")).Visible = false;
            }
            else
            {
                ((System.Web.UI.WebControls.Image)CategoriesList.Items[i].FindControl("img")).Visible = true;
            }
            if (((Label)CategoriesList.Items[i].FindControl("lbl1")).Text == "" || ((Label)CategoriesList.Items[i].FindControl("lbl1")).Text == null )
            {
                ((Label)CategoriesList.Items[i].FindControl("lbl_Parent")).Visible = false;
                ((Label)CategoriesList.Items[i].FindControl("Label")).Visible = false;
            }
            else
            {
                ((Label)CategoriesList.Items[i].FindControl("lbl_Parent")).Visible = true;
                ((Label)CategoriesList.Items[i].FindControl("Label")).Visible = true;
            }
        }
    }
    protected void DataPagerProducts_PreRender(object sender, EventArgs e)
    {
        hideNullINList();
    }
    protected void btn_Delete_Click(object sender, EventArgs e)
    {
        string con = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        SqlDataReader rd;
        using (SqlConnection Con = new SqlConnection(con))
        {

            SqlCommand cmd = new SqlCommand("dbo.checkChilds", Con);
            //Conn.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ID", ((System.Web.UI.WebControls.Button)sender).CommandArgument);
            Con.Open();
            rd = cmd.ExecuteReader();
            if (rd.Read())
            {
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('لا يمكنك مسح هذا التصنيف حيث انه تصنيف رئيسى يحتوى على عدة تصنيفات فرعية')", true);
            }

            else
            {
                using (SqlConnection Conn = new SqlConnection(con))
                {

                    cmd = new SqlCommand("dbo.getCat_Articles", Conn);
                    //Conn.Open();
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Cat_ID", ((System.Web.UI.WebControls.Button)sender).CommandArgument);
                    Conn.Open();
                    rd = cmd.ExecuteReader();
                    if (rd.Read())
                    {
                        ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:Confirm(); ", true);
                        ((System.Web.UI.WebControls.Button)sender).OnClientClick = "Confirm()";
                        string confirmValue = Request.Form["confirm_value"];
                        
                        if (confirmValue == "نعم")
                        {
                            using (SqlConnection connection = new SqlConnection(con))
                            {

                                cmd = new SqlCommand("dbo.DeleteCategory", connection);
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@ID", ((System.Web.UI.WebControls.Button)sender).CommandArgument);
                                connection.Open();
                                cmd.ExecuteNonQuery();
                                connection.Close();
                            }
                            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('تم مسح التصنيف')", true);

                        }
                        else
                        {
                            this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('تم الغاء المسح')", true);

                        }
                    }
                    else
                    {
                        using (SqlConnection Conn1 = new SqlConnection(con))
                        {

                            cmd = new SqlCommand("dbo.DeleteCategory", Conn1);
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@ID", ((System.Web.UI.WebControls.Button)sender).CommandArgument);
                            Conn1.Open();
                            cmd.ExecuteNonQuery();
                            Conn1.Close();

                        }
                    }
                    rd.Close();
                    Conn.Close();
                }
            }
            Con.Close();
        }

        CategoriesList.DataBind();
        hideNullINList();
    }
  
    protected void btn_Edit_Click(object sender, EventArgs e)
    {
        Response.Redirect("Categories.aspx?ID=" + General.b64encode(((System.Web.UI.WebControls.Button)sender).CommandArgument));
    }

}