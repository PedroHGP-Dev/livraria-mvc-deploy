package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.servico.WebConstante;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;

@WebServlet(WebConstante.BASE_PATH + "/RelatorioVendasClientePdfControlador")
public class RelatorioVendasClientePdfControlador extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3307/mer_livraria_pedroh_joaquim?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName(DB_DRIVER);
            Connection conexao = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            InputStream jrxmlStream = getServletContext().getResourceAsStream("/WEB-INF/relatorios/RelatorioVendasCliente.jrxml");

            if (jrxmlStream != null) {
                JasperReport jasperReport = JasperCompileManager.compileReport(jrxmlStream);
                byte[] bytes = JasperRunManager.runReportToPdf(jasperReport, null, conexao);
                
                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                response.getOutputStream().write(bytes, 0, bytes.length);
                response.getOutputStream().flush();
                response.getOutputStream().close();
            } else {
                response.getWriter().println("Ficheiro .jrxml nao encontrado em /WEB-INF/relatorios/");
            }
            
            conexao.close();
        } catch (Exception e) {
            response.getWriter().println("Erro ao gerar PDF: " + e.getMessage());
        }
    }
}