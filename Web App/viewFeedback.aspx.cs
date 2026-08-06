using System;
using System.Collections.Generic;
using System.Net.Http;
using Newtonsoft.Json;

namespace ReavayaWebNew
{
    public partial class viewFeedback : System.Web.UI.Page
    {
        private FeedbackData feedbackData;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeedbackData();
            }
        }

        protected void LoadFeedbackData()
        {
            string apiUrl = API.viewFeedback;

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    HttpResponseMessage response = client.GetAsync(apiUrl).Result;

                    if (response.IsSuccessStatusCode)
                    {
                        string responseData = response.Content.ReadAsStringAsync().Result;
                        feedbackData = JsonConvert.DeserializeObject<FeedbackData>(responseData);

                        if (feedbackData?.Feedback != null && feedbackData.Feedback.Count > 0)
                        {
                            gridFeedback.DataSource = feedbackData.Feedback;
                            gridFeedback.DataBind();
                            /*totalFeedbackLabel.Text = $"Total Feedbacks: {feedbackData.Feedback.Count}";
                            cleanlinessAverageLabel.Text = $"Average Cleanliness Rating: {feedbackData.CleanlinessAverage:F2}";
                            driverAverageLabel.Text = $"Average Driver Rating: {feedbackData.DriverAverage:F2}";*/
                        }
                        else
                        {
                            StatusLabel.Text = "There are no passenger feedbacks on the selected dates!";
                            StatusLabel.CssClass = "error-message";
                            StatusLabel.Visible = true;
                        }

                        // Call the JavaScript function to draw the chart
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "DrawRatingChart", $"drawRatingChart({GetChartDataForChart()});", true);
                    }
                    else
                    {
                        StatusLabel.Text = "Failed to retrieve feedback data. Please try again later.";
                        StatusLabel.CssClass = "error-message";
                        StatusLabel.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex);
                }
            }
        }

        private string GetChartDataForChart()
        {
            List<Tuple<string, double>> chartData = new List<Tuple<string, double>>();
            chartData.Add(new Tuple<string, double>("Cleanliness", feedbackData.CleanlinessAverage));
            chartData.Add(new Tuple<string, double>("Driver", feedbackData.DriverAverage));
            return JsonConvert.SerializeObject(chartData);
        }

        public class FeedbackData
        {
            [JsonProperty("feedbackData")]
            public List<Feedback> Feedback { get; set; }

            // Average cleanliness and driver ratings
            [JsonProperty("cleanlinessAverage")]
            public double CleanlinessAverage { get; set; }

            [JsonProperty("driverAverage")]
            public double DriverAverage { get; set; }
        }

        protected void btnFeedback_Click(object sender, EventArgs e)
        {
            string startDate = this.startDate.Text;
            string endDate = this.endDate.Text;

            string apiUrl = API.viewFeedback + $"?startDate={startDate}&endDate={endDate}";

            using (HttpClient client = new HttpClient())
            {
                try
                {
                    HttpResponseMessage response = client.GetAsync(apiUrl).Result;

                    if (response.IsSuccessStatusCode)
                    {
                        string responseData = response.Content.ReadAsStringAsync().Result;
                        feedbackData = JsonConvert.DeserializeObject<FeedbackData>(responseData);

                        if (feedbackData?.Feedback != null && feedbackData.Feedback.Count > 0)
                        {
                            gridFeedback.DataSource = feedbackData.Feedback;
                            gridFeedback.DataBind();
                            //totalFeedbackLabel.Text = $"Total Feedbacks: {feedbackData.Feedback.Count}";
                            //cleanlinessAverageLabel.Text = $"Average Cleanliness Rating: {feedbackData.CleanlinessAverage:F2}";
                            //driverAverageLabel.Text = $"Average Driver Rating: {feedbackData.DriverAverage:F2}";
                        }
                        else
                        {
                            StatusLabel.Text = "There are no passenger feedbacks on the selected dates!";
                            StatusLabel.CssClass = "error-message";
                            StatusLabel.Visible = true;
                        }

                        // Call the JavaScript function to draw the chart
                        Page.ClientScript.RegisterStartupScript(this.GetType(), "DrawRatingChart", $"drawRatingChart({GetChartDataForChart()});", true);
                    }
                    else
                    {
                        StatusLabel.Text = "Failed to retrieve feedback data. Please try again later.";
                        StatusLabel.CssClass = "error-message";
                        StatusLabel.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex);
                }
            }
        }

        public class Feedback
        {
            public string Buscode { get; set; }
            public int Cleanliness { get; set; }
            public string Driver { get; set; }
            public string Comments { get; set; }
            public DateTime TimeSent { get; set; }
        }
    }
}
