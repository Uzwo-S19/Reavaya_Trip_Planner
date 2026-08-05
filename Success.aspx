<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Success.aspx.cs" Inherits="ReavayaWebNew.Success" %>
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

    <div style="display: flex; justify-content: center; margin-top: 110px;">
    <div style="text-align: center; width: 30%;">
        <h1 style="color:blue;">Transaction Successful!</h1>
        <p>Your transaction was processed successfully. Thank you for your purchase</p>
        <img src="assets/img/sucess.jpg" alt="Green checkmark" style="max-width:100%; height:auto;">
            <p id="countdown">5 seconds...</p>
            <p>Manually go to the transaction page by clicking <a href="Transactions.aspx">here</a></p>
    </div>
</div>

    <script>
// Countdown function
function countdownRedirect() {
    var seconds = 5; // Number of seconds for the countdown
    var countdownElement = document.getElementById("countdown");

    var countdownInterval = setInterval(function() {
        countdownElement.innerHTML = seconds + " seconds...";
        seconds--;

        if (seconds < 0) {
            clearInterval(countdownInterval);
            window.location.href = "Transactions.aspx"; // Replace "TargetPage.aspx" with your actual target page URL
        }
    }, 1000); // Update every 1 second
}
    </script>

</asp:Content>
