<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="ReavayaWebNew.Transactions" Async="true" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Rea Vaya Website</title>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="manifest" href="https://preview.colorlib.com/theme/jobsco/site.webmanifest">
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="assets/css/slicknav.css">
    <link rel="stylesheet" href="assets/css/animate.min.css">
    <link rel="stylesheet" href="assets/css/magnific-popup.css">
    <link rel="stylesheet" href="assets/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="assets/css/themify-icons.css">
    <link rel="stylesheet" href="assets/css/slick.css">
    <link rel="stylesheet" href="assets/css/nice-select.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <style>
        .containers {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 60vh;
            padding: 15px;
        }

        #TransactionsGridViewContainer {
            width: 98%;
            max-height: 500px;
            overflow-y: auto;
            border: 1px solid #a6d4fa;
            background-color: #f5faff;
        }

        #TransactionsGridView {
            width: 100%;
            font-size: 16px;
            border-collapse: collapse;
        }

        #TransactionsGridView th {
            background-color: #a6d4fa;
            padding: 10px;
        }

        #TransactionsGridView td {
            padding: 10px;
            border-bottom: 1px solid #d0e4f6;
        }

        /* Additional styling for better spacing and the touch of blue */
        #selectedDateInput {
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
</head>
<body>
    
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
                                <span>View Transactions</span>
                            </div>
                            <div class="input-box">
                                <div class="single-input-fields">
                                    <asp:Label ID="SelectDateLabel" runat="server" Text="Select Date:"></asp:Label>
                                    <asp:TextBox ID="selectedDateInput" runat="server" TextMode="Date"></asp:TextBox>
                                </div>
                                <div class="login-footer">
                                    <asp:Button ID="FetchTransactionsButton" runat="server" Text="Fetch Transactions" OnClick="FetchTransactionsButton_Click" class="btn login-btn" />
                                    <!--<asp:Button ID="GeneratePDFReportButton" runat="server" Text="Download PDF Report" OnClick="GeneratePDFReport_Click" class="btn login-btn" />-->
                                    <!-- Add the Draw Pie Chart button here -->
                                    <asp:Button ID="DrawPieChartButton" runat="server" Text="Pie Chart" OnClientClick="displayPieChart(); return false;" class="btn login-btn" />
                                </div>
                                <br /><br />
                                <!-- Add the canvas element for the pie chart -->
                               <!-- Add the canvas element for the pie chart -->
<div class="text-center">
    <canvas id="pieChartCanvas" width="400" height="400" style="display: none;"></canvas>
</div>
<asp:HiddenField ID="HiddenFieldForTransactions" runat="server" />

                                <div id="TransactionsGridViewContainer">
                                    <asp:GridView ID="TransactionsGridView" runat="server" AutoGenerateColumns="False">
                                        <Columns>
                                            <asp:BoundField DataField="User_ID" HeaderText="User ID" />
                                            <asp:BoundField DataField="TotalPoints" HeaderText="Total Points" />
                                            <asp:BoundField DataField="TimeStamp" HeaderText="Time" />
                                            <asp:BoundField DataField="TimePeriod" HeaderText="Time Period" />
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer>
        <!-- Your footer content here -->
    </footer>

<!-- JavaScript code for displaying the pie chart -->
<script type="text/javascript">
    $(document).ready(function () {
        // Function to display the pie chart
        function displayPieChart() {
            // Hide the TransactionsGridViewContainer
            $("#TransactionsGridViewContainer").hide();

            // Retrieve the data from the HiddenFieldForTransactions
            var transactionsData = JSON.parse(document.getElementById('<%= HiddenFieldForTransactions.ClientID %>').value);

            // Prepare data for the pie chart (modify as needed)
            var data = [
                {
                    label: 'Morning',
                    value: transactionsData[0][0] // Change [0, 0] to [0][0]
                },
                {
                    label: 'Afternoon',
                    value: transactionsData[0][1] // Change [0, 1] to [0][1]
                },
                {
                    label: 'Evening',
                    value: transactionsData[0][2] // Change [0, 2] to [0][2]
                }
            ];

            // Get the canvas element and its context
            var canvas = document.getElementById('pieChartCanvas');
            var ctx = canvas.getContext('2d');

            // Calculate total value
            var totalValue = data.reduce(function (acc, slice) {
                return acc + slice.value;
            }, 0);

            // Set the center and radius
            var centerX = canvas.width / 2;
            var centerY = canvas.height / 2;
            var radius = Math.min(centerX, centerY);

            // Starting angle
            var startAngle = 0;

            // Clear the canvas
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            // Draw the pie chart
            data.forEach(function (slice) {
                var sliceAngle = (Math.PI * 2 * slice.value) / totalValue;

                ctx.beginPath();
                ctx.moveTo(centerX, centerY);
                ctx.arc(centerX, centerY, radius, startAngle, startAngle + sliceAngle);
                ctx.fillStyle = getRandomColor(); // Function to generate random colors
                ctx.fill();

                // Draw label
                var labelX = centerX + (radius / 2) * Math.cos(startAngle + sliceAngle / 2);
                var labelY = centerY + (radius / 2) * Math.sin(startAngle + sliceAngle / 2);
                ctx.fillStyle = 'black';
                ctx.font = '14px Arial';
                ctx.fillText(slice.label, labelX, labelY);

                startAngle += sliceAngle;
            });

            // Show the pie chart canvas
            $("#pieChartCanvas").show();
        }

        // Function to generate random colors
        function getRandomColor() {
            var letters = '0123456789ABCDEF';
            var color = '#';
            for (var i = 0; i < 6; i++) {
                color += letters[Math.floor(Math.random() * 16)];
            }
            return color;
        }

        // Attach the click event to the DrawPieChartButton
        $("#DrawPieChartButton").click(function () {
            displayPieChart();
            return false;
        });
    });
</script>
</body>
</html>
