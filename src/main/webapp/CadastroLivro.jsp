<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastro de Livros</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="Menu.jsp" %>
        
        <div class="container mt-4">
            <h1 class="mb-4">Cadastro Livro</h1>

            <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/LivroControlador" class="row g-3 mb-4">
                <input type="hidden" name="opcao" value="${opcao}">
                <input type="hidden" name="codigoLivro" value="${codigoLivro}">

                <div class="col-md-6">
                    <label class="form-label">Título:</label>
                    <input type="text" class="form-control" required name="tituloLivro" value="${tituloLivro}"/>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Autor:</label>
                    <input type="text" class="form-control" required name="autorLivro" value="${autorLivro}"/>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label">Preço:</label>
                    <input type="number" step="0.01" min="0" class="form-control" required name="precoLivro" value="${precoLivro}"/>
                </div>
                
                <div class="col-md-6">
                    <label class="form-label">Estoque:</label>
                    <input type="number" step="1" min="0" class="form-control" required name="estoqueLivro" value="${estoqueLivro}"/>
                </div>
                
                <div class="col-md-4">
                    <label class="form-label">Gênero:</label>
                    <select class="form-select" name="generoLivro">
                        <c:forEach var="generos" items="${listaGenero}">
                            <option value="${generos.codGeneroLivro}" ${generos.codGeneroLivro == generoLivro ? 'selected' : ''}>${generos.nomeGeneroLivro}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Editora:</label>
                    <select class="form-select" name="editoraLivro">
                        <c:forEach var="editoras" items="${listaEditora}">
                            <option value="${editoras.codEditora}" ${editoras.codEditora == editoraLivro ? 'selected' : ''}>${editoras.nomeEditora}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-4">
                    <label class="form-label">Livraria:</label>
                    <select class="form-select" name="livrariaLivro">
                        <c:forEach var="livrarias" items="${listaLivraria}">
                            <option value="${livrarias.idLivraria}" ${livrarias.idLivraria == livrariaLivro ? 'selected' : ''}>${livrarias.nomeLivraria}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-12">
                    <c:choose>
                        <c:when test="${opcao == 'confirmarExcluir'}">
                            <button type="submit" formnovalidate class="btn btn-danger">
                                Confirmar Exclusão
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button type="submit" class="btn btn-primary">
                                Salvar
                            </button>
                        </c:otherwise>
                    </c:choose>
                    <a href="${pageContext.request.contextPath}${URL_BASE}/LivroControlador?opcao=cancelar" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>

            <hr class="my-4">

            <div class="table-responsive">
                <table class="table table-striped table-hover table-bordered">
                    <thead class="table-dark">
                        <tr>
                            <th style="width: 8%">ID</th>
                            <th>TÍTULO</th>
                            <th>AUTOR</th>
                            <th>PREÇO</th>
                            <th>ESTOQUE</th>
                            <th>GÊNERO</th>
                            <th>EDITORA</th>
                            <th>LIVRARIA</th>
                            <th style="width: 10%">ALTERAR</th>
                            <th style="width: 10%">EXCLUIR</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="livros" items="${listaLivro}">
                            <tr>
                                <td class="align-middle">${livros.codigo}</td>
                                <td class="align-middle">${livros.titulo}</td>
                                <td class="align-middle">${livros.autor}</td>
                                <td class="align-middle">${livros.preco}</td>
                                <td class="align-middle">${livros.estoque}</td>
                                <td class="align-middle">${livros.generoLivro.nomeGeneroLivro}</td>
                                <td class="align-middle">${livros.editora.nomeEditora}</td>
                                <td class="align-middle">${livros.livraria.nomeLivraria}</td>
                                
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/LivroControlador">
                                        <input type="hidden" name="codigoLivro" value="${livros.codigo}">
                                        <input type="hidden" name="tituloLivro" value="${livros.titulo}">
                                        <input type="hidden" name="autorLivro" value="${livros.autor}">
                                        <input type="hidden" name="precoLivro" value="${livros.preco}">
                                        <input type="hidden" name="estoqueLivro" value="${livros.estoque}">
                                        <input type="hidden" name="generoLivro" value="${livros.generoLivro.codGeneroLivro}">
                                        <input type="hidden" name="editoraLivro" value="${livros.editora.codEditora}">
                                        <input type="hidden" name="livrariaLivro" value="${livros.livraria.idLivraria}">
                                        <input type="hidden" name="opcao" value="enviarAlterar">
                                        <button type="submit" class="btn btn-sm btn-warning w-100">Alterar</button>
                                    </form>
                                </td>
                                <td class="align-middle">
                                    <form method="get" action="${pageContext.request.contextPath}${URL_BASE}/LivroControlador">
                                        <input type="hidden" name="codigoLivro" value="${livros.codigo}">
                                        <input type="hidden" name="tituloLivro" value="${livros.titulo}">
                                        <input type="hidden" name="autorLivro" value="${livros.autor}">
                                        <input type="hidden" name="precoLivro" value="${livros.preco}">
                                        <input type="hidden" name="estoqueLivro" value="${livros.estoque}">
                                        <input type="hidden" name="generoLivro" value="${livros.generoLivro.codGeneroLivro}">
                                        <input type="hidden" name="editoraLivro" value="${livros.editora.codEditora}">
                                        <input type="hidden" name="livrariaLivro" value="${livros.livraria.idLivraria}">
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