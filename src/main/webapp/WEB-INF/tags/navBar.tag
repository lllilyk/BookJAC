<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ attribute name="current" %>

<style>

    @import url(//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css);

    @import url(https://fonts.googleapis.com/css?family=Titillium+Web:300);

    .fa-2x {
        font-size: 2em;
    }

    .fa {
        position: relative;
        display: table-cell;
        width: 60px;
        height: 36px;
        text-align: center;
        vertical-align: middle;
        font-size: 20px;
    }


    .main-menu:hover, nav.main-menu.expanded {
        width: 250px;
        overflow: visible;
    }

    .main-menu {
        background: #212121;
        border-right: 1px solid #e5e5e5;
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        width: 60px;
        overflow: hidden;
        -webkit-transition: width .05s linear;
        transition: width .05s linear;
        -webkit-transform: translateZ(0) scale(1, 1);
        z-index: 1000;
    }

    .main-menu > ul {
        margin: 7px 0;
    }

    .main-menu li {
        position: relative;
        display: block;
        width: 250px;
    }

    .main-menu li > a {
        position: relative;
        display: table;
        border-collapse: collapse;
        border-spacing: 0;
        color: #999;
        font-family: arial;
        font-size: 14px;
        text-decoration: none;
        -webkit-transform: translateZ(0) scale(1, 1);
        -webkit-transition: all .1s linear;
        transition: all .1s linear;

    }

    .main-menu .nav-icon {
        position: relative;
        display: table-cell;
        width: 60px;
        height: 36px;
        text-align: center;
        vertical-align: middle;
        font-size: 18px;
    }

    .main-menu .nav-text {
        position: relative;
        display: table-cell;
        vertical-align: middle;
        width: 190px;
        font-family: 'Titillium Web', sans-serif;
    }

    .main-menu > ul.logout {
        position: absolute;
        left: 0;
        bottom: 0;
    }

    .no-touch .scrollable.hover {
        overflow-y: hidden;
    }

    .no-touch .scrollable.hover:hover {
        overflow-y: auto;
        overflow: visible;
    }

    a:hover, a:focus {
        text-decoration: none;
    }

    nav {
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        -o-user-select: none;
        user-select: none;
    }

    nav ul, nav li {
        outline: 0;
        margin: 0;
        padding: 0;
    }

    .main-menu li:hover > a, nav.main-menu li.active > a, .dropdown-menu > li > a:hover, .dropdown-menu > li > a:focus, .dropdown-menu > .active > a, .dropdown-menu > .active > a:hover, .dropdown-menu > .active > a:focus, .no-touch .dashboard-page nav.dashboard-menu ul li:hover a, .dashboard-page nav.dashboard-menu ul li.active a {
        color: #fff;
        background-color: #000000;
    }

    body {
        float: left;
        /*background: #e2e2e2;*/
        width: 100%;
        height: 100vh;
    }

    @font-face {
        font-family: 'Titillium Web';
        font-style: normal;
        font-weight: 300;
        src: local('Titillium WebLight'), local('TitilliumWeb-Light'), url(http://themes.googleusercontent.com/static/fonts/titilliumweb/v2/anMUvcNT0H1YN4FII8wpr24bNCNEoFTpS2BTjF6FB5E.woff) format('woff');
    }

</style>

<nav class="main-menu">
    <ul>
        <li>
            <a href="/">
                <i class="fa fa-home fa-2x"></i>
                <span class="nav-text">
                           홈
                        </span>
            </a>
        </li>

        <li class="has-subnav">
            <a href="customBookList">
                <i class="fa fa-magnifying-glass fa-2x"></i>
                <span class="nav-text">
                            도서 검색
                        </span>
            </a>
        </li>

        <sec:authorize access="isAnonymous()">
            <li>
                <a href="/member/login">
                    <i class="fa fa-right-to-bracket fa-2x"></i>
                    <span class="nav-text">
                            로그인
                        </span>
                </a>
            </li>
        </sec:authorize>

        <li class="has-subnav">
            <a href="/customBookList">
                <i class="fa fa-magnifying-glass fa-2x"></i>
                <span class="nav-text">
                            도서 검색
                        </span>
            </a>
        </li>

        <sec:authorize access="isAuthenticated()">
            <li class="has-subnav">
                <a class="${current eq 'orderProcess' ? 'active' : '' } item"
                   href="/order/process">
                    <i class="fa fa-solid fa-cart-plus fa-2x"></i>
                    <span class="nav-text">
                            발주 관리
                        </span>
                </a>
            </li>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <li class="has-subnav">
                <a class="${current eq 'orderList' ? 'active' : '' } item"
                   href="/order/details">
                    <i class="fa fa-solid fa-cart-arrow-down fa-2x"></i>
                    <span class="nav-text">
                            발주 내역
                        </span>
                </a>
            </li>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <li class="has-subnav">
                <a href="/inventory/inboundSellingList">
                    <i class="fa fa-cart-flatbed fa-2x"></i>
                    <span class="nav-text">
                            입고 내역
                        </span>
                </a>
            </li>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <li class="has-subnav">

                <a href="/inventory/inventoryList">
                    <i class="fa fa-industry fa-2x"></i>
                    <span class="nav-text">
                            재고 목록
                        </span>
                </a>
            </li>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <li class="has-subnav">

                <a href="/list">
                    <i class="fa fa-book fa-2x"></i>
                    <span class="nav-text">
                            매대 관리
                        </span>
                </a>
            </li>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <li class="has-subnav">
                <a href="/Revenue/daily">
                    <i class="fa fa-chart-line fa-2x"></i>
                    <span class="nav-text">
                            매출 관리
                    </span>
                </a>
            </li>
        </sec:authorize>

        <sec:authorize access="isAnonymous()">
            <li>
                <a href="/member/signup">
                    <i class="fa fa-user-plus fa-2x"></i>
                    <span class="nav-text">
                           회원 가입
                        </span>
                </a>
            </li>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <li>
                <a href="/member/info?id=<sec:authentication property="name"/>">
                    <i class="fa fa-id-card fa-2x"></i>
                    <span class="nav-text">
                            마이페이지
                        </span>
                </a>
            </li>
        </sec:authorize>

        <sec:authorize access="hasAuthority('manager')">
            <li>
                <a href="/member/list">
                    <i class="fa fa-cogs fa-2x"></i>
                    <span class="nav-text">
                            직원 관리 목록
                        </span>
                </a>
            </li>
        </sec:authorize>
        >
    </ul>

    <sec:authorize access="isAuthenticated()">
        <ul class="logout">
            <li>
                <a href="/member/logout">
                    <i class="fa fa-power-off fa-2x"></i>
                    <span class="nav-text">
                            로그아웃
                        </span>
                </a>
            </li>
        </ul>
    </sec:authorize>

</nav>