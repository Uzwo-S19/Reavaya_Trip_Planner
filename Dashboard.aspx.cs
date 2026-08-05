using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var userData = (Dictionary<string, string>)Session["user_data"];

            string name = userData["user_name"];
            welcome.InnerHtml = "Hi <span>" + name + "</span>, Welcome to Rea Vaya";
        }
    }
}