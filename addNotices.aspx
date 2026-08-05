<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="addNotices.aspx.cs" Inherits="ReavayaWebNew.addNotices" %>
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
<span>Add Notice</span>

</div>

<div class="input-box">

    <div class="single-input-fields">
        <label>Title</label>
        <asp:TextBox ID="titleNotice" type="text" runat="server" required="required" placeholder="Enter the title for your notice" Height="31px" Width="700px"></asp:TextBox>
    </div>
    <div class="single-input-fields">
        <label>Write a notice</label>
        
        <textarea id="Notice" runat="server" cols="85" rows="6" required="required" placeholder="Enter the notice"></textarea>
    </div>

    <div class="single-input-fields">
        <asp:Label ID="StatusLabel" runat="server" style="color:green" Text="" CssClass="success-message" Visible="false"></asp:Label>

    </div>
    

    

</div>

<div class="login-footer">
    
        <asp:Button ID="btnAddNotice" runat="server" type="submit" class="btn login-btn" Text="Send Notice" OnClick="btnAddNotice_Click" /> <div></div>
        
    
</div>
</form>
</div>
</div>
</div>
</div>
</div>

     
</asp:Content>
