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
            <c:forEach items="${['Started', 'Påbegyndt', 'Færdigt']}" var="status">
                <table class="table table-dark table-striped">
                    <thead>
                        <tr>
                            <th scope="col">Kunde id</th>
                            <th scope="col">Ordre id</th>
                            <th scope="col">Status</th>
                            <th scope="col">Carport bredde</th>
                            <th scope="col">Carport længde</th>
                            <th scope="col">Skur bredde</th>
                            <th scope="col">Skur længde</th>
                            <th scope="col">Carport tag</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${sessionScope.orders}" var="order">
                            <c:if test="${order.orderStatus.equals(status)}">
                                <form action="/editorder">
                                    <tr id="rowOrderEdit${order.idOrder}" hidden>
                                        <td>${order.idCustomer}</td>
                                        <td>${order.idOrder}</td>
                                        <td>${order.orderStatus}</td>
                                        <td>
                                            <select class="form-select">
                                                <c:forEach begin="240" end="600" step="30" var="value">
                                                    <option value="${value}"<c:if test="${order.carportBred == value}"> selected</c:if>>
                                                            ${value} cm
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td>
                                            <select class="form-select">
                                                <c:forEach begin="240" end="780" step="30" var="value">
                                                    <option value="${value}"<c:if test="${order.carportLængde == value}"> selected</c:if>>
                                                            ${value} cm
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td>
                                            <select class="form-select">
                                                <c:forEach begin="210" end="720" step="30" var="value">
                                                    <option value="${value}"<c:if test="${order.skurBred == value}"> selected</c:if>>
                                                            ${value} cm
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td>
                                            <select class="form-select">
                                                <c:forEach begin="150" end="690" step="30" var="value">
                                                    <option value="${value}"<c:if test="${order.skurLængde == value}"> selected</c:if>>
                                                            ${value} cm
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </td>
                                        <td>${order.tag}</td>
                                        <td>
                                            <button class="btn btn-primary" onclick="stopEditOrder(${order.idOrder})">
                                                Rediger
                                            </button>
                                        </td>
                                    </tr>
                                </form>
                                <tr id="rowOrder${order.idOrder}">
                                    <td>${order.idCustomer}</td>
                                    <td>${order.idOrder}</td>
                                    <td>${order.orderStatus}</td>
                                    <td>${order.carportBred}</td>
                                    <td>${order.carportLængde}</td>
                                    <td>${order.skurBred}</td>
                                    <td>${order.skurLængde}</td>
                                    <td>${order.tag}</td>
                                    <c:if test="${order.orderStatus.equals('Started')}">
                                        <td>
                                            <button class="btn btn-primary" onclick="startEditOrder(${order.idOrder})">
                                                Rediger
                                            </button>
                                        </td>
                                        <td>
                                            <form method="post" action="removeorder">
                                                <button class="btn btn-secondary" type="submit" id="Fjern" name="OrderID" value="${order.idOrder}">
                                                    Fjern
                                                </button>
                                            </form>
                                        </td>
                                        <td>
                                            <form method="post" action="updatestatusorder">
                                                <input type="hidden" name="status" value="${order.orderStatus}"/>
                                                <button class="btn btn-secondary" type="submit" id="updatestatusorder" name="OrderID" value="${order.idOrder}">
                                                    Send videre
                                                </button>
                                            </form>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
                <br>
                <br>
            </c:forEach>
        </c:if>
        <script>
            function startEditOrder(value) {
                document.getElementById("rowOrder" + value).setAttribute("hidden", "");
                document.getElementById("rowOrderEdit" + value).removeAttribute("hidden");
            }

            function stopEditOrder(value) {
                document.getElementById("rowOrderEdit" + value).setAttribute("hidden", "");
                document.getElementById("rowOrder" + value).removeAttribute("hidden");
            }
        </script>

    </jsp:body>
</t:pagetemplate>