<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@page errorPage="error.jsp" isErrorPage="false" %>
<c:set var="servletPath" value="${pageContext.request.servletPath}"/>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<c:set var="order" value="${sessionScope.orders.get(sessionScope.orders.size() - 1)}"/>

<t:pagetemplate>
    <jsp:attribute name="header">
        Forespørgsel
    </jsp:attribute>

    <jsp:body>
        <br>
        <br>
        <p>Plantegninger set oppefra</p>
        <input type="hidden" id="carL" value="${order.carportLængde}">
        <input type="hidden" id="carW" value="${order.carportBred}">
        <input type="hidden" id="shedL" value="${order.skurLængde}">
        <input type="hidden" id="shedW" value="${order.skurBred}">
        <div class="col-md-2">
            <svg width="780" height="780" x="0" y="0" preserveAspectRatio="xMinYMin" id="topSVG${order.idOrder}">
                <style>
                    text { text-anchor: middle; dominant-baseline: middle; }
                </style>
                <text x="300" y="300">Please ensure that javascript is enabled in your browser</text>
            </svg>
            <!--img src="${contextPath}/images/carport%20fladt%20tag.png"-->
        </div>
        <p>Plantegninger set fra siden</p>
        <div class="col-md-2">
            <svg width="780" height="780" x="0" y="0" preserveAspectRatio="xMinYMin" id="sideSVG${order.idOrder}">
                <style>
                    text { text-anchor: middle; dominant-baseline: middle; }
                </style>
                <text x="300" y="300">Please ensure that javascript is enabled in your browser</text>
            </svg>
            <!--img src="${contextPath}/images/carport%20fladt%20tag.png"-->
        </div>
        <div class="card text-center mb-3">
            <div class="row g-0 align-items-center">
                <div class="col-md-2">
                    <h5 class="card-title">Carport med fladt tag</h5>
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <p class="card-text">Dato for bestilling: ${sessionScope.date}</p>
                            </div>
                            <div class="col-md-6">
                                <p class="card-text">Vejledende pris: ${sessionScope.price} kr.</p>
                            </div>
                        </div>
                        <div class="row">
<%--                            <div class="col-md-6">--%>
<%--                                <p class="card-text">Ordre status: ${sessionScope.order.orderStatus}</p>--%>
<%--                            </div>--%>
                            <div class="col-md-6">
                                <p class="card-text">Tegninger og stykliste: Tilgængelig</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <form method="post" action="removeorder">
            <input type="hidden" name="pageHidden" value="accept" />
            <button type="submit" class="btn btn-primary">Fortryd ordre</button>
        </form>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/orders.jsp" role="button">Send forespørgsel</a>
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
                canvasX = document.getElementById("carL").value;
                canvasY = document.getElementById("carW").value;
                shedX = document.getElementById("shedL").value;
                shedY = document.getElementById("shedW").value;
                amountOfRafters = calRafters(canvasX);
                amountOfPosts = calPost(canvasX);
                shed = true;
                if (shedX <= 0 || shedY <= 0) {
                    shed = false;
                }
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
            updateSVGs(${order.idOrder});
        </script>
    </jsp:body>
</t:pagetemplate>