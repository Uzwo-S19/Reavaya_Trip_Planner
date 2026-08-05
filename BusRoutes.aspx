<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="BusRoutes.aspx.cs" Inherits="ReavayaWebNew.BusRoutes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
     <style>
 

       h2 {
        text-align: center;
       
      }

         h1 {
        text-align: center;
           margin-top: -100px;
          // margin-bottom: 1000px;
      }

table {
    border-collapse: collapse;
    width: 50%;
    margin: 0 auto;
    margin-bottom: 100px;
     
}

th, td {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

/* Add a style for the 'a' elements */
table a {
    color: blue;
    text-decoration: none;
}

table a:hover {
    text-decoration: underline;
}

/* Add a style for the first row */
tr:first-child th {
    background-color: blue;
    color: white;
}

/* Add a style for all other rows */
tbody tr {
    background-color: #f2f2f2;
}
    </style>
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
    <div class="single-slider d-flex align-items-center slider-height2">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="hero-caption hero-caption2">
                        <h2>Bus Routes Download</h2>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <h1>Centurion Bus Routes</h1>
    <table>
        <thead>
            <tr>
                <th>Route</th>
                <th>File</th>
                <th>Size</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Centurion - Rooihuiskraal - C2</td>
                <td><a href="your-pdf-file-link-here" download>Acrobat</a></td>
                <td>1519 KB</td>
            </tr>
            <tr>
                <td>Centurion - Southdowns - C4</td>
                <td><a href="your-pdf-file-link-here" download>Acrobat</a></td>
                <td>1219 KB</td>
            </tr>
            <tr>
                <td>Centurion - Technopark - C1</td>
                <td><a href="your-pdf-file-link-here" download>Acrobat</a></td>
                <td>1498 KB</td>
            </tr>
            <tr>
                <td>Centurion - Wierdapark - C3</td>
                <td><a href="your-pdf-file-link-here" download>Acrobat</a></td>
                <td>1214 KB</td>
            </tr>
            <tr>
                <td>Midibus Route Highveld</td>
                <td><a href="your-pdf-file-link-here" download>Acrobat</a></td>
                <td>2433 KB</td>
            </tr>
            <tr>
                <td>Midibus Route Map Midstream</td>
                <td><a href="your-pdf-file-link-here" download>Acrobat</a></td>
                <td>2539 KB</td>
            </tr>
        </tbody>
    </table>
</asp:Content>
