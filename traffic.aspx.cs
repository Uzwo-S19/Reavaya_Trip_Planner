using System;
using System.Net.Http;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace ReavayaWebNew
{
    public partial class traffic : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                regPassengers();
            }
        }

        protected void FilterTrafficData_Click(object sender, EventArgs e)
        {
            using (HttpClient client = new HttpClient())
            {
                string apiUrl = API.loginCounter;

                string startDate = this.startDate.Text;
                string endDate = this.endDate.Text;

                apiUrl += $"?startDate={startDate}&endDate={endDate}";

                HttpResponseMessage response = client.GetAsync(apiUrl).Result;

                if (response.IsSuccessStatusCode)
                {
                    string responseData = response.Content.ReadAsStringAsync().Result;
                    Dictionary<string, dynamic> responseDataJson = JsonConvert.DeserializeObject<Dictionary<string, dynamic>>(responseData);

                    if (responseDataJson.ContainsKey("success") && responseDataJson["success"])
                    {
                        if (responseDataJson.ContainsKey("count"))
                        {
                            int loginCount = Convert.ToInt32(responseDataJson["count"]);
                            loginCountLiteral.Text = loginCount.ToString();

                            int registeredPassengersCount = Convert.ToInt32(registeredPassengersLiteral.Text);
                            double loginPercentage = (double)loginCount / registeredPassengersCount * 100;
                            string dis = "<span>" + loginPercentage.ToString("0.##") + "%</span><h2>Logins over Registered Passengers Percentage</h2>";

                            if (!string.IsNullOrEmpty(startDate) && !string.IsNullOrEmpty(endDate))
                            {
                                dis += $"<p>The percentage number of logins over registered passengers from {startDate} to {endDate} is {loginPercentage.ToString("0.##")}%. This means that {loginCount} out of the {registeredPassengersCount} registered passengers logged in to the Rea Vaya App.</p>";
                            }
                            else
                            {
                                dis += $"<p>The overall percentage number of logins over registered passengers is {loginPercentage.ToString("0.##")}%. This means that {loginCount} out of the {registeredPassengersCount} registered passengers logged in to the Rea Vaya App.</p>";
                            }

                            text.InnerHtml = dis;
                        }
                    }
                    else
                    {
                        Console.WriteLine("Unsuccessful response");
                    }
                }
                else
                {
                    Console.WriteLine("Connection failed or other errors");
                }
            }
        }


        private void regPassengers()
        {
            using (HttpClient client = new HttpClient())
            {
                string apiUrl = API.getRegisteredPassengers;

                HttpResponseMessage response = client.GetAsync(apiUrl).Result;

                if (response.IsSuccessStatusCode)
                {
                    string responseData = response.Content.ReadAsStringAsync().Result;
                    Dictionary<string, dynamic> responseDataJson = JsonConvert.DeserializeObject<Dictionary<string, dynamic>>(responseData);

                    if (responseDataJson.ContainsKey("success") && responseDataJson["success"])
                    {
                        if (responseDataJson.ContainsKey("count"))
                        {
                            int regCount = Convert.ToInt32(responseDataJson["count"]);
                            registeredPassengersLiteral.Text = regCount.ToString();
                        }
                    }
                    else
                    {
                        // Handle unsuccessful response
                        Console.WriteLine("Unsuccessful response");
                    }
                }
                else
                {
                    // Connection failed or other errors
                    // Display error message or handle as needed
                    Console.WriteLine("Connection failed or other errors");
                }
            }
        }
    }
}
