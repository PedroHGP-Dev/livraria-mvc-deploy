package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.ClienteDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Cliente;
import com.mycompany.livrariapedrojoaquim.relatorios.RelatorioClienteExcel;
import com.mycompany.livrariapedrojoaquim.servico.WebConstante;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(WebConstante.BASE_PATH + "/RelatorioClienteControlador")
public class RelatorioClienteControlador extends HttpServlet {

    private ClienteDao clienteDao = new ClienteDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Cliente> clientes = clienteDao.buscarTodosClientes();
        RelatorioClienteExcel relatorio = new RelatorioClienteExcel(clientes);
        relatorio.gerarRelatorio(response);
    }
}