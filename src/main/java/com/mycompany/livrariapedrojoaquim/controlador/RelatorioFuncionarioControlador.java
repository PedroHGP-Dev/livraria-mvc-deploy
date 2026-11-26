package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.FuncionarioDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Funcionario;
import com.mycompany.livrariapedrojoaquim.relatorios.RelatorioFuncionarioExcel;
import com.mycompany.livrariapedrojoaquim.servico.WebConstante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/RelatorioFuncionarioControlador")
public class RelatorioFuncionarioControlador extends HttpServlet {

    private FuncionarioDao funcionarioDao = new FuncionarioDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Funcionario> funcionarios = funcionarioDao.buscarTodosFuncionarios();
        RelatorioFuncionarioExcel relatorio = new RelatorioFuncionarioExcel(funcionarios);
        relatorio.gerarRelatorio(response);
    }
}