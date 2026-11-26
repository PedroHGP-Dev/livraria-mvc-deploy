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

            ResultSet rs = stmt.executeQuery("SHOW TABLES LIKE 'USUARIO'");
            if (rs.next()) {
                return;
            }

            InputStream is = getClass().getClassLoader().getResourceAsStream("backup_aiven.sql");
            if (is != null) {
                StringBuilder sb = new StringBuilder();
                String delimiter = ";";

                try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        String trimmed = line.trim();
                        if (trimmed.isEmpty() || trimmed.startsWith("--") || trimmed.startsWith("#") || trimmed.startsWith("/*")) {
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
                                try {
                                    stmt.execute(sql);
                                } catch (Exception ex) {
                                    System.err.println("Aviso SQL: " + ex.getMessage());
                                }
                            }
                            sb.setLength(0);
                        }
                    }
                }
            }

            // Garante a tabela USUARIO em maiúsculo para compatibilidade com Linux/Aiven
            stmt.execute("CREATE TABLE IF NOT EXISTS `USUARIO` ("
                    + "`id` int NOT NULL AUTO_INCREMENT,"
                    + "`nomeusuario` varchar(255) NOT NULL,"
                    + "`senhahash` varchar(60) NOT NULL,"
                    + "`email` varchar(255) NOT NULL,"
                    + "`token_recuperacao` varchar(255) DEFAULT NULL,"
                    + "`token_expiracao` datetime DEFAULT NULL,"
                    + "PRIMARY KEY (`id`),"
                    + "UNIQUE KEY `nomeusuario` (`nomeusuario`),"
                    + "UNIQUE KEY `email` (`email`)"
                    + ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci");

            System.out.println("Banco de dados Aiven e tabela USUARIO inicializados com sucesso!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}