using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Http;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class addNotices : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /*protected async Task<List<string>> FetchUserEmailsAsync()
        {
            List<string> recipientEmails = new List<string>();

            try
            {
                using (HttpClient client = new HttpClient())
                {
                    var response = await client.GetAsync(API.FetchUserData);

                    if (response.IsSuccessStatusCode)
                    {
                        var responseContent = await response.Content.ReadAsStringAsync();
                        var data = JsonConvert.DeserializeObject<List<Dictionary<string, string>>>(responseContent);

                        recipientEmails = data.Select(item => item["email"]).ToList();
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex}");
                // Display error message or handle as needed
            }

            return recipientEmails;
        }

        protected async void SendEmailAsync(List<string> recipientEmails, string subject, string message)
        {
            try
            {
                // Retrieve user data from session
                var userData = (Dictionary<string, string>)Session["user_data"];

                // Configure SMTP settings
                SmtpClient smtpClient = new SmtpClient("smtp.gmail.com")
                {
                    Port = 587,
                    Credentials = new NetworkCredential(userData["email"], userData["user_password"]),
                    EnableSsl = true
                };

                // Create an email message
                MailMessage mailMessage = new MailMessage
                {
                    From = new MailAddress(userData["email"], userData["user_name"]),
                    Subject = subject,
                    Body = message,
                    IsBodyHtml = true
                };

                // Add recipients
                foreach (string recipientEmail in recipientEmails)
                {
                    mailMessage.To.Add(recipientEmail);
                }

                // Send the email
                await smtpClient.SendMailAsync(mailMessage);

                // Display success message
                Console.WriteLine("Emails sent successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Failed to send emails: {ex}");
                // Display error message or handle as needed
            }
        }*/

        protected void btnAddNotice_Click(object sender, EventArgs e)
        {
            int manager_id = int.Parse(Session["user_id"].ToString());
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    var values = new Dictionary<string, string>
                    {
                        { "manager_id", manager_id.ToString() },
                        { "title", titleNotice.Text },
                        { "notice", Notice.Value },
                        //{ "timesent", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") },
                    };

                    var content = new FormUrlEncodedContent(values);
                    var response = client.PostAsync(API.notifications, content).Result;


                    if (response.IsSuccessStatusCode)
                    {
                        // Notice submitted successfully
                        // You might want to display a success message or handle as needed
                        //Response.Redirect("Dashboard.aspx");

                        // Display success message and redirect
                        StatusLabel.Text = "Notification sent successfully!";
                        StatusLabel.CssClass = "success-message";
                        StatusLabel.Visible = true;
                    }
                    else
                    {
                        // Error submitting notice
                        // You might want to display an error message or handle as needed
                        Console.WriteLine("Connection failed");
                        // Error submitting notice
                        // You might want to display an error message or handle as needed
                        StatusLabel.Text = "Failed to send notification!";
                        StatusLabel.CssClass = "error-message";
                        StatusLabel.Visible = true;
                    }
                    // Disposing the HttpClient instance properly
                    client.Dispose();
                }
                
            }
            catch (Exception ex)
            {
                StatusLabel.Text = $"Failed to submit notice: {ex}";
                StatusLabel.CssClass = "error-message";
                StatusLabel.Visible = true;
                Console.WriteLine($"Failed to submit notice: {ex}");
                // Display error message or handle as needed
            }
        }
    }
}
