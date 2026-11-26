/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.livrariapedrojoaquim.modelo.dao;

import com.mycompany.livrariapedrojoaquim.modelo.entidade.Usuario;
import java.sql.Timestamp;

public class UsuarioDao extends GenericoDAO<Usuario> {

    private final RowMapper<Usuario> mapper = rs -> {
        Usuario u = new Usuario();
        u.setId(rs.getInt("id"));
        u.setNomeusuario(rs.getString("nomeusuario"));
        u.setSenhahash(rs.getString("senhahash"));
        u.setEmail(rs.getString("email"));
        u.setTokenRecuperacao(rs.getString("token_recuperacao"));
        
        Timestamp ts = rs.getTimestamp("token_expiracao");
        if (ts != null) {
            u.setTokenExpiracao(ts.toLocalDateTime());
        }
        return u;
    };

    public void cadastrar(Usuario usuario) {
        String sql = "INSERT INTO USUARIO (nomeusuario, senhahash, email) VALUES (?, ?, ?)";
        save(sql, usuario.getNomeusuario(), usuario.getSenhahash(), usuario.getEmail());
    }

    public Usuario buscarPorNomeUsuario(String nomeusuario) {
        String sql = "SELECT * FROM USUARIO WHERE nomeusuario = ?";
        return buscarPorId(sql, mapper, nomeusuario);
    }

    public Usuario buscarPorEmail(String email) {
        String sql = "SELECT * FROM USUARIO WHERE email = ?";
        return buscarPorId(sql, mapper, email);
    }

    public Usuario buscarPorToken(String token) {
        String sql = "SELECT * FROM USUARIO WHERE token_recuperacao = ?";
        return buscarPorId(sql, mapper, token);
    }

    public void salvarTokenRecuperacao(String email, String token, Timestamp expiracao) {
        String sql = "UPDATE USUARIO SET token_recuperacao = ?, token_expiracao = ? WHERE email = ?";
        save(sql, token, expiracao, email);
    }

    public void atualizarSenhaEInvalidarToken(int idUsuario, String novaSenhaHash) {
        String sql = "UPDATE USUARIO SET senhahash = ?, token_recuperacao = NULL, token_expiracao = NULL WHERE id = ?";
        save(sql, novaSenhaHash, idUsuario);
    }
}