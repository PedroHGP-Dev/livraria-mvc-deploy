<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html" pageEncoding="Latin1"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=Latin1">
        <title>Cadastro de Editoras</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="Menu.jsp" %>

        <div class="container mt-4">
            <h1 class="mb-4">Cadastro Editora</h1>

            <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/EditoraControlador" class="row g-3 mb-4">
                <input type="hidden" name="opcao" value="${opcao}">
                <input type="hidden" name="codEditora" value="${codEditora}">

                <div class="col-md-6">
                    <label class="form-label">Nome:</label>
                    <input type="text" class="form-control" required name="nomeEditora" value="${nomeEditora}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">CNPJ:</label>
                    <input type="text" class="form-control" required name="cnpjEditora" value="${cnpjEditora}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Endere�o:</label>
                    <input type="text" class="form-control" required name="enderecoEditora" value="${enderecoEditora}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Telefone:</label>
                    <input type="text" class="form-control" required name="telefoneEditora" value="${telefoneEditora}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Email:</label>
                    <input type="email" class="form-control" required name="emailEditora" value="${emailEditora}"/>
                </div>

                <div class="col-12">
                    <button type="submit" class="btn btn-primary">
                        ${opcao == 'confirmarExcluir' ? 'Confirmar Exclus�o' : 'Salvar'}
                    </button>
                    <a href="${pageContext.request.contextPath}${URL_BASE}/EditoraControlador?opcao=cancelar" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>

            <c:if test="${not empty mensagem}">
                <div class="alert alert-info mt-3">${mensagem}</div>
            </c:if>

            <hr class="my-4">

            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 8%">ID</th>
                            <th>NOME</th>
                            <th>CNPJ</th>
                            <th>ENDERE�O</th>
                            <th>TELEFONE</th>
                            <th>EMAIL</th>
                            <th style="width: 10%">ALTERAR</th>
                            <th style="width: 10%">EXCLUIR</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="edit" items="${listaEditoras}">
                            <tr>
                                <td class="align-middle">${edit.codEditora}</td>
                                <td class="align-middle">${edit.nomeEditora}</td>
                                <td class="align-middle">${edit.cnpj}</td>
                                <td class="align-middle">${edit.endereco}</td>
                                <td class="align-middle">${edit.telefone}</td>
                                <td class="align-middle">${edit.email}</td>

                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/EditoraControlador">
                                        <input type="hidden" name="codEditora" value="${edit.codEditora}">
                                        <input type="hidden" name="nomeEditora" value="${edit.nomeEditora}">
                                        <input type="hidden" name="cnpjEditora" value="${edit.cnpj}">
                                        <input type="hidden" name="enderecoEditora" value="${edit.endereco}">
                                        <input type="hidden" name="telefoneEditora" value="${edit.telefone}">
                                        <input type="hidden" name="emailEditora" value="${edit.email}">
                                        <input type="hidden" name="opcao" value="enviarAlterar">
                                        <button type="submit" class="btn btn-sm btn-warning w-100">Alterar</button>
                                    </form>
                                </td>

                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/EditoraControlador">
                                        <input type="hidden" name="codEditora" value="${edit.codEditora}">
                                        <input type="hidden" name="nomeEditora" value="${edit.nomeEditora}">
                                        <input type="hidden" name="cnpjEditora" value="${edit.cnpj}">
                                        <input type="hidden" name="enderecoEditora" value="${edit.endereco}">
                                        <input type="hidden" name="telefoneEditora" value="${edit.telefone}">
                                        <input type="hidden" name="emailEditora" value="${edit.email}">
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