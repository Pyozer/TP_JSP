/**
 * Title:        commerce
 * Description:  Class for e-commerce
 * Company:      IUT Laval - Université du Maine
 * @author  A. Corbière
 */

package commerce.catalogue.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Query;

import commerce.catalogue.domaine.modele.Article;
import commerce.catalogue.domaine.modele.Livre;
import commerce.catalogue.domaine.modele.Musique;
import commerce.catalogue.domaine.modele.Piste;
import commerce.catalogue.domaine.utilitaire.HibernateUtil;
import commerce.catalogue.domaine.utilitaire.UniqueKeyGenerator;

public class CatalogueManager {

	private List<Article> articles; 
	
	public Article chercherArticleParRef(String inRefArticle) throws Exception {
		Article article;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession() ;
		try {
			session.beginTransaction();
			article = (Article) session.get(Article.class, inRefArticle) ;
			session.getTransaction().commit();
		}
		catch (RuntimeException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
			throw e; 
		}
		return (article) ;
	}
	
	public void supprimerArticleParRef(String inRefArticle) throws Exception {
		Article article ;
		Session session = HibernateUtil.getSessionFactory().getCurrentSession() ;
		try {
			session.beginTransaction();
			article = (Article)session.get(Article.class, inRefArticle) ;
			session.delete(article) ;
			session.getTransaction().commit();
		}
		catch (RuntimeException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
			throw e; 
		}
	}
	public void soumettreArticle(Article inArticle) throws Exception {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession() ;
		try {
			session.beginTransaction();
			if (inArticle.getRefArticle() == null) {
				new UniqueKeyGenerator();
				inArticle.setRefArticle(UniqueKeyGenerator.getUniqueId()) ;
				session.save(inArticle) ;
			}
			else {
				session.saveOrUpdate(inArticle) ;
			}
			session.getTransaction().commit();
		}
		catch (RuntimeException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
			throw e; 
		}
	}
	public void soumettrePiste(Piste inPiste) throws Exception {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession() ;
		try {
			session.beginTransaction();
			if (inPiste.getRefPiste() == null) {
				new UniqueKeyGenerator();
				inPiste.setRefPiste(UniqueKeyGenerator.getUniqueId()) ;
				session.save(inPiste) ;
			}
			else {
				session.saveOrUpdate(inPiste) ;
			}
			session.getTransaction().commit();
		}
		catch (RuntimeException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
			throw e; 
		}
	}
	
	public void setArticles(List<Article> inArticles) throws Exception {
		articles = inArticles;
	}
	
	public List<Article> getArticles() throws Exception {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession() ;
		try {
			session.beginTransaction();
			Query query = session.createQuery("from commerce.catalogue.domaine.modele.Article");
			articles = query.list();
			session.getTransaction().commit();
		}
		catch (RuntimeException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
			throw e; 
		}
		return articles ;
	}
	
	public List<Article> getArticles(String category) throws Exception {
		if(category == null || category.length() < 1) {
			return getArticles();
		}
		
		return filterArticleByCat(getArticles(), category);
	}
	
	private List<Article> filterArticleByCat(List<Article> articlesNotFiltered, String category) throws Exception {
		List<Article> articlesFiltered = new ArrayList<Article>();
		
		Iterator<Article> listeDesArticles = articlesNotFiltered.iterator();
		Article article = null;
		while (listeDesArticles.hasNext()) {
			article = (Article) listeDesArticles.next();
			if((article instanceof Livre) && category.equalsIgnoreCase("livre")) {
				articlesFiltered.add(article);
			} else if((article instanceof Musique) && category.equalsIgnoreCase("musique")) {
				articlesFiltered.add(article);
			}
		}
		return articlesFiltered;
	}
	
	public List<Article> rechercherArticles(String searchTitre) throws Exception {
		Session session = HibernateUtil.getSessionFactory().getCurrentSession() ;
		try {
			session.beginTransaction();
			Query query = session.createQuery("from commerce.catalogue.domaine.modele.Article article where lower(article.titre) LIKE lower(:titre)");
			query.setParameter("titre", "%" + searchTitre + "%");
			articles = query.list();
			session.getTransaction().commit();
		}
		catch (RuntimeException e) {
			if (session.getTransaction() != null)
				session.getTransaction().rollback();
			throw e; 
		}
		return articles ;
	}
	
	public List<Article> rechercherArticles(String searchTitre, String category) throws Exception {
		if(category == null || category.length() < 1) {
			return rechercherArticles(searchTitre);
		}
		
		return filterArticleByCat(rechercherArticles(searchTitre), category);
	}
}
	