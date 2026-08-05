using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace ReavayaWebNew
{
    public partial class bus_ScheduleOperations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnDeleteSchedule_Click(object sender, EventArgs e)
        {
            // Get the schedule ID to delete
            int scheduleIdToDelete;
            if (int.TryParse(deleteScheduleId.Text, out scheduleIdToDelete))
            {
                // Perform the delete operation using the scheduleIdToDelete
                string connectionString = "Data Source=YourServerName;Initial Catalog=reavaya_app;Integrated Security=True";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    try
                    {
                        connection.Open();
                        string deleteQuery = "DELETE FROM bus WHERE busId = @ScheduleId";
                        using (SqlCommand cmd = new SqlCommand(deleteQuery, connection))
                        {
                            cmd.Parameters.AddWithValue("@ScheduleId", scheduleIdToDelete);
                            int rowsAffected = cmd.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Deletion successful
                                Response.Write("<script>alert('Bus schedule deleted successfully!');</script>");
                            }
                            else
                            {
                                // Deletion failed
                                Response.Write("<script>alert('Error: Bus schedule could not be deleted.');</script>");
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
            else
            {
                // Invalid input for schedule ID
                Response.Write("<script>alert('Please enter a valid schedule ID to delete.');</script>");
            }
        }

        protected void btnUpdateSchedule_Click(object sender, EventArgs e)
        {
            // Get the schedule ID and new departure time
            int scheduleIdToUpdate;
            if (int.TryParse(updateScheduleId.Text, out scheduleIdToUpdate))
            {
                string newDepartureTime = updateScheduleDeparture.Text;

                // Perform the update operation using the scheduleIdToUpdate and newDepartureTime
                string connectionString = "Data Source=YourServerName;Initial Catalog=reavaya_app;Integrated Security=True";
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    try
                    {
                        connection.Open();
                        string updateQuery = "UPDATE bus SET departure_time = @NewDepartureTime WHERE busId = @ScheduleId";
                        using (SqlCommand cmd = new SqlCommand(updateQuery, connection))
                        {
                            cmd.Parameters.AddWithValue("@ScheduleId", scheduleIdToUpdate);
                            cmd.Parameters.AddWithValue("@NewDepartureTime", newDepartureTime);
                            int rowsAffected = cmd.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Update successful
                                Response.Write("<script>alert('Bus schedule updated successfully!');</script>");
                            }
                            else
                            {
                                // Update failed
                                Response.Write("<script>alert('Error: Bus schedule could not be updated.');</script>");
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
            else
            {
                // Invalid input for schedule ID
                Response.Write("<script>alert('Please enter a valid schedule ID and new departure time to update.');</script>");
            }
        }
    }
}
