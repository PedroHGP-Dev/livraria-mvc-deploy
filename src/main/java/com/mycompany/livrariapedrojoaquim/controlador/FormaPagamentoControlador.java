/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.livrariapedrojoaquim.controlador;

/**
 *
 * @author 16387875650
 */
import com.mycompany.livrariapedrojoaquim.modelo.dao.FormaPagamentoDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.FormaPagamento;
import com.mycompany.livrariapedrojoaquim.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH+"/FormaPagamentoControlador")
public class FormaPagamentoControlador extends HttpServlet {
    FormaPagamento obj = new FormaPagamento();
    FormaPagamentoDao objDao = new FormaPagamentoDao();
    String nome = "";
    String cod = "";
    String opcao = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            opcao = request.getParameter("opcao");
            if(opcao == null || opcao.isEmpty()) opcao = "cadastrar";
            
            cod = request.getParameter("codFormaPagamento");
            nome = request.getParameter("nomeFormaPagamento");

            switch(opcao){
                case "cadastrar": cadastrar(request,response); break;
                case "enviarAlterar": enviarAlterar(request,response); break; 
                case "enviarExcluir": enviarExcluir(request,response); break; 
                case "confirmarAlterar": confirmarAlterar(request,response); break;
                case "confirmarExcluir": confirmarExcluir(request,response); break;
                case "cancelar": cancelar(request,response); break;
            }
        } catch(Exception e) {
            response.getWriter().println("Erro: " + e.getMessage());
        }
    }

    private void cadastrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        obj.setNomeFormaPagamento(nome);
        objDao.salvar(obj);
        cancelar(request, response);
    }

    private void enviarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codFormaPagamento", cod);
        request.setAttribute("nomeFormaPagamento", nome);
        request.setAttribute("opcao", "confirmarAlterar");
        encaminharParaPagina(request, response);
    }

    private void enviarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codFormaPagamento", cod);
        request.setAttribute("nomeFormaPagamento", nome);
        request.setAttribute("opcao", "confirmarExcluir");
        encaminharParaPagina(request, response);
    }

    private void confirmarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        obj.setCodFormaPagamento(Integer.valueOf(cod));
        obj.setNomeFormaPagamento(nome);
        objDao.alterar(obj);
        cancelar(request, response);
    }

    private void confirmarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        obj.setCodFormaPagamento(Integer.valueOf(cod));
        objDao.excluir(obj);
        cancelar(request, response);
    }

    private void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<FormaPagamento> lista = objDao.buscarTodasFormas();
        request.setAttribute("listaPagamentos", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroFormaPagamento.jsp");
        dispatcher.forward(request, response);
    }

    private void cancelar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codFormaPagamento", "0");
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nomeFormaPagamento", "");
        encaminharParaPagina(request, response);
    }
}