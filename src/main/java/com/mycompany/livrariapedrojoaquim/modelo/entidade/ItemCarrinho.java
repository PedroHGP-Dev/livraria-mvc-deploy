package com.mycompany.livrariapedrojoaquim.modelo.entidade;

public class ItemCarrinho {

    private int livroCodLivro;
    private String tituloLivro;
    private int quantLivroPorVenda;
    private double valorVendaUnidade;
    private double subtotal;

    public ItemCarrinho() {
    }

    public ItemCarrinho(int livroCodLivro, String tituloLivro, int quantLivroPorVenda, double valorVendaUnidade) {
        this.livroCodLivro = livroCodLivro;
        this.tituloLivro = tituloLivro;
        this.quantLivroPorVenda = quantLivroPorVenda;
        this.valorVendaUnidade = valorVendaUnidade;
        this.subtotal = quantLivroPorVenda * valorVendaUnidade;
    }

    public int getLivroCodLivro() {
        return livroCodLivro;
    }

    public void setLivroCodLivro(int livroCodLivro) {
        this.livroCodLivro = livroCodLivro;
    }

    public String getTituloLivro() {
        return tituloLivro;
    }

    public void setTituloLivro(String tituloLivro) {
        this.tituloLivro = tituloLivro;
    }

    public int getQuantLivroPorVenda() {
        return quantLivroPorVenda;
    }

    public void setQuantLivroPorVenda(int quantLivroPorVenda) {
        this.quantLivroPorVenda = quantLivroPorVenda;
        this.subtotal = this.quantLivroPorVenda * this.valorVendaUnidade;
    }

    public double getValorVendaUnidade() {
        return valorVendaUnidade;
    }

    public void setValorVendaUnidade(double valorVendaUnidade) {
        this.valorVendaUnidade = valorVendaUnidade;
        this.subtotal = this.quantLivroPorVenda * this.valorVendaUnidade;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
}