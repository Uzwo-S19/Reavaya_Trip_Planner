using ReavayaWebNew.ServiceReference1;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class Buypoint : System.Web.UI.Page
    {

        Service1Client sr = new Service1Client();
        protected void Page_Load(object sender, EventArgs e)
        {

            //decimal amountIn = decimal.Parse(points.Text);

        }
        protected void Purchase_Click(object sender, EventArgs e)
        {
            //int userId = int.Parse(Request.QueryString["userID"]);
            int userId = int.Parse(Session["user_id"].ToString());
            DateTime currentDateTime = DateTime.Now;
            string dateTimeString = currentDateTime.ToString();


            decimal amountIn = decimal.Parse(points.Text);

            bool recordered = sr.RecordTransaction(userId, cardName.Text, amountIn, dateTimeString);
            Response.Redirect("Success.aspx");
        }
    }
}
