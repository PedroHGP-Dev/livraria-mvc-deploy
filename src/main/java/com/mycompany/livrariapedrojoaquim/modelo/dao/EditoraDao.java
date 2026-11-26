/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.livrariapedrojoaquim.modelo.dao;

import com.mycompany.livrariapedrojoaquim.modelo.entidade.Editora;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class EditoraDao extends GenericoDAO<Editora> {

    public void salvar(Editora obj) {
        String sql = "INSERT INTO editora(nomeEditora, endereco, cnpj, telefone, email) VALUES(?,?,?,?,?)";
        save(sql, obj.getNomeEditora(), obj.getEndereco(), obj.getCnpj(), obj.getTelefone(), obj.getEmail());
    }

    public void alterar(Editora obj) {
        String sql = "UPDATE editora SET nomeEditora=?, endereco=?, cnpj=?, telefone=?, email=? WHERE codEditora=?";
        save(sql, obj.getNomeEditora(), obj.getEndereco(), obj.getCnpj(), obj.getTelefone(), obj.getEmail(), obj.getCodEditora());
    }

    public void excluir(Editora obj) {
        String sql = "DELETE FROM editora WHERE codEditora=?";
        save(sql, obj.getCodEditora());
    }

    private static class EditoraRowMapper implements RowMapper<Editora> {
        @Override
        public Editora mapRow(ResultSet rs) throws SQLException {
            Editora obj = new Editora();
            obj.setCodEditora(rs.getInt("codEditora"));
            obj.setNomeEditora(rs.getString("nomeEditora"));
            
           
            obj.setEndereco(rs.getString("endereco"));
            obj.setCnpj(rs.getString("cnpj"));
            obj.setTelefone(rs.getString("telefone"));
            obj.setEmail(rs.getString("email"));
            
            return obj;
        }
    }

    public List<Editora> buscarTodasEditoras() {
        String sql = "SELECT * FROM editora";
        return buscarTodos(sql, new EditoraRowMapper());
    }
}