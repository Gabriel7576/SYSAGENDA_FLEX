package br.com.gabriel.sysagenda.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.transaction.SystemException;
import javax.transaction.UserTransaction;

import br.com.gabriel.sysagenda.business.LigacaoBss;
import br.com.gabriel.sysagenda.factory.ConnectionFactory;
import br.com.gabriel.sysagendasrv.domain.Ligacao;
import br.com.gabriel.sysagendasrv.domain.LigacaoId;

public class LigacaoDao {

	private EntityManager em;
	private UserTransaction userTransaction;

	public LigacaoDao() {
		em = ConnectionFactory.getEntityManager();
		userTransaction = ConnectionFactory.getUserTransaction();
	}

	public Ligacao adicionaLigacao(Ligacao ligacao) {
		try {
			userTransaction.begin();
			em.persist(ligacao);
			userTransaction.commit();
			
			return ligacao;
		} catch (Exception e) {
			e.printStackTrace();
			try {
				userTransaction.rollback();
			} catch (IllegalStateException | SecurityException | SystemException e1) {
				e1.printStackTrace();
			}
			throw new RuntimeException(e);
		}
	}

	public Ligacao getLigacao(LigacaoId id) {

		try {
			return em.find(Ligacao.class, id);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	@SuppressWarnings("unchecked")
	public List<Ligacao> lista(String dataInicio, String dataFinal,int codContato,int codLigacao) {
		try {
			
			StringBuilder sql = new StringBuilder();
			
			sql.append("select o from Ligacao o ");
			sql.append("where id.codLigacao != 0 ");
			
			if (dataInicio != null && !dataInicio.isEmpty()) {
				
				sql.append(" and data_hora > TO_DATE('"+ dataInicio +"','DD/MM/YYYY')");
			}
			
			if (dataFinal != null && !dataFinal.isEmpty()) {
				
				sql.append(" and  data_hora < TO_DATE('"+ dataFinal +"','DD/MM/YYYY')");
			}
			
			if (codContato != 0) {
				
				sql.append(" and id.codContato = ");
				sql.append(codContato);
			}
			
			if (codLigacao != 0) {
				
				sql.append(" and id.codLigacao = ");
				sql.append(codLigacao);
			}
			
			Query query = em.createQuery(sql.toString());
			return query.getResultList();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public Ligacao alterar(Ligacao ligacao) {
		try {
			userTransaction.begin();
			em.merge(ligacao);
			userTransaction.commit();
			
			return ligacao;
		} catch (Exception e) {
			e.printStackTrace();
			try {
				userTransaction.rollback();
			} catch (IllegalStateException | SecurityException | SystemException e1) {
				e1.printStackTrace();
			}
			throw new RuntimeException(e);
		}
	}

	public void deletaUma(LigacaoId ligacaoid) {
		try {
			userTransaction.begin();
			em.remove(new LigacaoBss().getLigacao(ligacaoid));
			userTransaction.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				userTransaction.rollback();
			} catch (IllegalStateException | SecurityException | SystemException e1) {
				e1.printStackTrace();
			}
			throw new RuntimeException(e);
		}
	}

	public void deletaTodas(int codContato) {
		try {

			userTransaction.begin();
			Query query = em.createQuery("delete from Ligacao l where id.codContato = :codContato");
			query.setParameter("codContato", codContato);
			query.executeUpdate();
			userTransaction.commit();

		} catch (Exception e) {
			e.printStackTrace();
			try {
				userTransaction.rollback();
			} catch (IllegalStateException | SecurityException | SystemException e1) {
				e1.printStackTrace();
			}
			throw new RuntimeException(e);
		}
	}

	public Integer getUtlCodLigacao(Integer codContato) {
		try {
			Query query = em
					.createQuery("select nvl(max(id.codLigacao), 0) from Ligacao where id.codContato = :codContato");
			query.setParameter("codContato", codContato);
			return (Integer) query.getSingleResult();
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
