package com.mycompany.livrariapedrojoaquim.servico;

import com.mycompany.livrariapedrojoaquim.modelo.dao.ConnectionFactory;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

@WebListener
public class ConfigListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        sce.getServletContext().setAttribute("URL_BASE", WebConstante.BASE_PATH);

        try (Connection conn = ConnectionFactory.getInstance().getConnection();
             Statement stmt = conn.createStatement()) {

            ResultSet rs = stmt.executeQuery("SHOW TABLES LIKE 'usuario'");
            if (rs.next()) {
                return;
            }

            InputStream is = getClass().getClassLoader().getResourceAsStream("backup_aiven.sql");
            if (is == null) return;

            StringBuilder sb = new StringBuilder();
            String delimiter = ";";

            try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String trimmed = line.trim();
                    if (trimmed.isEmpty() || trimmed.startsWith("--") || trimmed.startsWith("#")) {
                        continue;
                    }
                    if (trimmed.toUpperCase().startsWith("DELIMITER ")) {
                        delimiter = trimmed.substring(10).trim();
                        continue;
                    }
                    sb.append(line).append("\n");
                    if (trimmed.endsWith(delimiter)) {
                        String sql = sb.toString().trim();
                        sql = sql.substring(0, sql.length() - delimiter.length()).trim();
                        if (!sql.isEmpty()) {
                            stmt.execute(sql);
                        }
                        sb.setLength(0);
                    }
                }
            }
            System.out.println("Banco de dados Aiven inicializado com sucesso!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}