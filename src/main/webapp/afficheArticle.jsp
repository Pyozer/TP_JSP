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
			<img
				class="img-fluid"
				src="<%= (target.getImage().startsWith("http")) ? target.getImage() : "./images/" + target.getImage() %>"
				alt="Card image cap" />
		</div>
		<div class ="col-12 col-md-8">
			<h2><%= target.getTitre() %></h2>
			<p>Ref. <%= target.getRefArticle() %></p>
			 <!-- player -->
	        <% if (target instanceof Musique) {
 				Musique musique = (Musique) target;
 				%>
 				<div class="row">
 				<% for(Piste piste : musique.getPistes()) { %>
 					<div class="col-6 col-md-3">
 						<div class="card mt-2">
							<div class="card-body text-left">
		 						<h5 class="text-truncate mb-0" title="<%= piste.getTitre() %>"><%= piste.getTitre() %></h5>
		 						<%
		 							int min = piste.getDuree() / 60;
		 							int sec = piste.getDuree() - min * 60;
		 						%>
		 						<small class="mb-3">(<%= min %>min <%= sec %>sec)</small>
								<div id="jquery_jplayer_<%= piste.getRefPiste() %>" class="jp-jplayer"></div>
								<div id="jp_container_<%= piste.getRefPiste() %>" class="jp-audio" role="application">
									<div class="jp-type-playlist">
										<div class="jp-gui jp-interface">
											<div class="jp-controls-holder">
												<div class="jp-controls btn-group" data-toggle="buttons">
												  	<label class="btn btn-primary jp-play btn-sm px-3 ml-2">
												    	<input type="radio" /> <i class="fa fa-play"></i>
												  	</label>
												  	<label class="btn btn-primary jp-stop btn-sm px-3 mr-2">
												    	<input type="radio" /> <i class="fa fa-stop"></i>
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
							</div>
						</div>
					</div>
					<script type="text/javascript">
	 					var myPlaylist_<%= piste.getRefPiste() %> = new jPlayerPlaylist({
							cssSelectorAncestor : "#jp_container_<%= piste.getRefPiste() %>",
							jPlayer: "#jquery_jplayer_<%= piste.getRefPiste() %>"
						}, [
							{
								title: "<%= piste.getTitre().replace("\"", "\\\"" ) %>",
								mp3:"<%= piste.getUrl() %>"
							}
						],
						{
							swfPath : "/js/jplayer-2.9.2/jplayer",
							supplied : "mp3",
							wmode: "window",
							useStateClassSkin: true,
							autoBlur: false,
							smoothPlayBar: true,
							keyEnabled: true
						});
 					</script>
				<% } %>
 				</div>
 				
 				<div class="row my-5">
 					<div class="col-12 col-md-6 mb-3">
						<h5>Artiste</h5>
						<%= musique.getArtiste() %>
					</div>
					<div class="col-12 col-md-6 mb-3">
						<h5>Date de parution</h5>
						<%= musique.getDateDeParution() %>
					</div>
					<div class="col-12 col-md-6 mb-3">
						<h5>Langue</h5>
						<%= musique.getLangue() %>
					</div>
					<div class="col-12 col-md-6 mb-3">
						<h5>EAN</h5>
						<%= musique.getEAN() %>
					</div>
				</div>
	 		<% } else if(target instanceof Livre) {
	 			Livre livre = (Livre) target;
	 			%>
	 			<div class="row my-5">
 					<div class="col-12 col-md-6">
						Auteur: <%= livre.getAuteur() %>
					</div>
					<div class="col-12 col-md-6">
						Date de parution: <%= livre.getDateDeParution() %>
					</div>
					<div class="col-12 col-md-6">
						Nombre de page: <%= livre.getNbPages() %>
					</div>
					<div class="col-12 col-md-6">
						ISBN: <%= livre.getISBN() %>
					</div>
				</div>
	 		<% } %>
			<div class="row my-5">
				<div class="col-12 col-md-6">
					Prix: <strong><%= target.getPrix() %> <i class="fa fa-eur"></i></strong>
				</div>
				<div class="col-12 col-md-6">
					En stock: <strong><%= target.getDisponibilite() %></strong>
				</div>
			</div>
			<form method="get" action ="./controlePanier.jsp">
				<div class="row my-5">
					<div class="col-12 col-md-6">
						<input name="refArticle" value="<%= target.getRefArticle()%>" type="hidden">
						<input name="commande" value="ajouterLigne" type="hidden">
						<input id="article-<%= target.getRefArticle() %>"
				    	class="form-control col-sm-3 float-left"
						title="Qty"
						value="1"
						name="qty"
						min="1" step="1" readonly>
	                    <div class="btn-group radio-group ml-2" data-toggle="buttons">
	                       	<button type="button" class="btn btn-sm btn-primary btn-rounded" onclick="updateQty('<%= target.getRefArticle() %>', -1);"><i class="fa fa-minus m-1"></i></button>
	                        <button type="button" class="btn btn-sm btn-primary btn-rounded" onclick="updateQty('<%= target.getRefArticle() %>', 1);"><i class="fa fa-plus m-1"></i></button>
	                    </div>
					</div>
					<div class="col-12 col-md-6">
						<button type="submit" 
						class="btn btn-deep-orange btn-sm btn-rounded mr-0">Ajouter <i class="fa fa-2x fa-cart-plus"></i></button>
					</div>
	
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="piedDePage.html"%>