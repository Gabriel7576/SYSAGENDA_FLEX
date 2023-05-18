package br.com.gabriel.sysagenda.service;

import java.util.List;

import br.com.gabriel.sysagenda.business.ContatoBss;
import br.com.gabriel.sysagendasrv.domain.Contato;

public class ContatoService {

	ContatoBss contatoBss = new ContatoBss();

	public List<Contato> getLista(Integer codContato, String nome) {

		return contatoBss.getLista(codContato, nome);
	}

	public Contato getContato(int codContato) {

		return contatoBss.getContato(codContato);
	}

	public Contato adiciona(Contato contato) {

		return contatoBss.adicionaContato(contato);
	}

	public Contato altera(Contato contato) {

		return contatoBss.alteraContato(contato);
	}

	public void deletaContato(int codContato) {

		contatoBss.deletaContato(codContato);
	}

	public int getCodContato() {

		return contatoBss.getCodContato();
	}
}
