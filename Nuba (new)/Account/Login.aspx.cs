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

public partial class Account_Login : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


    }

    protected void LogIn(object sender, EventArgs e)
    {

        if (IsValid)
        {
            // Validate the user password
            var manager = new UserManager();
            ApplicationUser user = manager.Find(UserName.Text, Password.Text);
            if (user != null)
            {
                string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                byte value = 1;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("getTwoBitLockField", con);
                    cmd.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = user.UserName;
                    SqlParameter output = new SqlParameter("@twoBitValue", SqlDbType.Bit);
                    output.Direction = ParameterDirection.Output;
                    cmd.Parameters.Add(output);

                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    cmd.ExecuteReader();
                    value = Convert.ToByte(cmd.Parameters["@twoBitValue"].Value);

                }
                if (value == 1)
                {
                    Response.Redirect("AccessDenied.aspx");
                }
                else
                {
                    IdentityHelper.SignIn(manager, user, RememberMe.Checked);
                    //Response.Redirect("Home.aspx");
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }

            }
            /*
            else
            {
                FailureText.Text = "Invalid username or password.";
                ErrorMessage.Visible = true;
            }
            */
        }

    }


}