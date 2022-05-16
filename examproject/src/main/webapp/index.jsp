<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page errorPage="error.jsp" isErrorPage="false" %>

<t:pagetemplate>
    <jsp:attribute name="header">
         Carport med fladt tag
    </jsp:attribute>

    <jsp:body>
        <div class="d-flex flex-row pt-3 mb-3">
            <div>
                <ul class="nav flex-column text-uppercase">
                    <li><a href="#" class="nav-link px-2 border-bottom sidebar-link">Carport med fladt tag</a></li>
                    <li><a href="#" class="nav-link px-2 border-bottom sidebar-link">Carport med rejsning</a></li>
                    <li><a href="#" class="nav-link px-2 border-bottom sidebar-link">Standard carporte</a></li>
                </ul>
            </div>
            <div class="flex-grow-1" style="padding: 0 2rem;">
                <h2>Quick-Byg tilbud - carport med fladt tag</h2>
                <p>
                    Med et specialudviklet computerprogram kan vi lynhurtigt beregne prisen og udskrive en skitsetegning på en carport indenfor vores standardprogram, der tilpasses dine specifikke ønsker.
                </p>
                <p>
                    Tilbud og skitsetegning fremsendes med post hurtigst muligt.
                    <br>
                    Ved bestilling medfølger standardbyggevejledning.
                </p>
                <p>
                    <strong>Udfyld nedenstående omhyggeligt og klik på "Bestil tilbud"</strong>
                    <br>
                    Felter markeret * SKAL udfyldes!
                </p>
                <c:if test="${sessionScope.user == null }">
                    <form action="createaccount" method="POST">
                        <br>
                        <legend>Carport</legend>
                        <div class="mb-3">
                            <label for="carW" class="form-label">Bredde</label>
                            <select id="carW" name="carW" class="form-select">
                                <option value="" selected>Vælg bredde</option>
                                <option value="240">240 cm</option>
                                <option value="270">270 cm</option>
                                <option value="300">300 cm</option>
                                <option value="330">330 cm</option>
                                <option value="360">360 cm</option>
                                <option value="390">390 cm</option>
                                <option value="420">420 cm</option>
                                <option value="450">450 cm</option>
                                <option value="480">480 cm</option>
                                <option value="510">510 cm</option>
                                <option value="540">540 cm</option>
                                <option value="570">570 cm</option>
                                <option value="600">600 cm</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="carL" class="form-label">Længde</label>
                            <select id="carL" name="carL" class="form-select">
                                <option value="" selected>Vælg længde</option>
                                <option value="240">240 cm</option>
                                <option value="270">270 cm</option>
                                <option value="300">300 cm</option>
                                <option value="330">330 cm</option>
                                <option value="360">360 cm</option>
                                <option value="390">390 cm</option>
                                <option value="420">420 cm</option>
                                <option value="450">450 cm</option>
                                <option value="480">480 cm</option>
                                <option value="510">510 cm</option>
                                <option value="540">540 cm</option>
                                <option value="570">570 cm</option>
                                <option value="600">600 cm</option>
                                <option value="630">630 cm</option>
                                <option value="660">660 cm</option>
                                <option value="690">690 cm</option>
                                <option value="720">720 cm</option>
                                <option value="750">750 cm</option>
                                <option value="780">780 cm</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="roof" class="form-label">Tag</label>
                            <select id="roof" name="roof" class="form-select">
                                <option value="1">Plasttrapezplader</option>
                                <option value="2" selected>Plasttrapezplader</option>
                            </select>
                        </div>
                        <br>
                        <legend>Redskabsrum</legend>
                        <div class="mb-3">
                            <label class="form-label">Redskabsrum</label>
                            <br>
                            NB! Der skal beregnes 15 cm tagudhæng på hver side af redskabsrummet*
                        </div>
                        <div class="mb-3">
                            <label for="shedW" class="form-label">Redskabsrum bredde</label>
                            <select id="shedW" name="shedW" class="form-select">
                                <option value="" selected>Ønsker ikke redskabsrum</option>
                                <option value="210">210 cm</option>
                                <option value="240">240 cm</option>
                                <option value="270">270 cm</option>
                                <option value="300">300 cm</option>
                                <option value="330">330 cm</option>
                                <option value="360">360 cm</option>
                                <option value="390">390 cm</option>
                                <option value="420">420 cm</option>
                                <option value="450">450 cm</option>
                                <option value="480">480 cm</option>
                                <option value="510">510 cm</option>
                                <option value="540">540 cm</option>
                                <option value="570">570 cm</option>
                                <option value="600">600 cm</option>
                                <option value="630">630 cm</option>
                                <option value="660">660 cm</option>
                                <option value="690">690 cm</option>
                                <option value="720">720 cm</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="shedL" class="form-label">Redskabsrum længde</label>
                            <select id="shedL" name="shedL" class="form-select">
                                <option value="" selected>Ønsker ikke redskabsrum</option>
                                <option value="150">150 cm</option>
                                <option value="180">180 cm</option>
                                <option value="210">210 cm</option>
                                <option value="240">240 cm</option>
                                <option value="270">270 cm</option>
                                <option value="300">300 cm</option>
                                <option value="330">330 cm</option>
                                <option value="360">360 cm</option>
                                <option value="390">390 cm</option>
                                <option value="420">420 cm</option>
                                <option value="450">450 cm</option>
                                <option value="480">480 cm</option>
                                <option value="510">510 cm</option>
                                <option value="540">540 cm</option>
                                <option value="570">570 cm</option>
                                <option value="600">600 cm</option>
                                <option value="630">630 cm</option>
                                <option value="660">660 cm</option>
                                <option value="690">690 cm</option>
                            </select>
                        </div>
                        <br>
                        <legend>Personlige oplysninger</legend>
                        <div class="mb-3">
                            <label for="createEmail" class="form-label">E-mail</label>
                            <input type="email" class="form-control" id="createEmail" name="createEmail">
                        </div>
                        <div class="mb-3">
                            <label for="createPassword" class="form-label">Adgangskode</label>
                            <input type="password" class="form-control" id="createPassword" name="createPassword">
                        </div>
                        <div class="mb-3">
                            <label for="createName" class="form-label">Navn</label>
                            <input type="text" class="form-control" id="createName" name="createName">
                        </div>
                        <div class="mb-3">
                            <label for="createPhone" class="form-label">Telefon nr.</label>
                            <input type="text" class="form-control" id="createPhone" name="createPhone">
                        </div>
                        <div class="mb-3">
                            <label for="createCardNr" class="form-label">Kort nr.</label>
                            <input type="number" class="form-control" id="createCardNr" name="createCardNr">
                        </div>
                        <div class="mb-3">
                            <label for="createExpMonth" class="form-label">Kort udløbsdato</label>
                            <div class="input-group">
                                <input type="number" class="form-control" id="createExpMonth" name="createExpMonth" placeholder="mm">
                                <input type="number" class="form-control" id="createExpYear" name="createExpYear" placeholder="yy">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="createCvc" class="form-label">CVC</label>
                            <input type="number" class="form-control" id="createCvc" name="createCvc">
                        </div>
                        <div class="mb-3">
                            <label for="createAddress" class="form-label">Adresse</label>
                            <input type="text" class="form-control" id="createAddress" name="createAddress">
                        </div>
                        <div class="mb-3">
                            <label for="createZip" class="form-label">Postnummer og by</label>
                            <div class="input-group">
                                <input type="number" class="form-control" id="createZip" name="createZip" minlength="4" maxlength="4" placeholder="Post nr.">
                                <input type="text" class="form-control" id="createCity" name="createCity" placeholder="By">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="inputBemærkninger" class="form-label">Evt. bemærkninger</label>
                            <textarea class="form-control" id="inputBemærkninger" rows="2"></textarea>
                        </div>
                        <input type="hidden" name="pageHidden" value="index" />
                        <button type="submit" class="btn btn-primary">Opret ordre og konto</button>
                    </form>
                </c:if>
                <c:if test="${sessionScope.user != null }">
                    <form action="addorder" method="POST">
                        <br>
                        <legend>Carport</legend>
                        <div class="mb-3">
                            <label for="carW2" class="form-label">Bredde</label>
                            <select id="carW2" name="carW2" class="form-select">
                                <option value="" selected>Vælg bredde</option>
                                <option value="240">240 cm</option>
                                <option value="270">270 cm</option>
                                <option value="300">300 cm</option>
                                <option value="330">330 cm</option>
                                <option value="360">360 cm</option>
                                <option value="390">390 cm</option>
                                <option value="420">420 cm</option>
                                <option value="450">450 cm</option>
                                <option value="480">480 cm</option>
                                <option value="510">510 cm</option>
                                <option value="540">540 cm</option>
                                <option value="570">570 cm</option>
                                <option value="600">600 cm</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="carL2" class="form-label">Længde</label>
                            <select id="carL2" name="carL2" class="form-select">
                                <option value="" selected>Vælg længde</option>
                                <option value="240">240 cm</option>
                                <option value="270">270 cm</option>
                                <option value="300">300 cm</option>
                                <option value="330">330 cm</option>
                                <option value="360">360 cm</option>
                                <option value="390">390 cm</option>
                                <option value="420">420 cm</option>
                                <option value="450">450 cm</option>
                                <option value="480">480 cm</option>
                                <option value="510">510 cm</option>
                                <option value="540">540 cm</option>
                                <option value="570">570 cm</option>
                                <option value="600">600 cm</option>
                                <option value="630">630 cm</option>
                                <option value="660">660 cm</option>
                                <option value="690">690 cm</option>
                                <option value="720">720 cm</option>
                                <option value="750">750 cm</option>
                                <option value="780">780 cm</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="roof2" class="form-label">Tag</label>
                            <select id="roof2" name="roof2" class="form-select">
                                <option value="1">Plasttrapezplader</option>
                                <option value="2" selected>Plasttrapezplader</option>
                            </select>
                        </div>
                        <br>
                        <legend>Redskabsrum</legend>
                        <div class="mb-3">
                            <label class="form-label">Redskabsrum</label>
                            <br>
                            NB! Der skal beregnes 15 cm tagudhæng på hver side af redskabsrummet*
                        </div>
                        <div class="mb-3">
                            <label for="shedW2" class="form-label">Redskabsrum bredde</label>
                            <select id="shedW2" name="shedW2" class="form-select">
                                <option value="" selected>Ønsker ikke redskabsrum</option>
                                <option value="210">210 cm</option>
                                <option value="240">240 cm</option>
                                <option value="270">270 cm</option>
                                <option value="300">300 cm</option>
                                <option value="330">330 cm</option>
                                <option value="360">360 cm</option>
                                <option value="390">390 cm</option>
                                <option value="420">420 cm</option>
                                <option value="450">450 cm</option>
                                <option value="480">480 cm</option>
                                <option value="510">510 cm</option>
                                <option value="540">540 cm</option>
                                <option value="570">570 cm</option>
                                <option value="600">600 cm</option>
                                <option value="630">630 cm</option>
                                <option value="660">660 cm</option>
                                <option value="690">690 cm</option>
                                <option value="720">720 cm</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="shedL2" class="form-label">Redskabsrum længde</label>
                            <select id="shedL2" name="shedL2" class="form-select">
                                <option value="" selected>Ønsker ikke redskabsrum</option>
                                <option value="150">150 cm</option>
                                <option value="180">180 cm</option>
                                <option value="210">210 cm</option>
                                <option value="240">240 cm</option>
                                <option value="270">270 cm</option>
                                <option value="300">300 cm</option>
                                <option value="330">330 cm</option>
                                <option value="360">360 cm</option>
                                <option value="390">390 cm</option>
                                <option value="420">420 cm</option>
                                <option value="450">450 cm</option>
                                <option value="480">480 cm</option>
                                <option value="510">510 cm</option>
                                <option value="540">540 cm</option>
                                <option value="570">570 cm</option>
                                <option value="600">600 cm</option>
                                <option value="630">630 cm</option>
                                <option value="660">660 cm</option>
                                <option value="690">690 cm</option>
                            </select>
                        </div>
                        <br>
                        <div class="mb-3">
                            <label for="inputBemærkninger2" class="form-label">Evt. bemærkninger</label>
                            <textarea class="form-control" id="inputBemærkninger2" rows="2"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Opret ordre</button>
                    </form>
                </c:if>
            </div>
        </div>
    </jsp:body>

</t:pagetemplate>