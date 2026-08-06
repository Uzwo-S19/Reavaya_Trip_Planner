<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="scanQR.aspx.cs" Inherits="ReavayaWebNew.scanQR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="https://rawgit.com/schmich/instascan-builds/master/instascan.min.js"></script>

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

    <main>
    <div class="register-form-area section-padding">
<div class="container">
<div class="row justify-content-center">
<div class="col-xl-6 col-lg-7 col-md-10">
<div class="register-form text-center">

    <div class="register-heading">
<span>Scan QR Code</span>

</div>

<video id="preview"></video>


<div class="register-footer">

<button class="btn login-btn">Waiting for the code</button>
</div>
    </div>
    </div>
    </div>
    </div>
        </div>


<style>

#preview {
  width: 100%;
  height: auto;
}


</style>

</main>

    <script>

// Create a new instance of Instascan
let scanner = new Instascan.Scanner({ video: document.getElementById('preview') });

// Add a listener to detect when a QR code is scanned
scanner.addListener('scan', function (content) {
  console.log('Scanned content: ' + content);
});

// Start the camera
Instascan.Camera.getCameras().then(function (cameras) {
  if (cameras.length > 0) {
    scanner.start(cameras[0]);
  } else {
    console.error('No cameras found.');
  }
}).catch(function (e) {
  console.error(e);
});


    </script>

</asp:Content>
