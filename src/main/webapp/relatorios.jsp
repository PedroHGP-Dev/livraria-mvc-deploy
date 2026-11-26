<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="Latin1"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=Latin1">
        <title>Relatórios do Sistema</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="Menu.jsp" %>
        
        <div class="container mt-4">
            <h1 class="mb-4">Relatórios Gerenciais</h1>

            <div class="row g-4">
                <div class="col-md-6">
                    <div class="card p-3 bg-dark border-secondary">
                        <h3 class="h5 text-success mb-3">Relatórios em Excel (Apache POI)</h3>
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}${URL_BASE}/RelatorioLivroControlador" class="btn btn-outline-success">1. Livros e Estoque (XLSX)</a>
                            <a href="${pageContext.request.contextPath}${URL_BASE}/RelatorioClienteControlador" class="btn btn-outline-success">2. Lista de Clientes (XLSX)</a>
                            <a href="${pageContext.request.contextPath}${URL_BASE}/RelatorioFuncionarioControlador" class="btn btn-outline-success">3. Lista de Funcionários (XLSX)</a>
                            <a href="${pageContext.request.contextPath}${URL_BASE}/RelatorioLivrariaControlador" class="btn btn-outline-success">4. Unidades de Livrarias (XLSX)</a>
                            <a href="${pageContext.request.contextPath}${URL_BASE}/RelatorioFormaPagamentoControlador" class="btn btn-outline-success">5. Formas de Pagamento (XLSX)</a>
                        </div>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="card p-3 bg-dark border-secondary">
                        <h3 class="h5 text-info mb-3">Relatórios em PDF (JasperReports)</h3>
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}${URL_BASE}/RelatorioVendasPdfControlador" target="_blank" class="btn btn-outline-info">6. Resumo de Vendas (PDF)</a>
                            <a href="${pageContext.request.contextPath}${URL_BASE}/RelatorioEstoqueBaixoPdfControlador" target="_blank" class="btn btn-outline-info">7. Alerta Estoque Baixo (PDF)</a>
                            <a href="${pageContext.request.contextPath}${URL_BASE}/RelatorioVendasClientePdfControlador" target="_blank" class="btn btn-outline-info">8. Vendas por Cliente (PDF)</a>
                            <a href="${pageContext.request.contextPath}${URL_BASE}/RelatorioVendasFuncionarioPdfControlador" target="_blank" class="btn btn-outline-info">9. Desempenho Funcionários (PDF)</a>
                            <a href="${pageContext.request.contextPath}${URL_BASE}/RelatorioCaixaDiarioPdfControlador" target="_blank" class="btn btn-outline-info">10. Fechamento de Caixa (PDF)</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>