using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



public partial class ViewArticles : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (!HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/Account/Login.aspx");
            }
            
            DropDownList_Categories.DataBind();
            DropDownList_Categories.Items.Insert(0, new ListItem(" اختر التصنيف", "-1"));
            
        }

        ArticlesList.DataBind();
        if (ArticlesList.Items.Count == 0)
        {
            div_show.Visible = false;
        }
        else
        {
            div_show.Visible = true;
        }
        ArticlesList.DataBind();
        hideNullImage();
    }

    protected void ArticlesList_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void DataPagerProducts_PreRender(object sender, EventArgs e)
    {
        hideNullImage();
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
        ArticlesList.DataBind();
        DropDownList_Categories.DataBind();
        this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('تم مسح المقال')", true);

    }





    protected void edit(object sender, EventArgs e)
    {
        
        Response.Redirect("EditArticles.aspx?artID="+(General.b64encode(((Button)sender).CommandArgument)));
    }
    protected void hideNullImage()
    {
        for (int i = 0; i < ArticlesList.Items.Count; i++)
        {
            if (((Label)ArticlesList.Items[i].FindControl("lbl1")).Text=="")
            {
                ((Image)ArticlesList.Items[i].FindControl("MainImg")).Visible = false;
            }
            else
            {
                ((Image)ArticlesList.Items[i].FindControl("MainImg")).Visible = true;
            }
        }
    }

    
}