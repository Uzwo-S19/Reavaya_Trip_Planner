<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="bus_Schedule.aspx.cs" Inherits="ReavayaWebNew.bus_Schedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
            .success-message {
    color: green;

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
                        <form id="form1" runat="server">

                            <div class="login-heading">
 


                            <div class="login-heading">
                                <span>Add Bus Schedule</span>
                                <!--<asp:Label ID="Label1" runat="server" Text="" CssClass="success-message" Visible="false" Style="color: green;"></asp:Label>-->

                              <asp:Label ID="lblSuccessMessage" runat="server" Text="" CssClass="success-message" Visible="false" Style="color: green;"></asp:Label>
                                    <!--  <asp:Label ID="Label2" runat="server" Text="" CssClass="success-message" Visible="false"></asp:Label>-->
                            </div>

                            <div class="input-box">
                                <div class="single-input-fields">
                                    <label>Bus Name</label>
                                    <asp:TextBox ID="busName" runat="server" type="text" required="required" placeholder="Enter the bus name"></asp:TextBox>
                                </div>
                                <div class="single-input-fields">
                                    <label>Pickup Point</label>
                                    <asp:TextBox ID="pickupPoint" runat="server" type="text" required="required" placeholder="Enter the pickup point"></asp:TextBox>
                                </div>
                                <div class="single-input-fields">
                                    <label>Destination</label>
                                    <asp:TextBox ID="destination" runat="server" type="text" required="required" placeholder="Enter the destination"></asp:TextBox>
                                </div>
                                <div class="single-input-fields">
                                    <label>Departure</label>
                                    <asp:TextBox ID="departure" runat="server" type="text" required="required" placeholder="Enter the departure time"></asp:TextBox>
                                </div>
                            </div>

                            <div class="login-footer">
                                <asp:Button ID="btnAddSchedule" runat="server" type="submit" class="btn login-btn" Text="Add Schedule" OnClick="btnAddSchedule_Click" />
                                
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
