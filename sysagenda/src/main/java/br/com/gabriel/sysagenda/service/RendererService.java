package br.com.gabriel.sysagenda.service;

import br.com.gabriel.sysagenda.business.ContatoBss;

public class RendererService {

	public String getContato(Integer codContato) {

		return new ContatoBss().getContato(codContato).getNome();
	}
}
