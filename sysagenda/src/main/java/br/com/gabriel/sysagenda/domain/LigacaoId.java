package br.com.gabriel.sysagenda.domain;

import java.io.Serializable;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class LigacaoId implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "COD_CONTATO")
	private int codContato;

	@Column(name = "COD_LIGACAO")
	private int codLigacao;

	public int getCodContato() {
		return codContato;
	}

	public void setCodContato(int codContato) {
		this.codContato = codContato;
	}

	public int getCodLigacao() {
		return codLigacao;
	}

	public void setCodLigacao(int codLigacao) {
		this.codLigacao = codLigacao;
	}

	@Override
	public String toString() {
		return "LigacaoId [codContato=" + codContato + ", codLigacao=" + codLigacao + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(codContato, codLigacao);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		LigacaoId other = (LigacaoId) obj;
		return codContato == other.codContato && codLigacao == other.codLigacao;
	}

}
