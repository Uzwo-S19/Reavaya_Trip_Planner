using System;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.UI;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Web.Services;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace ReavayaWebNew
{
    public partial class Transactions : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                TransactionsGridView.DataSource = null;
                TransactionsGridView.DataBind();
            }
        }

        protected void FetchTransactionsButton_Click(object sender, EventArgs e)
        {
            try
            {
                string selectedDate = selectedDateInput.Text;
                var dayTransactions = FetchTransactionsForDate(selectedDate);

                int[,] matrix = new int[1, 3]; // 1 day, 3 time periods

                // Process the transactions to update the heatmap matrix
                foreach (var transaction in dayTransactions)
                {
                    string timePeriod = transaction.TimePeriod;
                    int points = transaction.TotalPoints;

                    // Update the heatmap matrix based on the time period
                    if (timePeriod == "Morning")
                        matrix[0, 0] += points;
                    else if (timePeriod == "Afternoon")
                        matrix[0, 1] += points;
                    else if (timePeriod == "Evening")
                        matrix[0, 2] += points;
                }

                // Serialize the matrix and store it in the HiddenField
                string jsonMatrix = JsonConvert.SerializeObject(matrix);
                HiddenFieldForTransactions.Value = jsonMatrix;

                // Bind the transactions to the GridView
                TransactionsGridView.DataSource = dayTransactions;
                TransactionsGridView.DataBind();
            }
            catch (Exception ex)
            {
                // Handle error: Exception while fetching data
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        [WebMethod]
        public static List<Transaction> FetchTransactionsForDate(string selectedDate)
        {
            using (HttpClient client = new HttpClient())
            {
                try
                {
                    string formattedDate = DateTime.Parse(selectedDate).ToString("yyyy-MM-dd");
                    var url = $"http://localhost:8080/api_reavaya/user/displayTransaction.php?selected_date={formattedDate}";
                    var response = client.GetAsync(url).Result;
                    var jsonResponse = response.Content.ReadAsStringAsync().Result;

                    if (response.IsSuccessStatusCode)
                    {
                        Console.WriteLine(jsonResponse);
                        var transactions = JsonConvert.DeserializeObject<List<Transaction>>(JObject.Parse(jsonResponse)["data"].ToString());
                        return transactions;
                    }
                    else
                    {
                        // Handle error: non-success status code
                        // You can log the jsonResponse to see the error message returned by the API
                        return new List<Transaction>(); // return an empty list if the fetch failed
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Exception: " + ex.Message);
                    // Handle error: exception while making the request
                    // Log the exception message: ex.Message
                    return new List<Transaction>(); // return an empty list if there was an exception
                }
            }
        }

        protected void GeneratePDFReport_Click(object sender, EventArgs e)
        {
            // Create a new document
            iTextSharp.text.Document document = new iTextSharp.text.Document();
            MemoryStream memoryStream = new MemoryStream();

            // Create a PDF writer to write to the memory stream
            PdfWriter writer = PdfWriter.GetInstance(document, memoryStream);

            // Open the document for writing
            document.Open();

            // Create a paragraph for the report title
            iTextSharp.text.Paragraph title = new iTextSharp.text.Paragraph();
            title.Alignment = Element.ALIGN_CENTER; // Center-align the text

            // Create a font for the title with blue color and bold style
            iTextSharp.text.Font titleFont = new iTextSharp.text.Font(FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 24, BaseColor.BLUE));
            title.Add(new Chunk("Point Purchase Report", titleFont));

            // Add the title to the document
            document.Add(title);

            // Add an empty line
            document.Add(new iTextSharp.text.Paragraph(""));

            // Add your statistics to the PDF
            document.Add(new iTextSharp.text.Paragraph("Total Revenue: R" + CalculateTotalRevenue()));
            document.Add(new iTextSharp.text.Paragraph("Number of Transactions: " + GetTransactionCount()));
            document.Add(new iTextSharp.text.Paragraph("Average Transaction Value: R" + CalculateAverageTransactionValue()));

            // Close the document
            document.Close();

            // Create a response to download the PDF
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-disposition", "attachment;filename=PointPurchaseReport.pdf");
            Response.OutputStream.Write(memoryStream.GetBuffer(), 0, memoryStream.GetBuffer().Length);
            Response.OutputStream.Flush();
            Response.OutputStream.Close();
            Response.End();
        }

        // Helper functions to calculate statistics
        private decimal CalculateTotalRevenue()
        {
            // Implement your logic to calculate total revenue here
            decimal totalRevenue = 1408345; // Replace with your actual calculation
            return totalRevenue;
        }

        private int GetTransactionCount()
        {
            // Implement your logic to get the transaction count here
            int transactionCount = 600000; // Replace with your actual count
            return transactionCount;
        }

        private decimal CalculateAverageTransactionValue()
        {
            // Implement your logic to calculate average transaction value here
            decimal averageTransactionValue = 350432; // Replace with your actual calculation
            return averageTransactionValue;
        }

        public class Transaction
        {
            public int User_ID { get; set; }
            public int TotalPoints { get; set; }
            public string TimeStamp { get; set; }
            public string TimePeriod { get; set; }
        }
    }
}
