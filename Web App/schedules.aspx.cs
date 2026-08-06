using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class schedules : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginStats_Click(object sender, EventArgs e)
        {
            Response.Redirect("bus_Schedule.aspx");
        }

        protected void ridesStats_Click(object sender, EventArgs e)
        {
            Response.Redirect("bus_ScheduleOperations.aspx");
        }
    }
}