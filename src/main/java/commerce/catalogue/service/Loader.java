/**
 * Title:        commerce
 * Description:  Class for e-commerce
 * Company:      IUT Laval - Université du Maine
 * @author  A. Corbière
 */
package commerce.catalogue.service;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import commerce.catalogue.domaine.modele.Livre;

public class Loader implements ServletContextListener {
	private ServletContext application = null;

	public void contextDestroyed(ServletContextEvent event) {
	}

	public void contextInitialized(ServletContextEvent event) {
		this.application = event.getServletContext();
		CatalogueManager catalogueManager = null;
		if (this.application.getAttribute("catalogueManager") == null) {
			catalogueManager = new CatalogueManager();
			this.application.setAttribute("catalogueManager", catalogueManager);
		} else {
			catalogueManager = (CatalogueManager) this.application.getAttribute("catalogueManager");
		}
		new InitAmazon(catalogueManager, "Music", "Ibrahim Maalouf").init();
		new InitAmazon(catalogueManager, "Music", "Renaud").init();
		new InitAmazon(catalogueManager, "Music", "David guetta").init();
		new InitAmazon(catalogueManager, "Music", "Parov stelar").init();

		try {
			Livre livre = new Livre();
			livre.setRefArticle("1141555677821");
			livre.setTitre("Le seigneur des anneaux");
			livre.setAuteur("J.R.R. TOLKIEN");
			livre.setISBN("2070612880");
			livre.setImage("61PEbZ1QDfL-300x300.jpg");
			livre.setNbPages(736);
			livre.setLangue("fr");
			livre.setDateDeParution("23/08/07");
			livre.setPrix("8.50");
			livre.setDisponibilite("1");
			catalogueManager.soumettreArticle(livre);

			livre = new Livre();
			livre.setRefArticle("1141555897821");
			livre.setTitre("Un paradis trompeur");
			livre.setAuteur("Henning Mankell");
			livre.setISBN("275784797X");
			livre.setImage("61NfUluHsML-300x300.jpg");
			livre.setNbPages(400);
			livre.setLangue("fr");
			livre.setDateDeParution("09/10/14");
			livre.setPrix("7.90");
			livre.setDisponibilite("1");
			catalogueManager.soumettreArticle(livre);

			livre = new Livre();
			livre.setRefArticle("1141556299459");
			livre.setTitre("Dôme tome 1");
			livre.setAuteur("Stephen King");
			livre.setISBN("2212110685");
			livre.setImage("61sGE8edJmL-300x300.jpg");
			livre.setNbPages(840);
			livre.setLangue("fr");
			livre.setDateDeParution("06/03/13");
			livre.setPrix("8.90");
			livre.setDisponibilite("1");
			catalogueManager.soumettreArticle(livre);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}