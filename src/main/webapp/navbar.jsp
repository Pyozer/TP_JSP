<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-lg navbar-dark primary-color">

    <a class="navbar-brand" href="#">Site marchand</a>

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
                <a class="nav-link" href="<%=response.encodeURL("./controlePanier.jsp")%>">Panier</a>
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