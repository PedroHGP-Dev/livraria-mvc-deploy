<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html" pageEncoding="Latin1"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=Latin1">
        <title>Cadastro de Clientes</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="Menu.jsp" %>
        
        <div class="container mt-4">
            <h1 class="mb-4">Cadastro Cliente</h1>

            <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador" class="row g-3 mb-4">
                <input type="hidden" name="opcao" value="${opcao}">
                <input type="hidden" name="codigoCliente" value="${codigoCliente}">

                <div class="col-md-6">
                    <label class="form-label">Nome:</label>
                    <input type="text" class="form-control" required name="nomeCliente" value="${nomeCliente}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">CPF:</label>
                    <input type="text" class="form-control" required name="cpfCliente" value="${cpfCliente}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Endere�o:</label>
                    <input type="text" class="form-control" required name="enderecoCliente" value="${enderecoCliente}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Bairro:</label>
                    <input type="text" class="form-control" required name="bairroCliente" value="${bairroCliente}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">CEP:</label>
                    <input type="text" class="form-control" required name="cepCliente" value="${cepCliente}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Cidade:</label>
                    <input type="text" class="form-control" required name="cidadeCliente" value="${cidadeCliente}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Telefone:</label>
                    <input type="text" class="form-control" required name="telefoneCliente" value="${telefoneCliente}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Email:</label>
                    <input type="email" class="form-control" required name="emailCliente" value="${emailCliente}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Livraria:</label>
                    <select class="form-select" name="livrariaCliente">
                        <c:forEach var="livrarias" items="${listaLivraria}">
                            <option value="${livrarias.idLivraria}" ${livrarias.idLivraria == livrariaCliente ? 'selected' : ''}>${livrarias.nomeLivraria}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-12">
                    <c:choose>
                        <c:when test="${opcao == 'confirmarExcluir'}">
                            <a href="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador?opcao=confirmarExcluir&codigoCliente=${codigoCliente}" class="btn btn-primary">
                                Confirmar Exclus�o
                            </a>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" class="btn btn-primary">
                                Salvar
                            </button>
                        </c:otherwise>
                    </c:choose>
                    <a href="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador?opcao=cancelar" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>

            <hr class="my-4">

            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 8%">ID</th>
                            <th>NOME</th>
                            <th>CPF</th>
                            <th>ENDERE�O</th>
                            <th>BAIRRO</th>
                            <th>CEP</th>
                            <th>CIDADE</th>
                            <th>TELEFONE</th>
                            <th>EMAIL</th>
                            <th>LIVRARIA</th>
                            <th style="width: 10%">ALTERAR</th>
                            <th style="width: 10%">EXCLUIR</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="clientes" items="${listaCliente}">
                            <tr>
                                <td class="align-middle">${clientes.codigo}</td>
                                <td class="align-middle">${clientes.nome}</td>
                                <td class="align-middle">${clientes.cpf}</td>
                                <td class="align-middle">${clientes.endereco}</td>
                                <td class="align-middle">${clientes.bairro}</td>
                                <td class="align-middle">${clientes.cep}</td>
                                <td class="align-middle">${clientes.cidade}</td>
                                <td class="align-middle">${clientes.telefone}</td>
                                <td class="align-middle">${clientes.email}</td>
                                <td class="align-middle">${clientes.livraria.nomeLivraria}</td>
                                
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador">
                                        <input type="hidden" name="codigoCliente" value="${clientes.codigo}">
                                        <input type="hidden" name="nomeCliente" value="${clientes.nome}">
                                        <input type="hidden" name="cpfCliente" value="${clientes.cpf}">
                                        <input type="hidden" name="enderecoCliente" value="${clientes.endereco}">
                                        <input type="hidden" name="bairroCliente" value="${clientes.bairro}">
                                        <input type="hidden" name="cepCliente" value="${clientes.cep}">
                                        <input type="hidden" name="cidadeCliente" value="${clientes.cidade}">
                                        <input type="hidden" name="telefoneCliente" value="${clientes.telefone}">
                                        <input type="hidden" name="emailCliente" value="${clientes.email}">
                                        <input type="hidden" name="livrariaCliente" value="${clientes.livraria.idLivraria}">
                                        <input type="hidden" name="opcao" value="enviarAlterar">
                                        <button type="submit" class="btn btn-sm btn-warning w-100">Alterar</button>
                                    </form>
                                </td>
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador">
                                        <input type="hidden" name="codigoCliente" value="${clientes.codigo}">
                                        <input type="hidden" name="nomeCliente" value="${clientes.nome}">
                                        <input type="hidden" name="cpfCliente" value="${clientes.cpf}">
                                        <input type="hidden" name="enderecoCliente" value="${clientes.endereco}">
                                        <input type="hidden" name="bairroCliente" value="${clientes.bairro}">
                                        <input type="hidden" name="cepCliente" value="${clientes.cep}">
                                        <input type="hidden" name="cidadeCliente" value="${clientes.cidade}">
                                        <input type="hidden" name="telefoneCliente" value="${clientes.telefone}">
                                        <input type="hidden" name="emailCliente" value="${clientes.email}">
                                        <input type="hidden" name="livrariaCliente" value="${clientes.livraria.idLivraria}">
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