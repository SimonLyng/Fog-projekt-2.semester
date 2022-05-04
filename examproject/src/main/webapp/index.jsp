<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page errorPage="error.jsp" isErrorPage="false" %>

<t:pagetemplate>
    <jsp:attribute name="header">
        <br>
         Carport med fladt tag
    </jsp:attribute>

    <jsp:body>

        <%-- Comment: Kunne bruge <c:if test="${sessionScope.user == null }"> så bruger ikke skal
        indtaste e-mail etc. hvis de allerede er logget ind, eneste problem er, submit button --%>
            <form action="createaccount" method="post">
                Ønsket carport mål:
                <div class="row mb-3">
                    <label for="carW" class="col-sm-2 col-form-label">Carport bredde: </label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="carW" name="carW"/>
                    </div>
                </div>
                <div class="row mb-3">
                    <label for="carL" class="col-sm-2 col-form-label">Carport længde: </label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="carL" name="carL"/>
                    </div>
                </div>
                <div class="row mb-3">
                    <label for="roof" class="col-sm-2 col-form-label">Tag: </label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="roof" name="roof"/>
                    </div>
                </div>
                Redskabsrum:
                NB! Der skal beregnes 15 cm tagudhæng på hver side af redskabsrummet*
                <div class="row mb-3">
                    <label for="shedW" class="col-sm-2 col-form-label">Redskabsrum bredde: </label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="shedW" name="shedW"/>
                    </div>
                </div>
                <div class="row mb-3">
                    <label for="shedL" class="col-sm-2 col-form-label">Redskabsrum længde: </label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="shedL" name="shedL"/>
                    </div>
                </div>
                <br>
                <br>
                Personlig info
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
                        <input type="number" class="form-control" id="createPhone" name="createPhone"/>
                    </div>
                </div>
                <div class="row mb-3">
                    <label for="createCardNr" class="col-sm-2 col-form-label">Kort nr: </label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="createCardNr" name="createCardNr"/>
                    </div>
                </div>
                <div class="row mb-5">
                    <label for="createExpMonth" class="col-sm-2 col-form-label">Kort udløbsdato: </label>
                    <div class="col-sm-1">
                        <input type="number" class="form-control" id="createExpMonth" name="createExpMonth"/>
                    </div>
                    <div class="col-sm-1">
                        <a>/</a>
                    </div>
                    <div class="col-sm-1">
                        <input type="number" class="form-control" id="createExpYear" name="createExpYear"/>
                    </div>
                    <label for="createCvc" class="col-sm-1 col-form-label">cvc: </label>
                    <div class="col-sm-1">
                        <input type="number" class="form-control" id="createCvc" name="createCvc"/>
                    </div>
                </div>
                <div class="row mb-3 justify-content-center">
                    <div class="col-sm-3">
                        <input type="submit" class="btn btn-primary" value="Opret ordre og konto"/>
                    </div>
                </div>
            </form>
            <br>
<%--        <c:if test="${sessionScope.user =! null }">
            <form action="addorder" method="post">
                Ønsket carport mål:
                <div class="row mb-3">
                    <label for="carBred" class="col-sm-2 col-form-label">Carport bredde: </label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="carBred" name="carBred"/>
                    </div>
                </div>
                <div class="row mb-3">
                    <label for="carLæng" class="col-sm-2 col-form-label">Carport længde: </label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="carLæng" name="carLæng"/>
                    </div>
                </div>
                <div class="row mb-3">
                    <label for="tag" class="col-sm-2 col-form-label">Tag: </label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="tag" name="tag"/>
                    </div>
                </div>
                Redskabsrum:
                NB! Der skal beregnes 15 cm tagudhæng på hver side af redskabsrummet*
                <div class="row mb-3">
                    <label for="redBred" class="col-sm-2 col-form-label">Redskabsrum bredde: </label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="redBred" name="redBred"/>
                    </div>
                </div>
                <div class="row mb-3">
                    <label for="redLæng" class="col-sm-2 col-form-label">Redskabsrum længde: </label>
                    <div class="col-sm-10">
                        <input type="number" class="form-control" id="redLæng" name="redLæng"/>
                    </div>
                </div>
                <div class="row mb-3 justify-content-center">
                    <div class="col-sm-3">
                        <input type="submit" class="btn btn-primary" value="Opret ordre"/>
                    </div>
                </div>
            </form>
        </c:if>--%>
            <br>
    </jsp:body>

</t:pagetemplate>