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
			 <!-- player -->
		        <% if (target instanceof Musique) {
	 				Musique musique = (Musique) target;
	 				if (musique.getPistes().size() > 0) { %>
						<div id="jquery_jplayer_<%=target.getRefArticle()%>" class="jp-jplayer"></div>
						<div id="jp_container_<%=target.getRefArticle()%>" class="jp-audio" role="application">
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
			<div class="row my-5">
				<div class="col-12 col-md-6">
					<%=target.getPrix()%> <i class="fa fa-eur"></i>
				</div>
				<div class="col-12 col-md-6">
					en stock: <%= target.getDisponibilite() %>
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