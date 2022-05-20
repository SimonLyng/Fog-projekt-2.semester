<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page errorPage="error.jsp" isErrorPage="false" %>
<c:set var="servletPath" value="${pageContext.request.servletPath}"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<t:pagetemplate>
    <jsp:attribute name="header">
        Forespørgsel
    </jsp:attribute>

    <jsp:body>
        <br>
        <br>
        <p>Plantegninger set oppefra</p>
        <div class="col-md-2">
            <img src="${contextPath}/images/carport%20fladt%20tag.png">
        </div>
        <p>Plantegninger set fra siden</p>
        <div class="col-md-2">
            <img src="${contextPath}/images/carport%20fladt%20tag.png">
        </div>
        <div class="card text-center mb-3">
            <div class="row g-0 align-items-center">
                <div class="col-md-2">
                    <h5 class="card-title">Carport med fladt tag</h5>
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p class="card-text">Dato for bestilling: ${sessionScope.date}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="card-text">Vejledende pris: ${sessionScope.price} kr.</p>
                            </div>
                        </div>
                        <div class="row">
<%--                            <div class="col-md-6">--%>
<%--                                <p class="card-text">Ordre status: ${sessionScope.order.orderStatus}</p>--%>
<%--                            </div>--%>
                            <div class="col-md-6">
                                <p class="card-text">Tegninger og stykliste: Tilgængelig</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <form method="post" action="removeorder">
            <input type="hidden" name="pageHidden" value="accept" />
            <button type="submit" class="btn btn-primary">Fortryd ordre</button>
        </form>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/orders.jsp" role="button">Send forespørgsel</a>
    </jsp:body>
</t:pagetemplate>