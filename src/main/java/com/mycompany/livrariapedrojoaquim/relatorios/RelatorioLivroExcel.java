package com.mycompany.livrariapedrojoaquim.relatorios;

import com.mycompany.livrariapedrojoaquim.modelo.entidade.Livro;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.util.List;

public class RelatorioLivroExcel {

    private List<Livro> livros;

    public RelatorioLivroExcel(List<Livro> livros) {
        this.livros = livros;
    }

    public void gerarRelatorio(HttpServletResponse response) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Livros");

        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Código");
        headerRow.createCell(1).setCellValue("Título");
        headerRow.createCell(2).setCellValue("Preço R$");
        headerRow.createCell(3).setCellValue("Estoque");

        int rowCount = 1;
        for (Livro livro : livros) {
            Row row = sheet.createRow(rowCount++);
            row.createCell(0).setCellValue(livro.getCodigo());
            row.createCell(1).setCellValue(livro.getTitulo());
            row.createCell(2).setCellValue(livro.getPreco());
            row.createCell(3).setCellValue(livro.getEstoque());
        }

        for (int i = 0; i < 4; i++) {
            sheet.autoSizeColumn(i);
        }

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=relatorio_livros.xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
        }

        workbook.close();
    }
}