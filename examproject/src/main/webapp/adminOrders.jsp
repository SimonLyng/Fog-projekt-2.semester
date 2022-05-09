<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page errorPage="error.jsp" isErrorPage="false" %>

<t:pagetemplate>
    <jsp:attribute name="header">
        Ordre status
    </jsp:attribute>

    <jsp:body>

        <br>
        <br>
        <c:if test="${sessionScope.orders == null}">
            <p>Der er ingen forespørgsler i systemet</p>
        </c:if>
        <c:if test="${sessionScope.orders != null}">
            <table class="table table-dark table-striped">
                <thead>
                <tr>
                    <th scope="col">Kunde id</th>
                    <th scope="col">Ordre id</th>
                    <th scope="col">Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${sessionScope.orders}" var="order">
                    <c:if test="${order.getOrderStatus().equals('Started')}">
                        <tr>
                            <td>${Integer.parseInt(order.getIdCustomer())}</td>
                            <td>${Integer.parseInt(order.getIdOrder())}</td>
                            <td>${order.getOrderStatus()}</td>
                            <td> <input id="clickMe" type="button" value="Fjern Ordre" onclick="removeOrder(${Integer.parseInt(order.getIdOrder())});" /></td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
            <br>
            <br>
            <table class="table table-dark table-striped">
                <thead>
                <tr>
                    <th scope="col">Kunde id</th>
                    <th scope="col">Ordre id</th>
                    <th scope="col">Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${sessionScope.orders}" var="order">
                    <c:if test="${order.getOrderStatus().equals('Påbegyndt')}">
                        <tr>
                            <td>${Integer.parseInt(order.getIdCustomer())}</td>
                            <td>${Integer.parseInt(order.getIdOrder())}</td>
                            <td>${order.getOrderStatus()}</td>
                            <td> <input id="clickMe1" type="button" value="Fjern Ordre" onclick="removeOrder(${Integer.parseInt(order.getIdOrder())});" /></td>
                            <button onclick="removeOrder()">Fjern Ordre</button>

                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
            <br>
            <br>
            <table class="table table-dark table-striped">
                <thead>
                <tr>
                    <th scope="col">Kunde id</th>
                    <th scope="col">Ordre id</th>
                    <th scope="col">Status</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${sessionScope.orders}" var="order">
                    <c:if test="${order.getOrderStatus().equals('Færdigt')}">
                        <tr>
                            <td>${Integer.parseInt(order.getIdCustomer())}</td>
                            <td>${Integer.parseInt(order.getIdOrder())}</td>
                            <td>${order.getOrderStatus()}</td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </c:if>

    </jsp:body>
</t:pagetemplate>