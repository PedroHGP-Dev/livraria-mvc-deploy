<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Livrarias</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="Menu.jsp" %>

        <div class="container mt-4">
            <h1 class="mb-4">Cadastro Livraria</h1>

            <form id="cadastroForm" method="get" action="${pageContext.request.contextPath}${URL_BASE}/LivrariaControlador" class="row g-3 mb-4">
                <input type="hidden" name="opcao" value="${opcao}">
                <input type="hidden" name="idLivraria" value="${idLivraria}">

                <div class="col-md-6">
                    <label class="form-label">Nome:</label>
                    <input type="text" class="form-control" required name="nomeLivraria" value="${nomeLivraria}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Endere�o:</label>
                    <input type="text" class="form-control" required name="enderecoLivraria" value="${enderecoLivraria}"/>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Cidade:</label>
                    <input type="text" class="form-control" required name="cidadeLivraria" value="${cidadeLivraria}"/>
                </div>
                <div class="col-md-3">
                    <label class="form-label">UF:</label>
                    <input type="text" class="form-control" required name="estadoLivraria" value="${estadoLivraria}"/>
                </div>
                <div class="col-md-3">
                    <label class="form-label">Telefone:</label>
                    <input type="text" class="form-control" required name="telefoneLivraria" value="${telefoneLivraria}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Email:</label>
                    <input type="email" class="form-control" required name="emailLivraria" value="${emailLivraria}"/>
                </div>

                <div class="col-12">
                    <c:choose>
                        <c:when test="${opcao == 'confirmarExcluir'}">
                            <button type="submit" formnovalidate class="btn btn-danger">Confirmar Exclus�o</button>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" class="btn btn-primary">Salvar</button>
                        </c:otherwise>
                    </c:choose>
                    <a href="${pageContext.request.contextPath}${URL_BASE}/LivrariaControlador?opcao=cancelar" class="btn btn-secondary">Cancelar</a>
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
                            <th style="width: 5%">ID</th>
                            <th>NOME</th>
                            <th>ENDERE�O</th>
                            <th>CIDADE</th>
                            <th style="width: 6%">UF</th>
                            <th>EMAIL</th>
                            <th>TELEFONE</th>
                            <th style="width: 10%">ALTERAR</th>
                            <th style="width: 10%">EXCLUIR</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="liv" items="${listaLivraria}">
                            <tr>
                                <td class="align-middle">${liv.idLivraria}</td>
                                <td class="align-middle">${liv.nomeLivraria}</td>
                                <td class="align-middle">${liv.enderecoLivraria}</td>
                                <td class="align-middle">${liv.cidadeLivraria}</td>
                                <td class="align-middle">${liv.estadoLivraria}</td>
                                <td class="align-middle">${liv.emailLivraria}</td>
                                <td class="align-middle">${liv.telefoneLivraria}</td>
                                
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/LivrariaControlador">
                                        <input type="hidden" name="idLivraria" value="${liv.idLivraria}">
                                        <input type="hidden" name="nomeLivraria" value="${liv.nomeLivraria}">
                                        <input type="hidden" name="enderecoLivraria" value="${liv.enderecoLivraria}">
                                        <input type="hidden" name="cidadeLivraria" value="${liv.cidadeLivraria}">
                                        <input type="hidden" name="estadoLivraria" value="${liv.estadoLivraria}">
                                        <input type="hidden" name="emailLivraria" value="${liv.emailLivraria}">
                                        <input type="hidden" name="telefoneLivraria" value="${liv.telefoneLivraria}">
                                        <input type="hidden" name="opcao" value="enviarAlterar">
                                        <button type="submit" class="btn btn-sm btn-warning w-100">Alterar</button>
                                    </form>
                                </td>
                                
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/LivrariaControlador">
                                        <input type="hidden" name="idLivraria" value="${liv.idLivraria}">
                                        <input type="hidden" name="nomeLivraria" value="${liv.nomeLivraria}">
                                        <input type="hidden" name="enderecoLivraria" value="${liv.enderecoLivraria}">
                                        <input type="hidden" name="cidadeLivraria" value="${liv.cidadeLivraria}">
                                        <input type="hidden" name="estadoLivraria" value="${liv.estadoLivraria}">
                                        <input type="hidden" name="emailLivraria" value="${liv.emailLivraria}">
                                        <input type="hidden" name="telefoneLivraria" value="${liv.telefoneLivraria}">
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