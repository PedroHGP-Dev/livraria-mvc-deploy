package com.mycompany.livrariapedrojoaquim.modelo.dao;

import com.mycompany.livrariapedrojoaquim.modelo.entidade.ItemCarrinho;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.PagamentoCarrinho;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Venda;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class VendaDao extends GenericoDAO<Venda> {

    private static class VendaRowMapper implements RowMapper<Venda> {
        @Override
        public Venda mapRow(ResultSet rs) throws SQLException {
            Venda obj = new Venda();
            obj.setCodVenda(rs.getInt("codVenda"));
            obj.setDataHoraVenda(rs.getTimestamp("dataHoraVenda"));
            return obj;
        }
    }

    public void salvarVendaCompleta(int clienteCod, int funcionarioCod, int livrariaId,
            List<ItemCarrinho> itens, List<PagamentoCarrinho> pagamentos) {

        String sqlVenda = "INSERT INTO venda (dataHoraVenda, cliente_codCliente, funcionario_codFuncionario, livraria_idLivraria) VALUES (NOW(), ?, ?, ?)";
        save(sqlVenda, clienteCod, funcionarioCod, livrariaId);

        int codVendaGerado = getLastId();

        String sqlItem = "INSERT INTO livroporvenda (livro_codLivro, venda_codVenda, quantLivroPorVenda, valorVendaUnidade) VALUES (?, ?, ?, ?)";
        String sqlEstoque = "UPDATE livro SET quantidadeLivro = quantidadeLivro - ? WHERE codLivro = ?";
        
        for (ItemCarrinho item : itens) {
            save(sqlItem, item.getLivroCodLivro(), codVendaGerado, item.getQuantLivroPorVenda(), item.getValorVendaUnidade());
            save(sqlEstoque, item.getQuantLivroPorVenda(), item.getLivroCodLivro());
        }

        String sqlPgto = "INSERT INTO formapagamentoporvenda (formaPagamento_codFormaPagamento, venda_codVenda, valor) VALUES (?, ?, ?)";
        for (PagamentoCarrinho pgto : pagamentos) {
            save(sqlPgto, pgto.getFormaPagamentoCod(), codVendaGerado, pgto.getValor());
        }
    }
}