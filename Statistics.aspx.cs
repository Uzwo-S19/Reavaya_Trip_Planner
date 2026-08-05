using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class Statistics : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginStats_Click(object sender, EventArgs e)
        {
            Response.Redirect("traffic.aspx");
        }

        protected void ridesStats_Click(object sender, EventArgs e)
        {
            Response.Redirect("ridesStats.aspx");
        }
        protected void transactionsStats_Click(object sender, EventArgs e)
        {
            Response.Redirect("Transactions.aspx");
        }
    }
}