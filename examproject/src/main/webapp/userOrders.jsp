<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page errorPage="error.jsp" isErrorPage="false" %>
<c:set var="servletPath" value="${pageContext.request.servletPath}"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<t:pagetemplate>
    <jsp:attribute name="header">
        Dine ordre
    </jsp:attribute>

    <jsp:body>
        <br>
        <br>
        <c:if test="${sessionScope.orders == null}">
            <p>Der er ingen forespørgsler i systemet</p>
        </c:if>
        <c:if test="${sessionScope.orders != null}">
            <c:forEach items="${sessionScope.orders}" var="order">
                <div class="card text-center mb-3<c:if test="${order.orderStatus.equals('Færdigt')}"> bg-secondary</c:if>">
                    <div class="row g-0 align-items-center">
                        <div class="col-md-2">
                            <img src="${contextPath}/images/carport%20fladt%20tag.png">
                        </div>
                        <div class="col-md-2">
                            <h5 class="card-title">Carport med fladt tag</h5>
                        </div>
                        <div class="col-md-8">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <p class="card-text">Dato for bestilling: 9 Maj, 2022</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p class="card-text">Pris: 1,000,000 Kr.</p>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <p class="card-text">Ordre status: ${order.orderStatus}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p class="card-text">Tegninger og stykliste: Tilgængelig</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </jsp:body>
</t:pagetemplate>