package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.VendaDao;
import com.mycompany.livrariapedrojoaquim.modelo.dao.ClienteDao;
import com.mycompany.livrariapedrojoaquim.modelo.dao.FuncionarioDao;
import com.mycompany.livrariapedrojoaquim.modelo.dao.LivrariaDao;
import com.mycompany.livrariapedrojoaquim.modelo.dao.LivroDao;
import com.mycompany.livrariapedrojoaquim.modelo.dao.FormaPagamentoDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.ItemCarrinho;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.PagamentoCarrinho;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Cliente;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Funcionario;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livraria;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livro;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.FormaPagamento;
import com.mycompany.livrariapedrojoaquim.servico.WebConstante;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/VendaControlador")
public class VendaControlador extends HttpServlet {

    private VendaDao objDao = new VendaDao();
    private ClienteDao clienteDao = new ClienteDao();
    private FuncionarioDao funcionarioDao = new FuncionarioDao();
    private LivrariaDao livrariaDao = new LivrariaDao();
    private LivroDao livroDao = new LivroDao();
    private FormaPagamentoDao formaPagamentoDao = new FormaPagamentoDao();
    
    private List<ItemCarrinho> carrinhoItens = new ArrayList<>();
    private List<PagamentoCarrinho> carrinhoPagamentos = new ArrayList<>();
    
    private String clienteCod = "", funcionarioCod = "", livrariaId = "";
    private String livroCodStr = "", quantLivro = "", formaPagamentoCod = "", valorPagamento = "";
    private String opcao = "", mensagem = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            opcao = request.getParameter("opcao");
            if (opcao == null || opcao.isEmpty()) {
                opcao = "abrirCaixa";
            }

            clienteCod = request.getParameter("cliente_codCliente");
            funcionarioCod = request.getParameter("funcionario_codFuncionario");
            livrariaId = request.getParameter("livraria_idLivraria");
            livroCodStr = request.getParameter("livro_codLivro");
            quantLivro = request.getParameter("quantLivroPorVenda");
            formaPagamentoCod = request.getParameter("formaPagamento_codFormaPagamento");
            valorPagamento = request.getParameter("valorPagamento");

