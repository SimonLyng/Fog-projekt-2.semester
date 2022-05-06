<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page errorPage="error.jsp" isErrorPage="false" %>

<t:pagetemplate>
    <jsp:attribute name="header">
        Login
    </jsp:attribute>

    <jsp:body>

        <form action="login" method="post">
            <div class="row mb-3">
                <label for="email" class="col-sm-2 col-form-label">E-mail: </label>
                <div class="col-sm-10">
                    <input type="email" class="form-control" id="email" name="email"/>
                </div>
            </div>
            <div class="row mb-3">
                <label for="password" class="col-sm-2 col-form-label">Password: </label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="password" name="password"/>
                </div>
            </div>
            <div class="row mb-3 justify-content-center">
                <div class="col-sm-3">
                    <input type="submit" class="btn btn-primary" value="Log på"/>
                </div>
            </div>
        </form>
        <br>
        <br>
    </jsp:body>
</t:pagetemplate>