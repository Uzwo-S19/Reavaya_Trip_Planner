<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="traffic.aspx.cs" Inherits="ReavayaWebNew.traffic" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <!-- Include Plotly JavaScript -->
    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
    <style>
    .containers {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 60vh;
        padding: 15px;
    }

        #startDate {
            margin-bottom: 10px;
            border: 2px solid #a6d4fa;
            padding: 5px 10px;
        }
        
        #eDate {
            margin-bottom: 10px;
            border: 2px solid #a6d4fa;
            padding: 5px 10px;
        }

        .blue-btn {
            background-color: #a6d4fa;
            border: none;
            padding: 5px 15px;
            margin-top: 10px;
            cursor: pointer;
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

  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f5f5f5;
      color: #333;
      margin: 0;
      padding: 0;
    }

    h1 {
      text-align: center;
      margin-top: 100px;
    }

    p {
      margin-bottom: 20px;
    }

    .stats ul {
      list-style-type: none;
      margin: 0;
      padding: 0;
    }

    .stats li {
      display: inline-block;
      width: calc(25% - 10px);
      margin-right: 30px;
      padding: 20px;
      text-align: center;
      background-color: #ffffff;
      border-radius: 5px;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
      transition: all 0.3s ease-in-out;
      cursor: pointer;
    }

    .stats li:hover {
      transform: translateY(-5px);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }

    .stats li strong {
      display: block;
      font-size: 36px;
      margin-bottom: 10px;
      color: #333;
    }

    .stats li span {
      display: block;
      font-size: 18px;
      color: #aaa;
    }

    .stats li i {
      display: block;
      font-size: 24px;
      margin-bottom: 10px;
      color: #4285f4;
    }

    /* Add some styles for the filter buttons */
    button {
      background-color: #4285f4;
      color: #ffffff;
      border: none;
      padding: 10px;
      margin-right: 10px;
      border-radius: 5px;
      cursor: pointer;
    }
  </style>

    <div class="login-form-area section-padding">
<div class="container">
<div class="row justify-content-center">
<div class="col-xl-9 col-lg-9 col-md-10">
<div class="login-form">
<form runat="server">
 <div class="login-heading">
<span>View Traffic Statistics</span>
</div>

<div class="input-box">

                                <div class="single-input-fields">
<asp:Label ID="lblStartDate" runat="server" Text="Start Date:"></asp:Label>
                                    <asp:TextBox ID="startDate" TextMode="Date" runat="server" ></asp:TextBox>
                                </div>
                                <div class="single-input-fields">
<asp:Label ID="lblEndDate" runat="server" Text="End Date:"></asp:Label>
                                    <asp:TextBox ID="endDate" TextMode="Date" runat="server" ></asp:TextBox>
                                </div>
                                <div class="login-footer">
                                    <asp:Button ID="filterButton" runat="server" type="submit" class="btn login-btn" Text="Get Number of Logins" OnClick="FilterTrafficData_Click" />
                                </div>
                                    <p>Filter for Number of Passenger Logins</p><br />

        <div class="stats"><div class="text-center mb-10">

            <ul>
                <li>
                    <i class="fas fa-sign-in-alt"></i>
                    <strong><asp:Literal ID="loginCountLiteral" runat="server">0</asp:Literal></strong>
                    <span>Number of Passenger Logins</span>
                </li>
        <li>
            <i class="fas fa-users"></i>
            <strong><asp:Literal ID="registeredPassengersLiteral" runat="server">0</asp:Literal></strong>
            <span>Number of Registered Passengers</span>
        </li>
            </ul><br /></div>
            
            <div ID="text" runat="server" class="section-tittle section-tittle3 text-center mb-10">
            </div>
</div></div>
    </form>
</div>
</div>
</div>
</div>
    </div>

    <script src="https://kit.fontawesome.com/2c36e9b7b1.js" crossorigin="anonymous"></script>

</asp:Content>
