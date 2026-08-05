using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class viewPastNotices : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private async Task FetchAndBindPastNotices(int managerId)
        {
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    string startDate = this.startDate.Text;
                    string endDate = this.endDate.Text;

                    string apiUrl = API.fetchNotifications + $"?manager_id={managerId}&startDate={startDate}&endDate={endDate}";

                    HttpResponseMessage response = await client.GetAsync(apiUrl);

                    if (response.IsSuccessStatusCode)
                    {
                        string responseData = await response.Content.ReadAsStringAsync();
                        var notificationsData = JsonConvert.DeserializeObject<NotificationsData>(responseData);

                        gridPastNotices.DataSource = notificationsData.Notifications;
                        gridPastNotices.DataBind();
                    }
                    else
                    {
                        StatusLabel.Text = "You have not written any notices!";
                        StatusLabel.CssClass = "error-message";
                        StatusLabel.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    StatusLabel.Text = "Error connecting to API!" + ex.Message;
                    StatusLabel.CssClass = "error-message";
                    StatusLabel.Visible = true;
                }
            }
        }

        public class NotificationsData
        {
            [JsonProperty("notificationsData")]
            public List<Notification> Notifications { get; set; }
        }

        public class Notification
        {
            public string TimeSent { get; set; }
            public string Title { get; set; }
            public string Notice { get; set; }

        }

        protected void btnPastNotices_Click(object sender, EventArgs e)
        {
            int managerId = Session["user_id"] != null ? Convert.ToInt32(Session["user_id"]) : 0;

            if (managerId > 0)
            {
                PageAsyncTask task = new PageAsyncTask(async () =>
                {
                    await FetchAndBindPastNotices(managerId);
                });

                Page.RegisterAsyncTask(task);
            }
            else
            {
                StatusLabel.Text = "You are not an authorized manager!";
                StatusLabel.CssClass = "error-message";
                StatusLabel.Visible = true;
            }
        }
    }
}

