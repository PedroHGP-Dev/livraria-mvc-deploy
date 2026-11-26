package com.mycompany.livrariapedrojoaquim.relatorios;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;

import java.io.InputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public class GeradorRelatorioJasper {

    public static void gerarPdf(String caminhoJrxml, List<?> dados, Map<String, Object> parametros, HttpServletResponse response) throws IOException {
        try {
            InputStream relatorioStream = GeradorRelatorioJasper.class.getResourceAsStream(caminhoJrxml);
            JasperReport jasperReport = JasperCompileManager.compileReport(relatorioStream);

            JRBeanCollectionDataSource dataSource = new JRBeanCollectionDataSource(dados);
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parametros, dataSource);

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=relatorio.pdf");

            try (ServletOutputStream out = response.getOutputStream()) {
                JasperExportManager.exportReportToPdfStream(jasperPrint, out);
            }
        } catch (JRException e) {
            throw new IOException("Erro ao gerar o relatório em PDF: " + e.getMessage(), e);
        }
    }
}