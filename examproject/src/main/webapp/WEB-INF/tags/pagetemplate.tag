<%@tag description="Overall Page template" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@attribute name="header" fragment="true" %>
<%@attribute name="footer" fragment="true" %>
<c:set var="servletPath" value="${pageContext.request.servletPath}"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="da">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>
        <jsp:invoke fragment="header"/>
    </title>
    <link rel="stylesheet" href="${contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- Bootstrap CSS -->
    <link href="${contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <header class="mb-3">
        <div class="container" style="background-color: #0c2069; padding-left: 0px;">
            <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                <a href="${contextPath}/index.jsp">
                    <img src="${contextPath}/images/logo.png">
                </a>
                <div>

                </div>
                <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0 text-uppercase">
                    <c:if test="${sessionScope.user == null }">
                        <li><a href="${contextPath}/index.jsp" class="nav-link px-2 navbar-link">Byg carport</a></li>
                        <li><a href="${contextPath}/createAccount.jsp" class="nav-link px-2 navbar-link">Lav konto</a></li>
                        <li><a href="${contextPath}/login.jsp" class="nav-link px-2 navbar-link">Log ind</a></li>
                    </c:if>
                    <c:if test="${sessionScope.user != null && sessionScope.user.getRole().equals('user')}">
                        <li><a href="${contextPath}/index.jsp" class="nav-link px-2 navbar-link">Byg carport</a></li>
                        <li><a href="${contextPath}/orders.jsp" class="nav-link px-2 navbar-link">Ordre</a></li>
                        <li><a href="${contextPath}/logout" class="nav-link px-2 navbar-link">Log ud</a></li>
                    </c:if>
                    <c:if test="${sessionScope.user != null && sessionScope.user.getRole().equals('admin')}">
                        <li><a href="${contextPath}/adminOrders.jsp" class="nav-link px-2 navbar-link">Se ordre</a></li>
                        <li><a href="${contextPath}/logout" class="nav-link px-2 navbar-link">Log ud</a></li>
                    </c:if>
                </ul>
                <div class="text-light">
                    <c:if test="${sessionScope.user == null }">
                        <i class="fa fa-envelope-o"></i>
                        <a>something@mail.dk</a>
                    </c:if>
                    <c:if test="${sessionScope.user != null }">
                        <i class="fa fa-envelope-o"></i>
                        <a>${sessionScope.user.getMail()}</a>
                    </c:if>
                </div>
            </div>
        </div>
    </header>

    <div class="text-center mb-3 text-uppercase">
        <h1>
            <jsp:invoke fragment="header"/>
        </h1>
    </div>
    <div style="background-color: #f8f8f8;">
        <div class="container">
            <jsp:doBody/>
        </div>
    </div>

    <!-- Footer -->
    <div class="container-fluid mt-2 rounded-3" style="width: 95%;" style="height: 5%;">
        <hr/>
        <div class="row mt-4">
            <div class="col border-end border-3">
                <p class="fw-bold">Adresse</p>
                Cupcakevej 66<br/>
                Bornholm
            </div>
            <div class="col border-end border-3">
                <p class="fw-bold">Om os</p>
                Vi er et lille bageri,<br/>
                der bare elsker at lave cupcakes
            </div>
            <div class="col">
                <p class="fw-bold">Kontakt</p>
                <i class="fa fa-mobile" aria-hidden="true"></i> +45 67 43 28 73<br/>
                <i class="fa fa-envelope-o"></i> OlskerCupcakes@gmail.com
            </div>
        </div>

    </div>

    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="${contextPath}/js/bootstrap.bundle.min.js"></script>

</body>
</html>