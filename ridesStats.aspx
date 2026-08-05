<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ridesStats.aspx.cs" Inherits="ReavayaWebNew.ridesStats" Async="true" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- required JS imports-->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/modules/heatmap.js"></script>

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
                                <span>Passenger Rides Statistics</span>
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

                                <!--Route Frequencies-->
                                <div class="login-footer">
                                    <asp:Button ID="filterButton" runat="server" type="submit" class="btn login-btn" Text="Show route frequencies" OnClick="filterButton_Click" />
                                </div>
                                    <br />
                                <table id="tbl" runat="server" style="border:1px black; font-family:Cambria" Visible="false">
                                   
                                    <tr>
                                        <td colspan="2">
                                            <asp:Chart ID="RideChart" runat="server" Width="600" Height="400" Visible="false">
                                                <Titles><asp:Title Text="Frequency of rides accross different routes" Font="Bold, 12pt"></asp:Title></Titles>
                                                <ChartAreas>
                                                    <asp:ChartArea Name="ChartArea1">
                                                        <AxisX Title="Routes (Pickup to Destination)" IsLabelAutoFit="True" Interval="1">
                                                            <LabelStyle Angle="-45" />
                                                        </AxisX>
                                                        <AxisY Title="Frequency" />
                                                    </asp:ChartArea>
                                                </ChartAreas>
                                                <Series>
                                                    <asp:Series Name="Rides" ChartArea="ChartArea1" ChartType="Column" XValueMember="Route" YValueMembers="Frequency" IsValueShownAsLabel="True">
                                                    </asp:Series>
                                                </Series>
                                            </asp:Chart>
                                        </td>
                                    </tr>
                                </table>
                                

                                 <!--Route Frequencies by week/ month..-->
                               <!-- <tr>
                                        <td>
                                            <b> Select Chart Type </b>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddList" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddList_SelectedIndexChanged"> 

                                            </asp:DropDownList>
                                        </td>
                                    </tr>-->

                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

     <script src="https://kit.fontawesome.com/2c36e9b7b1.js" crossorigin="anonymous"></script>
</asp:Content>
