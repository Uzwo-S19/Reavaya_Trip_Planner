using System;
using System.Web.UI;
using System.Net.Http;
using Newtonsoft.Json;
using System.Collections.Generic;

namespace ReavayaWebNew
{
    public partial class deleteAccount : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var userData = (Dictionary<string, string>)Session["user_data"];

                Email.Text = userData["email"];
            }
        }

        protected void btnDeleteAccount_Click(object sender, EventArgs e)
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    // Get email and password from the form
                    string email = Email.Text;
                    string password = Password.Text;

                    // Prepare the request content
                    var values = new Dictionary<string, string>
                    {
                        { "email", email },
                        { "user_password", password }
                    };

                    var content = new FormUrlEncodedContent(values);

                    var response = client.PostAsync(API.deleteAccount, content).Result;

                    if (response.IsSuccessStatusCode)
                    {
                        // Handle success or display appropriate message
                        string responseContent = response.Content.ReadAsStringAsync().Result;
                        var responseData = JsonConvert.DeserializeObject<Dictionary<string, dynamic>>(responseContent);

                        if (responseData.ContainsKey("success") && responseData["success"] == true)
                        {
                            Session["user_id"] = null;
                            Session["user_data"] = null;
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "successAlert", "alert('Account deleted successfully');", true);
                            Response.Redirect("index.aspx");
                        }
                        else
                        {
                            // Handle failure or display appropriate message
                            delError.Visible = true;
                        }
                    }
                    else
                    {
                        // Handle failure or display appropriate message
                        Console.WriteLine("Connection failed");
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "successAlert", "alert('Connection failed');", true);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex}");
                // Display error message or handle as needed
            }
        }
    }
}
