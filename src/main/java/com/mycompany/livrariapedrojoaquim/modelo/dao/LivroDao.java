package com.mycompany.livrariapedrojoaquim.modelo.dao;

import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livro;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.GeneroLivro;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Editora;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livraria;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class LivroDao extends GenericoDAO<Livro> {

    public void salvar(Livro objLivro) {
        String sql = "INSERT INTO livro(nomeLivro, autorLivro, precoVenda, quantidadeLivro, generoLivro_codGeneroLivro, editora_codEditora, livraria_idLivraria, tombo, precoCompra) VALUES(?,?,?,?,?,?,?,?,?)";
        save(sql, objLivro.getTitulo(), objLivro.getAutor(), objLivro.getPreco(), objLivro.getEstoque(), objLivro.getGeneroLivro().getCodGeneroLivro(), objLivro.getEditora().getCodEditora(), objLivro.getLivraria().getIdLivraria(), "1", 0.0);
    }

    public void alterar(Livro objLivro) {
        String sql = "UPDATE livro SET nomeLivro=?, autorLivro=?, precoVenda=?, quantidadeLivro=?, generoLivro_codGeneroLivro=?, editora_codEditora=?, livraria_idLivraria=? WHERE codLivro=?";
        save(sql, objLivro.getTitulo(), objLivro.getAutor(), objLivro.getPreco(), objLivro.getEstoque(), objLivro.getGeneroLivro().getCodGeneroLivro(), objLivro.getEditora().getCodEditora(), objLivro.getLivraria().getIdLivraria(), objLivro.getCodigo());
    }

    public void excluir(Livro objLivro) {
        String sql = "DELETE FROM livro WHERE codLivro=?";
        save(sql, objLivro.getCodigo());
    }

    private static class LivroCompletoRowMapper implements RowMapper<Livro> {
        @Override
        public Livro mapRow(ResultSet rs) throws SQLException {
            Livro objLivro = new Livro();
            objLivro.setCodigo(rs.getInt("codLivro"));
            objLivro.setTitulo(rs.getString("nomeLivro"));
            objLivro.setAutor(rs.getString("autorLivro"));
            objLivro.setPreco(rs.getDouble("precoVenda"));
            objLivro.setEstoque(rs.getInt("quantidadeLivro"));

            GeneroLivro gen = objLivro.getGeneroLivro();
            gen.setCodGeneroLivro(rs.getInt("generoLivro_codGeneroLivro"));
            try {
                gen.setNomeGeneroLivro(rs.getString("nomeGeneroLivro"));
            } catch (SQLException e) {
            }

            Editora ed = objLivro.getEditora();
            ed.setCodEditora(rs.getInt("editora_codEditora"));
            try {
                ed.setNomeEditora(rs.getString("nomeEditora"));
            } catch (SQLException e) {
            }

            Livraria liv = objLivro.getLivraria();
            liv.setIdLivraria(rs.getInt("livraria_idLivraria"));
            try {
                liv.setNomeLivraria(rs.getString("nomeLivraria"));
            } catch (SQLException e) {
            }

            return objLivro;
        }
    }

    public List<Livro> buscarTodosLivros() {
        String sql = "SELECT l.*, g.nomeGeneroLivro, e.nomeEditora, liv.nomeLivraria FROM livro l " +
                     "INNER JOIN generolivro g ON l.generoLivro_codGeneroLivro = g.codGeneroLivro " +
                     "INNER JOIN editora e ON l.editora_codEditora = e.codEditora " +
                     "INNER JOIN livraria liv ON l.livraria_idLivraria = liv.idLivraria";
        return buscarTodos(sql, new LivroCompletoRowMapper());
    }

    public Livro buscarPorId(int id) {
        String sql = "SELECT l.*, g.nomeGeneroLivro, e.nomeEditora, liv.nomeLivraria FROM livro l " +
                     "INNER JOIN generolivro g ON l.generoLivro_codGeneroLivro = g.codGeneroLivro " +
                     "INNER JOIN editora e ON l.editora_codEditora = e.codEditora " +
                     "INNER JOIN livraria liv ON l.livraria_idLivraria = liv.idLivraria " +
                     "WHERE l.codLivro = ?";
        return buscarPorId(sql, new LivroCompletoRowMapper(), id);
    }
}