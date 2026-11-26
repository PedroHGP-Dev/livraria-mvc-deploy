<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Redefinir Senha</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap_config.css" rel="stylesheet">
    </head>
    <body class="d-flex align-items-center justify-content-center vh-100">
        <div class="container" style="max-width: 450px;">
            <div class="card p-4 bg-dark border-secondary shadow-lg">
                <h1 class="h3 mb-4 text-center">Redefinir Senha</h1>

                <form method="post" action="${pageContext.request.contextPath}/LoginControlador" class="row g-3">
                    <input type="hidden" name="opcao" value="redefinirSenha">
                    <input type="hidden" name="token" value="${param.token}">

                    <div class="col-12">
                        <label class="form-label">Nova Senha:</label>
                        <input type="password" class="form-control" required name="novaSenha" autofocus/>
                    </div>

                    <div class="col-12 mt-4">
                        <button type="submit" class="btn btn-primary w-100">Salvar Nova Senha</button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>