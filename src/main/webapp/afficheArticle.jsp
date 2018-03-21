<%@ page pageEncoding="UTF-8"%>
<%@ include file="enTetePage.html"%>
<script type="text/javascript" src="./js/playListJs.jsp"></script>
<%@ page import="commerce.catalogue.service.CatalogueManager"%>
<%@ page import="commerce.catalogue.domaine.modele.Article"%>
<%@ page import="commerce.catalogue.domaine.modele.Livre"%>
<%@ page import="commerce.catalogue.domaine.modele.Musique"%>
<%@ page import="commerce.catalogue.domaine.modele.Piste"%>

<%@ include file="navbar.jsp"%>


<%
	CatalogueManager catalogueManager = (CatalogueManager) application.getAttribute("catalogueManager");
	Article target = catalogueManager.chercherArticleParRef(request.getParameter("refArticle"));
	if(target == null){
		response.sendRedirect("index.jsp");	
	}
%>
<div class="container my-5">
	<div class="row">
		<div class="col-12 col-md-4">
			<img class="img-fluid" src="<%=(target.getImage().startsWith("http"))?
					target.getImage():"./images/" + target.getImage()%>" 
					alt="Card image cap">
		</div>
		<div class ="col-12 col-md-8">
			<h2><%= target.getTitre() %></h2>
			<p>Ref. <%= target.getRefArticle() %></p>
			<div class="row">
				<div class="col-12 col-md-3">
					<%=target.getPrix()%> <i class="fa fa-eur"></i>
				</div>
				<div class="col-12 col-md-3">
					en stock: <%= target.getDisponibilite() %>
				</div>
				<div class="col-12 col-md-3">
					<!-- Mettre ici le sélectionneur de quantité -->_
				</div>
				<div class="col-12 col-md-3">
					<a href="<%=response.encodeURL("./controlePanier.jsp?refArticle=" + target.getRefArticle() + "&amp;commande=ajouterLigne")%>" 
					class="btn btn-deep-orange btn-sm btn-rounded mr-0">Ajouter <i class="fa fa-2x fa-cart-plus"></i></a>
				</div>

			</div>
		</div>
	</div>
</div>
<%@ include file="piedDePage.html"%>