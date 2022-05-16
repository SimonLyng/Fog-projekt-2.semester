<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page errorPage="error.jsp" isErrorPage="false" %>

<t:pagetemplate>
    <jsp:attribute name="header">
        <br>
             Stykliste
    </jsp:attribute>

    <jsp:body>
        <c:if test="${sessionScope.rt != null}">
            <table class="table table-dark table-striped">
                <thead>
                <tr>
                    <th scope="col">Type</th>
                    <th scope="col">Beskrivelse</th>
                    <th scope="col">Længde</th>
                    <th scope="col">Antal</th>
                    <th scope="col">Fremgangsmåde</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${sessionScope.rt}" var="styk">
                    <tr>
                        <td>${styk.getType()}</td>
                        <td>${styk.getDescription()}</td>
                        <td>${Integer.parseInt(styk.getLength())}</td>
                        <td>${Integer.parseInt(styk.getAmount())}</td>
                        <td>${styk.getDesc()}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${sessionScope.sf != null}">
            <table class="table table-dark table-striped">
                <thead>
                <tr>
                    <th scope="col">Type</th>
                    <th scope="col">Beskrivelse</th>
                    <th scope="col">Antal</th>
                    <th scope="col">Enhed</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${sessionScope.sf}" var="styk">
                    <tr>
                        <td>${styk.getType()}</td>
                        <td>${styk.getDescription()}</td>
                        <td>${Integer.parseInt(styk.getAmount())}</td>
                        <td>${styk.getUnit()}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
    </jsp:body>
</t:pagetemplate>