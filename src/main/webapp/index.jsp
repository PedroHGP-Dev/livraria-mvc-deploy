<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-br" data-bs-theme="dark">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Home | TechLib Solutions</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&display=swap" rel="stylesheet">
        <style>
            body { font-family: 'Inter', sans-serif; }
            .logo-ficticia {
                width: 80px; height: 80px;
                background-color: #0d6efd;
                border-radius: 20%;
                display: flex; align-items: center; justify-content: center;
                margin: 0 auto 20px;
                font-weight: bold; font-size: 2rem; color: white;
                box-shadow: 0 4px 15px rgba(13, 110, 253, 0.3);
            }
            .feature-list li {
                margin-bottom: 10px;
                padding-left: 15px;
                border-left: 3px solid #0d6efd;
            }
        </style>
    </head>
    <body>
        <%@include file="Menu.jsp" %>

        <div class="container mt-5">
            <div class="p-5 mb-4 bg-body-tertiary rounded-4 shadow-lg border border-secondary-subtle">
                <div class="container-fluid text-center">
                    
                    <div class="logo-ficticia">TL</div>
                    <h1 class="display-4 fw-bold text-primary mb-3">TechLib Solutions</h1>
                    
                    <p class="fs-4 text-secondary mb-4">
                        Sistema Integrado de GestÃ£o para Livrarias Modernas.
                    </p>
                    
                    <div class="row text-start mt-5 g-4">
                        <div class="col-md-6">
                            <h3 class="h4 text-light border-bottom pb-2">Sobre o Sistema</h3>
                            <p class="text-muted">
                                O TechLib Solutions foi desenvolvido para centralizar o controle operacional 
                                da sua livraria. Nossa plataforma permite o gerenciamento completo de dados essenciais, 
                                garantindo que a organizaÃ§Ã£o do acervo e as transaÃ§Ãµes financeiras estejam sempre em dia.
                            </p>
                        </div>
                        
                        <div class="col-md-6">
                            <h3 class="h4 text-light border-bottom pb-2">Funcionalidades Principais</h3>
                            <ul class="list-unstyled text-muted feature-list">
                                <li><strong>Cadastros Estruturados:</strong> Gerenciamento de GÃªneros, Editoras e Livrarias.</li>
                                <li><strong>Controle Financeiro:</strong> ConfiguraÃ§Ã£o de Formas de Pagamento.</li>
                                <li><strong>Interface AdaptÃ¡vel:</strong> NavegaÃ§Ã£o otimizada para diferentes resoluÃ§Ãµes.</li>
                                <li><strong>Integridade de Dados:</strong> Armazenamento seguro de informaÃ§Ãµes crÃ­ticas.</li>
                            </ul>
                        </div>
                    </div>

                    <hr class="my-5 border-secondary opacity-25">
                    
                    <p class="small text-uppercase tracking-widest text-primary fw-semibold">
                        Navegue atravÃ©s do menu superior para acessar as funcionalidades.
                    </p>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>