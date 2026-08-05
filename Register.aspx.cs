using System;
using System.Drawing;
using QRCoder;
using System.Net.Http;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using System.Text.RegularExpressions;

namespace ReavayaWebNew
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Password.Text.Equals(CPassword.Text))
            {
                bool isEmailValid = ValidateUserEmail(Email.Text);
                bool isNameValid = ValidateAlphabeticInput(FirstName.Text);
                bool isSurnameValid = ValidateAlphabeticInput(Surname.Text);
                bool isPhoneNumberValid = ValidatePhoneNumber(PhoneNumbers.Text);
                bool isAgeValid = ValidateAge(Age.Text);
                bool isPasswordValid = ValidatePassword(Password.Text);

                if (isEmailValid && isNameValid && isSurnameValid && isPhoneNumberValid && isAgeValid && isPasswordValid)
                {
                    try
                    {
                        using (HttpClient client = new HttpClient())
                        {
                            var values = new Dictionary<string, string>
                            {
                                { "email", Email.Text }
                            };

                            var content = new FormUrlEncodedContent(values);

                            var response = client.PostAsync(API.ValidateEmail, content).Result;

                            if (response.IsSuccessStatusCode)
                            {
                                var responseContent = response.Content.ReadAsStringAsync().Result;
                                var resBody = JsonConvert.DeserializeObject<Dictionary<string, dynamic>>(responseContent);

                                if (resBody.ContainsKey("emailFound") && (bool)resBody["emailFound"])
                                {
                                    ErrorEmail.Visible = true;
                                }
                                else
                                {
                                    RegisterUser();
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"ErrorEmail:: {ex}");
                    }
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
                    if (!isAgeValid)
                    {
                        ageErr.Visible = true;
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
                ErrorPW.Visible = true;
            }
        }

        private void RegisterUser()
        {
            using (HttpClient client = new HttpClient())
            {
                var values = new Dictionary<string, string>
                {
                    { "user_name", FirstName.Text },
                    { "surname", Surname.Text },
                    { "email", Email.Text },
                    { "phone_number", PhoneNumbers.Text },
                    { "age", Age.Text },
                    { "points_balance", "0" },
                    { "created_at", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") },
                    { "is_active", "1" }, 
                    { "updated_at", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") },
                    { "last_login", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") },
                    { "qr_code", GenerateQRCodeString(FirstName.Text, Surname.Text, Email.Text, PhoneNumbers.Text, Age.Text) },
                    { "user_password", Password.Text }
                };

                var content = new FormUrlEncodedContent(values);

                var response = client.PostAsync(API.Register, content).Result;

                if (response.IsSuccessStatusCode)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "successAlert", "alert('Registered successfully');", true);
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    regError.Visible = true;
                }
            }
        }

        private string GenerateQRCodeString(string firstName, string surname, string email, string pnumber, string age)
        {
            string userData = $"{firstName},{surname},{email},{pnumber},{age}";

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

                    var response = client.PostAsync(API.ValidateEmail, content).Result;

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

        private bool ValidateAlphabeticInput(string input)
        {
            return Regex.IsMatch(input, "^[a-zA-Z]+$");
        }

        private bool ValidatePhoneNumber(string input)
        {
            return Regex.IsMatch(input, "^[0-9]{10}$");
        }

        private bool ValidateAge(string input)
        {
            return Regex.IsMatch(input, "^[0-9]+$");
        }

        private bool ValidatePassword(string password)
        {
            return Regex.IsMatch(password, @"^(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&*()_+])[A-Za-z\d@#$%^&*()_+]{9,}$");
        }
    }
}