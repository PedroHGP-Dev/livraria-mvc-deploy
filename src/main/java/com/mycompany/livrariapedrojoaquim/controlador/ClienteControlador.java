package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.LivrariaDao;
import com.mycompany.livrariapedrojoaquim.modelo.dao.ClienteDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livraria;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Cliente;
import com.mycompany.livrariapedrojoaquim.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/ClienteControlador")
public class ClienteControlador extends HttpServlet {

    ClienteDao objDao = new ClienteDao();
    LivrariaDao objLivrariaDao = new LivrariaDao();
    
    String codigoCliente = "", nomeCliente = "", cpfCliente = "", enderecoCliente = "";
    String bairroCliente = "", cepCliente = "", cidadeCliente = "", telefoneCliente = "", emailCliente = "", livrariaCliente = "";
    String opcao = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            opcao = request.getParameter("opcao");
            if (opcao == null || opcao.isEmpty()) opcao = "cadastrar";
            
            codigoCliente = request.getParameter("codigoCliente");
            nomeCliente = request.getParameter("nomeCliente");
            cpfCliente = request.getParameter("cpfCliente");
            enderecoCliente = request.getParameter("enderecoCliente");
            bairroCliente = request.getParameter("bairroCliente");
            cepCliente = request.getParameter("cepCliente");
            cidadeCliente = request.getParameter("cidadeCliente");
            telefoneCliente = request.getParameter("telefoneCliente");
            emailCliente = request.getParameter("emailCliente");
            livrariaCliente = request.getParameter("livrariaCliente");

            switch (opcao) {
                case "cadastrar": cadastrar(request, response); break;
                case "enviarAlterar": enviarAlterar(request, response); break;
                case "enviarExcluir": enviarExcluir(request, response); break;
                case "confirmarAlterar": confirmarAlterar(request, response); break;
                case "confirmarExcluir": confirmarExcluir(request, response); break;
                case "cancelar": cancelar(request, response); break;
            }
        } catch (Exception e) {
            response.getWriter().println("Erro no Controlador: " + e.getMessage());
        }
    }

    private void cadastrar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cliente obj = new Cliente();
        setDados(obj);
        objDao.salvar(obj);
        cancelar(request, response);
    }

    private void enviarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codigoCliente", codigoCliente);
        request.setAttribute("nomeCliente", nomeCliente);
        request.setAttribute("cpfCliente", cpfCliente);
        request.setAttribute("enderecoCliente", enderecoCliente);
        request.setAttribute("bairroCliente", bairroCliente);
        request.setAttribute("cepCliente", cepCliente);
        request.setAttribute("cidadeCliente", cidadeCliente);
        request.setAttribute("telefoneCliente", telefoneCliente);
        request.setAttribute("emailCliente", emailCliente);
        request.setAttribute("livrariaCliente", livrariaCliente);
        request.setAttribute("opcao", "confirmarAlterar");
        encaminharParaPagina(request, response);
    }

    private void enviarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codigoCliente", codigoCliente);
        request.setAttribute("nomeCliente", nomeCliente);
        request.setAttribute("cpfCliente", cpfCliente);
        request.setAttribute("enderecoCliente", enderecoCliente);
        request.setAttribute("bairroCliente", bairroCliente);
        request.setAttribute("cepCliente", cepCliente);
        request.setAttribute("cidadeCliente", cidadeCliente);
        request.setAttribute("telefoneCliente", telefoneCliente);
        request.setAttribute("emailCliente", emailCliente);
        request.setAttribute("livrariaCliente", livrariaCliente);
        request.setAttribute("opcao", "confirmarExcluir");
        encaminharParaPagina(request, response);
    }

    private void confirmarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Cliente obj = new Cliente();
        obj.setCodigo(Integer.valueOf(codigoCliente));
        setDados(obj);
        objDao.alterar(obj);
        cancelar(request, response);
    }

    private void confirmarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (codigoCliente != null && !codigoCliente.isEmpty()) {
            Cliente objExcluir = new Cliente();
            objExcluir.setCodigo(Integer.valueOf(codigoCliente));
            objDao.excluir(objExcluir);
        }
        cancelar(request, response);
    }

    private void setDados(Cliente obj) {
        obj.setNome(nomeCliente);
        obj.setCpf(cpfCliente);
        obj.setEndereco(enderecoCliente);
        obj.setBairro(bairroCliente);
        obj.setCep(cepCliente);
        obj.setCidade(cidadeCliente);
        obj.setTelefone(telefoneCliente);
        obj.setEmail(emailCliente);
        
        if (livrariaCliente != null && !livrariaCliente.isEmpty()) {
            if (obj.getLivraria() == null) {
                obj.setLivraria(new Livraria());
            }
            obj.getLivraria().setIdLivraria(Integer.valueOf(livrariaCliente));
        }
    }

    private void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Livraria> listaLivraria = objLivrariaDao.buscarDadosLivraria();
        request.setAttribute("listaLivraria", listaLivraria);

        List<Cliente> listaCliente = objDao.buscarTodosClientes(); 
        request.setAttribute("listaCliente", listaCliente);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroCliente.jsp");
        dispatcher.forward(request, response);
    }

    private void cancelar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codigoCliente", "0");
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nomeCliente", "");
        request.setAttribute("cpfCliente", "");
        request.setAttribute("enderecoCliente", "");
        request.setAttribute("bairroCliente", "");
        request.setAttribute("cepCliente", "");
        request.setAttribute("cidadeCliente", "");
        request.setAttribute("telefoneCliente", "");
        request.setAttribute("emailCliente", "");
        request.setAttribute("livrariaCliente", "");
        encaminharParaPagina(request, response);
    }
}