<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Fluxo de Caixa</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body>
        <fmt:setLocale value="pt_BR" />
        <%@include file="Menu.jsp" %>
        
        <div class="container mt-4">
            <h1 class="mb-4">Fluxo de Caixa / Nova Venda</h1>

            <c:set var="vendaIniciada" value="${not empty cliente_codCliente and cliente_codCliente != '' and cliente_codCliente != '0'}" />

            <div class="card p-3 bg-dark border-secondary mb-4">
                <form method="post" action="${pageContext.request.contextPath}${URL_BASE}/VendaControlador" class="row g-3 align-items-end">
                    <div class="col-md-3">
                        <label class="form-label">Cliente:</label>
                        <select class="form-select" name="cliente_codCliente" ${vendaIniciada ? 'disabled' : ''} required>
                            <option value="" disabled ${empty cliente_codCliente ? 'selected' : ''}>Selecione...</option>
                            <c:forEach var="cli" items="${listaCliente}">
                                <option value="${cli.codigo}" ${cli.codigo == cliente_codCliente ? 'selected' : ''}>${cli.nome}</option>
                            </c:forEach>
                        </select>
                        <c:if test="${vendaIniciada}">
                            <input type="hidden" name="cliente_codCliente" value="${cliente_codCliente}" />
                        </c:if>
                    </div>
                    
                    <div class="col-md-3">
                        <label class="form-label">Funcionário:</label>
                        <select class="form-select" name="funcionario_codFuncionario" ${vendaIniciada ? 'disabled' : ''} required>
                            <option value="" disabled ${empty funcionario_codFuncionario ? 'selected' : ''}>Selecione...</option>
                            <c:forEach var="f" items="${listaFuncionario}">
                                <option value="${f.codigo}" ${f.codigo == funcionario_codFuncionario ? 'selected' : ''}>${f.nome}</option>
                            </c:forEach>
                        </select>
                        <c:if test="${vendaIniciada}">
                            <input type="hidden" name="funcionario_codFuncionario" value="${funcionario_codFuncionario}" />
                        </c:if>
                    </div>
                    
                    <div class="col-md-3">
                        <label class="form-label">Livraria:</label>
                        <select class="form-select" name="livraria_idLivraria" ${vendaIniciada ? 'disabled' : ''} required>
                            <option value="" disabled ${empty livraria_idLivraria ? 'selected' : ''}>Selecione...</option>
                            <c:forEach var="l" items="${listaLivraria}">
                                <option value="${l.idLivraria}" ${l.idLivraria == livraria_idLivraria ? 'selected' : ''}>${l.nomeLivraria}</option>
                            </c:forEach>
                        </select>
                        <c:if test="${vendaIniciada}">
                            <input type="hidden" name="livraria_idLivraria" value="${livraria_idLivraria}" />
                        </c:if>
                    </div>

                    <div class="col-md-3">
                        <c:if test="${!vendaIniciada}">
                            <button type="submit" name="opcao" value="iniciar" class="btn btn-success w-100">Iniciar Atendimento</button>
                        </c:if>
                        <c:if test="${vendaIniciada}">
                            <button type="submit" name="opcao" value="cancelar" class="btn btn-danger w-100">Cancelar</button>
                        </c:if>
                    </div>
                </form>
            </div>

            <form method="post" action="${pageContext.request.contextPath}${URL_BASE}/VendaControlador" class="row g-3 mb-4">
                <input type="hidden" name="cliente_codCliente" value="${cliente_codCliente}" />
                <input type="hidden" name="funcionario_codFuncionario" value="${funcionario_codFuncionario}" />
                <input type="hidden" name="livraria_idLivraria" value="${livraria_idLivraria}" />
                
                <div class="col-md-6 mt-4">
                    <div class="card p-3 bg-dark border-secondary ${!vendaIniciada ? 'opacity-50' : ''}">
                        <h3 class="h5 mb-3 text-light">Adicionar Livros</h3>
                        <div class="mb-3">
                            <label class="form-label">Escolha o Livro:</label>
                            <select class="form-select" name="livro_codLivro" size="4" ${!vendaIniciada ? 'disabled' : ''}>
                                <c:forEach var="livro" items="${listaLivros}">
                                    <option value="${livro.codigo}">${livro.titulo} - R$ <fmt:formatNumber value="${livro.preco}" pattern="#,##0.00"/> (${livro.estoque} un)</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3" style="max-width: 120px;">
                            <label class="form-label">Quantidade:</label>
                            <input type="number" class="form-control" name="quantLivroPorVenda" value="1" min="1" ${!vendaIniciada ? 'disabled' : ''}>
                        </div>
                        <button type="submit" name="opcao" value="addLivro" class="btn btn-success" ${!vendaIniciada ? 'disabled' : ''}>Inserir Item</button>
                    </div>
                </div>
                
                <div class="col-md-6 mt-4">
                    <div class="card p-3 bg-dark border-secondary ${!vendaIniciada ? 'opacity-50' : ''}">
                        <h3 class="h5 mb-3 text-light">Formas de Pagamento</h3>
                        <div class="mb-3">
                            <label class="form-label">Forma:</label>
                            <select class="form-select" name="formaPagamento_codFormaPagamento" ${!vendaIniciada ? 'disabled' : ''}>
                                <c:forEach var="forma" items="${listaFormasPagamento}">
                                    <option value="${forma.codFormaPagamento}">${forma.nomeFormaPagamento}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Valor R$:</label>
                            <input type="number" class="form-control" name="valorPagamento" value="0.00" step="0.01" ${!vendaIniciada ? 'disabled' : ''}>
                        </div>
                        <button type="submit" name="opcao" value="addPagamento" class="btn btn-info text-dark font-weight-bold" ${!vendaIniciada ? 'disabled' : ''}>Lançar Pagamento</button>
                    </div>
                </div>

                <div class="col-md-6 mt-4">
                    <h3 class="h5 mb-3">Itens Inseridos</h3>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                            <thead class="table-dark">
                                <tr>
                                    <th>Livro</th>
                                    <th style="width: 15%">Qtd</th>
                                    <th>Preço</th>
                                    <th style="width: 15%">Remover</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${carrinhoItens}" varStatus="st">
                                    <tr>
                                        <td class="align-middle">${item.tituloLivro}</td>
                                        <td class="align-middle">${item.quantLivroPorVenda}</td>
                                        <td class="align-middle">
                                            R$ <fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/>
                                        </td>
                                        <td class="align-middle">
                                            <button type="submit" name="opcao" value="removeLivro" class="btn btn-sm btn-danger w-100" onclick="this.form.action+='?indexLivro=${st.index}'" ${!vendaIniciada ? 'disabled' : ''}>X</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-md-6 mt-4">
                    <h3 class="h5 mb-3">Pagamentos Lançados</h3>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                            <thead class="table-dark">
                                <tr>
                                    <th>Forma</th>
                                    <th>Valor</th>
                                    <th style="width: 15%">Remover</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="pg" items="${carrinhoPagamentos}" varStatus="st">
                                    <tr>
                                        <td class="align-middle">${pg.nomeFormaPagamento}</td>
                                        <td class="align-middle">
                                            R$ <fmt:formatNumber value="${pg.valor}" pattern="#,##0.00"/>
                                        </td>
                                        <td class="align-middle">
                                            <button type="submit" name="opcao" value="removePagamento" class="btn btn-sm btn-danger w-100" onclick="this.form.action+='?indexPgto=${st.index}'" ${!vendaIniciada ? 'disabled' : ''}>X</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-12 mt-4">
                    <div class="p-3 bg-secondary bg-opacity-10 border border-secondary rounded d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <div>
                            <span class="me-3">
                                <strong>Subtotal Itens:</strong> R$ <fmt:formatNumber value="${totalLivros != null ? totalLivros : 0.0}" pattern="#,##0.00"/>
                            </span>
                            <span class="me-3">
                                <strong>Total Pago:</strong> R$ <fmt:formatNumber value="${totalPago != null ? totalPago : 0.0}" pattern="#,##0.00"/>
                            </span>
                            <span>
                                <c:choose>
                                    <c:when test="${restante < 0}">
                                        <strong class="text-success">Troco:</strong> R$ <fmt:formatNumber value="${restante * -1}" pattern="#,##0.00"/>
                                    </c:when>
                                    <c:otherwise>
                                        <strong class="text-danger">Falta pagar:</strong> R$ <fmt:formatNumber value="${restante != null ? restante : 0.0}" pattern="#,##0.00"/>
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <div>
                            <button type="submit" name="opcao" value="finalizar" class="btn btn-primary" ${!vendaIniciada ? 'disabled' : ''}>Concluir Venda</button>
                        </div>
                    </div>
                </div>
            </form>

            <c:if test="${not empty mensagem}">
                <div class="alert alert-info mt-3" role="alert">
                    <strong>${mensagem}</strong>
                </div>
            </c:if>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>