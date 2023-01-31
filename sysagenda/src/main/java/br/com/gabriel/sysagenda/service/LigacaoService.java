package br.com.gabriel.sysagenda.service;

import java.util.List;

import br.com.gabriel.sysagenda.business.LigacaoBss;
import br.com.gabriel.sysagenda.domain.Ligacao;
import br.com.gabriel.sysagenda.domain.LigacaoId;

public class LigacaoService {

	LigacaoBss ligacaoBss = new LigacaoBss();
	
	public List<Ligacao> getList(String dataInicio, String dataFinal,int codContato,int codLigacao) {
		
		return ligacaoBss.getlista(dataInicio, dataFinal, codContato, codLigacao);
	}
	
	public Ligacao getLigacao(LigacaoId id) {
		
		return ligacaoBss.getLigacao(id);
	}
	
	public Ligacao adiciona(Ligacao ligacao) {
		
		return ligacaoBss.adicionaLigacao(ligacao);
	}
	
	public Ligacao altera(Ligacao ligacao) {
		
		return ligacaoBss.alteraLigacao(ligacao);
	}
	
	public void deletaLigacao(LigacaoId id) {
		
		ligacaoBss.deletaLigacao(id);
	}
	
	public int getCodLigacao(int codContato) {
		
		return ligacaoBss.getCodLigacao(codContato);
	}
}
