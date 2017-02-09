using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;

public partial class Account_Admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string value = "";
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("getUserRole", con);
                cmd.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = User.Identity.Name;
                SqlParameter output = new SqlParameter("@role", SqlDbType.NVarChar);
                output.Direction = ParameterDirection.Output;
                output.Size = 50;
                cmd.Parameters.Add(output);

                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.ExecuteReader();
                value = cmd.Parameters["@role"].Value.ToString();
            }
            if (value == "Admin")
            {
                getData();
            }
            else
            {
                Response.Redirect("AccessDenied.aspx");
            }

        }
    }
    private void getData()
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("getAllUserAccounts", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            GridViewAdmin.DataSource = cmd.ExecuteReader();
            GridViewAdmin.DataBind();

        }
    }
    private void updateUserEnableBit(String userName)
    {
        string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand("updateUserEnableBit", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter ParameterUserName = new SqlParameter()
            {
                ParameterName = "@UserName",
                Value = userName
            };
            cmd.Parameters.Add(ParameterUserName);
            con.Open();
            cmd.ExecuteNonQuery();

        }
    }

    protected void GridViewAdmin_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //sendMail();
        updateUserEnableBit(e.CommandArgument.ToString());
        getData();
    }

    private void sendMail()
    {
        MailMessage mailMessage = new MailMessage("mohamed.kamal20130214@gmail.com", "mohamed.kamal20130214@gmail.com");
        mailMessage.Subject = "testFunction";
        mailMessage.Body = "hello :D :p";

        SmtpClient smptClient = new SmtpClient("smtp.gmail.com", 587);
        smptClient.Credentials = new System.Net.NetworkCredential()
        {
            UserName = "mohamed.kamal20130214@gmail.com",
            Password = "Test12345"
        };
        smptClient.EnableSsl = true;
        smptClient.Send(mailMessage);
    }
}