package br.com.gabriel.sysagenda.business;

import java.util.List;

import br.com.gabriel.sysagenda.dao.ContatoDao;
import br.com.gabriel.sysagenda.domain.Contato;

public class ContatoBss {

	public Contato adicionaContato(Contato contato) {
		
		ContatoDao dao = new ContatoDao();
		
		contato.setCodContato(getCodContato());
		
		dao.adiciona(contato);
		
		return contato;
	}

	public List<Contato> getLista(Integer codContato, String nome) {

		ContatoDao dao = new ContatoDao();
		
		return dao.getList(codContato, nome);
	}

	public Contato getContato(Integer codContato) {
		
		ContatoDao dao = new ContatoDao();
		
		return dao.getContato(codContato);
	}

	public Contato alteraContato(Contato contato) {
		
		ContatoDao dao = new ContatoDao();
		
		return dao.altera(contato);
	}

	public void deletaContato(int codContato) {
		
		ContatoDao dao = new ContatoDao();

		new LigacaoBss().deletaLigacoes(codContato);
		dao.deleta(codContato);
	}

	public Integer getCodContato() {
		
		ContatoDao dao = new ContatoDao();

		return dao.getUtlCodContato() + 1;
	}
}
