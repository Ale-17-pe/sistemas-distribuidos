/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.apiweb.aresfitnes.Controller;

import com.apiweb.aresfitnes.Model.Cliente;
import com.apiweb.aresfitnes.Model.Usuario;
import com.apiweb.aresfitnes.Service.ClienteService;
import com.apiweb.aresfitnes.dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASPIRE 5 CI7 10MA
 */
public class RegistroServlet extends HttpServlet {

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
        // Obtener datos del formulario
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String dni = request.getParameter("dni");
        String telefono = request.getParameter("telefono");
        String correo = request.getParameter("correo");
        String direccion = request.getParameter("direccion");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String genero = request.getParameter("genero");
        String contrasena = request.getParameter("contrasena");
        String confirmarContrasena = request.getParameter("confirmarContrasena");

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        if (usuarioDAO.existeDni(dni)) {
            // Mostrar error o redirigir
            response.sendRedirect("registrar.jsp?error=dni_duplicado");
            return;
        }

        Usuario usuario = new Usuario();
        usuario.setDni(dni);
        usuario.setContraseña(contrasena);
        usuario.setTipoUsuario("cliente");

        Cliente cliente = new Cliente();
        cliente.setNombre(nombre);
        cliente.setApellido(apellido);
        cliente.setCorreo(correo);
        cliente.setTelefono(telefono);
        cliente.setDireccion(direccion);
        cliente.setGenero(genero);
        cliente.setFechaNacimiento(Date.valueOf(fechaNacimiento)); // java.sql.Date

        ClienteService service = new ClienteService();

        if (!service.validarCliente(cliente, usuario)) {
            // Mostrar error o redirigir
            response.sendRedirect("registrar.jsp?error=validacion");
            return;
        }

        // Además validar que las contraseñas coincidan
        if (!service.contrasenasCoinciden(contrasena, confirmarContrasena)) {
            response.sendRedirect("registrar.jsp?error=contrasenas_no_coinciden");
            return;
        }

        // Guardar en sesión
        HttpSession session = request.getSession();
        session.setAttribute("usuarioTemp", usuario);
        session.setAttribute("clienteTemp", cliente);

        // Redirigir a pago.jsp
        response.sendRedirect("pago.jsp");
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
            Logger.getLogger(RegistroServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(RegistroServlet.class.getName()).log(Level.SEVERE, null, ex);
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
