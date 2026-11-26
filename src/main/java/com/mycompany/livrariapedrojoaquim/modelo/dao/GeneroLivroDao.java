/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.livrariapedrojoaquim.modelo.dao;

/**
 *
 * @author 16387875650
 */
import com.mycompany.livrariapedrojoaquim.modelo.entidade.GeneroLivro;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class GeneroLivroDao extends GenericoDAO<GeneroLivro> {

    public void salvar(GeneroLivro obj) {
        String sql = "INSERT INTO generolivro(nomeGeneroLivro) VALUES(?)";
        save(sql, obj.getNomeGeneroLivro());
    }

    public void alterar(GeneroLivro obj) {
        String sql = "UPDATE generolivro SET nomeGeneroLivro=? WHERE codGeneroLivro=?";
        save(sql, obj.getNomeGeneroLivro(), obj.getCodGeneroLivro());
    }

    public void excluir(GeneroLivro obj) {
        String sql = "DELETE FROM generolivro WHERE codGeneroLivro=?";
        save(sql, obj.getCodGeneroLivro());
    }

    private static class GeneroRowMapper implements RowMapper<GeneroLivro> {
        @Override
        public GeneroLivro mapRow(ResultSet rs) throws SQLException {
            GeneroLivro obj = new GeneroLivro();
            obj.setCodGeneroLivro(rs.getInt("codGeneroLivro"));
            obj.setNomeGeneroLivro(rs.getString("nomeGeneroLivro"));
            return obj;
        }
    }

    public List<GeneroLivro> buscarTodosGeneros() {
        String sql = "SELECT * FROM generolivro";
        return buscarTodos(sql, new GeneroRowMapper());
    }

    public GeneroLivro buscarGeneroPorId(int id) {
        String sql = "SELECT * FROM generolivro WHERE codGeneroLivro = ?";
        return buscarPorId(sql, new GeneroRowMapper(), id);
    }
}
