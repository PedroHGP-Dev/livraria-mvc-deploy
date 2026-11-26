package com.mycompany.livrariapedrojoaquim.modelo.entidade;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class Funcionario {

    private Integer codigo;
    private String nome;
    private String cpf;
    private Double salario;
    private Double comissaoPorLivro;
    private String endereco;
    private String email;
    private String telefone;
    private String carteiraTrabalho;
    private String pis;
    private LocalDate nascimento;

    private Livraria livraria = new Livraria();

    public Integer getCodigo() {
        return codigo;
    }

    public void setCodigo(Integer codigo) {
        this.codigo = codigo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public Double getSalario() {
        return salario;
    }

    public void setSalario(Double salario) {
        this.salario = salario;
    }

    public Double getComissaoPorLivro() {
        return comissaoPorLivro;
    }

    public void setComissaoPorLivro(Double comissaoPorLivro) {
        this.comissaoPorLivro = comissaoPorLivro;
    }

    public String getEndereco() {
        return endereco;
    }

    public void setEndereco(String endereco) {
        this.endereco = endereco;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getCarteiraTrabalho() {
        return carteiraTrabalho;
    }

    public void setCarteiraTrabalho(String carteiraTrabalho) {
        this.carteiraTrabalho = carteiraTrabalho;
    }

    public String getPis() {
        return pis;
    }

    public void setPis(String pis) {
        this.pis = pis;
    }

    public LocalDate getNascimento() {
        return nascimento;
    }

    public void setNascimento(LocalDate nascimento) {
        this.nascimento = nascimento;
    }

    public Livraria getLivraria() {
        return livraria;
    }

    public void setLivraria(Livraria livraria) {
        this.livraria = livraria;
    }

    public String getNascimentoFormatado() {
        if (nascimento == null) {
            return "";
        }
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        return nascimento.format(formatter);
    }

}