<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="404Error.aspx.cs" Inherits="ReavayaWebNew._404Error" %>
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
       
      <div class="register-form-area section-padding">
        <div class="error-content text-center" style="background-image: url(assets/img/backgrounds/404-error-bg.jpg)">

            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-6 col-lg-7 col-md-10">
                        <div class="register-form text-center">
                            <form runat="server">
                                <div class="register-heading" >
                                    <h1 class="error-title">Error 404</h1><!-- End .error-title -->
                                    <p id="countdown">5 seconds...</p>
      		                        <p>We are sorry, something went wrong.</p>
    		                        <a href="TripPlanner.aspx" class="btn btn-outline-primary-2 btn-minwidth-lg">
     			                        <span>BACK TO PLANNING A TRIP</span>
       			                        <i class="icon-long-arrow-right"></i>
      		                        </a>
                                </div>


                            </form>
                         </div>
                    </div>
                </div>
            </div>
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
            window.location.href = "TripPlanner.aspx"; 
        }
    }, 1000); // Update every 1 second
}
    </script>
</asp:Content>
