<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Statistics.aspx.cs" Inherits="ReavayaWebNew.Statistics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Include Plotly JavaScript -->
    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
    <style>
        /* Your existing styles here */
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

    <div class="login-form-area section-padding">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-9 col-lg-9 col-md-10">
                    <div class="login-form">
                        <form runat="server">
                            <div class="login-heading">
                                <span>Statistics</span>
                            </div>

                            <div class="input-box">
                                <div class="single-input-fields">
                                    <div class="stats">
                                        <div class="text-center mb-10">
                                            <div class="login-footer">
                                                <asp:Button ID="loginStats" runat="server" type="submit" class="btn login-btn" Text="Traffic Statistics" OnClick="loginStats_Click"/>
                                            </div>

                                            <br />

                                            <div class="login-footer">
                                                <asp:Button ID="ridesStats" runat="server" type="submit" class="btn login-btn" Text="Rides Statistics" OnClick="ridesStats_Click"/>
                                            </div>

                                            <br />

                                            <div class="login-footer">
                                                <asp:Button ID="transactionsStats" runat="server" type="submit" class="btn login-btn" Text="Transactions Statistics" OnClick="transactionsStats_Click"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> 
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://kit.fontawesome.com/2c36e9b7b1.js" crossorigin="anonymous"></script>
</asp:Content>
