package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.LivroDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livro;
import com.mycompany.livrariapedrojoaquim.relatorios.RelatorioLivroExcel;
import com.mycompany.livrariapedrojoaquim.servico.WebConstante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/RelatorioLivroControlador")
public class RelatorioLivroControlador extends HttpServlet {

    private LivroDao livroDao = new LivroDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Livro> livros = livroDao.buscarTodosLivros();
        RelatorioLivroExcel relatorio = new RelatorioLivroExcel(livros);
        relatorio.gerarRelatorio(response);
    }
}