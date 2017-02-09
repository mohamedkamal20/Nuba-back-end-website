using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using Nuba;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI.WebControls;

public partial class Account_Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void CreateUser_Click(object sender, EventArgs e)
    {
        var manager = new UserManager();
        var user = new ApplicationUser() { UserName = UserName2.Text };
        IdentityResult result = manager.Create(user, Password2.Text);
        if (result.Succeeded)
        {
            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("addUserRole", con);
                cmd.Parameters.Add("@ID", SqlDbType.NVarChar).Value = user.Id;
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.ExecuteNonQuery();
            }
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("updateUserEnableBit", con);
                cmd.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = user.UserName;
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.ExecuteNonQuery();
            }
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("addEmailToUser", con);
                cmd.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = user.UserName;
                cmd.Parameters.Add("@Email", SqlDbType.NVarChar).Value = Email2.Text;
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.ExecuteNonQuery();
            }
            Response.Redirect("newRegisteration.aspx");
            //IdentityHelper.SignIn(manager, user, isPersistent: false);
            //IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
        }
        /*
        else
        {
            ErrorMessage.Text = result.Errors.FirstOrDefault();
        }
        */
    }
}