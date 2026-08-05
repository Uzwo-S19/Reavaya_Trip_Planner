<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="RegisterManager.aspx.cs" Inherits="ReavayaWebNew.RegisterManager" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
     <header>
<div class="header-area header-transparent">
<div class="main-header header-sticky">
<div class="container">
<div class="menu-wrapper d-flex align-items-center justify-content-between">
<div class="left-content d-flex align-items-center">
<div class="logo mr-45">
<a href="index.aspx"><img src="assets/img/Rea_Vaya_logo.svg" alt=""></a>
</div>

<div class="main-menu d-none d-lg-block">
<nav>
<ul id="navigation">
<li><a href="index.aspx">Home</a></li>
<!--li><a href="borwse_job.html">About us</a></!--li>
<li><a href="contact.html">Contact</a></li-->
</ul>
</nav>
</div>
</div>

<div class="buttons">
<ul>
    <li class="button-header">
        <a href="LoginManager.aspx" id="log" runat="server" class="btn header-btn2"><i class="fas fa-phone-alt"></i>Login</a>
    </li>
</ul>
</div>
</div>
</div>
</div>
</div>
</header>
    <div class="register-form-area section-padding">
<div class="container">
<div class="row justify-content-center">
<div class="col-xl-9 col-lg-9 col-md-10">
<div class="register-form text-center">
<form runat="server">
<div class="register-heading">
<span>Register</span>
</div>

<div class="input-box">
    <div class="single-input-fields">
        <label>Name</label>
        <asp:TextBox ID="FirstName" type="text" runat="server" required="required" placeholder="Enter Your Name"></asp:TextBox>
    </div>
        <p id="nameErr" visible="false" runat="server" style="color:red">Name can only be alphabets.</p>
    <div class="single-input-fields">
        <label>Surname</label>
        <asp:TextBox ID="Surname" type="text" runat="server" required="required" placeholder="Enter Your Surname"></asp:TextBox>
    </div>
        <p id="surErr" visible="false" runat="server" style="color:red">Surname can only be alphabets.</p>
    <div class="single-input-fields">
        <label>Email</label>
        <asp:TextBox ID="Email" type="email" runat="server" required="required" placeholder="Enter Your Email Address"></asp:TextBox>
    </div>
        <p id="ErrorEmail" visible="false" runat="server" style="color:red">The email you entered is already used.</p>
    
    <div class="single-input-fields">
        <label>Phone Number</label>
        <asp:TextBox ID="PhoneNumbers" type="text" runat="server" required="required" placeholder="Enter Your Phone Number"></asp:TextBox>
    </div>
        <p id="phoneErr" visible="false" runat="server" style="color:red">Phone number can only be numbers of 10 digits.</p>
    <div class="single-input-fields">
        <label>Manager ID</label>
        <asp:TextBox ID="managerID" type="text" runat="server" required="required" placeholder="Enter Your Manager ID"></asp:TextBox>
    </div>
    <div class="single-input-fields">
        <label>Password</label>
        <asp:TextBox ID="Password" type="password" runat="server" required="required" placeholder="Enter Password"></asp:TextBox>
    </div>
        <p id="passEr" visible="false" runat="server" style="color:red">The password must at lease have 1 Capital letter, 1 number and 1 special character.</p>
        <p id="passEr1" visible="true" runat="server">The password must at lease have 1 Capital letter, 1 number and 1 special character.</p>
    <div class="single-input-fields">
        <label>Confirm Password</label>
        <asp:TextBox ID="CPassword" type="password" runat="server" required="required" placeholder="Confirm Password"></asp:TextBox>
    </div>
        <p id="ErrorPW" visible="false" runat="server" style="color:red">Passwords don't match.</p>

</div>

<div class="register-footer">
    <asp:Button ID="btnRegister" runat="server" type="submit" class="btn login-btn" Text="Register" OnClick="btnRegister_Click"/>
    <p> Already have an account? <a href="LoginManager.aspx">Click here</a></p>
    <!--p>Are you a Passenger? <a href="Register.aspx">Register here</a></!--p-->
</div><br />
    <p id="regError" visible="false" runat="server" style="color:red">Please check if you entered your correct credentials.</p>
</form>
</div>
</div>
</div>
</div>
</div>

</asp:Content>
