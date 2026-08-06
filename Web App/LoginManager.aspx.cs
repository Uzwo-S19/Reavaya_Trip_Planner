using System;
using System.Net.Http;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class LoginManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = Email.Text;
            string userPassword = Password.Text;

            using (HttpClient client = new HttpClient())
            {
                var values = new Dictionary<string, string>
                {
                    { "email", email },
                    { "user_password", userPassword }
                };

                var content = new FormUrlEncodedContent(values);

                var response = client.PostAsync(API.LoginManager, content).Result;

                if (response.IsSuccessStatusCode)
                {
                    string responseContent = response.Content.ReadAsStringAsync().Result;
                    var responseData = Newtonsoft.Json.JsonConvert.DeserializeObject<Dictionary<string, dynamic>>(responseContent);

                    if (responseData.ContainsKey("success") && responseData["success"] == true)
                    {
                        Session["user_id"] = responseData["user_id"];

                        var userData = new Dictionary<string, string>
                        {
                            { "user_name", responseData["userData"]["user_name"].ToString() },
                            { "surname", responseData["userData"]["surname"].ToString() },
                            { "email", responseData["userData"]["email"].ToString() },
                            { "phone_number", responseData["userData"]["phone_number"].ToString() },
                            { "manager_id", responseData["userData"]["manager_id"].ToString() },
                            { "user_password", responseData["userData"]["user_password"].ToString() },
                        };

                        Session["user_data"] = userData;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "successAlert", "alert('Logged-in successfully');", true);

                        Response.Redirect("Dashboard.aspx");
                    }
                    else
                    {
                        logError.Visible = true;
                    }
                }
                else
                {
                    logError.Visible = true;
                }
            }
        }
    }
}