<%-- 
    Document   : mutar
    Created on : 23 jun. 2025, 11:40:13
    Author     : ASPIRE 5 CI7 10MA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    com.apiweb.aresfitnes.Model.Usuario usuario = (com.apiweb.aresfitnes.Model.Usuario) session.getAttribute("usuarioLogeado");
    com.apiweb.aresfitnes.dto.ClienteDTO clientedto = (com.apiweb.aresfitnes.dto.ClienteDTO) session.getAttribute("clientedto");
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AresFitness</title>
        <link rel="stylesheet" href="Css/mutar.css">
        <link rel="icon" href="Imagenes/logo.png">
        <link href="https://fonts.googleapis.com/css2?family=Anton&display=swap" rel="stylesheet">
    </head>
    <body>
        <header>
            <div class="logo-container">
                <a href="index.jsp">
                    <img src="Imagenes/logo.png" alt="Logo AresFitness">
                </a>
            </div>
            <nav>
                <ul> 
                    <li><a href=mutar.jsp >PLANES</a></li>
                    <li><a href=ubicacion.jsp >UBICACIÓN</a></li>
                        <% if (usuario != null) { %>

                    <% 
                        String tipo = usuario.getTipoUsuario(); 
                        if ("cliente".equals(tipo)) {
                    %>
                    <li><a href="portalCliente.jsp">MI PORTAL</a></li>
                        <% } else if ("recepcionista".equals(tipo)) { %>
                    <li><a href="portalRecepcionista.jsp">MI PORTAL</a></li>
                        <% } else if ("administrador".equals(tipo)) { %>
                    <li><a href="portalAdmin.jsp">MI PORTAL</a></li>
                        <% } %>

                    <li><a href="LogoutServlet">CERRAR SESION</a></li>
                        <% } else { %>
                    <li><a href="login.jsp">INICIAR SESION</a></li>
                        <% } %>
                </ul>
            </nav>
        </header>
        <section class="gym-section">
            <div class="gym-banner">
                <img src="Imagenes/Gym-4.1.PNG" alt="Gimnasio">
            </div>

            <!-- Planes DEBAJO de la imagen -->
            <div class="planes-container">
                <!-- Plan 1 -->
                <div class="plan-card">
                    <h2>INTERDIARIO</h2>
                    <p>Entrena 3 días a la semana por mes y no pierdas el ritmo de tu cambio fisico</p>
                    <a href="PlanServlet">
                        <button class="btn-magic">
                            <span class="btn-text">MUTAR</span>
                            <span class="hover-effect"></span>
                        </button></a>
                </div>

                <!-- Plan 2 -->
                <div class="plan-card">
                    <h2>MENSUAL</h2>
                    <p>Entrena de Lunes a sábados por 3 meses a menor precio y cree en el cambio </p>
                    <a href="PlanServlet">
                        <button class="btn-magic">
                            <span class="btn-text">MUTAR</span>
                            <span class="hover-effect"></span>
                        </button></a>
                </div>

                <!-- Plan 3 -->
                <div class="plan-card">
                    <h2>BIMESTRAL</h2>
                    <p>Entrena de Lunes a sábados por 3 meses a el precio de 2 meses</p>
                    <a href="PlanServlet">
                        <button class="btn-magic">
                            <span class="btn-text">MUTAR</span>
                            <span class="hover-effect"></span>
                        </button></a>
                </div>

                <!-- Plan 4 -->
                <div class="plan-card">
                    <h2>TRIMESTRAL</h2>
                    <p>Posibilidad de entrenar de Lunes a sábados por 6 meses pagando como si fueran 3 meses</p>
                    <a href="PlanServlet">
                        <button class="btn-magic">
                            <span class="btn-text">MUTAR</span>
                            <span class="hover-effect"></span>
                        </button></a>
                </div>
                <!-- Plan 5 -->
                <div class="plan-card">
                    <h2>SEMESTRE</h2>
                    <p>Posibilidad de entrenar de Lunes a sábados por 2 meses a menor precio</p>
                    <a href="PlanServlet">
                        <button class="btn-magic">
                            <span class="btn-text">MUTAR</span>
                            <span class="hover-effect"></span>
                        </button></a>
                </div>

                <!-- Plan 6 -->
                <div class="plan-card">
                    <h2>ANUAL</h2>
                    <p>Posibilidad de entrenar de Lunes a sábados por todo el año con descuentos únicos</p>
                    <a href="PlanServlet">
                        <button class="btn-magic">
                            <span class="btn-text">MUTAR</span>
                            <span class="hover-effect"></span>
                        </button></a>
                </div>
            </div>
        </section>
        <!--&nbsp; espacio en blanco-->
        <footer>
            <div id="LOGO">
                <a href="index.jsp" target="_blank"><img id="LOGO" src="Imagenes/logo.png" alt="Logo Ares Fitness"><br><br></a>
            </div>

            <div class="footer_container">

                <!-- Sección izquierda: Redes y contacto -->
                <div class="redes-sociales">
                    <strong>Redes Sociales:</strong><br><br>
                    <a href="#" target="_blank"><img  target src="Imagenes/FB.png" alt="Facebook" class="icono-red"></a>
                    <a href="https://www.instagram.com/aresfitness.peru/" target="_blank"><img src="Imagenes/Insta.png" alt="Instagram" class="icono-red"></a>
                    <a href="#"target="_blank"><img src="Imagenes/Tiktok.png" alt="Tiktok" class="icono-red"></a>
                    <a href="#"target="_blank"><img src="Imagenes/X.png" alt="X" class="icono-red"></a><br>
                    <br><br>
                    <strong">CONTACTANOS:</strong><br><br>
                    <a href="#" target="_blank">
                        <img src="Imagenes/WhatsApp.png" alt="WhatsApp" style="width: 20px; vertical-align: middle;"></a>
                    <br><br>
                    <a href="#" target="_blank">
                        <img src="Imagenes/Gmail.png" alt="Correo" style="width: 20px; vertical-align: middle;"></a> 

                </div>
                <!-- Sección central: Enlaces -->
                <div class="footer-section">
                    <a href="#">TERMINOS Y CONDICIONES</a><br><br><br>
                    <a href="#">POLITICAS Y PRIVACIDAD</a><br><br><br>
                    <a href="#">QUEJAS Y RECLAMOS</a>
                </div>

                <!-- Sección derecha: soporte y libro -->
                <div class="footer-section" style="text-align: center;">
                    <a href="#">SOPORTE TECNICO</a><br><br><br>
                    <a href=index.jsp>ARES FITNESS</a><br><br><br><br>
                    <span style="color: #00ccff; font-weight: bold;"></span><br>
                    <img src="Imagenes/LibroR.png" alt="Libro de Reclamaciones" style="width: 150px;">
                </div>
            </div>
            <p>&copy; COPYRIGHT</p>
        </footer>
    </body>
</html>
