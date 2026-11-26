package com.mycompany.livrariapedrojoaquim.modelo.dao;

import com.mycompany.livrariapedrojoaquim.modelo.entidade.Funcionario;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livraria;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FuncionarioDao extends GenericoDAO<Funcionario>{
    
    public void salvar(Funcionario objFuncionario){
        String sql = "INSERT INTO funcionario(nomeFuncionario, cpfFuncionario, salario, comissaoPorLivro, endereco, email, telefone, carteiraTrabalho, pis, livraria_idLivraria) VALUES(?,?,?,?,?,?,?,?,?,?)";
        save(sql, objFuncionario.getNome(), objFuncionario.getCpf(), objFuncionario.getSalario(), objFuncionario.getComissaoPorLivro(), objFuncionario.getEndereco(), objFuncionario.getEmail(), objFuncionario.getTelefone(), objFuncionario.getCarteiraTrabalho(), objFuncionario.getPis(), objFuncionario.getLivraria().getIdLivraria());
    }

    public void alterar(Funcionario objFuncionario){
        String sql = "UPDATE funcionario SET nomeFuncionario=?, cpfFuncionario=?, salario=?, comissaoPorLivro=?, endereco=?, email=?, telefone=?, carteiraTrabalho=?, pis=?, livraria_idLivraria=? WHERE codFuncionario=?";
        save(sql, objFuncionario.getNome(), objFuncionario.getCpf(), objFuncionario.getSalario(), objFuncionario.getComissaoPorLivro(), objFuncionario.getEndereco(), objFuncionario.getEmail(), objFuncionario.getTelefone(), objFuncionario.getCarteiraTrabalho(), objFuncionario.getPis(), objFuncionario.getLivraria().getIdLivraria(), objFuncionario.getCodigo());
    }

    public void excluir(Funcionario objFuncionario){
        String sql = "DELETE FROM funcionario WHERE codFuncionario=?";
        save(sql, objFuncionario.getCodigo());
    }
    
    private static class FuncionarioCompletoRowMapper implements RowMapper<Funcionario>{
        @Override
        public Funcionario mapRow(ResultSet rs) throws SQLException {
            Funcionario objFuncionario = new Funcionario();
            objFuncionario.setCodigo(rs.getInt("codFuncionario"));
            objFuncionario.setNome(rs.getString("nomeFuncionario"));
            objFuncionario.setCpf(rs.getString("cpfFuncionario"));
            objFuncionario.setSalario(rs.getDouble("salario"));
            objFuncionario.setComissaoPorLivro(rs.getDouble("comissaoPorLivro"));
            objFuncionario.setEndereco(rs.getString("endereco"));
            objFuncionario.setEmail(rs.getString("email"));
            objFuncionario.setTelefone(rs.getString("telefone"));
            objFuncionario.setCarteiraTrabalho(rs.getString("carteiraTrabalho"));
            objFuncionario.setPis(rs.getString("pis"));
            
            Livraria liv = objFuncionario.getLivraria();
            liv.setIdLivraria(rs.getInt("livraria_idLivraria"));
            try {
                liv.setNomeLivraria(rs.getString("nomeLivraria"));
            } catch (SQLException e) {
            }
            
            return objFuncionario;
        }
    }
    
    public List<Funcionario> buscarTodosFuncionarios(){
        String sql = "SELECT f.*, l.nomeLivraria FROM funcionario f " +
                     "INNER JOIN livraria l ON f.livraria_idLivraria = l.idLivraria";
        return buscarTodos(sql, new FuncionarioCompletoRowMapper());
    }
    
    public Funcionario buscarPorId(int id){
        String sql = "SELECT f.*, l.nomeLivraria FROM funcionario f " +
                     "INNER JOIN livraria l ON f.livraria_idLivraria = l.idLivraria " +
                     "WHERE f.codFuncionario = ?";
        return buscarPorId(sql, new FuncionarioCompletoRowMapper(), id);
    }
}