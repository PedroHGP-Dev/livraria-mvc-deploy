<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Gêneros</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="Menu.jsp" %>

        <div class="container mt-4">
            <h1 class="mb-4">Cadastro Gênero Literário</h1>

            <form id="cadastroForm" method="get" action="${pageContext.request.contextPath}${URL_BASE}/GeneroLivroControlador" class="row g-3 mb-4">
                <input type="hidden" name="opcao" value="${opcao}">
                <input type="hidden" name="codGeneroLivro" value="${codGeneroLivro}">

                <div class="col-md-6">
                    <label class="form-label">Gênero:</label>
                    <input type="text" class="form-control" required name="nomeGeneroLivro" value="${nomeGeneroLivro}"/>
                </div>

                <div class="col-12">
                    <button type="submit" class="btn btn-primary" name="Salvar">
                        ${opcao == 'confirmarExcluir' ? 'Confirmar Exclusão' : 'Salvar'}
                    </button>
                    <a href="${pageContext.request.contextPath}${URL_BASE}/GeneroLivroControlador?opcao=cancelar" class="btn btn-secondary">Cancelar</a>
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
                        <c:forEach var="genero" items="${listaGeneros}">
                            <tr>
                                <td class="align-middle">${genero.codGeneroLivro}</td>
                                <td class="align-middle">${genero.nomeGeneroLivro}</td>
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/GeneroLivroControlador">
                                        <input type="hidden" name="codGeneroLivro" value="${genero.codGeneroLivro}">
                                        <input type="hidden" name="nomeGeneroLivro" value="${genero.nomeGeneroLivro}">
                                        <input type="hidden" name="opcao" value="enviarAlterar">
                                        <button type="submit" class="btn btn-sm btn-warning w-100">Alterar</button>
                                    </form>
                                </td>
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/GeneroLivroControlador">
                                        <input type="hidden" name="codGeneroLivro" value="${genero.codGeneroLivro}">
                                        <input type="hidden" name="nomeGeneroLivro" value="${genero.nomeGeneroLivro}">
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