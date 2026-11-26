package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.FormaPagamentoDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.FormaPagamento;
import com.mycompany.livrariapedrojoaquim.relatorios.RelatorioFormaPagamentoExcel;
import com.mycompany.livrariapedrojoaquim.servico.WebConstante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/RelatorioFormaPagamentoControlador")
public class RelatorioFormaPagamentoControlador extends HttpServlet {

    private FormaPagamentoDao formaPagamentoDao = new FormaPagamentoDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<FormaPagamento> formas = formaPagamentoDao.buscarTodasFormas();
        RelatorioFormaPagamentoExcel relatorio = new RelatorioFormaPagamentoExcel(formas);
        relatorio.gerarRelatorio(response);
    }
}