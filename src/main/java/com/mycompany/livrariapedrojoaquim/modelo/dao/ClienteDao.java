package com.mycompany.livrariapedrojoaquim.modelo.dao;

import com.mycompany.livrariapedrojoaquim.modelo.entidade.Cliente;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livraria;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ClienteDao extends GenericoDAO<Cliente> {
    
    public void salvar(Cliente objCliente) {
        String sql = "INSERT INTO cliente(nomeCliente, cpfCliente, endereco, bairro, cep, cidade, telefone, email, livraria_idLivraria) VALUES(?,?,?,?,?,?,?,?,?)";
        save(sql, objCliente.getNome(), objCliente.getCpf(), objCliente.getEndereco(), objCliente.getBairro(), objCliente.getCep(), objCliente.getCidade(), objCliente.getTelefone(), objCliente.getEmail(), objCliente.getLivraria().getIdLivraria());
    }

    public void alterar(Cliente objCliente) {
        String sql = "UPDATE cliente SET nomeCliente=?, cpfCliente=?, endereco=?, bairro=?, cep=?, cidade=?, telefone=?, email=?, livraria_idLivraria=? WHERE codCliente=?";
        save(sql, objCliente.getNome(), objCliente.getCpf(), objCliente.getEndereco(), objCliente.getBairro(), objCliente.getCep(), objCliente.getCidade(), objCliente.getTelefone(), objCliente.getEmail(), objCliente.getLivraria().getIdLivraria(), objCliente.getCodigo());
    }

    public void excluir(Cliente objCliente) {
        String sql = "DELETE FROM cliente WHERE codCliente=?";
        save(sql, objCliente.getCodigo());
    }
    
    private static class ClienteCompletoRowMapper implements RowMapper<Cliente> {
        @Override
        public Cliente mapRow(ResultSet rs) throws SQLException {
            Cliente objCliente = new Cliente();
            objCliente.setCodigo(rs.getInt("codCliente"));
            objCliente.setNome(rs.getString("nomeCliente"));
            objCliente.setCpf(rs.getString("cpfCliente"));
            objCliente.setEndereco(rs.getString("endereco"));
            objCliente.setBairro(rs.getString("bairro"));
            objCliente.setCep(rs.getString("cep"));
            objCliente.setCidade(rs.getString("cidade"));
            objCliente.setTelefone(rs.getString("telefone"));
            objCliente.setEmail(rs.getString("email"));
            
            Livraria liv = new Livraria();
            liv.setIdLivraria(rs.getInt("livraria_idLivraria"));
            
            try {
                liv.setNomeLivraria(rs.getString("nomeLivraria"));
            } catch (SQLException e) {
            }
            
            objCliente.setLivraria(liv);
            
            return objCliente;
        }
    }
    
    public List<Cliente> buscarTodosClientes() {
        String sql = "SELECT c.*, l.nomeLivraria FROM cliente c " +
                     "INNER JOIN livraria l ON c.livraria_idLivraria = l.idLivraria";
        return buscarTodos(sql, new ClienteCompletoRowMapper());
    }
    
    public Cliente buscarPorId(int id) {
        String sql = "SELECT c.*, l.nomeLivraria FROM cliente c " +
                     "INNER JOIN livraria l ON c.livraria_idLivraria = l.idLivraria " +
                     "WHERE c.codCliente = ?";
        return buscarPorId(sql, new ClienteCompletoRowMapper(), id);
    }
}