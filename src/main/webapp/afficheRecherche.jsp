<%@ page pageEncoding="UTF-8"%>

<%@ page import="org.omg.CORBA.Request"%>
<%@ page import="commerce.catalogue.service.CatalogueManager"%>
<%@ page import="commerce.catalogue.domaine.modele.Article"%>
<%@ page import="commerce.catalogue.domaine.modele.Livre"%>
<%@ page import="commerce.catalogue.domaine.modele.Musique"%>
<%@ page import="commerce.catalogue.domaine.modele.Piste"%>
<%@ page import="java.util.Iterator"%>

<%@ include file="enTetePage.html"%>

<%
	if (session.getAttribute("panier") == null) {
		response.sendRedirect("./index.jsp");
	} else {
		String search = "";
		if(request.getParameter("search") != null)
			search = request.getParameter("search");
%>

<%@ include file="navbar.jsp" %>

<div class="container">
	<section id="main" class="my-5" role="main">
		<h1 class="page-title">
			Résultats de la recherche :
			<%= search %>
		</h1>
		<div class="row">
			<%
			CatalogueManager catalogueManager = (CatalogueManager) application.getAttribute("catalogueManager");
			Iterator<Article> listeDesArticles = catalogueManager.rechercherArticles(search).iterator();
			Livre livre = null;
			Musique musique = null;
			Article article;
			while (listeDesArticles.hasNext()) {
				article = (Article) listeDesArticles.next();
			%>
				<div class="col-md-4 col-xl-3 col-sm-6">					
					<div class="card card-cascade card-ecommerce narrower my-4">
					   <!--Card image-->
					   <div class="view overlay">
					   		<a href="<%=response.encodeURL("./afficheArticle.jsp?refArticle=" + article.getRefArticle())%>">
						    	<img class="img-fluid" src="
									<%=(article.getImage().startsWith("http"))?article.getImage():"./images/" + article.getImage()%>
										" alt="Card image cap">
							</a>
						</div>
						<!--Card content-->
					    <div class="card-body text-center">
					        <!--Title-->
					        <h4 class="card-title">
					        	<a href="<%=response.encodeURL("./afficheArticle.jsp?refArticle=" + article.getRefArticle())%>">
					        		<%out.print(article.getTitre());%>
					        	</a>
					        </h4>
					        <!-- player -->
					        <% if (article instanceof Musique) {
				 				musique = (Musique) article;
				 				if (musique.getPistes().size() > 0) { %>
									<div id="jquery_jplayer_<%=article.getRefArticle()%>" class="jp-jplayer"></div>
									<div id="jp_container_<%=article.getRefArticle()%>" class="jp-audio" role="application">
										<div class="jp-type-playlist">
											<div class="jp-gui jp-interface">
												<div class="jp-controls-holder">
													<div class="jp-controls btn-group" data-toggle="buttons">
													 	<label class="btn btn-primary jp-previous btn-sm px-3">
													    	<input type="radio" /> <i class="fa fa-backward"></i>
													  	</label>
													  	<label class="btn btn-primary jp-play btn-sm px-3 ml-2">
													    	<input type="radio" /> <i class="fa fa-play"></i>
													  	</label>
													  	<label class="btn btn-primary jp-stop btn-sm px-3 mr-2">
													    	<input type="radio" /> <i class="fa fa-stop"></i>
													  	</label>
													  	<label class="btn btn-primary jp-next btn-sm px-3">
													    	<input type="radio" /> <i class="fa fa-forward"></i>
													  	</label>
													</div>
												</div>
											</div>
											<div class="jp-playlist">
												<ul>
													<li>&nbsp;</li>
												</ul>
											</div>
										</div>
									</div>
								<% }
					 			} %>
					 			
			 					<!--Card footer-->
       							<div class="card-footer mt-3 mx-0">
						            <span class="float-left mt-2"><%out.print(article.getPrix()+" €"); %></span>
						            <span class="float-right">
						            	<a href="<%=response.encodeURL("./controlePanier.jsp?refArticle=" + article.getRefArticle() + "&amp;commande=ajouterLigne")%>" class="btn btn-deep-orange btn-sm btn-rounded mr-0"><i class="fa fa-cart-plus"></i></a>
						            </span>
      								</div>	
    							</div> 
					</div>	
				</div>
						
			<% } %>
		</div>
	</section>
</div>

<%
	}
%>

<%@ include file="piedDePage.html"%>