<%@ page pageEncoding="UTF-8"%>

<%@ page import="commerce.catalogue.service.CatalogueManager"%>
<%@ page import="commerce.catalogue.domaine.modele.Article"%>
<%@ page import="commerce.gestion.Panier"%>
<%@ page import="commerce.gestion.LignePanier"%>
<%@ page import="java.util.Iterator"%>

<%@ include file="enTetePage.html"%>

<%@ include file="navbar.jsp"%>

<%
	if (session.getAttribute("panier") == null) {
		response.sendRedirect("./index.jsp");
	} else {
		Panier lePanier = (Panier) session.getAttribute("panier");
		CatalogueManager catalogueManager = (CatalogueManager) application.getAttribute("catalogueManager");
%>

<div class="container my-5">
	<section>
			<form
				action="<%= response.encodeURL("controlePanier.jsp?commande=recalculerPanier") %>"
				name="panier" method="post">

		        <div class="table-responsive">
		            <table class="table product-table">
		                <thead class="mdb-color lighten-5">
		                    <tr>
		                        <th></th>
		                        <th class="font-weight-bold">
		                            <strong>Produit</strong>
		                        </th>
		                        <th class="font-weight-bold">
		                            <strong>Prix</strong>
		                        </th>
		                        <th class="font-weight-bold">
		                            <strong>Quantité</strong>
		                        </th>
		                        <th class="font-weight-bold">
		                            <strong>Total</strong>
		                        </th>
		                        <th></th>
		                    </tr>
		                </thead>
		                <tbody>
		                	<%
							Iterator<LignePanier> it = lePanier.getLignesPanier().iterator();
							while (it.hasNext()) {
								LignePanier lignePanier = (LignePanier) it.next();
								Article article = lignePanier.getArticle();
								%>
								<tr>
									<th scope="row">
										<a href="<%=response.encodeURL("./afficheArticle.jsp?refArticle=" + article.getRefArticle())%>">
				                            <img
												class="img-fluid z-depth-0 w-50"
												alt="<%= article.getTitre() %>"
												src="<%= (article.getImage().startsWith("http")) ? article.getImage() : "./images/" + article.getImage() %>" />
			                        	</a>
			                        </th>
			                        <td>
			                            <h5>
			                                <a href="<%=response.encodeURL("./afficheArticle.jsp?refArticle=" + article.getRefArticle())%>">
			                                	<strong><%= article.getTitre()%></strong>
			                                </a>
			                            </h5>
			                        </td>
			                        <td>
			                        	<%= article.getPrix() %> €
			                        </td>
			                        <td class="center-on-small-only">
                                        <input
                                        	id="article-<%= lignePanier.getArticle().getRefArticle() %>"
									    	class="form-control col-sm-3 float-left"
											title="Qty"
											value="<%= lignePanier.getQuantite() %>"
											name="cart[<%= lignePanier.getArticle().getRefArticle() %>][qty]"
											min="1" step="1" readonly>
                                        <div class="btn-group radio-group ml-2 mt-2" data-toggle="buttons">
                                           	<button type="button" class="btn btn-sm btn-primary btn-rounded" onclick="updateQty('<%= lignePanier.getArticle().getRefArticle() %>', -1);"><i class="fa fa-minus m-1"></i></button>
                                            <button type="button" class="btn btn-sm btn-primary btn-rounded" onclick="updateQty('<%= lignePanier.getArticle().getRefArticle() %>', 1);"><i class="fa fa-plus m-1"></i></button>
                                        </div>
                                    </td>
			                        <td class="font-weight-bold">
			                            <strong><%= lignePanier.getPrixTotal() %>€</strong>
			                        </td>
									<td>
										<a
											class="btn btn-sm btn-primary"
											data-toggle="tooltip"
											data-placement="top"
											title="Remove item"
											href="<%= response.encodeURL("./controlePanier.jsp?refArticle="
												+ lignePanier.getArticle().getRefArticle()
												+ "&amp;commande=supprimerLigne")%>">
											<i class="fa fa-times-circle fa-2x" aria-hidden="true"></i>
										</a>
									</td>
								</tr>
							<%
								}
							%>
		                </tbody>
		            </table>
		        </div>
				<input class="btn btn-primary btn-rounded" type="submit" value="Mise à jour du panier" name="update_cart" />
				<a
					href="<%=response.encodeURL("./controlePanier.jsp?commande=viderPanier")%>"
					class="btn btn-outline-danger btn-rounded">
					Vider le panier
				</a>
			</form>
			<div class="row mt-5">
				<div class="col-12">
					<h2>Total de la commande</h2>
					<table class="table table-bordered table-responsive w-auto">
						<tbody>
							<tr>
								<th class="blue-grey lighten-4 text-right">
									<strong>Sous-total :</strong>
								</th>
								<td>
									<span class="amount"><%=lePanier.getTotal()%>€</span>
								</td>
							</tr>
							<tr>
								<th class="blue-grey lighten-4 text-right">
									<strong>Frais de port :</strong>
								</th>
								<td>Gratuit</td>
							</tr>
							<tr>
								<th class="blue-grey lighten-4 text-right">
									<strong>Total :</strong>
								</th>
								<td>
									<strong>
										<span class="amount"><%=lePanier.getTotal()%>€</span>
									</strong>
								</td>
							</tr>
						</tbody>
					</table>
					<a
						href="<%=response.encodeURL("./afficheCommande.jsp?")%>"
						class="btn btn-primary btn-rounded">
						Effectuer la commande
					</a>
				</div>
			</div>
	</section>
</div>
<%
	}
%>

<%@ include file="piedDePage.html"%>