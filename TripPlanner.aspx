<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TripPlanner.aspx.cs" Inherits="ReavayaWebNew.TripPlanner" %>
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
<div class="container">
<div class="row justify-content-center">
<div class="col-xl-6 col-lg-7 col-md-10">
<div class="register-form text-center">
<form runat="server">
<div class="register-heading">
<span>Plan Your Journey</span>
</div>

<div class="input-box">
    <div class="single-input-fields">
        <label>From</label>
        <asp:TextBox ID="initLoc" type="text" runat="server" required="required" placeholder="Your initial location"></asp:TextBox>
       
    </div>
    <div class="single-input-fields">
        <label>To</label>
        <asp:TextBox ID="destLoc" type="text" runat="server" required="required" placeholder="Your destination"></asp:TextBox>
       
    </div>
    <div class="single-input-fields">
        <label>Date</label>
        <asp:TextBox ID="date" type="date" runat="server" required="required" placeholder="dd/mm/yyy"></asp:TextBox>
    </div>
    <div class="single-input-fields">
        <label>Time</label>
        <asp:TextBox ID="time" type="time" runat="server" required="required" placeholder="hh:mm"></asp:TextBox>
    </div>
</div>

<div class="register-footer">
    <asp:Button ID="btnRoute" runat="server" type="submit" class="btn login-btn" Text="Get Trip Details" OnClick="btnRoute_Click"/>
</div>
</form>
</div>
</div>
</div>
</div>
</div>
</asp:Content>
