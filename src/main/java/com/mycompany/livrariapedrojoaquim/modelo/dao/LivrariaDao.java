/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.livrariapedrojoaquim.modelo.dao;

import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livraria;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author 16387875650
 */
public class LivrariaDao extends GenericoDAO<Livraria> {

    public void salvar(Livraria obj) {
        String sql = "INSERT INTO livraria(nomeLivraria, enderecoLivraria, estadoLivraria, cidadeLivraria, emailLivraria, telefoneLivraria) VALUES(?,?,?,?,?,?)";
        save(sql, obj.getNomeLivraria(), obj.getEnderecoLivraria(), obj.getEstadoLivraria(), obj.getCidadeLivraria(), obj.getEmailLivraria(), obj.getTelefoneLivraria());
    }

    public void alterar(Livraria obj) {
        String sql = "UPDATE livraria SET nomeLivraria=?, enderecoLivraria=?, estadoLivraria=?, cidadeLivraria=?, emailLivraria=?, telefoneLivraria=? WHERE idLivraria=?";
        save(sql, obj.getNomeLivraria(), obj.getEnderecoLivraria(), obj.getEstadoLivraria(), obj.getCidadeLivraria(), obj.getEmailLivraria(), obj.getTelefoneLivraria(), obj.getIdLivraria());
    }

    public void excluir(Livraria obj) {
        String sql = "DELETE FROM livraria WHERE idLivraria=?";
        save(sql, obj.getIdLivraria());
    }

   
    private static class LivrariaRowMapper implements RowMapper<Livraria> {
        @Override
        public Livraria mapRow(ResultSet rs) throws SQLException {
            Livraria obj = new Livraria();
            obj.setIdLivraria(rs.getInt("idLivraria"));
            obj.setNomeLivraria(rs.getString("nomeLivraria"));
            obj.setEnderecoLivraria(rs.getString("enderecoLivraria"));
            obj.setEstadoLivraria(rs.getString("estadoLivraria"));
            obj.setCidadeLivraria(rs.getString("cidadeLivraria"));
            obj.setEmailLivraria(rs.getString("emailLivraria"));
            obj.setTelefoneLivraria(rs.getString("telefoneLivraria"));
            return obj;
        }
    }

    public List<Livraria> buscarDadosLivraria() {
        String sql = "SELECT * FROM livraria";
        return buscarTodos(sql, new LivrariaRowMapper());
    }
}