package com.mycompany.livrariapedrojoaquim.servico;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();

        boolean ePaginaPublica = uri.endsWith("login.jsp") || 
                                 uri.endsWith("CadastrarUsuario.jsp") || 
                                 uri.endsWith("esqueciSenha.jsp") || 
                                 uri.endsWith("redefinirSenha.jsp") || 
                                 uri.contains("LoginControlador") ||
                                 uri.endsWith(".css") || 
                                 uri.endsWith(".js");

        boolean estaLogado = (session != null && session.getAttribute("usuarioLogado") != null);

        if (estaLogado || ePaginaPublica) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
    }
}