using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ReavayaWebNew
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["user_id"] = null;
            Session["user_data"] = null;
            ScriptManager.RegisterStartupScript(this, this.GetType(), "successAlert", "alert('Logged-out successfully');", true);
            Response.Redirect("index.aspx");
        }
    }
}