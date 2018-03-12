<%@ page pageEncoding="UTF-8"%>
<%@ include file="enTetePage.html"%>
<script type="text/javascript" src="./js/playListJs.jsp"></script>
<%@ page import="commerce.catalogue.service.CatalogueManager"%>
<%@ page import="commerce.catalogue.domaine.modele.Article"%>
<%@ page import="commerce.catalogue.domaine.modele.Livre"%>
<%@ page import="commerce.catalogue.domaine.modele.Musique"%>
<%@ page import="commerce.catalogue.domaine.modele.Piste"%>



<%
	CatalogueManager catalogueManager = (CatalogueManager) application.getAttribute("catalogueManager");
	Article target = catalogueManager.chercherArticleParRef(request.getParameter("refArticle"));
	if(target == null){
		response.sendRedirect("../index.jsp");	
	}
%>


<%@ include file="piedDePage.html"%>