<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page errorPage="error.jsp" isErrorPage="false" %>

<t:pagetemplate>
    <jsp:attribute name="header">
        Opret bruger
    </jsp:attribute>

    <jsp:body>
        <form action="createaccount" method="post">
            <div class="row mb-3">
                <label for="createEmail" class="col-sm-2 col-form-label">E-mail: </label>
                <div class="col-sm-10">
                    <input type="email" class="form-control" id="createEmail" name="createEmail"/>
                </div>
            </div>
            <div class="row mb-3">
                <label for="createPassword" class="col-sm-2 col-form-label">Password: </label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="createPassword" name="createPassword"/>
                </div>
            </div>
            <div class="row mb-3">
                <label for="createName" class="col-sm-2 col-form-label">Navn: </label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="createName" name="createName"/>
                </div>
            </div>
            <div class="row mb-3">
                <label for="createPhone" class="col-sm-2 col-form-label">Telefon nr: </label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="createPhone" name="createPhone" maxlength="8" minlength="8"/>
                </div>
            </div>
            <div class="row mb-3">
                <label for="createCardNr" class="col-sm-2 col-form-label">Kort nr: </label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="createCardNr" name="createCardNr" maxlength="16" minlength="16"/>
                </div>
            </div>
            <div class="row mb-5">
                <label for="createExpMonth" class="col-sm-2 col-form-label">Kort udløbsdato: </label>
                <div class="col-sm-1">
                    <input type="text" class="form-control" id="createExpMonth" name="createExpMonth" maxlength="2" minlength="2"/>
                </div>
                <div class="col-sm-1">
                    <a>/</a>
                </div>
                <div class="col-sm-1">
                    <input type="text" class="form-control" id="createExpYear" name="createExpYear" maxlength="2" minlength="2"/>
                </div>
                <label for="createCvc" class="col-sm-1 col-form-label">cvc: </label>
                <div class="col-sm-1">
                    <input type="text" class="form-control" id="createCvc" name="createCvc" maxlength="3" minlength="3"/>
                </div>
            </div>
            <input type="hidden" name="pageHidden" value="createHidden" />
            <div class="row mb-3 justify-content-center">
                <div class="col-sm-3">
                    <input type="submit" class="btn btn-primary" value="Opret konto"/>
                </div>
            </div>
        </form>
        <br>
        <br>
    </jsp:body>
</t:pagetemplate>
