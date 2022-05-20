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
            <c:forEach items="${sessionScope.compiledOrders}" var="list">
                <c:if test="${list.isEmpty() != true}">
                <h3>Tabel for ${list.get(0).getOrderStatus()}</h3>
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
                            <th></th>
                            <c:if test="${list.get(0).getOrderStatus().equals('Started')}">
                                <th scope="col">Rediger ordre</th>
                                <th scope="col">Fjern ordre</th>
                                <th scope="col">Updater status</th>
                            </c:if>
                            <c:if test="${list.get(0).getOrderStatus().equals('Påbegyndt')}">
                                <th scope="col">Updater status</th>
                            </c:if>
                            <th scope="col">Se stykliste</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${list}" var="order">
                            <tr id="rowOrder${order.idOrder}">
                                <td>${order.idCustomer}</td>
                                <td>${order.idOrder}</td>
                                <td>${order.orderStatus}</td>
                                <td id="carWVal${order.idOrder}">${order.carportBred}</td>
                                <td id="carLVal${order.idOrder}">${order.carportLængde}</td>
                                <td id="shedWVal${order.idOrder}">${order.skurBred}</td>
                                <td id="shedLVal${order.idOrder}">${order.skurLængde}</td>
                                <td>${order.tag}</td>
                                <td>${order.date}</td>
                                <c:if test="${order.orderStatus.equals('Started')}">
                                    <td>
                                        <button class="btn btn-primary" onclick="editOrder(${order.idOrder}, this)">
                                            Rediger
                                        </button>
                                    </td>
                                    <td>
                                        <form method="post" action="removeorder">
                                            <input type="hidden" name="pageHidden" value=""/>
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
                                <c:if test="${order.orderStatus.equals('Påbegyndt')}">
                                    <td>
                                        <form method="post" action="updatestatusorder">
                                            <input type="hidden" name="status" value="${order.orderStatus}"/>
                                            <button class="btn btn-secondary" type="submit" id="updatestatusorder" name="OrderID" value="${order.idOrder}">
                                                Send videre
                                            </button>
                                        </form>
                                    </td>
                                </c:if>
                                <td>
                                    <form method="post" action="styklist">
                                        <input type="hidden" name="status" value="${order.orderStatus}"/>
                                        <button class="btn btn-secondary" type="submit" id="stykliste" name="orderid" value="${order.idOrder}">
                                            Stykliste
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <form action="/editorder">
                                <tr id="rowOrderEdit${order.idOrder}" hidden>
                                    <td colspan="13" style="padding: 0;">
                                        <table class="table table-dark" style="border-width: 0">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Carport bredde</th>
                                                    <th scope="col">Carport længde</th>
                                                    <th scope="col">Skur bredde</th>
                                                    <th scope="col">Skur længde</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <input class="form-range carW" id="carW" type="range" min="240" max="600" step="30" value="${order.carportBred}" oninput="updateSVGs(${order.idOrder})">
                                                    </td>
                                                    <td>
                                                        <input class="form-range carL" id="carL" type="range" min="240" max="780" step="30" value="${order.carportLængde}" oninput="updateSVGs(${order.idOrder})">
                                                    </td>
                                                    <td>
                                                        <input class="form-range shedW" id="shedW" type="range" min="210" max="720" step="30" value="${order.skurBred}" oninput="updateSVGs(${order.idOrder})">
                                                    </td>
                                                    <td>
                                                        <input class="form-range shedL" id="shedL" type="range" min="150" max="690" step="30" value="${order.skurLængde}" oninput="updateSVGs(${order.idOrder})">
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <table class="table table-light">
                                            <thead>
                                                <tr>
                                                    <th>Side illustration</th>
                                                    <th>Top illustration</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <svg width="600" height="600" x="0" y="0" preserveAspectRatio="xMinYMin" id="sideSVG${order.idOrder}">
                                                            <style>
                                                                text { text-anchor: middle; dominant-baseline: middle; }
                                                            </style>
                                                            <text x="300" y="300">Please ensure that javascript is enabled in your browser</text>
                                                        </svg>
                                                    </td>
                                                    <td>
                                                        <svg width="600" height="600" x="0" y="0" preserveAspectRatio="xMinYMin" id="topSVG${order.idOrder}">
                                                            <style>
                                                                text { text-anchor: middle; dominant-baseline: middle; }
                                                            </style>
                                                            <text x="300" y="300">Please ensure that javascript is enabled in your browser</text>
                                                        </svg>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
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
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </td>
                                </tr>
                            </form>
                        </c:forEach>
                    </tbody>
                </table>
                </c:if>
                <br>
                <br>
            </c:forEach>
        </c:if>
        <script>
            function editOrder(value, element) {
                const toggled = document.getElementById("rowOrderEdit" + value).toggleAttribute("hidden");
                // if (toggled) {
                //     element.innerHTML = "Rediger";
                // } else {
                //     element.innerHTML = "Stop redigering";
                // }
            }

            function stopEditOrder(value) {
                document.getElementById("rowOrderEdit" + value).setAttribute("hidden", "");
                document.getElementById("rowOrder" + value).removeAttribute("hidden");
            }
        </script>
        <script>
            // Det her script er en kopi af Calculator klassen som er skrevet i Java.
            const widthPiece = 0.55;
            function calPost(objectLength) {
                // Starter med 4, hvis der er skur på, skal der være 4 ekstra, og så skal der sættes 2 ind per 3-3,3 meter
                const length = objectLength/100;
                const post = 4; // Starts of as 4, because there is a minimum of 5 posts
                const extraPosts = Math.floor((length-(4*widthPiece))/3.3)*2;
                return post+extraPosts;
            }

            function calRafters(objectLength) { // Udregner til spær
                const rafters = 2; // There is at least 2 rafters, 1 in each end
                const length = objectLength/100;
                const extraRafters = Math.floor(length/(widthPiece+0.045));
                return rafters+extraRafters;
            }
        </script>
        <script>
            // Both SVGs. activeSVG is the one currently being drawn.
            //const topSVGs = document.getElementsByClassName("topSVG");
            //const sideSVGs = document.getElementsByClassName("sideSVG");
            let activeSVG;

            // Styles for the rectangles
            const blank = "stroke: #000000; fill: #fff;";
            const clear = "stroke: #000000; fill: none;";
            // These styles are for debugging.
            const clearRed = "stroke: #f006; fill: #f006;";
            const red = "stroke: #f00; fill: #f00;";

            let canvasX = 0;
            let canvasY = 0;
            const canvasZ = 230;
            let amountOfRafters = 0;
            let amountOfPosts = 0;
            let shed;
            let shedX;
            let shedY;
            let shedPos;

            const rafterY = 4.5;
            const rafterZ = 19.5;
            const postsX = 10;
            const postsY = 10;
            const postsZ = 210;
            const postsXOffsetLeft = 50;
            const postsXOffsetRight = 50;
            const roofZ = 230-210
            const shedPlanksY = 1.9;
            const shedPlanksX = 10;
            const shedPlanksZ = 210;

            function clearTopSVG() {
                topSVGs.innerHTML = "";
            }

            function clearSideSVG() {
                sideSVGs.innerHTML = "";
            }

            function drawRect(x, y, width, height, style) {
                const rect = document.createElement("rect");
                rect.setAttribute("x", x);
                rect.setAttribute("y", y);
                rect.setAttribute("width", width);
                rect.setAttribute("height", height);
                rect.setAttribute("style", style);
                activeSVG.appendChild(rect);
            }

            function drawTopPosts(amount) {
                const postsTopY = 35-postsY/2;
                const postsBottomY = canvasY-35-postsY/2;
                const offset = (canvasX-postsXOffsetLeft-postsXOffsetRight)/((amount-2)/2);
                for (let i = 0; i < amount/2; i++) {
                    drawRect(postsXOffsetLeft + offset * i - postsX/2, postsTopY, postsX, postsY, clear);
                    drawRect(postsXOffsetLeft + offset * i - postsX/2, postsBottomY, postsX, postsY, clear);
                }
            }

            function drawTopRafters() {
                drawRect(0, 35-rafterY/2, canvasX, rafterY, clear);
                drawRect(0, canvasY-35-rafterY/2, canvasX, rafterY, clear);
            }

            function drawTopRoof() {
                drawRect(0, 0, canvasX, canvasY, clear);
            }

            function drawTopThings(amount) {
                const offset = (canvasX-rafterY)/(amount-1);
                for (let i = 0; i < amount; i++) {
                    drawRect(offset*i, 0, rafterY, canvasY, clear);
                }
            }

            function drawTopShed() {
                if (shed) {
                    const offsetX = 50 - postsX/2;
                    const offsetY = 35 - postsY/2;
                    switch (shedPos) {
                        case "center":
                            drawRect(canvasX - offsetX - shedX, canvasY/2 - shedY/2, shedX, shedY, clear);
                            // Adding a shed requires two extra posts
                            drawRect(canvasX - offsetX - shedX, canvasY/2 - postsY/2, postsX, postsY, clear);
                            drawRect(canvasX - offsetX - postsX, canvasY/2 - postsY/2, postsX, postsY, clear);
                            break;
                        case "top":
                            drawRect(canvasX - offsetX - shedX, offsetY, shedX, shedY, clear);

                            drawRect(canvasX - offsetX - shedX, shedY/2 + offsetY - postsY/2, postsX, postsY, clear);
                            drawRect(canvasX - offsetX - postsX, shedY/2 + offsetY - postsY/2, postsX, postsY, clear);
                            break;
                        case "bottom":
                            drawRect(canvasX - offsetX - shedX, canvasY - shedY - offsetY, shedX, shedY, clear);

                            drawRect(canvasX - offsetX - shedX, canvasY - shedY/2 - offsetY - postsY/2, postsX, postsY, clear);
                            drawRect(canvasX - offsetX - postsX, canvasY - shedY/2 - offsetY - postsY/2, postsX, postsY, clear);
                            break;
                    }

                }
            }

            function drawSideRoof() {
                drawRect(0, 0, canvasX, canvasZ-postsZ, blank);
            }

            function drawSidePosts(amount) {
                const offset = (canvasX-postsXOffsetLeft-postsXOffsetRight)/((amount-2)/2);
                for (let i = 0; i < amount/2; i++) {
                    drawRect(postsXOffsetLeft + offset * i - postsX/2, canvasZ-postsZ, postsX, postsZ, blank);
                }
            }

            function drawSideRafters() {
                drawRect(0, roofZ, canvasX, rafterZ, blank)
            }

            function drawSideShed() {
                if (shed) {
                    const offset = 50-postsX/2;
                    for (let i = shedPlanksX; i <= shedX; i += shedPlanksX) {
                        drawRect(canvasX - offset - i, canvasZ-shedPlanksZ, shedPlanksX, shedPlanksZ, blank);
                    }
                    //drawRect(canvasX - offset - shedX, canvasZ-shedPlanksZ, shedX, shedPlanksZ, red);
                }
            }

            function updateSVGs(oid) {
                // canvasX = document.getElementById("x").value;
                // canvasY = document.getElementById("y").value;
                // amountOfThings = document.getElementById("amountOfThings").value;
                // amountOfPosts = document.getElementById("amountOfPosts").value;
                // shed = document.getElementById("shed").checked;
                // shedX = document.getElementById("shedX").value;
                // shedY = document.getElementById("shedY").value;
                // shedPos = document.getElementById("shedPosition").value;
                const rowOrderEditValues = document.getElementById("rowOrderEdit"+oid);
                document.getElementById("carLVal"+oid).innerText = rowOrderEditValues.getElementsByClassName("carL")[0].value;
                document.getElementById("carWVal"+oid).innerText = rowOrderEditValues.getElementsByClassName("carW")[0].value;
                document.getElementById("shedLVal"+oid).innerText = rowOrderEditValues.getElementsByClassName("shedL")[0].value;
                document.getElementById("shedWVal"+oid).innerText = rowOrderEditValues.getElementsByClassName("shedW")[0].value;
                const rowOrderValues = document.getElementById("rowOrder"+oid).children;
                canvasX = rowOrderValues[4].innerHTML;
                canvasY = rowOrderValues[3].innerHTML;
                amountOfRafters = calRafters(canvasX);
                amountOfPosts = calPost(canvasX);
                shed = true;
                if (rowOrderValues[5].innerHTML <= 0 || rowOrderValues[6].innerHTML <= 0) {
                    shed = false;
                }
                shedX = rowOrderValues[6].innerHTML;
                shedY = rowOrderValues[5].innerHTML;
                shedPos = "top";
                updateSideSVG(oid);
                updateTopSVG(oid);
            }

            function updateSideSVG(oid) {
                // For the sideSVG the rectangles are opaque.
                activeSVG = document.getElementById("sideSVG"+oid);
                //sideSVG.setAttribute("viewBox", `0 0 ${canvasX} ${canvasZ}`);
                activeSVG.setAttribute("viewBox", `0 0 780 780`);
                activeSVG.innerHTML = "";
                drawSideRoof();
                // These if statements are for deciding when the shed should be drawn
                // so that it ends up on the correct layer.
                if (shed) {
                    if (shedPos === "bottom") {
                        drawSidePosts(parseInt(amountOfPosts));
                        drawSideRafters();
                        drawSideShed();
                    }
                    else {
                        console.log(canvasY - shedY)
                        if (canvasY - shedY <= 60) {
                            drawSidePosts(parseInt(amountOfPosts));
                            drawSideRafters();
                            drawSideShed();
                        }
                        else {
                            drawSideShed();
                            drawSidePosts(parseInt(amountOfPosts));
                            drawSideRafters();
                        }
                    }
                }
                else {
                    drawSidePosts(parseInt(amountOfPosts));
                    drawSideRafters();
                }
                activeSVG.innerHTML += "";
            }

            function updateTopSVG(oid) {
                activeSVG = document.getElementById("topSVG"+oid);
                //topSVG.setAttribute("viewBox", `0 0 ${canvasX} ${canvasY}`);
                activeSVG.setAttribute("viewBox", `0 0 780 780`);
                activeSVG.innerHTML = "";
                drawTopRoof();
                drawTopPosts(parseInt(amountOfPosts));
                drawTopRafters();
                drawTopThings(parseInt(amountOfRafters));
                drawTopShed(0, 0);
                activeSVG.innerHTML += "";
            }
            <c:forEach items="${sessionScope.orders}" var="order"><c:if test="${order.orderStatus.equals('Started')}">updateSVGs(${order.idOrder});</c:if>
            </c:forEach>
        </script>
    </jsp:body>
</t:pagetemplate>