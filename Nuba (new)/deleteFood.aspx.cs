using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class deleteFood : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (HttpContext.Current.User.Identity.IsAuthenticated)
        {
            if (!IsPostBack)
            {
                DropDownListCategory.DataSource = getData("getCategoriesNameAndId", null);
                DropDownListCategory.DataBind();

                ListItem liCategory = new ListItem("اختر تصنيف", "-1");
                DropDownListCategory.Items.Insert(0, liCategory);

                ListItem liFood = new ListItem("اختر الطعام", "-1");
                DropDownListFood.Items.Insert(0, liFood);

                DropDownListFood.Enabled = false;
            }
        }
        else
        {
            Response.Redirect("Account//Login.aspx");
        }
    }
    private DataSet getData(String spName, SqlParameter input)
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        SqlConnection con = new SqlConnection(cs);
        SqlDataAdapter da = new SqlDataAdapter(spName, con);
        da.SelectCommand.CommandType = CommandType.StoredProcedure;

        if (input != null)
        {
            da.SelectCommand.Parameters.Add(input);
        }

        DataSet DS = new DataSet();
        da.Fill(DS);

        return DS;
    }
    protected void DropDownListCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownListCategory.SelectedIndex == 0)
        {
            DropDownListFood.SelectedIndex = 0;
            DropDownListFood.Enabled = false;
            DropDownListFood.Visible = false;
            ButtonDelete.Visible = false;
        }
        else
        {

            DropDownListFood.Visible = true;
            ButtonDelete.Visible = true;
            DropDownListFood.Enabled = true;
            SqlParameter input = new SqlParameter("@Cat_ID", DropDownListCategory.SelectedValue);
            DataSet DS = new DataSet();
            DS = getData("getFoodsByCategoryID", input);
            DropDownListFood.DataSource = DS;
            DropDownListFood.DataBind();

            ListItem liFood = new ListItem("اختر الطعام", "-1");
            DropDownListFood.Items.Insert(0, liFood);

        }
    }
    protected void ButtonDelete_Click(object sender, EventArgs e)
    {
        if (DropDownListFood.SelectedIndex != 0)
        {
            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("deleteFoodByID", con);
                cmd.Parameters.Add("@ID", SqlDbType.Int).Value = int.Parse(DropDownListFood.SelectedValue);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                if (cmd.ExecuteNonQuery() == 1)
                {
                    Response.Redirect(Request.Url.PathAndQuery, true);
                }
                con.Close();
            }
        }
    }
}