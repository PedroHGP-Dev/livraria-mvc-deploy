package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.LivroDao;
import com.mycompany.livrariapedrojoaquim.modelo.dao.GeneroLivroDao;
import com.mycompany.livrariapedrojoaquim.modelo.dao.EditoraDao;
import com.mycompany.livrariapedrojoaquim.modelo.dao.LivrariaDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livro;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.GeneroLivro;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Editora;
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

@WebServlet(WebConstante.BASE_PATH + "/LivroControlador")
public class LivroControlador extends HttpServlet {

    LivroDao objDao = new LivroDao();
    GeneroLivroDao objGeneroDao = new GeneroLivroDao();
    EditoraDao objEditoraDao = new EditoraDao();
    LivrariaDao objLivrariaDao = new LivrariaDao();

    String codigoLivro = "", tituloLivro = "", autorLivro = "", precoLivro = "";
    String estoqueLivro = "", generoLivro = "", editoraLivro = "", livrariaLivro = "";
    String opcao = "";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            opcao = request.getParameter("opcao");
            if (opcao == null || opcao.isEmpty()) opcao = "cadastrar";

            codigoLivro = request.getParameter("codigoLivro");
            tituloLivro = request.getParameter("tituloLivro");
            autorLivro = request.getParameter("autorLivro");
            precoLivro = request.getParameter("precoLivro");
            estoqueLivro = request.getParameter("estoqueLivro");
            generoLivro = request.getParameter("generoLivro");
            editoraLivro = request.getParameter("editoraLivro");
            livrariaLivro = request.getParameter("livrariaLivro");

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
        Livro obj = new Livro();
        setDados(obj);
        objDao.salvar(obj);
        cancelar(request, response);
    }

    private void enviarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codigoLivro", codigoLivro);
        request.setAttribute("tituloLivro", tituloLivro);
        request.setAttribute("autorLivro", autorLivro);
        request.setAttribute("precoLivro", precoLivro);
        request.setAttribute("estoqueLivro", estoqueLivro);
        request.setAttribute("generoLivro", generoLivro);
        request.setAttribute("editoraLivro", editoraLivro);
        request.setAttribute("livrariaLivro", livrariaLivro);
        request.setAttribute("opcao", "confirmarAlterar");
        encaminharParaPagina(request, response);
    }

    private void enviarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codigoLivro", codigoLivro);
        request.setAttribute("tituloLivro", tituloLivro);
        request.setAttribute("autorLivro", autorLivro);
        request.setAttribute("precoLivro", precoLivro);
        request.setAttribute("estoqueLivro", estoqueLivro);
        request.setAttribute("generoLivro", generoLivro);
        request.setAttribute("editoraLivro", editoraLivro);
        request.setAttribute("livrariaLivro", livrariaLivro);
        request.setAttribute("opcao", "confirmarExcluir");
        encaminharParaPagina(request, response);
    }

    private void confirmarAlterar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Livro obj = new Livro();
        obj.setCodigo(Integer.valueOf(codigoLivro));
        setDados(obj);
        objDao.alterar(obj);
        cancelar(request, response);
    }

    private void confirmarExcluir(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (codigoLivro != null && !codigoLivro.isEmpty()) {
            Livro objExcluir = new Livro();
            objExcluir.setCodigo(Integer.valueOf(codigoLivro));
            objDao.excluir(objExcluir);
        }
        cancelar(request, response);
    }

    private void setDados(Livro obj) {
        obj.setTitulo(tituloLivro);
        obj.setAutor(autorLivro);

        if (precoLivro != null && !precoLivro.isEmpty()) {
            obj.setPreco(Double.valueOf(precoLivro));
        } else {
            obj.setPreco(0.0);
        }

        if (estoqueLivro != null && !estoqueLivro.isEmpty()) {
            obj.setEstoque(Integer.valueOf(estoqueLivro));
        } else {
            obj.setEstoque(0);
        }

        if (generoLivro != null && !generoLivro.isEmpty()) {
            if (obj.getGeneroLivro() == null) {
                obj.setGeneroLivro(new GeneroLivro());
            }
            obj.getGeneroLivro().setCodGeneroLivro(Integer.valueOf(generoLivro));
        }

        if (editoraLivro != null && !editoraLivro.isEmpty()) {
            if (obj.getEditora() == null) {
                obj.setEditora(new Editora());
            }
            obj.getEditora().setCodEditora(Integer.valueOf(editoraLivro));
        }

        if (livrariaLivro != null && !livrariaLivro.isEmpty()) {
            if (obj.getLivraria() == null) {
                obj.setLivraria(new Livraria());
            }
            obj.getLivraria().setIdLivraria(Integer.valueOf(livrariaLivro));
        }
    }

    private void encaminharParaPagina(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<GeneroLivro> listaGenero = objGeneroDao.buscarTodosGeneros();
        request.setAttribute("listaGenero", listaGenero);

        List<Editora> listaEditora = objEditoraDao.buscarTodasEditoras();
        request.setAttribute("listaEditora", listaEditora);

        List<Livraria> listaLivraria = objLivrariaDao.buscarDadosLivraria();
        request.setAttribute("listaLivraria", listaLivraria);

        List<Livro> listaLivro = objDao.buscarTodosLivros();
        request.setAttribute("listaLivro", listaLivro);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/CadastroLivro.jsp");
        dispatcher.forward(request, response);
    }

    private void cancelar(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("codigoLivro", "0");
        request.setAttribute("opcao", "cadastrar");
        request.setAttribute("tituloLivro", "");
        request.setAttribute("autorLivro", "");
        request.setAttribute("precoLivro", "");
        request.setAttribute("estoqueLivro", "");
        request.setAttribute("generoLivro", "");
        request.setAttribute("editoraLivro", "");
        request.setAttribute("livrariaLivro", "");
        encaminharParaPagina(request, response);
    }
}