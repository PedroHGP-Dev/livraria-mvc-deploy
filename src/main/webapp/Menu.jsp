<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/estilo.css">
<nav>
    <ul>
        <li><a href="${pageContext.request.contextPath}/index.jsp">HOME</a></li>        
        <li><a href="${pageContext.request.contextPath}${URL_BASE}/GeneroLivroControlador?opcao=cancelar">GÊNERO</a></li>        
        <li><a href="${pageContext.request.contextPath}${URL_BASE}/EditoraControlador?opcao=cancelar">EDITORA</a></li>
        <li><a href="${pageContext.request.contextPath}${URL_BASE}/LivroControlador?opcao=cancelar">LIVRO</a></li>
        <li><a href="${pageContext.request.contextPath}${URL_BASE}/FormaPagamentoControlador?opcao=cancelar">PAGAMENTO</a></li>
        <li><a href="${pageContext.request.contextPath}${URL_BASE}/LivrariaControlador?opcao=cancelar">LIVRARIA</a></li>
        <li><a href="${pageContext.request.contextPath}${URL_BASE}/FuncionarioControlador?opcao=cancelar">FUNCIONÁRIO</a></li>
        <li><a href="${pageContext.request.contextPath}${URL_BASE}/ClienteControlador?opcao=cancelar">CLIENTE</a></li>
        <li><a href="${pageContext.request.contextPath}${URL_BASE}/VendaControlador?opcao=abrirCaixa">CAIXA</a></li>
        
        <li><a href="${pageContext.request.contextPath}/relatorios.jsp">RELATÓRIOS</a></li>
        
        <c:choose>
            <c:when test="${not empty sessionScope.usuarioLogado}">
                <li><a href="${pageContext.request.contextPath}/LoginControlador?opcao=logout">LOGOUT (${sessionScope.usuarioLogado.nomeusuario})</a></li>
            </c:when>
            <c:otherwise>
                <li><a href="${pageContext.request.contextPath}/login.jsp">LOGIN</a></li>
            </c:otherwise>
        </c:choose>
    </ul>
</nav>