package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.LivrariaDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livraria;
import com.mycompany.livrariapedrojoaquim.relatorios.RelatorioLivrariaExcel;
import com.mycompany.livrariapedrojoaquim.servico.WebConstante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/RelatorioLivrariaControlador")
public class RelatorioLivrariaControlador extends HttpServlet {

    private LivrariaDao livrariaDao = new LivrariaDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Livraria> livrarias = livrariaDao.buscarDadosLivraria();
        RelatorioLivrariaExcel relatorio = new RelatorioLivrariaExcel(livrarias);
        relatorio.gerarRelatorio(response);
    }
}