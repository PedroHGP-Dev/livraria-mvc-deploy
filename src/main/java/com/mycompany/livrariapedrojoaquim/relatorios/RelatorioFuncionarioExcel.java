package com.mycompany.livrariapedrojoaquim.relatorios;

import com.mycompany.livrariapedrojoaquim.modelo.entidade.Funcionario;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.util.List;

public class RelatorioFuncionarioExcel {

    private List<Funcionario> funcionarios;

    public RelatorioFuncionarioExcel(List<Funcionario> funcionarios) {
        this.funcionarios = funcionarios;
    }

    public void gerarRelatorio(HttpServletResponse response) throws IOException {
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Funcionários");

        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Código");
        headerRow.createCell(1).setCellValue("Nome");

        int rowCount = 1;
        for (Funcionario f : funcionarios) {
            Row row = sheet.createRow(rowCount++);
            row.createCell(0).setCellValue(f.getCodigo());
            row.createCell(1).setCellValue(f.getNome());
        }

        for (int i = 0; i < 2; i++) {
            sheet.autoSizeColumn(i);
        }

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=relatorio_funcionarios.xlsx");

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
        }

        workbook.close();
    }
}