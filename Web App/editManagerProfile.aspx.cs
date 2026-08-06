using System;
using System.Net.Http;
using QRCoder;
using System.Drawing;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace ReavayaWebNew
{
    public partial class editManagerProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserProfile();
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (Password.Text.Equals(CPassword.Text))
            {
                var userData = (Dictionary<string, string>)Session["user_data"];
                bool isNameValid = ValidateAlphabeticInput(FirstName.Text);
                bool isSurnameValid = ValidateAlphabeticInput(Surname.Text);
                bool isPhoneNumberValid = ValidatePhoneNumber(PhoneNumbers.Text);
                bool isPasswordValid = ValidatePassword(Password.Text);

                if (userData["email"] == Email.Text)
                {
                    if (isNameValid && isSurnameValid && isPhoneNumberValid && isPasswordValid)
                    {
                        UpdateUserProfile();
                    }
                    else
                    {
                        if (!isNameValid)
                        {
                            nameErr.Visible = true;
                        }
                        if (!isSurnameValid)
                        {
                            surErr.Visible = true;
                        }
                        if (!isPhoneNumberValid)
                        {
                            phoneErr.Visible = true;
                        }
                        if (!isPasswordValid)
                        {
                            passEr1.Visible = false;
                            passEr.Visible = true;
                        }
                    }
                }
                else
                {
                    bool isEmailValid = ValidateUserEmail(Email.Text);
                    if (isEmailValid && isNameValid && isSurnameValid && isPhoneNumberValid && isPasswordValid)
                    {
                        UpdateUserProfile();
                    }
                    else
                    {
                        if (!isEmailValid)
                        {
                            ErrorEmail.Visible = true;
                        }
                        if (!isNameValid)
                        {
                            nameErr.Visible = true;
                        }
                        if (!isSurnameValid)
                        {
                            surErr.Visible = true;
                        }
                        if (!isPhoneNumberValid)
                        {
                            phoneErr.Visible = true;
                        }
                        if (!isPasswordValid)
                        {
                            passEr1.Visible = false;
                            passEr.Visible = true;
                        }
                    }
                }
            }
            else
            {
                ErrorPW.Visible = true;
            }
        }

        private void LoadUserProfile()
        {
            var userData = (Dictionary<string, string>)Session["user_data"];

            FirstName.Text = userData["user_name"];
            Surname.Text = userData["surname"];
            Email.Text = userData["email"];
            PhoneNumbers.Text = userData["phone_number"];
        }

        private void UpdateUserProfile()
        {
            string userId = Session["user_id"].ToString();
            var userData = (Dictionary<string, string>)Session["user_data"];

            using (HttpClient client = new HttpClient())
            {
                var values = new Dictionary<string, string>
                {
                    { "user_id", userId },
                    { "user_name", FirstName.Text },
                    { "surname", Surname.Text },
                    { "email", Email.Text },
                    { "phone_number", PhoneNumbers.Text },
                    { "qr_code", GenerateQRCodeString(FirstName.Text, Surname.Text, Email.Text, PhoneNumbers.Text, userData["manager_id"]) },
                    { "user_password", Password.Text },
                };

                var content = new FormUrlEncodedContent(values);

                var response = client.PostAsync(API.UpdateAccountManager, content).Result;

                if (response.IsSuccessStatusCode)
                {
                    string responseContent = response.Content.ReadAsStringAsync().Result;
                    var responseData = JsonConvert.DeserializeObject<Dictionary<string, dynamic>>(responseContent);

                    if (responseData.ContainsKey("success") && responseData["success"] == true)
                    {
                        var Data = new Dictionary<string, string>
                        {
                            { "user_name", responseData["userData"]["user_name"].ToString() },
                            { "surname", responseData["userData"]["surname"].ToString() },
                            { "email", responseData["userData"]["email"].ToString() },
                            { "phone_number", responseData["userData"]["phone_number"].ToString() },
                            { "user_password", responseData["userData"]["user_password"].ToString() },
                        };

                        Session["user_data"] = Data;
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "successAlert", "alert('Updated account successfully');", true);

                        Response.Redirect("Dashboard.aspx");
                    }
                }
                else
                {
                    Console.WriteLine("Connection failed");
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successAlert", "alert('Connection failed');", true);
                }
            }
        }

        private bool ValidateUserEmail(string email)
        {
            try
            {
                using (HttpClient client = new HttpClient())
                {
                    var values = new Dictionary<string, string>
                    {
                        { "email", email }
                    };

                    var content = new FormUrlEncodedContent(values);

                    var response = client.PostAsync(API.ValidateEmailManager, content).Result;

                    if (response.IsSuccessStatusCode)
                    {
                        var responseContent = response.Content.ReadAsStringAsync().Result;
                        var resBody = JsonConvert.DeserializeObject<Dictionary<string, dynamic>>(responseContent);

                        return !(resBody.ContainsKey("emailFound") && (bool)resBody["emailFound"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"ErrorEmail:: {ex}");
            }

            return false;
        }

        private string GenerateQRCodeString(string firstName, string surname, string email, string pnumber, string managerID)
        {
            string userData = $"{firstName},{surname},{email},{pnumber},{managerID}";

            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeData qrCodeData = qrGenerator.CreateQrCode(userData, QRCodeGenerator.ECCLevel.Q);
            QRCode qrCode = new QRCode(qrCodeData);
            Bitmap qrCodeImage = qrCode.GetGraphic(10);

            using (System.IO.MemoryStream memoryStream = new System.IO.MemoryStream())
            {
                qrCodeImage.Save(memoryStream, System.Drawing.Imaging.ImageFormat.Png);
                byte[] imageBytes = memoryStream.ToArray();
                string base64Image = Convert.ToBase64String(imageBytes);
                return base64Image;
            }
        }

        private bool ValidateAlphabeticInput(string input)
        {
            return Regex.IsMatch(input, "^[a-zA-Z]+$");
        }

        private bool ValidatePhoneNumber(string input)
        {
            return Regex.IsMatch(input, "^[0-9]{10}$");
        }

        private bool ValidatePassword(string password)
        {
            return Regex.IsMatch(password, @"^(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&*()_+])[A-Za-z\d@#$%^&*()_+]{9,}$");
        }
    }
}