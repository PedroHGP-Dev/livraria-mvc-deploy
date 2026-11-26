/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.LivrariaDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livraria;
import com.mycompany.livrariapedrojoaquim.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH+"/LivrariaControlador")
public class LivrariaControlador extends HttpServlet {
    Livraria obj = new Livraria();
    LivrariaDao objDao = new LivrariaDao();
    String id="", nome="", endereco="", estado="", cidade="", email="", telefone="", opcao="";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            opcao = request.getParameter("opcao");
            if(opcao == null || opcao.isEmpty()) opcao = "cadastrar";
            
            id = request.getParameter("idLivraria");
            nome = request.getParameter("nomeLivraria");
            endereco = request.getParameter("enderecoLivraria");
            estado = request.getParameter("estadoLivraria");
            cidade = request.getParameter("cidadeLivraria");
            email = request.getParameter("emailLivraria");
            telefone = request.getParameter("telefoneLivraria");

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
        setDados();
        objDao.salvar(obj);
        cancelar(request, response);
    }

    private void enviarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("idLivraria", id);
        request.setAttribute("nomeLivraria", nome);
        request.setAttribute("enderecoLivraria", endereco);
        request.setAttribute("estadoLivraria", estado);
        request.setAttribute("cidadeLivraria", cidade);
        request.setAttribute("emailLivraria", email);
        request.setAttribute("telefoneLivraria", telefone);
        request.setAttribute("opcao", "confirmarAlterar");
        encaminharParaPagina(request, response);
    }

    private void enviarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // CORREÇÃO: Agora enviando todos os atributos para o JSP preencher o formulário no topo
        request.setAttribute("idLivraria", id);
        request.setAttribute("nomeLivraria", nome);
        request.setAttribute("enderecoLivraria", endereco);
        request.setAttribute("estadoLivraria", estado);
        request.setAttribute("cidadeLivraria", cidade);
        request.setAttribute("emailLivraria", email);
        request.setAttribute("telefoneLivraria", telefone);
        
        request.setAttribute("opcao", "confirmarExcluir");
        encaminharParaPagina(request, response);
    }

    private void confirmarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        obj.setIdLivraria(Integer.valueOf(id));
        setDados();
        objDao.alterar(obj);
        cancelar(request, response);
    }

    private void confirmarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        obj.setIdLivraria(Integer.valueOf(id));
        objDao.excluir(obj);
        cancelar(request, response);
    }

    private void setDados(){
        obj.setNomeLivraria(nome);
        obj.setEnderecoLivraria(endereco);
        obj.setEstadoLivraria(estado);
        obj.setCidadeLivraria(cidade);
        obj.setEmailLivraria(email);
        obj.setTelefoneLivraria(telefone);
    }

    private void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Livraria> lista = objDao.buscarDadosLivraria();
        request.setAttribute("listaLivraria", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroLivraria.jsp");
        dispatcher.forward(request, response);
    }

    private void cancelar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("idLivraria", "0");
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nomeLivraria", "");
        request.setAttribute("enderecoLivraria", "");
        request.setAttribute("estadoLivraria", "");
        request.setAttribute("cidadeLivraria", "");
        request.setAttribute("emailLivraria", "");
        request.setAttribute("telefoneLivraria", "");
        encaminharParaPagina(request, response);
    }
}