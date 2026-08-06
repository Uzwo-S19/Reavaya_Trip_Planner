using ReavayaWebNew.ServiceReference1;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class TripPlanner : System.Web.UI.Page
    {
        Service1Client sr = new Service1Client();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRoute_Click(object sender, EventArgs e)
        {
            Route route = sr.getRoute(initLoc.Text, destLoc.Text, DateTime.Parse(date.Text+" "+time.Text));


            if (route != null)
            {
                //Session["route"] = route;
                Response.Redirect("RouteDetails.aspx?fare=" + route.Price + "&routeImg=" + route.RoutePicture);
            }
            else
            {
                Response.Redirect("404Error.aspx");
            }
        }
    }
}