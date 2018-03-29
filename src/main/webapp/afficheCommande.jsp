<%@ page pageEncoding="UTF-8"%>
<%@ include file="enTetePage.html"%>
<script type="text/javascript" src="./js/playListJs.jsp"></script>
<%@ page import="commerce.catalogue.service.CatalogueManager"%>
<%@ page import="commerce.catalogue.domaine.modele.Article"%>
<%@ page import="commerce.catalogue.domaine.modele.Livre"%>
<%@ page import="commerce.catalogue.domaine.modele.Musique"%>
<%@ page import="commerce.catalogue.domaine.modele.Piste"%>
<%@ page import="commerce.gestion.Panier"%>
<%@ page import="commerce.gestion.LignePanier"%>

<%@ include file="navbar.jsp"%>
<%
	if (session.getAttribute("panier") == null) {
		response.sendRedirect("./index.jsp");
	} else {
		Panier lePanier = (Panier) session.getAttribute("panier");
		CatalogueManager catalogueManager = (CatalogueManager) application.getAttribute("catalogueManager");
%>

<div class="container my-5">
 <h1 class="text-center mb-4">Commande</h1>
	<form action="./submitCommande.jsp">
		<div class="row">
			<div class="col-12 col-md-6">
				<!-- nom prénom, adresse ville code postal,pays, email, moyen de paiement(onglets) -->   
			
			    <!-- Material input text -->
			    <div class="md-form">
			        <i class="fa fa-user prefix grey-text"></i>
			        <input type="text" id="inputName" class="form-control">
			        <label for="inputName">Nom</label>
			   	</div>
			   	<!-- Material input text -->
			    <div class="md-form">
			        <i class="fa fa-user prefix grey-text"></i>
			        <input type="text" id="inputPrenom" class="form-control" >
			        <label for="inputPrenom">Prénom</label>
			   	</div>
			   		<!-- Material input text -->
			    <div class="md-form">
			        <i class="fa fa-home prefix grey-text"></i>
			        <input type="text" id="inputAdresse" class="form-control">
			        <label for="inputAdresse">Adresse</label>
			   	</div>
			   		<!-- Material input text -->
			    <div class="md-form">
			        <i class="fa fa-map-marker prefix grey-text"></i>
			        <input type="text" id="inputVille" class="form-control">
			        <label for="inputVille">Ville</label>
			   	</div>
			   		<!-- Material input text -->
			    <div class="md-form">
			        <i class="fa fa-map-marker prefix grey-text"></i>
			        <input type="number" id="inputCodePostal" class="form-control">
			        <label for="inputCodePostal">Code Postal</label>
			   	</div>
			   		<!-- Material input text -->
			    <div class="md-form">
			        <i class="fa fa-globe prefix grey-text"></i>
			        <input type="text" id="inputPays" class="form-control">
			        <label for="inputPays">Pays</label>
			   	</div>
			
			    <!-- Material input email -->
			    <div class="md-form">
			        <i class="fa fa-envelope prefix grey-text"></i>
			        <input type="email" id="inputEmail" class="form-control">
			        <label for="inputEmail">Adresse email</label>
			    </div>	
			</div>
			
			
			<div class ="col-12 col-md-6">
				<table class="table">				
				    <thead class="mdb-color darken-3">
				        <tr class="text-white">
				            <th>Article</th>
				            <th>Prix Unitaire</th>
				            <th>Quantité</th>
				            <th>PrixTotal</th>
				        </tr>
				    </thead>
				    
				    <tbody>
				   		<%for(LignePanier lignePanier : lePanier.getLignesPanier()) { %>
					        <tr>
					            <td><%=lignePanier.getArticle().getTitre() %></td>
					            <td><%=lignePanier.getPrixUnitaire()%> <i class="fa fa-eur"></i></td>
					            <td><%=lignePanier.getQuantite() %></td>
					            <td><%=lignePanier.getPrixTotal()%> <i class="fa fa-eur"></i></td>
					        </tr>
						<%} %>
						<tr>
							<td>Total</td>
							<td>-</td>
							<td>-</td>
							<td><%= lePanier.getTotal() %> <i class="fa fa-eur"></i></td>
						</tr>
					</tbody>
					
						
				</table>
				
				    <ul class="nav md-pills nav-justified pills-primary">
					    <li class="nav-item">
					        <a class="nav-link active" data-toggle="tab" href="#panelCarte" role="tab">Carte Bancaire</a>
					    </li>
					    <li class="nav-item">
					        <a class="nav-link" data-toggle="tab" href="#panelCheque" role="tab">Chèque</a>
					    </li>
					</ul>
					
					<div class="tab-content">
					
					    <div class="tab-pane fade in show active" id="panelCarte" role="tabpanel">
							
					        
						   	<div class="row">
							   	<div class="col-12">
								   	<div class="md-form">
								        <input type="text" id="inputNumCarte" class="form-control">
								        <label for="inputNumCarte">Numéro de carte</label>
								   	</div>
								</div>
								<div class="col-12 col-md-2">
								   	<div class="md-form">
								        <input type="number" id="inputMoisCarte" class="form-control">
								        <label for="inputMoisCarte">Mois</label>
								   	</div>
								</div>
								<div class="col-12 col-md-2">
								   	<div class="md-form">
								        <input type="number" id="inputAnCarte" class="form-control">
								        <label for="inputAnCarte">An</label>									   	
									</div>
								</div>
								<span class ="col-12 col-md-6"></span>
								<div class="col-12 col-md-2">
								   	<div class="md-form">
								        <input type="number" id="inputCrypto" class="form-control">
								        <label for="inputCrypto">V Code</label>
								   	</div>
								</div>
							</div>
					    </div>
					    
					    <div class="tab-pane fade" id="panelCheque" role="tabpanel">
					        <br>
							<p>Votre commande sera enregistrée.</p>
					        <p>Pour payer, veuillez envoyer un chèque de <%=lePanier.getTotal() %><i class="fa fa-eur"></i> à l'adresse suivante</p>
					        <p>25 Rue des Lilas, 12345, BelleVille, FRANCE</p>
					    </div>
					 </div>
				
				<div class="text-center mt-4">
			        <button class="btn btn-outline-info" type="submit">Valider<i class="fa fa-paper-plane-o ml-2"></i></button>
			    </div>
			    
			</div>
		</div>
	</form>
</div>

<%} %>
<%@ include file="piedDePage.html"%>