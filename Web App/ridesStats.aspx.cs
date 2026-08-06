using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class ridesStats : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected async void filterButton_Click(object sender, EventArgs e)
        {
            string apiUrl = API.fetchRides; 

            string startDateStr = this.startDate.Text;
            string endDateStr = this.endDate.Text;

            using (HttpClient client = new HttpClient())
            {
                // Prepare POST data
                var postData = new List<KeyValuePair<string, string>>
                {
                    new KeyValuePair<string, string>("start_date", startDateStr),
                    new KeyValuePair<string, string>("end_date", endDateStr)
                };
                HttpContent content = new FormUrlEncodedContent(postData);

                HttpResponseMessage response = await client.PostAsync(apiUrl, content);

                if (response.IsSuccessStatusCode)
                {
                    string responseData = await response.Content.ReadAsStringAsync();

                    // Assuming your API returns a success status and a list of ride data.
                    var jsonResponse = JsonConvert.DeserializeObject<Dictionary<string, object>>(responseData);

                    if ((bool)jsonResponse["success"])
                    {
                        var rides = JsonConvert.DeserializeObject<List<RideData>>(jsonResponse["data"].ToString());
                        //JavaScriptSerializer js = new JavaScriptSerializer();
                        //string data = js.Serialize(rides);

                        // Store the data in a hidden field to be accessed in JavaScript
                        //HiddenField1.Value = data;

                        RideChart.DataSource = rides;
                        RideChart.Series["Rides"].XValueMember = "Route";
                        RideChart.Series["Rides"].YValueMembers = "frequency";
                        RideChart.DataBind();
                        tbl.Visible = true;
                        RideChart.Visible = true;
                    }
                    else
                    {
                        // Handle unsuccessful response from the API. 
                        // For simplicity, I'm just writing to the Console. You'd likely want to inform the user.
                        Console.WriteLine("Error: " + jsonResponse["message"].ToString());
                    }
                }
                else
                {
                    // Handle connection or other errors. Again, this would need better handling in a real application.
                    Console.WriteLine("Connection failed or other errors");
                }
            }

        }

        private void getChartType()
        {
            foreach (int chartType in Enum.GetValues(typeof(SeriesChartType)))
            {
                ListItem li = new ListItem(Enum.GetName(typeof(SeriesChartType), chartType));
                ddList.Items.Add(li);
            }
        }
        protected void ddList_SelectedIndexChanged(object sender, EventArgs e)
        {
            RideChart.Series["Rides"].ChartType = (SeriesChartType)Enum.Parse(typeof(SeriesChartType), ddList.SelectedValue);
        }
    }
}

public class RideData
{
    public string pickup_point { get; set; }
    public string destination { get; set; }
    public int frequency { get; set; }

    public string Route => $"{pickup_point} to {destination}";
}