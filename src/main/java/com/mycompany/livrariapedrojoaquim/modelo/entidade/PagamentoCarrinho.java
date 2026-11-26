package com.mycompany.livrariapedrojoaquim.modelo.entidade;

public class PagamentoCarrinho {

    private int formaPagamentoCod;
    private String nomeFormaPagamento;
    private double valor;

    public PagamentoCarrinho() {
    }

    public PagamentoCarrinho(int formaPagamentoCod, String nomeFormaPagamento, double valor) {
        this.formaPagamentoCod = formaPagamentoCod;
        this.nomeFormaPagamento = nomeFormaPagamento;
        this.valor = valor;
    }

    public int getFormaPagamentoCod() {
        return formaPagamentoCod;
    }

    public void setFormaPagamentoCod(int formaPagamentoCod) {
        this.formaPagamentoCod = formaPagamentoCod;
    }

    public String getNomeFormaPagamento() {
        return nomeFormaPagamento;
    }

    public void setNomeFormaPagamento(String nomeFormaPagamento) {
        this.nomeFormaPagamento = nomeFormaPagamento;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }
}