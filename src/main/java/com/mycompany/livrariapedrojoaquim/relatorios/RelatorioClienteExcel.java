package com.mycompany.livrariapedrojoaquim.relatorios;

import com.mycompany.livrariapedrojoaquim.modelo.entidade.Cliente;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.util.List;

public class RelatorioClienteExcel {

    private List<Cliente> clientes;

    public RelatorioClienteExcel(List<Cliente> clientes) {
        this.clientes = clientes;
    }

    public void gerarRelatorio(HttpServletResponse response) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Clientes");

        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Código");
        headerRow.createCell(1).setCellValue("Nome");

        int rowCount = 1;
        for (Cliente c : clientes) {
            Row row = sheet.createRow(rowCount++);
            row.createCell(0).setCellValue(c.getCodigo());
            row.createCell(1).setCellValue(c.getNome());
        }

        for (int i = 0; i < 2; i++) {
            sheet.autoSizeColumn(i);
        }

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=relatorio_clientes.xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
        }

        workbook.close();
    }
}