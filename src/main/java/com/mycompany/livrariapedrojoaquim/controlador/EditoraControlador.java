/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.EditoraDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Editora;
import com.mycompany.livrariapedrojoaquim.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/EditoraControlador")
public class EditoraControlador extends HttpServlet {
    Editora obj = new Editora();
    EditoraDao objDao = new EditoraDao();
    String cod = "", nome = "", endereco = "", cnpj = "", telefone = "", email = "", opcao = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            opcao = request.getParameter("opcao");
            if (opcao == null || opcao.isEmpty()) opcao = "cadastrar";

            // Capturando os parâmetros vindos do JSP
            cod = request.getParameter("codEditora");
            nome = request.getParameter("nomeEditora");
            endereco = request.getParameter("enderecoEditora");
            cnpj = request.getParameter("cnpjEditora");
            telefone = request.getParameter("telefoneEditora");
            email = request.getParameter("emailEditora");

            switch (opcao) {
                case "cadastrar": cadastrar(request, response); break;
                case "enviarAlterar": enviarAlterar(request, response); break;
                case "enviarExcluir": enviarExcluir(request, response); break;
                case "confirmarAlterar": confirmarAlterar(request, response); break;
                case "confirmarExcluir": confirmarExcluir(request, response); break;
                case "cancelar": cancelar(request, response); break;
            }
        } catch (Exception e) {
            response.getWriter().println("Erro: " + e.getMessage());
        }
    }

    private void cadastrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        setDados(request);
        objDao.salvar(obj);
        cancelar(request, response);
    }

    private void enviarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codEditora", cod);
        request.setAttribute("nomeEditora", nome);
        request.setAttribute("enderecoEditora", endereco);
        request.setAttribute("cnpjEditora", cnpj);
        request.setAttribute("telefoneEditora", telefone);
        request.setAttribute("emailEditora", email);
        request.setAttribute("opcao", "confirmarAlterar");
        encaminharParaPagina(request, response);
    }

    private void enviarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    request.setAttribute("codEditora", cod);
    request.setAttribute("nomeEditora", nome);
    request.setAttribute("enderecoEditora", endereco);
    request.setAttribute("cnpjEditora", cnpj);
    request.setAttribute("telefoneEditora", telefone);
    request.setAttribute("emailEditora", email);
    request.setAttribute("opcao", "confirmarExcluir");
    encaminharParaPagina(request, response);
}

    private void confirmarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        obj.setCodEditora(Integer.valueOf(cod));
        setDados(request);
        objDao.alterar(obj);
        cancelar(request, response);
    }

    private void confirmarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        obj.setCodEditora(Integer.valueOf(cod));
        objDao.excluir(obj);
        cancelar(request, response);
    }

    private void setDados(HttpServletRequest request) {
        // CORREÇÃO: Removido Integer.valueOf dos campos de texto
        obj.setNomeEditora(nome);
        obj.setEndereco(endereco); 
        obj.setCnpj(cnpj);         
        obj.setTelefone(telefone); 
        obj.setEmail(email);       
    }

    private void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Editora> lista = objDao.buscarTodasEditoras();
        request.setAttribute("listaEditoras", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroEditora.jsp");
        dispatcher.forward(request, response);
    }

    private void cancelar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codEditora", "0");
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nomeEditora", "");
        request.setAttribute("enderecoEditora", "");
        request.setAttribute("cnpjEditora", "");
        request.setAttribute("telefoneEditora", "");
        request.setAttribute("emailEditora", "");
        encaminharParaPagina(request, response);
    }
}