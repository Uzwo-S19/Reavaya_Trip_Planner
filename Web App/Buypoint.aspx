<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Buypoint.aspx.cs" Inherits="ReavayaWebNew.Buypoint" %>
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
<a href="Home.aspx"><img src="assets/img/Rea_Vaya_logo.svg" alt=""></a>
</div>

<div class="main-menu d-none d-lg-block">
<nav>
<ul id="navigation">
<li><a href="Home.aspx">Home</a></li>
<li><a href="Buypoint.aspx">Buy Points</a></li>
<li><a href="TripPlanner.aspx">Plan A Trip</a></li>
<li><a href="scanQR.aspx">Start A Ride</a></li>
<li><a href="BusRoutes.aspx">Bus Routes</a></li>
<!--li><a href="borwse_job.html">About us</a></!--li>
<li><a href="contact.html">Contact</a></li-->
<li><a href="editProfile.aspx" id="edit" runat="server">Profile</a></li>

</ul>
</nav>
</div>
</div>

<div class="buttons">
<ul>
    <li class="button-header">
        <a href="Logout.aspx" id="logout" runat="server" class="btn header-btn2"><i class="fas fa-phone-alt"></i>Logout</a>
    </li>
</ul>
</div>
</div>

<div class="col-12">
<div class="mobile_menu d-block d-lg-none"></div>
</div>
</div>
</div>
</div>
</header>
 
<main>

<div class="register-form-area section-padding">
<div class="container">
<div class="row justify-content-center">
<div class="col-xl-6 col-lg-7 col-md-10">
<div class="register-form text-center">

<div class="register-heading">
<span>Buy Points</span>
<p>Buy your points to start taking rides</p>
</div>

<form runat="server">

<div class="input-box">
<div class="single-input-fields">
<label>Card Number</label>
    <asp:TextBox type="text" id="cardNumber" placeholder="1234 5678 9012 3456" runat="server"></asp:TextBox>
</div>
<div class="single-input-fields">
<label>Cardholder Name:</label>
    <asp:TextBox type="text" id="cardName" name="cardName" placeholder="Xolani Mavuso" runat="server"></asp:TextBox>
</div>
<div class="single-input-fields">
    <label for="expiryDate">Expiry Date:</label>
    <asp:TextBox type="month" id="expiryDate" name="expiryDate" runat="server"></asp:TextBox>
</div>
<div class="single-input-fields">
    <label for="cvv">CVV:</label>
    <asp:TextBox type="text" id="cvv" name="cvv" placeholder="123" runat="server"></asp:TextBox>
</div>

<div class="single-input-fields">
<label>Points Amount</label>
    <asp:TextBox type="text" ID="points"  placeholder="1 Point = R1" runat="server"></asp:TextBox>
</div>
</div>
    
<div class="register-footer">
    <asp:Button class="btn login-btn" ID="Purchase" runat="server" Text="Purchase" OnClick="Purchase_Click" />
</div>
</form>
</div>
</div>
</div>
</div>
</div>

</main>

</asp:Content>
