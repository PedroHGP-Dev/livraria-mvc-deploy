<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="Latin1"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=Latin1">
        <title>Login de Usuário</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body class="d-flex align-items-center justify-content-center vh-100">
        <div class="container" style="max-width: 450px;">
            <div class="card p-4 bg-dark border-secondary shadow-lg">
                <h1 class="h3 mb-4 text-center">Acesso ao Sistema</h1>

                <c:if test="${not empty erro}">
                    <div class="alert alert-danger" role="alert">
                        ${erro}
                    </div>
                </c:if>

                <c:if test="${not empty mensagem}">
                    <div class="alert alert-success" role="alert">
                        ${mensagem}
                    </div>
                </c:if>

                <form method="post" action="${pageContext.request.contextPath}/LoginControlador" class="row g-3">
                    <input type="hidden" name="opcao" value="logar">

                    <div class="col-12">
                        <label class="form-label">Usuário:</label>
                        <input type="text" class="form-control" required name="nomeusuario" autofocus/>
                    </div>

                    <div class="col-12">
                        <label class="form-label">Senha:</label>
                        <input type="password" class="form-control" required name="senha"/>
                    </div>

                    <div class="col-12 mt-4">
                        <button type="submit" class="btn btn-primary w-100">Entrar</button>
                    </div>
                </form>

                <div class="d-flex justify-content-between mt-3">
                    <a href="${pageContext.request.contextPath}/CadastrarUsuario.jsp" class="btn btn-link text-decoration-none p-0">Criar Conta</a>
                    <a href="${pageContext.request.contextPath}/esqueciSenha.jsp" class="btn btn-link text-decoration-none p-0">Esqueci a Senha</a>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>