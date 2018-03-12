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
<div class="container">
	<a href="<%=response.encodeURL("./afficheArticle.jsp?refArticle=" + target.getRefArticle())%>">
		<div class="card card-cascade narrower">
		    <!--Card image-->
		    <div class="view overlay">
			    <img class="img-fluid" src="
								<%=(target.getImage().startsWith("http"))?target.getImage():"./images/" + target.getImage()%>
									" alt="Card image cap">
			</div>
		    <!--Card content-->
		    <div class="card-body">
		        <!--Title-->
		        <h4 class="card-title"><%out.print(target.getTitre());%></h4>
		        <!--Text-->
		        <p class="card-text"><%out.print(target.getPrix()+" €"); %></p>
		        <a href="<%=response.encodeURL("./controlePanier.jsp?refArticle=" + target.getRefArticle() + "&amp;commande=ajouterLigne")%>" class="btn btn-primary">Ajouter au Panier</a>
		    </div>
		
		</div>
	</a>
</div>
<%@ include file="piedDePage.html"%>