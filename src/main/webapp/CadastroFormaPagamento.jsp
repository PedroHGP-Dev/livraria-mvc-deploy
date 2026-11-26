<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Formas de Pagamento</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="Menu.jsp" %>

        <div class="container mt-4">
            <h1 class="mb-4">Cadastro Forma de Pagamento</h1>

            <form id="cadastroForm" method="get" action="${pageContext.request.contextPath}${URL_BASE}/FormaPagamentoControlador" class="row g-3 mb-4">
                <input type="hidden" name="opcao" value="${opcao}">
                <input type="hidden" name="codFormaPagamento" value="${codFormaPagamento}">

                <div class="col-md-6">
                    <label class="form-label">Nome:</label>
                    <input type="text" class="form-control" required name="nomeFormaPagamento" value="${nomeFormaPagamento}"/>
                </div>

                <div class="col-12">
                    <button type="submit" class="btn btn-primary" name="Salvar">
                        ${opcao == 'confirmarExcluir' ? 'Confirmar Exclusão' : 'Salvar'}
                    </button>
                    <a href="${pageContext.request.contextPath}${URL_BASE}/FormaPagamentoControlador?opcao=cancelar" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>

            <c:if test="${not empty mensagem}">
                <div class="alert alert-info mt-3">${mensagem}</div>
            </c:if>

            <hr>

            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered mt-3">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 10%;">CÓDIGO</th>
                            <th>NOME</th>
                            <th style="width: 15%;">ALTERAR</th>
                            <th style="width: 15%;">EXCLUIR</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="pag" items="${listaPagamentos}">
                            <tr>
                                <td class="align-middle">${pag.codFormaPagamento}</td>
                                <td class="align-middle">${pag.nomeFormaPagamento}</td>
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/FormaPagamentoControlador">
                                        <input type="hidden" name="codFormaPagamento" value="${pag.codFormaPagamento}">
                                        <input type="hidden" name="nomeFormaPagamento" value="${pag.nomeFormaPagamento}">
                                        <input type="hidden" name="opcao" value="enviarAlterar">
                                        <button type="submit" class="btn btn-sm btn-warning w-100">Alterar</button>
                                    </form>
                                </td>
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/FormaPagamentoControlador">
                                        <input type="hidden" name="codFormaPagamento" value="${pag.codFormaPagamento}">
                                        <input type="hidden" name="nomeFormaPagamento" value="${pag.nomeFormaPagamento}">
                                        <input type="hidden" name="opcao" value="enviarExcluir">
                                        <button type="submit" class="btn btn-sm btn-danger w-100">Excluir</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>