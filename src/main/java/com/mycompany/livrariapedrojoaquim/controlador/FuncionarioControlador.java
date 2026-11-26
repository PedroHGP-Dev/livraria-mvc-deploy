package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.LivrariaDao;
import com.mycompany.livrariapedrojoaquim.modelo.dao.FuncionarioDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livraria;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Funcionario;
import com.mycompany.livrariapedrojoaquim.servico.WebConstante;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/FuncionarioControlador")
public class FuncionarioControlador extends HttpServlet {

    FuncionarioDao objDao = new FuncionarioDao();
    LivrariaDao objLivrariaDao = new LivrariaDao();
    
    String codigoFuncionario = "", nomeFuncionario = "", cpfFuncionario = "", salarioFuncionario = "";
    String comissaoPorLivroFuncionario = "", enderecoFuncionario = "", emailFuncionario = "";
    String telefoneFuncionario = "", carteiraTrabalhoFuncionario = "", pisFuncionario = "", livrariaFuncionario = "";
    String opcao = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            opcao = request.getParameter("opcao");
            if (opcao == null || opcao.isEmpty()) opcao = "cadastrar";
            
            codigoFuncionario = request.getParameter("codigoFuncionario");
            nomeFuncionario = request.getParameter("nomeFuncionario");
            cpfFuncionario = request.getParameter("cpfFuncionario");
            salarioFuncionario = request.getParameter("salarioFuncionario");
            comissaoPorLivroFuncionario = request.getParameter("comissaoPorLivroFuncionario");
            enderecoFuncionario = request.getParameter("enderecoFuncionario");
            emailFuncionario = request.getParameter("emailFuncionario");
            telefoneFuncionario = request.getParameter("telefoneFuncionario");
            carteiraTrabalhoFuncionario = request.getParameter("carteiraTrabalhoFuncionario");
            pisFuncionario = request.getParameter("pisFuncionario");
            livrariaFuncionario = request.getParameter("livrariaFuncionario");

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
        Funcionario obj = new Funcionario();
        setDados(obj);
        objDao.salvar(obj);
        cancelar(request, response);
    }

    private void enviarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codigoFuncionario", codigoFuncionario);
        request.setAttribute("nomeFuncionario", nomeFuncionario);
        request.setAttribute("cpfFuncionario", cpfFuncionario);
        request.setAttribute("salarioFuncionario", salarioFuncionario);
        request.setAttribute("comissaoPorLivroFuncionario", comissaoPorLivroFuncionario);
        request.setAttribute("enderecoFuncionario", enderecoFuncionario);
        request.setAttribute("emailFuncionario", emailFuncionario);
        request.setAttribute("telefoneFuncionario", telefoneFuncionario);
        request.setAttribute("carteiraTrabalhoFuncionario", carteiraTrabalhoFuncionario);
        request.setAttribute("pisFuncionario", pisFuncionario);
        request.setAttribute("livrariaFuncionario", livrariaFuncionario);
        request.setAttribute("opcao", "confirmarAlterar");
        encaminharParaPagina(request, response);
    }

    private void enviarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codigoFuncionario", codigoFuncionario);
        request.setAttribute("nomeFuncionario", nomeFuncionario);
        request.setAttribute("cpfFuncionario", cpfFuncionario);
        request.setAttribute("salarioFuncionario", salarioFuncionario);
        request.setAttribute("comissaoPorLivroFuncionario", comissaoPorLivroFuncionario);
        request.setAttribute("enderecoFuncionario", enderecoFuncionario);
        request.setAttribute("emailFuncionario", emailFuncionario);
        request.setAttribute("telefoneFuncionario", telefoneFuncionario);
        request.setAttribute("carteiraTrabalhoFuncionario", carteiraTrabalhoFuncionario);
        request.setAttribute("pisFuncionario", pisFuncionario);
        request.setAttribute("livrariaFuncionario", livrariaFuncionario);
        request.setAttribute("opcao", "confirmarExcluir");
        encaminharParaPagina(request, response);
    }

    private void confirmarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Funcionario obj = new Funcionario();
        obj.setCodigo(Integer.valueOf(codigoFuncionario));
        setDados(obj);
        objDao.alterar(obj);
        cancelar(request, response);
    }

    private void confirmarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    if (codigoFuncionario != null && !codigoFuncionario.isEmpty()) {
        Funcionario objExcluir = new Funcionario();
        objExcluir.setCodigo(Integer.valueOf(codigoFuncionario));
        objDao.excluir(objExcluir);
    }
    cancelar(request, response);
}

    private void setDados(Funcionario obj) {
        obj.setNome(nomeFuncionario);
        obj.setCpf(cpfFuncionario);
        
        if (salarioFuncionario != null && !salarioFuncionario.isEmpty()) {
            obj.setSalario(Double.valueOf(salarioFuncionario));
        } else {
            obj.setSalario(0.0);
        }
        
        if (comissaoPorLivroFuncionario != null && !comissaoPorLivroFuncionario.isEmpty()) {
            obj.setComissaoPorLivro(Double.valueOf(comissaoPorLivroFuncionario));
        } else {
            obj.setComissaoPorLivro(0.0);
        }
        
        obj.setEndereco(enderecoFuncionario);
        obj.setEmail(emailFuncionario);
        obj.setTelefone(telefoneFuncionario);
        obj.setCarteiraTrabalho(carteiraTrabalhoFuncionario);
        obj.setPis(pisFuncionario);
        
        if (livrariaFuncionario != null && !livrariaFuncionario.isEmpty()) {
            if (obj.getLivraria() == null) {
                obj.setLivraria(new Livraria());
            }
            obj.getLivraria().setIdLivraria(Integer.valueOf(livrariaFuncionario));
        }
    }

    private void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Livraria> listaLivraria = objLivrariaDao.buscarDadosLivraria();
        request.setAttribute("listaLivraria", listaLivraria);

        List<Funcionario> listaFuncionario = objDao.buscarTodosFuncionarios(); 
        request.setAttribute("listaFuncionario", listaFuncionario);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroFuncionario.jsp");
        dispatcher.forward(request, response);
    }

    private void cancelar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codigoFuncionario", "0");
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("nomeFuncionario", "");
        request.setAttribute("cpfFuncionario", "");
        request.setAttribute("salarioFuncionario", "");
        request.setAttribute("comissaoPorLivroFuncionario", "");
        request.setAttribute("enderecoFuncionario", "");
        request.setAttribute("emailFuncionario", "");
        request.setAttribute("telefoneFuncionario", "");
        request.setAttribute("carteiraTrabalhoFuncionario", "");
        request.setAttribute("pisFuncionario", "");
        request.setAttribute("livrariaFuncionario", "");
        encaminharParaPagina(request, response);
    }
}