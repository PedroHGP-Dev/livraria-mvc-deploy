<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html" pageEncoding="Latin1"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=Latin1">
        <title>Cadastro de Usu�rio</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body class="d-flex align-items-center justify-content-center vh-100">
        <div class="container" style="max-width: 450px;">
            <div class="card p-4 bg-dark border-secondary shadow-lg">
                <h1 class="h3 mb-4 text-center">Novo Usu�rio</h1>

                <form method="post" action="${pageContext.request.contextPath}/LoginControlador" class="row g-3">
                    <input type="hidden" name="opcao" value="cadastrar">

                    <div class="col-12">
                        <label class="form-label">Nome de Usu�rio:</label>
                        <input type="text" class="form-control" required name="nomeusuario"/>
                    </div>

                    <div class="col-12">
                        <label class="form-label">Email:</label>
                        <input type="email" class="form-control" required name="email"/>
                    </div>

                    <div class="col-12">
                        <label class="form-label">Senha:</label>
                        <input type="password" class="form-control" required name="senha"/>
                    </div>

                    <div class="col-12 mt-4">
                        <button type="submit" class="btn btn-success w-100">Cadastrar</button>
                    </div>
                </form>

                <div class="text-center mt-3">
                    <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-link text-decoration-none p-0">Voltar ao Login</a>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>