            switch (opcao) {
                case "abrirCaixa": abrirCaixa(request, response); break;
                case "iniciar": iniciar(request, response); break;
                case "addLivro": addLivro(request, response); break;
                case "removeLivro": removeLivro(request, response); break;
                case "addPagamento": addPagamento(request, response); break;
                case "removePagamento": removePagamento(request, response); break;
                case "finalizar": finalizar(request, response); break;
                case "cancelar": cancelar(request, response); break;
            }
        } catch (Exception e) {
            response.getWriter().println("Erro no Controlador de Vendas: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    private void abrirCaixa(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        mensagem = "";
        encaminharParaPagina(request, response);
    }

    private void iniciar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        mensagem = "";
        encaminharParaPagina(request, response);
    }

    private void addLivro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (livroCodStr != null && !livroCodStr.isEmpty() && quantLivro != null && !quantLivro.isEmpty()) {
            try {
                int cod = Integer.parseInt(livroCodStr);
                int qtdDesejada = Integer.parseInt(quantLivro);

                Livro livro = livroDao.buscarPorId(cod);

                if (livro != null) {
                    int qtdNoCarrinho = 0;
                    for (ItemCarrinho item : carrinhoItens) {
                        if (item.getLivroCodLivro() == cod) {
                            qtdNoCarrinho += item.getQuantLivroPorVenda();
                        }
                    }

                    if ((qtdNoCarrinho + qtdDesejada) <= livro.getEstoque()) {
                        carrinhoItens.add(new ItemCarrinho(livro.getCodigo(), livro.getTitulo(), qtdDesejada, livro.getPreco()));
                        mensagem = "";
                    } else {
                        mensagem = "Quantidade indisponível em estoque. Estoque total: " + livro.getEstoque() + " un.";
                    }
                } else {
                    mensagem = "Livro não encontrado.";
                }
            } catch (Exception e) {
                mensagem = "Erro ao adicionar livro.";
            }
        }
        encaminharParaPagina(request, response);
    }

    private void removeLivro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String index = request.getParameter("indexLivro");
        if (index != null && !index.isEmpty()) {
            try {
                int idx = Integer.parseInt(index);
                if (idx >= 0 && idx < carrinhoItens.size()) {
                    carrinhoItens.remove(idx);
                }
            } catch (Exception e) {}
        }
        encaminharParaPagina(request, response);
    }

    private void addPagamento(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (formaPagamentoCod != null && !formaPagamentoCod.isEmpty() && valorPagamento != null && !valorPagamento.isEmpty()) {
            try {
                int fCod = Integer.parseInt(formaPagamentoCod);
                double valor = Double.parseDouble(valorPagamento.replace(",", "."));
                
                if (valor > 0) {
                    String nomeForma = "Desconhecido";
                    List<FormaPagamento> formas = formaPagamentoDao.buscarTodasFormas();
                    for (FormaPagamento fp : formas) {
                        if (fp.getCodFormaPagamento() == fCod) {
                            nomeForma = fp.getNomeFormaPagamento();
                            break;
                        }
                    }
                    
                    carrinhoPagamentos.add(new PagamentoCarrinho(fCod, nomeForma, valor));
                    mensagem = "";
                } else {
                    mensagem = "O valor do pagamento deve ser maior que zero.";
                }
            } catch (Exception e) {
                mensagem = "Erro ao adicionar pagamento.";
            }
        }
        encaminharParaPagina(request, response);
    }

    private void removePagamento(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String index = request.getParameter("indexPgto");
        if (index != null && !index.isEmpty()) {
            try {
                int idx = Integer.parseInt(index);
                if (idx >= 0 && idx < carrinhoPagamentos.size()) {
                    carrinhoPagamentos.remove(idx);
                }
            } catch (Exception e) {}
        }
        encaminharParaPagina(request, response);
    }

    private void finalizar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!carrinhoItens.isEmpty() && !carrinhoPagamentos.isEmpty()) {
            double totalLivros = 0;
            for (ItemCarrinho item : carrinhoItens) {
                totalLivros += item.getSubtotal();
            }

            double totalPago = 0;
            boolean temPagamentoDinheiro = false;
            
            for (PagamentoCarrinho p : carrinhoPagamentos) {
                totalPago += p.getValor();
                if (p.getNomeFormaPagamento() != null && p.getNomeFormaPagamento().equalsIgnoreCase("Dinheiro")) {
                    temPagamentoDinheiro = true;
                }
            }

            if (totalPago < totalLivros) {
                mensagem = "Não é possível finalizar a venda: O valor pago é menor do que o total dos livros.";
            } else if (totalPago > totalLivros && !temPagamentoDinheiro) {
                mensagem = "Não é possível passar valor a mais (troco) em formas de pagamento que não sejam Dinheiro.";
            } else {
                try {
                    int cCod = Integer.parseInt(clienteCod);
                    int fCod = Integer.parseInt(funcionarioCod);
                    int lId = Integer.parseInt(livrariaId);
                    
                    objDao.salvarVendaCompleta(cCod, fCod, lId, carrinhoItens, carrinhoPagamentos);
                    
                    carrinhoItens.clear();
                    carrinhoPagamentos.clear();
                    clienteCod = "";
                    funcionarioCod = "";
                    livrariaId = "";
                    mensagem = "Venda cadastrada com sucesso";
                } catch (Exception e) {
                    mensagem = "Erro ao finalizar venda: preencha todos os campos obrigatórios.";
                }
            }
        } else {
            mensagem = "Carrinho ou pagamentos não podem estar vazios.";
        }
        encaminharParaPagina(request, response);
    }

    private void cancelar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        carrinhoItens.clear();
        carrinhoPagamentos.clear();
        clienteCod = "";
        funcionarioCod = "";
        livrariaId = "";
        mensagem = "";
        encaminharParaPagina(request, response);
    }

    private void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        double totalLivros = 0;
        for (ItemCarrinho item : carrinhoItens) {
            totalLivros += item.getSubtotal();
        }

        double totalPago = 0;
        for (PagamentoCarrinho p : carrinhoPagamentos) {
            totalPago += p.getValor();
        }

        double restante = totalLivros - totalPago;

        List<Cliente> clientesMapeados = clienteDao.buscarTodosClientes();
        List<Funcionario> funcionariosMapeados = funcionarioDao.buscarTodosFuncionarios();
        List<Livraria> livrariasMapeadas = livrariaDao.buscarDadosLivraria();
        List<Livro> listaLivros = livroDao.buscarTodosLivros();
        List<FormaPagamento> listaFormasPagamento = formaPagamentoDao.buscarTodasFormas();

        request.setAttribute("listaCliente", clientesMapeados);
        request.setAttribute("listaFuncionario", funcionariosMapeados);
        request.setAttribute("listaLivraria", livrariasMapeadas);
        request.setAttribute("listaLivros", listaLivros);
        request.setAttribute("listaFormasPagamento", listaFormasPagamento);

        request.setAttribute("carrinhoItens", carrinhoItens);
        request.setAttribute("carrinhoPagamentos", carrinhoPagamentos);
        request.setAttribute("totalLivros", totalLivros);
        request.setAttribute("totalPago", totalPago);
        request.setAttribute("restante", restante);
        request.setAttribute("mensagem", mensagem);

        request.setAttribute("cliente_codCliente", clienteCod);
        request.setAttribute("funcionario_codFuncionario", funcionarioCod);
        request.setAttribute("livraria_idLivraria", livrariaId);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroCaixa.jsp");
        dispatcher.forward(request, response);
    }
}