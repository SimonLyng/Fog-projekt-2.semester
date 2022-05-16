<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page errorPage="error.jsp" isErrorPage="false" %>

<t:pagetemplate>
    <jsp:attribute name="header">
        <br>
             Kurv
    </jsp:attribute>

    <jsp:body>

        <c:if test="${sessionScope.rt == null}">
            <p>Ingen varer er lagt i kurven</p>
        </c:if>
        <c:if test="${sessionScope.orders != null}">
        <table class="table table-dark table-striped">
            <thead>
            <tr>
                <th scope="col">Ordre id</th>
                <th scope="col">Carport længde</th>
                <th scope="col">Carport bredde</th>
                <th scope="col">Skur længde</th>
                <th scope="col">Skur bredde</th>
                <th scope="col">Status</th>
                <th scope="col">Styklister</th>
                <%--ToDo: Ikke kunne slette ordre, hvis den er betalt?--%>
                <th scope="col">Slet ordre</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${sessionScope.orders}" var="order">
                <tr>
                    <td>${Integer.parseInt(order.getIdOrder())}</td>
                    <td>${Integer.parseInt(order.getCarportLængde())}</td>
                    <td>${Integer.parseInt(order.getCarportBred())}</td>
                    <td>${Integer.parseInt(order.getSkurLængde())}</td>
                    <td>${Integer.parseInt(order.getSkurBred())}</td>
                    <td>${order.getOrderStatus()}</td>
                    <td>
                        <c:if test="${order.getOrderStatus().equals('Started')}">
                            <button type="button" class="btn btn-primary" disabled>Stykliste</button>
                        </c:if>
                        <c:if test="${order.getOrderStatus().equals('Påbegyndt')}">
                            <a class="btn btn-primary" href="${pageContext.request.contextPath}/piecelist.jsp" role="button">Stykliste</a>
                        </c:if>
                    </td>
                    <td>
                        <form method="post" action="removeorder">
                            <input type="hidden" name="pageHidden" value="orders" />
                            <input type="hidden" name="OrderID" value="${Integer.parseInt(order.getIdOrder())}" />
                            <button type="submit" class="btn btn-primary">Slet ordre</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        </c:if>
    </jsp:body>
</t:pagetemplate>