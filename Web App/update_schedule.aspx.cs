using System;
using System.Net;
using System.Text;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class update_schedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddSchedule_Click(object sender, EventArgs e)
        {
            // Get the values entered by the user in the form
            string busName = this.busName.Text;
            string pickupPoint = this.pickupPoint.Text;
            string destination = this.destination.Text;
            string departure = this.departure.Text;

            // Create a JSON string with the data
            string jsonPayload = $"{{\"busName\":\"{busName}\",\"pickupPoint\":\"{pickupPoint}\",\"destination\":\"{destination}\",\"departure\":\"{departure}\"}}";

            // URL of your PHP script
            string phpUrl = API.UpdateSchedule; // Replace with the actual URL

            try
            {
                // Create a WebClient instance to send the POST request
                WebClient webClient = new WebClient();

                // Set the content type to JSON
                webClient.Headers[HttpRequestHeader.ContentType] = "application/json";

                // Send the POST request and get the response
                string response = webClient.UploadString(phpUrl, "POST", jsonPayload);
                lblSuccessMessages.Text = "Schedule updated successfully!";
                lblSuccessMessages.Visible = true;
                //  clear the form fields after successful submission
               this.busName.Text = "";
                this.pickupPoint.Text = "";
                this.destination.Text = "";
                this.departure.Text = "";
                // You can handle the response here (e.g., display a message to the user)
                //     Response.Write("<script>alert('" + response + "');</script>");
            }
            catch (Exception ex)
            {
                // Handle any exceptions that occur during the request
                Response.Write("<script>alert('An error occurred: " + ex.Message + "');</script>");
            }
        }
    }
}
