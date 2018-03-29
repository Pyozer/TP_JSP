<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="commerce.gestion.Panier"%>
<%
	int nbArticle = 0;
	if(session.getAttribute("panier") != null) {
		Panier lePanier = (Panier) session.getAttribute("panier");
		nbArticle = lePanier.getLignesPanier().size();
	}
%>
<nav class="navbar navbar-expand-lg navbar-dark primary-color">

    <a class="navbar-brand" href="/tpv35/">Site marchand</a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#basicExampleNav" aria-controls="basicExampleNav"
        aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="basicExampleNav">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="<%=response.encodeURL("./")%>">Accueil
                    <span class="sr-only">(current)</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%=response.encodeURL("./controlePanier.jsp")%>">Panier  <span class="badge badge-pill pink"><%= nbArticle %></span></a>
            </li>
            <!-- Dropdown -->
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Catégories</a>
                <div class="dropdown-menu dropdown-primary" aria-labelledby="navbarDropdownMenuLink">
                    <a class="dropdown-item" href="./afficheRecherche.jsp?category=livre">Livres</a>
                    <a class="dropdown-item" href="./afficheRecherche.jsp?category=musique">Musiques</a>
                </div>
            </li>
        </ul>
        <!-- Links -->

        <form class="form-inline" action="./afficheRecherche.jsp" method="GET">
            <div class="md-form mt-0">
                <input class="form-control mr-sm-2" type="text" name="search" placeholder="Rechercher" aria-label="Rechercher">
            </div>
        </form>
    </div>
</nav>