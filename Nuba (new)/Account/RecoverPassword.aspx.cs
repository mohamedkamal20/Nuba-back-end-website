using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Account_RecoverPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Recover(object sender, EventArgs e)
    {
        if (IsValid)
        {
            /*
            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            byte value = 1;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("searchForEmail", con);
                cmd.Parameters.Add("@UserName", SqlDbType.NVarChar).Value = null;
                SqlParameter output = new SqlParameter("@twoBitValue", SqlDbType.Bit);
                output.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(output);

                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.ExecuteReader();
                value = Convert.ToByte(cmd.Parameters["@twoBitValue"].Value);

            }
            */
        }
    }
    private void sendMail(String email)
    {
        MailMessage mailMessage = new MailMessage("mohamed.kamal20130214@gmail.com", email);
        Random rand = new Random();
        int password = rand.Next(111111,999999);
        mailMessage.Subject = "تغير كلمة المرور";
        mailMessage.Body = "اذا كان هناك خطأ ما يرجي الاتصال بنا من هنا" + password+"تم تغير كلمة المرور الى  ";

        SmtpClient smptClient = new SmtpClient("smtp.gmail.com", 587);
        smptClient.Credentials = new System.Net.NetworkCredential()
        {
            UserName = "",
            Password = ""
        };
        smptClient.EnableSsl = true;
        smptClient.Send(mailMessage);
    }

}