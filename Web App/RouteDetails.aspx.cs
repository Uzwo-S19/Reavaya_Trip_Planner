using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class RouteDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["fare"] != null)
            {
                string display1;
                double fare2 = Convert.ToDouble(Request.QueryString["fare"]);

                display1 = "<b>Fare: " + fare2 + " points</b>";
                fare.InnerHtml = display1;

                string display2;
                string routeImgUrl = Request.QueryString["routeImg"];

                display2 = "<img src='" + routeImgUrl + "'>";
                map.InnerHtml = display2;
            }
        }
    }
}