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
			<%= search %></h1>
			<ul class="products">
				<%
				CatalogueManager catalogueManager = (CatalogueManager) application.getAttribute("catalogueManager");
				Iterator<Article> listeDesArticles = catalogueManager.rechercherArticles(search).iterator();
				Livre livre = null;
				Musique musique = null;
				Article article;
				while (listeDesArticles.hasNext()) {
					article = (Article) listeDesArticles.next();
				%>
					<li class="product type-product">
						<a href="<%=response.encodeURL("./afficheArticle.jsp?refArticle=" + article.getRefArticle())%>">
						<img
						src="
							<%
								if (article.getImage().startsWith("http"))
									out.print(article.getImage());
								else
									out.print("./images/" + article.getImage());
							%>
						"
						class="attachment-shop_catalog wp-post-image"
						alt="poster_2_up"
						height="300" width="300" />
						
						<h3><%=article.getTitre()%></h3>
						<span class="price">
							<ins>
								<span class="amount"><%=article.getPrix()%> €</span>
							</ins>
						</span>
					</a>
					<a
						href="<%=response.encodeURL("./controlePanier.jsp?refArticle=" + article.getRefArticle() + "&amp;commande=ajouterLigne")%>"
						class="button add_to_cart_button product_type_simple">
						Mettre dans le panier
					</a> 
					<%
			 			if (article instanceof Musique) {
			 				musique = (Musique) article;
			 				if (musique.getPistes().size() > 0) { %>
							<div id="jquery_jplayer_<%=article.getRefArticle()%>" Class="jp-jplayer"></div>
							<div id="jp_container_<%=article.getRefArticle()%>" class="jp-audio" Role="application">
								<div class="jp-type-playlist">
									<div class="jp-gui jp-interface">
										<div class="jp-controls-holder">
											<div class="jp-controls">
												<button class="jp-previous" role="button" tabindex="0">previous</button>
												<button class="jp-play" role="button" tabindex="0">play</button>
												<button class="jp-stop" role="button" tabindex="0">stop</button>
												<button class="jp-next" role="button" tabindex="0">next</button>
											</div>
										</div>
									</div>
									<div class="jp-playlist">
										<ul>
											<li>&nbsp;</li>
										</ul>
									</div>
									<div class="jp-no-solution">
										<span>Update Required</span> To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
									</div>
								</div>
							</div>
							<%
			 				}
			 			}
 				} %>
		</ul>
	</section>
</div>
<%
	}
%>
<%@ include file="piedDePage.html"%>