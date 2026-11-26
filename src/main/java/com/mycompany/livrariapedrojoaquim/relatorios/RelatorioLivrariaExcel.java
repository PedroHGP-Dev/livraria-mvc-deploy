package com.mycompany.livrariapedrojoaquim.relatorios;

import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livraria;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.util.List;

public class RelatorioLivrariaExcel {

    private List<Livraria> livrarias;

    public RelatorioLivrariaExcel(List<Livraria> livrarias) {
        this.livrarias = livrarias;
    }

    public void gerarRelatorio(HttpServletResponse response) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Livrarias");

        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("ID");
        headerRow.createCell(1).setCellValue("Nome da Livraria");

        int rowCount = 1;
        for (Livraria l : livrarias) {
            Row row = sheet.createRow(rowCount++);
            row.createCell(0).setCellValue(l.getIdLivraria());
            row.createCell(1).setCellValue(l.getNomeLivraria());
        }

        for (int i = 0; i < 2; i++) {
            sheet.autoSizeColumn(i);
        }

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=relatorio_livrarias.xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
        }

        workbook.close();
    }
}