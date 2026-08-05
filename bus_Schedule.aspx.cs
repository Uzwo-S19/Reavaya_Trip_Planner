using System;
using System.Net;
using System.Text;

namespace ReavayaWebNew
{
    public partial class bus_Schedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAddSchedule_Click(object sender, EventArgs e)
        {
            // Get the values from the form
            string busNameValue = busName.Text;
            string pickupPointValue = pickupPoint.Text;
            string destinationValue = destination.Text;
            string departureValue = departure.Text;

            // Validate the input (you can add more validation as needed)
            if (string.IsNullOrEmpty(busNameValue) || string.IsNullOrEmpty(pickupPointValue) || string.IsNullOrEmpty(destinationValue) || string.IsNullOrEmpty(departureValue))
            {
                // Display an error message if any of the fields are empty
                Response.Write("<script>alert('Please fill in all required fields.');</script>");
                return;
            }

            try
            {
                // Create a WebClient instance to make a POST request to your PHP script
                using (WebClient client = new WebClient())
                {
                    // Specify the URL of your PHP script
                    //string url = "http://192.168.91.69:8080/api_reavaya/user/add_schedule.php";
                    string url = API.AddSchedule;
                    //   string url = "http://localhost/path/to/your/php/script.php"; 

                    // Create a data string to send as POST data
                    string postData = $"busName={busNameValue}&pickupPoint={pickupPointValue}&destination={destinationValue}&departure={departureValue}";

                    // Set the content type to form data
                    client.Headers[HttpRequestHeader.ContentType] = "application/x-www-form-urlencoded";

                    // Make the POST request and capture the response
                    byte[] responseBytes = client.UploadData(url, "POST", Encoding.ASCII.GetBytes(postData));

                    // Convert the response to a string
                    string responseString = Encoding.ASCII.GetString(responseBytes);

                    if (responseString == "success")
                    {
                        // Data successfully inserted
                        Response.Write("<script>alert('Bus schedule added successfully!');</script>");

                        // Optionally, you can clear the form fields after successful submission
                        busName.Text = "";
                        pickupPoint.Text = "";
                        destination.Text = "";
                        departure.Text = "";
                    }
                    else
                    {
                        // Data successfully inserted
                        lblSuccessMessage.Text = "Schedule added successfully!";
                        lblSuccessMessage.Visible = true;

                        //  clear the form fields after successful submission
                        busName.Text = "";
                        pickupPoint.Text = "";
                        destination.Text = "";
                        departure.Text = "";
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
    }
}
