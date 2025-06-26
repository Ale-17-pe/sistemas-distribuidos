<%-- 
    Document   : ubicacion
    Created on : 23 jun. 2025, 11:37:26
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
        <link rel="stylesheet" href="Css/ubi.css">
        <link rel="icon" href="Imagenes/logo.png">
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
        <section class="ubicacion-section">
            <h2>Nos encontramos aquÃ­!!!</h2>

            <div class="contenedor-ubicacion">
                <!-- Imagen de fondo -->
                <div class="fondo-ubicacion">
                    <img src="Imagenes/images.jpeg" alt="UbicaciÃ³n del gimnasio">
                </div>

                <!-- Mapa superpuesto -->
                <div class="mapa-overlay">
                    <iframe 
                        src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d975.6893812773908!2d-76.82245228381464!3d-11.991272776981225!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105e988107f9313%3A0xf42c35c05adcef9f!2sARES%20FITNESS!5e0!3m2!1ses-419!2spe!4v1745024811727!5m2!1ses-419!2spe" width="500px" height="500px" 
                        allowfullscreen="" 
                        loading="lazy">
                    </iframe>
                </div>
            </div>
        </section>

        <!--&nbsp; espacio en blanco-->
        <footer>
            <div id="LOGO">
                <a href="index.jsp" target="_blank"><img id="LOGO" src="Imagenes/logo.png" alt="Logo Ares Fitness"><br><br></a>
            </div>

            <div class="footer_container">
                <!-- SecciÃ³n izquierda: Redes y contacto -->
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
                <!-- SecciÃ³n central: Enlaces -->
                <div class="footer-section">
                    <a href="#">TERMINOS Y CONDICIONES</a><br><br><br>
                    <a href="#">POLITICAS Y PRIVACIDAD</a><br><br><br>
                    <a href="#">QUEJAS Y RECLAMOS</a>
                </div>

                <!-- SecciÃ³n derecha: soporte y libro -->
                <div class="footer-section" style="text-align: center;">
                    <a href="#">SOPORTE TECNICO</a><br><br><br>
                    <a href="Index.html">ARES FITNESS</a><br><br><br><br>
                    <span style="color: #00ccff; font-weight: bold;"></span><br>
                    <img src="Imagenes/LibroR.png" alt="Libro de Reclamaciones" style="width: 150px;">
                </div>
            </div>
            <p>&copy; COPYRIGHT</p>
        </footer>
    </body>
</html>
