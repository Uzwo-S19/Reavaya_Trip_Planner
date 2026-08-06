<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="viewFeedback.aspx.cs" Inherits="ReavayaWebNew.viewFeedback" %>
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

        #gridFeedbackContainer {
            width: 98%;
            max-height: 500px;  
            overflow-y: auto;
            border: 1px solid #a6d4fa;
            background-color: #f5faff;
        }

        #gridFeedback {
            width: 100%; 
            font-size: 16px;
            border-collapse: collapse;  
        }

        #gridFeedback th {
            background-color: #a6d4fa; 
            padding: 10px;
        }

        #gridFeedback td {
            padding: 10px;
            border-bottom: 1px solid #d0e4f6; 
        }

        /* Additional styling for better spacing and the touch of blue */
        #startDate {
            margin-bottom: 10px;
            border: 2px solid #a6d4fa;
            padding: 5px 10px;
        }
        
        #endDate {
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
                                <span>Passenger Feedback</span>
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
                                    <asp:Button ID="btnFeedback" runat="server" type="submit" class="btn login-btn" Text="View Passenger Feedback" OnClick="btnFeedback_Click" />
                                </div>
                                <br />
                                <div id="gridFeedbackContainer">
                                    <asp:GridView ID="gridFeedback" runat="server" AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:BoundField DataField="Buscode" HeaderText="Bus Code" />
                                            <asp:BoundField DataField="Cleanliness" HeaderText="Cleanliness Rating" />
                                            <asp:BoundField DataField="Driver" HeaderText="Driver Rating" />
                                            <asp:BoundField DataField="Comments" HeaderText="Comments" />
                                            <asp:BoundField DataField="TimeSent" HeaderText="Date & Time" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                                <div class="single-input-fields">
                                    <asp:Label ID="StatusLabel" runat="server" style="color:green" Text="" CssClass="success-message" Visible="false"></asp:Label>
                                </div>
                                <!-- Add a div to contain the chart >
                                <div class="containers">
                                    <div id="ratingChart" style="width: 100%; height: 400px;"></div>
                                </div-->
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function drawRatingChart(chartData) {
            var data = [{
                x: chartData.map(item => item.Item1), // Rating categories (Cleanliness, Driver)
                y: chartData.map(item => item.Item2), // Average ratings
                type: 'line',
                mode: 'lines+markers',
                marker: { color: 'blue' },
            }];

            var layout = {
                title: 'Average Ratings Over Time',
                xaxis: {
                    title: 'Rating Category',
                },
                yaxis: {
                    title: 'Average Rating',
                }
            };

            Plotly.newPlot('ratingChart', data, layout);
        }
    </script>

</asp:Content>
