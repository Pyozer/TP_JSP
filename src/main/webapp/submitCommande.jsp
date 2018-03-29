<%@ page pageEncoding="UTF-8"%>
<%@ include file="enTetePage.html"%>
<%@ page import="commerce.gestion.Panier"%>
<%@ page import="commerce.gestion.LignePanier"%>
<%@ include file="navbar.jsp"%>


<%
	if (session.getAttribute("panier") == null) {
		response.sendRedirect("./index.jsp");
	} else {
		Panier lePanier = (Panier) session.getAttribute("panier");
		lePanier.viderPanier();
%>
	<div class="container my-5 text-center">
		<!--Panel-->
		<div class="card">
		    <div class="card-body">
		        <h3 class="card-title">Votre commande a bien été effectuée !</h3>
		        <p class="card-text">Cliquez sur "OK" pour revenir sur la page d'accueil.</p>
		        <a href="<%=response.encodeURL("./index.jsp?")%>" class="btn btn-primary">OK</a>
		    </div>
		</div>
		<!--/.Panel-->
	</div>

<%} %>
<%@ include file="piedDePage.html"%>