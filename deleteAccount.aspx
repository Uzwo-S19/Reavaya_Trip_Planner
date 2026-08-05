<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="deleteAccount.aspx.cs" Inherits="ReavayaWebNew.deleteAccount" %>
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
<a href="Dashboard.aspx"><img src="assets/img/Rea_Vaya_logo.svg" alt=""></a>
</div>

<div class="main-menu d-none d-lg-block">
<nav>
<ul id="navigation">
<li><a href="Dashboard.aspx">Dashboard</a></li>
<li><a href="notices.aspx">Notices</a></li>
<li><a href="Statistics.aspx">Statistics</a></li>
<li><a href="viewFeedback.aspx">Feedback</a></li>
<li><a href="schedules.aspx">Scheduling</a></li>
<li><a href="editManagerProfile.aspx" id="edit" runat="server">Profile</a></li>

</ul>
</nav>
</div>
</div>

<div class="buttons">
<ul>
    <li class="button-header">
        <a href="Logout.aspx" id="logout" runat="server" class="btn header-btn2"><i class="fas fa-logout-alt"></i>Logout</a>
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

    <div class="login-form-area section-padding">
<div class="container">
<div class="row justify-content-center">
<div class="col-xl-9 col-lg-9 col-md-10">
<div class="login-form">
<form runat="server">
 <div class="login-heading">
<span>Delete Account</span>
<p>Enter your email and password to delete account</p>
</div>

<div class="input-box">
    
    <div class="single-input-fields">
        <label>Email Address</label>
        <asp:TextBox ID="Email" type="email" runat="server" required="required" placeholder="Enter Your Email Address"></asp:TextBox>
    </div>
    <div class="single-input-fields">
        <label>Password</label>
        <asp:TextBox ID="Password" type="password" runat="server" required="required" placeholder="Enter Your Password"></asp:TextBox>
    </div>
</div>

<div class="login-footer">
    <asp:Button ID="btnDelete" runat="server" type="submit" class="btn login-btn" Text="Delete Account" OnClick="btnDeleteAccount_Click"/>
</div><br />
    <p id="delError" visible="false" runat="server" style="color:red">The email or password entered is incorrect</p>
</form>
</div>
</div>
</div>
</div>
</div>
</asp:Content>
