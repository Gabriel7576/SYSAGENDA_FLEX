package br.com.gabriel.sysagenda.business;

import java.util.List;

import br.com.gabriel.sysagenda.dao.LigacaoDao;
import br.com.gabriel.sysagendasrv.domain.Ligacao;
import br.com.gabriel.sysagendasrv.domain.LigacaoId;

public class LigacaoBss {

	LigacaoDao dao = new LigacaoDao();

	public Ligacao adicionaLigacao(Ligacao ligacao) {
		
		LigacaoId id = new LigacaoId();
		
		id.setCodContato(ligacao.getId().getCodContato());
		id.setCodLigacao(new LigacaoBss().getCodLigacao(id.getCodContato()));
		
		ligacao.setId(id);
		
		return dao.adicionaLigacao(ligacao);
	}

	public List<Ligacao> getlista(String dataInicio, String dataFinal,int codContato,int codLigacao) {

		return dao.lista(dataInicio, dataFinal, codContato, codLigacao);
	}

	public Ligacao getLigacao(LigacaoId id) {

		return dao.getLigacao(id);
	}

	public Ligacao alteraLigacao(Ligacao ligacao) {

		return dao.alterar(ligacao);
	}

	public void deletaLigacoes(int codContato) {

		dao.deletaTodas(codContato);
	}

	public void deletaLigacao(LigacaoId ligacaoid) {

		dao.deletaUma(ligacaoid);
	}

	public Integer getCodLigacao(Integer codContato) {

		return dao.getUtlCodLigacao(codContato) + 1;
	}

}
