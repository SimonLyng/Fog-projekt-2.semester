<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page errorPage="error.jsp" isErrorPage="false" %>

<c:set var="servletPath" value="${pageContext.request.servletPath}"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

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
                            <th scope="col">Dato</th>
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
                                <td>${order.dateToString()}</td>
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
                            <tr id="rowOrderEdit${order.idOrder}" hidden>
                                <td colspan="13" style="padding: 0;">
                                    <form action="${contextPath}/editorder" method="POST">
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
                                                        <input id="carW${order.idOrder}" name="carW" type="hidden" value="${order.carportBred}">
                                                        <input id="carL${order.idOrder}" name="carL" type="hidden" value="${order.carportLængde}">
                                                        <input id="shedW${order.idOrder}" name="shedW" type="hidden" value="${order.skurBred}">
                                                        <input id="shedL${order.idOrder}" name="shedL" type="hidden" value="${order.skurLængde}">

                                                        <input class="form-range" id="tcarW${order.idOrder}" type="range" min="0" max="12" step="1" oninput="onSliderChange(${order.idOrder})">
                                                    </td>
                                                    <td>
                                                        <input class="form-range" id="tcarL${order.idOrder}" type="range" min="0" max="18" step="1" oninput="onSliderChange(${order.idOrder})">
                                                    </td>
                                                    <td>
                                                        <input class="form-range" id="tshedW${order.idOrder}" type="range" min="0" max="17" step="1" oninput="onSliderChange(${order.idOrder})">
                                                    </td>
                                                    <td>
                                                        <input class="form-range" id="tshedL${order.idOrder}" type="range" min="0" max="18" step="1" oninput="onSliderChange(${order.idOrder})">
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
                                                        <svg width="780" height="780" x="0" y="0" preserveAspectRatio="xMinYMin" id="sideSVG${order.idOrder}">
                                                            <style>
                                                                text { text-anchor: middle; dominant-baseline: middle; }
                                                            </style>
                                                            <text x="300" y="300">Please ensure that javascript is enabled in your browser</text>
                                                        </svg>
                                                    </td>
                                                    <td>
                                                        <svg width="780" height="780" x="0" y="0" preserveAspectRatio="xMinYMin" id="topSVG${order.idOrder}">
                                                            <style>
                                                                text { text-anchor: middle; dominant-baseline: middle; }
                                                            </style>
                                                            <text x="300" y="300">Please ensure that javascript is enabled in your browser</text>
                                                        </svg>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td><button class="btn btn-primary" type="submit" name="idOrder" value="${order.idOrder}">Anvend ændringer</button></td>
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
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                </c:if>
                <br>
                <br>
            </c:forEach>
        </c:if>
        <svg style="height: 0; width: 0;">
            <defs>
                <marker id="beginArrow" markerWidth="12" markerHeight="12" refX="0" refY="6" orient="auto">
                    <path d="M0,6 L12,0 L12,12 L0,6" style="fill: #000000;"></path>
                </marker>
                <marker id="endArrow" markerWidth="12" markerHeight="12" refX="12" refY="6" orient="auto">
                    <path d="M0,0 L12,6 L0,12 L0,0" style="fill: #000000;"></path>
                </marker>
            </defs>
        </svg>
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
            const postsXOffsetLeft = 100+postsX/2;
            const postsXOffsetRight = 30+postsX/2;
            // const postsXOffsetLeft = 50;
            // const postsXOffsetRight = 50;
            const roofZ = 230-210
            const shedPlanksY = 1.9;
            const shedPlanksX = 10;
            const shedPlanksZ = 210;

            // function clearTopSVG() {
            //     // if (activeSVG.parentNode.tagName === "svg") {
            //     //     topSVGs.innerHTML =
            //     // }
            //     topSVGs.innerHTML = "";
            // }
            //
            // function clearSideSVG() {
            //     sideSVGs.innerHTML = "";
            // }

            function clearActiveSVG() {
                const parent = activeSVG.parentNode;
                if (parent.tagName === "svg") {
                    parent.replaceWith(...parent.childNodes);
                }
                activeSVG.innerHTML = "";
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
                    const offsetX = postsXOffsetRight - postsX/2;
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
                    const offset = postsXOffsetRight - postsX / 2;
                    for (let i = shedPlanksX; i <= shedX; i += shedPlanksX) {
                        drawRect(canvasX - offset - i, canvasZ - shedPlanksZ, shedPlanksX, shedPlanksZ, blank);
                    }
                    //drawRect(canvasX - offset - shedX, canvasZ-shedPlanksZ, shedX, shedPlanksZ, red);
                }
            }

            function drawSVG(x, y, width, height) {
                const svg = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                svg.setAttribute("x", x);
                svg.setAttribute("y", y);
                svg.setAttribute("width", width);
                svg.setAttribute("height", height);
                svg.setAttribute("viewBox", "0 0 850 850");
                activeSVG.parentNode.replaceChild(svg, activeSVG);
                svg.appendChild(activeSVG);
            }

            function drawArrow(x1, y1, x2, y2) {
                const line = document.createElement("line");
                line.setAttribute("x1", x1);
                line.setAttribute("y1", y1);
                line.setAttribute("x2", x2);
                line.setAttribute("y2", y2);
                line.setAttribute("style", "stroke: #000000; marker-start: url(#beginArrow); marker-end: url(#endArrow);");
                activeSVG.parentNode.appendChild(line);

                const g = document.createElement("g");
                g.setAttribute("transform", `translate(\${(x2 + x1) / 2}, \${(y2 + y1) / 2}) rotate(\${Math.atan2(y1-y2, x1-x2)*(180/Math.PI)+180})`);
                activeSVG.parentNode.appendChild(g);
                const text = document.createElement("text");
                text.setAttribute("style", "text-anchor: middle");
                text.setAttribute("transform", "translate(0, 15)");
                //text.setAttribute("transform", `translate(\${(x2 + x1) / 2}, \${(y2 + y1) / 2}) rotate(\${Math.atan2(y1-y2, x1-x2)*(180/Math.PI)+180})`);
                text.innerText = ""+(Math.sqrt(Math.pow(x1-x2, 2) + Math.pow(y1-y2, 2))/100).toFixed(2);
                //activeSVG.parentNode.appendChild(text);
                g.appendChild(text);
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
                document.getElementById("carLVal"+oid).innerText = document.getElementById("carL"+oid).value;
                document.getElementById("carWVal"+oid).innerText = document.getElementById("carW"+oid).value;
                document.getElementById("shedLVal"+oid).innerText = document.getElementById("shedL"+oid).value;
                document.getElementById("shedWVal"+oid).innerText = document.getElementById("shedW"+oid).value;
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
                //activeSVG.setAttribute("viewBox", `0 0 780 780`);
                //activeSVG.setAttribute("x", "50");
                clearActiveSVG();
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
                drawSVG(0, 0, 650, 650);
                activeSVG.setAttribute("x", ""+(parseInt(activeSVG.parentNode.getAttribute("viewBox").split(" ")[3])-parseInt(activeSVG.getAttribute("width"))));
                drawArrow(35, 0, 35, canvasZ);
                drawArrow(60, roofZ, 60, canvasZ);
                drawArrow(70, canvasZ+10, parseInt(canvasX)+70, canvasZ+10);
                //activeSVG.parentNode.innerHTML += "";
                activeSVG.parentNode.innerHTML += "";
                //activeSVG.innerHTML += "";

            }

            function updateTopSVG(oid) {
                activeSVG = document.getElementById("topSVG"+oid);
                //topSVG.setAttribute("viewBox", `0 0 ${canvasX} ${canvasY}`);
                //activeSVG.setAttribute("viewBox", `0 0 780 780`);
                clearActiveSVG();
                drawTopRoof();
                drawTopPosts(parseInt(amountOfPosts));
                drawTopRafters();
                drawTopThings(parseInt(amountOfRafters));
                drawTopShed(0, 0);
                drawSVG(0, 0, 650, 650);
                activeSVG.setAttribute("x", ""+(parseInt(activeSVG.parentNode.getAttribute("viewBox").split(" ")[3])-parseInt(activeSVG.getAttribute("width"))));
                drawArrow(35, 0, 35, parseInt(canvasY));
                drawArrow(70, parseInt(canvasY)+10, parseInt(canvasX)+70, parseInt(canvasY)+10);
                drawArrow(60, 35, 60, parseInt(canvasY)-35);
                //activeSVG.innerHTML += "";
                activeSVG.parentNode.innerHTML += "";
            }
            <c:forEach items="${sessionScope.orders}" var="order"><c:if test="${order.orderStatus.equals('Started')}">updateSVGs(${order.idOrder});</c:if>
            </c:forEach>
        </script>
        <script>
            const valuesCarW = [240, 270, 300, 330, 360, 390, 420, 450, 480, 510, 540, 570, 600];
            const valuesCarL = [240, 270, 300, 330, 360, 390, 420, 450, 480, 510, 540, 570, 600, 630, 660, 690, 720, 750, 780];
            const valuesShedW = [0, 210, 240, 270, 300, 330, 360, 390, 420, 450, 510, 540, 570, 600, 630, 660, 690, 720];
            const valuesShedL = [0, 150, 180, 210, 240, 270, 300, 330, 360, 390, 420, 450, 510, 540, 570, 600, 630, 660, 690];

            function initOrderSliders(oid) {
                document.getElementById("carW")
            }
            function onSliderChange(oid) {
                document.getElementById("carW"+oid).value = valuesCarW[document.getElementById("tcarW"+oid).value];
                document.getElementById("carL"+oid).value = valuesCarL[document.getElementById("tcarL"+oid).value];
                document.getElementById("shedW"+oid).value = valuesShedW[document.getElementById("tshedW"+oid).value];
                document.getElementById("shedL"+oid).value = valuesShedL[document.getElementById("tshedL"+oid).value];
                updateSVGs(oid);
            }
            <c:forEach items="${sessionScope.orders}" var="order"><c:if test="${order.orderStatus.equals('Started')}">initOrderSliders(${order.idOrder});</c:if>
            </c:forEach>
        </script>
    </jsp:body>
</t:pagetemplate>