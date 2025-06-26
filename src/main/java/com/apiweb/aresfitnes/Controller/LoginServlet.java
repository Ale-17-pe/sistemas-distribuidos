/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.apiweb.aresfitnes.Controller;

import com.apiweb.aresfitnes.Model.Usuario;
import com.apiweb.aresfitnes.dao.UsuarioDAO;
import com.apiweb.aresfitnes.dto.ClienteDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASPIRE 5 CI7 10MA
 */
public class LoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String dni = request.getParameter("dni");
        String contrasena = request.getParameter("contrasena");

        UsuarioDAO loginDAO = new UsuarioDAO();
        ClienteDTO clientedto = new ClienteDTO();
        Usuario usuario = null;

        try {
            usuario = loginDAO.validar(dni, contrasena);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogeado", usuario);

            // Redirige según el tipo de usuario
            String tipo = usuario.getTipoUsuario();

            if ("cliente".equals(tipo)) {
                clientedto = loginDAO.obetenerClienteDTO(usuario);
                session.setAttribute("clientedto", clientedto);
                response.sendRedirect("portalCliente.jsp");
            } else if ("recepcionista".equals(tipo)) {
                response.sendRedirect("portalRecepcionista.jsp");
            } else if ("administrador".equals(tipo)) {
                response.sendRedirect("portalAdmin.jsp");
            } else {
                response.sendRedirect("login.jsp?error=tipo_desconocido");
            }

        } else {
            response.sendRedirect("login.jsp?error=credenciales_invalidas");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
