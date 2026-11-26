package com.mycompany.livrariapedrojoaquim.controlador;

import com.mycompany.livrariapedrojoaquim.modelo.dao.UsuarioDao;
import com.mycompany.livrariapedrojoaquim.modelo.entidade.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.UUID;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet(name = "LoginControlador", urlPatterns = {"/LoginControlador"})
public class LoginControlador extends HttpServlet {

    private UsuarioDao usuarioDao = new UsuarioDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processarRequisicao(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processarRequisicao(request, response);
    }

    protected void processarRequisicao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String opcao = request.getParameter("opcao");
        if (opcao == null) opcao = "";

        switch (opcao) {
            case "cadastrar":
                cadastrarUsuario(request, response);
                break;
            case "logar":
                logarUsuario(request, response);
                break;
            case "logout":
                logoutUsuario(request, response);
                break;
            case "esqueciSenha":
                solicitarRecuperacao(request, response);
                break;
            case "redefinirSenha":
                redefinirSenha(request, response);
                break;
            default:
                logoutUsuario(request, response);
                break;
        }
    }

    private void cadastrarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nomeusuario = request.getParameter("nomeusuario");
        String senha = request.getParameter("senha");
        String email = request.getParameter("email");

        String senhahash = BCrypt.hashpw(senha, BCrypt.gensalt());

        Usuario u = new Usuario();
        u.setNomeusuario(nomeusuario);
        u.setSenhahash(senhahash);
        u.setEmail(email);

        usuarioDao.cadastrar(u);

        request.setAttribute("mensagem", "Usuário cadastrado com sucesso!");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    private void logarUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nomeusuario = request.getParameter("nomeusuario");
        String senha = request.getParameter("senha");

        Usuario u = usuarioDao.buscarPorNomeUsuario(nomeusuario);

        if (u != null && BCrypt.checkpw(senha, u.getSenhahash())) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogado", u);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        } else {
            request.setAttribute("erro", "Usuário ou senha inválidos!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void logoutUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    private void solicitarRecuperacao(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        Usuario u = usuarioDao.buscarPorEmail(email);

        if (u != null) {
            String token = UUID.randomUUID().toString();
            Timestamp expiracao = Timestamp.valueOf(LocalDateTime.now().plusHours(1));

            usuarioDao.salvarTokenRecuperacao(email, token, expiracao);

            String linkRecuperacao = request.getContextPath() + "/redefinirSenha.jsp?token=" + token;
            request.setAttribute("mensagem", "Link de recuperação gerado com sucesso: <a href='" + linkRecuperacao + "'>Clique Aqui para Redefinir</a>");
        } else {
            request.setAttribute("erro", "E-mail não encontrado no sistema.");
        }
        request.getRequestDispatcher("/esqueciSenha.jsp").forward(request, response);
    }

    private void redefinirSenha(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        String novaSenha = request.getParameter("novaSenha");

        Usuario u = usuarioDao.buscarPorToken(token);

        if (u != null && u.getTokenExpiracao() != null && u.getTokenExpiracao().isAfter(LocalDateTime.now())) {
            String novoHash = BCrypt.hashpw(novaSenha, BCrypt.gensalt());
            usuarioDao.atualizarSenhaEInvalidarToken(u.getId(), novoHash);

            request.setAttribute("mensagem", "Senha alterada com sucesso! Faça login.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("erro", "Token inválido ou expirado.");
            request.getRequestDispatcher("/esqueciSenha.jsp").forward(request, response);
        }
    }
}