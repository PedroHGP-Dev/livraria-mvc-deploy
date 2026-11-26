/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.livrariapedrojoaquim.modelo.dao;

/**
 *
 * @author 16387875650
 */
import com.mycompany.livrariapedrojoaquim.modelo.entidade.FormaPagamento;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class FormaPagamentoDao extends GenericoDAO<FormaPagamento> {

    public void salvar(FormaPagamento obj) {
        String sql = "INSERT INTO formapagamento(nomeFormaPagamento) VALUES(?)";
        save(sql, obj.getNomeFormaPagamento());
    }

    public void alterar(FormaPagamento obj) {
        String sql = "UPDATE formapagamento SET nomeFormaPagamento=? WHERE codFormaPagamento=?";
        save(sql, obj.getNomeFormaPagamento(), obj.getCodFormaPagamento());
    }

    public void excluir(FormaPagamento obj) {
        String sql = "DELETE FROM formapagamento WHERE codFormaPagamento=?";
        save(sql, obj.getCodFormaPagamento());
    }

    private static class PagamentoRowMapper implements RowMapper<FormaPagamento> {
        @Override
        public FormaPagamento mapRow(ResultSet rs) throws SQLException {
            FormaPagamento obj = new FormaPagamento();
            obj.setCodFormaPagamento(rs.getInt("codFormaPagamento"));
            obj.setNomeFormaPagamento(rs.getString("nomeFormaPagamento"));
            return obj;
        }
    }

    public List<FormaPagamento> buscarTodasFormas() {
        String sql = "SELECT * FROM formapagamento";
        return buscarTodos(sql, new PagamentoRowMapper());
    }
}