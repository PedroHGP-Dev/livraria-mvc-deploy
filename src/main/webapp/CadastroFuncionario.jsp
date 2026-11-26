<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html" pageEncoding="Latin1"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=Latin1">
        <title>Cadastro de Funcion�rios</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="Menu.jsp" %>
        
        <div class="container mt-4">
            <h1 class="mb-4">Cadastro Funcion�rio</h1>

            <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/FuncionarioControlador" class="row g-3 mb-4">
                <input type="hidden" name="opcao" value="${opcao}">
                <input type="hidden" name="codigoFuncionario" value="${codigoFuncionario}">

                <div class="col-md-6">
                    <label class="form-label">Nome:</label>
                    <input type="text" class="form-control" required name="nomeFuncionario" value="${nomeFuncionario}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">CPF:</label>
                    <input type="text" class="form-control" required name="cpfFuncionario" value="${cpfFuncionario}"/>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label">Sal�rio:</label>
                    <input type="number" step="0.01" min="0" class="form-control" required name="salarioFuncionario" value="${salarioFuncionario}"/>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label">Comiss�o:</label>
                    <input type="number" step="0.01" min="0" class="form-control" required name="comissaoPorLivroFuncionario" value="${comissaoPorLivroFuncionario}"/>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label">Endere�o:</label>
                    <input type="text" class="form-control" required name="enderecoFuncionario" value="${enderecoFuncionario}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Email:</label>
                    <input type="email" class="form-control" required name="emailFuncionario" value="${emailFuncionario}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Telefone:</label>
                    <input type="text" class="form-control" required name="telefoneFuncionario" value="${telefoneFuncionario}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Carteira de Trabalho:</label>
                    <input type="text" class="form-control" required name="carteiraTrabalhoFuncionario" value="${carteiraTrabalhoFuncionario}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">PIS:</label>
                    <input type="text" class="form-control" required name="pisFuncionario" value="${pisFuncionario}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Livraria:</label>
                    <select class="form-select" name="livrariaFuncionario">
                        <c:forEach var="livrarias" items="${listaLivraria}">
                            <option value="${livrarias.idLivraria}" ${livrarias.idLivraria == livrariaFuncionario ? 'selected' : ''}>${livrarias.nomeLivraria}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-12">
                    <c:choose>
                        <c:when test="${opcao == 'confirmarExcluir'}">
                            <button type="submit" formnovalidate class="btn btn-danger">
                                Confirmar Exclus�o
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" class="btn btn-primary">
                                Salvar
                            </button>
                        </c:otherwise>
                    </c:choose>
                    <a href="${pageContext.request.contextPath}${URL_BASE}/FuncionarioControlador?opcao=cancelar" class="btn btn-secondary">Cancelar</a>
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
                            <th>SAL�RIO</th>
                            <th>COMISS�O</th>
                            <th>ENDERE�O</th>
                            <th>EMAIL</th>
                            <th>TELEFONE</th>
                            <th>CARTEIRA</th>
                            <th>PIS</th>
                            <th>LIVRARIA</th>
                            <th style="width: 10%">ALTERAR</th>
                            <th style="width: 10%">EXCLUIR</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="funcionarios" items="${listaFuncionario}">
                            <tr>
                                <td class="align-middle">${funcionarios.codigo}</td>
                                <td class="align-middle">${funcionarios.nome}</td>
                                <td class="align-middle">${funcionarios.cpf}</td>
                                <td class="align-middle">${funcionarios.salario}</td>
                                <td class="align-middle">${funcionarios.comissaoPorLivro}</td>
                                <td class="align-middle">${funcionarios.endereco}</td>
                                <td class="align-middle">${funcionarios.email}</td>
                                <td class="align-middle">${funcionarios.telefone}</td>
                                <td class="align-middle">${funcionarios.carteiraTrabalho}</td>
                                <td class="align-middle">${funcionarios.pis}</td>
                                <td class="align-middle">${funcionarios.livraria.nomeLivraria}</td>
                                
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/FuncionarioControlador">
                                        <input type="hidden" name="codigoFuncionario" value="${funcionarios.codigo}">
                                        <input type="hidden" name="nomeFuncionario" value="${funcionarios.nome}">
                                        <input type="hidden" name="cpfFuncionario" value="${funcionarios.cpf}">
                                        <input type="hidden" name="salarioFuncionario" value="${funcionarios.salario}">
                                        <input type="hidden" name="comissaoPorLivroFuncionario" value="${funcionarios.comissaoPorLivro}">
                                        <input type="hidden" name="enderecoFuncionario" value="${funcionarios.endereco}">
                                        <input type="hidden" name="emailFuncionario" value="${funcionarios.email}">
                                        <input type="hidden" name="telefoneFuncionario" value="${funcionarios.telefone}">
                                        <input type="hidden" name="carteiraTrabalhoFuncionario" value="${funcionarios.carteiraTrabalho}">
                                        <input type="hidden" name="pisFuncionario" value="${funcionarios.pis}">
                                        <input type="hidden" name="livrariaFuncionario" value="${funcionarios.livraria.idLivraria}">
                                        <input type="hidden" name="opcao" value="enviarAlterar">
                                        <button type="submit" class="btn btn-sm btn-warning w-100">Alterar</button>
                                    </form>
                                </td>
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/FuncionarioControlador">
                                        <input type="hidden" name="codigoFuncionario" value="${funcionarios.codigo}">
                                        <input type="hidden" name="nomeFuncionario" value="${funcionarios.nome}">
                                        <input type="hidden" name="cpfFuncionario" value="${funcionarios.cpf}">
                                        <input type="hidden" name="salarioFuncionario" value="${funcionarios.salario}">
                                        <input type="hidden" name="comissaoPorLivroFuncionario" value="${funcionarios.comissaoPorLivro}">
                                        <input type="hidden" name="enderecoFuncionario" value="${funcionarios.endereco}">
                                        <input type="hidden" name="emailFuncionario" value="${funcionarios.email}">
                                        <input type="hidden" name="telefoneFuncionario" value="${funcionarios.telefone}">
                                        <input type="hidden" name="carteiraTrabalhoFuncionario" value="${funcionarios.carteiraTrabalho}">
                                        <input type="hidden" name="pisFuncionario" value="${funcionarios.pis}">
                                        <input type="hidden" name="livrariaFuncionario" value="${funcionarios.livraria.idLivraria}">
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