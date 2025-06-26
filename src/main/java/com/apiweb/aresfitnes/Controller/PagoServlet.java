/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.apiweb.aresfitnes.Controller;

import com.apiweb.aresfitnes.Model.Cliente;
import com.apiweb.aresfitnes.Model.Matricula;
import com.apiweb.aresfitnes.Model.Pago;
import com.apiweb.aresfitnes.Model.Plan;
import com.apiweb.aresfitnes.Model.Usuario;
import com.apiweb.aresfitnes.Service.PagoService;
import com.apiweb.aresfitnes.dao.ClienteDAO;
import com.apiweb.aresfitnes.dao.MatriculaDAO;
import com.apiweb.aresfitnes.dao.PagoDAO;
import com.apiweb.aresfitnes.dao.PlanDAO;
import com.apiweb.aresfitnes.dao.UsuarioDAO;
import com.apiweb.aresfitnes.dto.ClienteDTO;
import com.apiweb.aresfitnes.dto.ResultadoPagoDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
/**
 *
 * @author ASPIRE 5 CI7 10MA
 */
public class PagoServlet extends HttpServlet {

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
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        Usuario usuario = (Usuario) session.getAttribute("usuarioTemp");
        Cliente cliente = (Cliente) session.getAttribute("clienteTemp");
        int idPlan = Integer.parseInt((String) session.getAttribute("idPlanSeleccionado"));

        // 1. Validar método de pago usando el servicio
        String metodo = request.getParameter("metodoPago");
        PagoService pagoService = new PagoService();

        ResultadoPagoDTO resultado = pagoService.validarPago(
                metodo,
                request.getParameter("numeroTarjeta"),
                request.getParameter("fechaVencimiento"),
                request.getParameter("cvv"),
                request.getParameter("titular"),
                request.getParameter("numeroYape")
        );

        if (!resultado.isValido()) {
            request.setAttribute("error", "Error en el método de pago");
            request.getRequestDispatcher("pago.jsp").forward(request, response);
            return;
        }

        String referenciaPago = resultado.getReferencia();

        try {
            // 2. Insertar Usuario
            UsuarioDAO usuarioDAO = new UsuarioDAO();
            int idUsuarioGenerado = usuarioDAO.insertar(usuario); // guarda y retorna id
            if (idUsuarioGenerado == -1) {
                // manejar error, mostrar mensaje, no continuar con el registro de cliente
                request.setAttribute("error", "No se pudo registrar el usuario. Intente de nuevo.");
                request.getRequestDispatcher("registro.jsp").forward(request, response);
            }
            usuario.setIdUsuario(idUsuarioGenerado); // ✔️ aquí agregamos el ID al objeto
            cliente.setIdUsuario(idUsuarioGenerado);

            // 3. Insertar Cliente
            ClienteDAO clienteDAO = new ClienteDAO();
            int idCliente = clienteDAO.insertar(cliente); // guarda y retorna id

            if (idCliente == -1) {
                // manejar error
                request.setAttribute("error", "No se pudo registrar el usuario. Intente de nuevo.");
                request.getRequestDispatcher("registro.jsp").forward(request, response);
            }
            // 4. Insertar Pago
            PlanDAO planDAO = new PlanDAO();
            Plan plan = planDAO.obtenerPorId(idPlan);

            Pago pago = new Pago();

            LocalDateTime ahora = LocalDateTime.now();
            Timestamp timestamp = Timestamp.valueOf(ahora);

            pago.setFechaPago(timestamp);
            pago.setMonto(plan.getPrecio());
            pago.setMetodoPago(metodo);
            pago.setReferenciaPago(referenciaPago);
            pago.setEstadoPago("aprobado");

            PagoDAO pagoDAO = new PagoDAO();
            int idPago = pagoDAO.insertar(pago);
            if (idPago == -1) {
                // manejar error
                request.setAttribute("error", "No se pudo registrar el Pago. Intente de nuevo.");
                request.getRequestDispatcher("pago.jsp").forward(request, response);
            }
            // 5. Insertar Matrícula
            Matricula matricula = new Matricula();
            matricula.setIdCliente(idCliente);
            matricula.setIdPlan(idPlan);
            matricula.setIdPago(idPago);

            LocalDate inicio = LocalDate.now();
            LocalDate fin = inicio.plusMonths(plan.getDuracionMeses());
            java.sql.Date fechaInicioSql = java.sql.Date.valueOf(inicio);
            java.sql.Date fechaFinSql = java.sql.Date.valueOf(fin);

            matricula.setFechaInicio(fechaInicioSql);
            matricula.setFechaFin(fechaFinSql);
            matricula.setEstado("activo");

            MatriculaDAO matriculaDAO = new MatriculaDAO();
            boolean exito = matriculaDAO.insertar(matricula);
            if (!exito) {
                // manejar error
                request.setAttribute("error", "No se pudo Matricularse. Intente de nuevo.");
                request.getRequestDispatcher("pago.jsp").forward(request, response);
            }
            // Registro exitoso
            ClienteDTO clientedto = new ClienteDTO(cliente.getNombre(),cliente.getApellido(),cliente.getCorreo(),cliente.getTelefono(),cliente.getDireccion(),cliente.getFechaNacimiento(),cliente.getGenero(),usuario.getDni());
            session.setAttribute("clientedto", clientedto);
            session.setAttribute("usuarioLogeado", usuario);
            session.removeAttribute("usuarioTemp");
            session.removeAttribute("clienteTemp");
            session.removeAttribute("idPlanSeleccionado");

            response.sendRedirect("portalCliente.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Ocurrió un error durante el registro");
            request.getRequestDispatcher("pago.jsp").forward(request, response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
