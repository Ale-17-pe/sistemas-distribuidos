<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.apiweb.aresfitnes.Model.Plan" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="Css/Plan.css"/>
        <link rel="icon" href="Imagenes/logo.png"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
        <title>Planes - AresFitness</title>
    </head>
    <body>
        <!-- Header -->
        <header>
            <div class="logo-container">
                <a href="index.jsp">
                    <img src="Imagenes/logo.png" alt="Logo AresFitness" />
                </a>
            </div>
        </header>

        <!-- Contenido principal -->
        <main class="contenido">
            <section class="contenido-planes">
                <div>
                    <h1 class="color-titulo">Seleccionar Plan</h1>
                    <div class="planes-grid">
                        <% 
                            int idPlanPorDefecto = 4;
                            List<Plan> planes = (List<Plan>) request.getAttribute("listaPlanes");
                            if (planes != null) {
                                for (int i = 0; i < planes.size(); i++) {
                                    Plan p = planes.get(i);
                                    String idRadio = "plan-" + p.getNombre().toLowerCase();
                                    String claseDestacada = (p.getIdPlan() == idPlanPorDefecto) ? "highlight-plan" : "";
                        %>
                        <div class="contenido-op caja plan-card <%= claseDestacada %>">
                            <% if (p.getIdPlan() == idPlanPorDefecto) { %>
                            <div class="plan-badge">RECOMENDADO</div>
                            <% } %>

                            <div class="plan-header">
                                <input class="plan-checkbox" type="radio" name="planSeleccionado" 
                                       id="<%= idRadio %>" value="<%= p.getIdPlan() %>"
                                       <%= (p.getIdPlan() == idPlanPorDefecto) ? "checked" : "" %>
                                       onclick="mostrarDetalle('<%= p.getNombre().replace("'", "\'") %>', `<%= p.getDescripcion().replaceAll("\n", "<br>") %>`, '<%= p.getDuracionMeses() %>', '<%= p.getPrecio() %>')">
                                <label for="<%= idRadio %>"><h3><%= p.getNombre() %></h3></label>
                            </div>

                            <div class="plan-body">
                                <p><i class="fas fa-calendar-alt"></i> <%= p.getDescripcion().split("\\n")[0] %></p>
                                <p><i class="fas fa-clock"></i> 6:00 am - 10:00 pm</p>
                                <p><i class="fas fa-dumbbell"></i> Todas las áreas</p>
                                <div class="plan-price">
                                    <h2>S/<span><%= p.getPrecio() %></span></h2>
                                    <small>por <%= p.getDuracionMeses() %> mes(es)</small>
                                </div>
                            </div>
                        </div>
                        <% 
                                }
                            }
                        %>
                    </div>
                </div>
            </section>

            <!-- Detalles del plan seleccionado -->
            <section class="contenido-detalles">
                <h3 class="color-titulo">Detalles de la compra</h3>
                <div class="caja2 selected-plan">
                    <div class="plan-summary">
                        <h4><i class="fas fa-check-circle"></i> Plan seleccionado:</h4>
                        <p class="plan-name" id="nombrePlan">Nombre del Plan</p>
                        <p class="plan-savings" id="descripcionPlan">Descripción aquí</p>
                    </div>
                    <div class="plan-benefits">
                        <p><strong>Duración:</strong> <span id="duracionPlan">0</span> mes(es)</p>
                        <p><strong>Precio:</strong> S/ <span id="precioPlan">0.00</span></p>
                    </div>
                </div>

                <div class="continue-section">
                    <form action="SeleccionarPlanServlet" method="post" id="formPlan">
                        <input type="hidden" name="idPlan" id="inputIdPlan">
                        <button type="submit" class="btn-continue">
                            CONTINUAR REGISTRO <i class="fas fa-arrow-right"></i>
                        </button>
                    </form>
                </div>
            </section>
        </main>

        <!-- Footer -->
        <footer>
            <p>&copy; COPYRIGHT</p>
        </footer>

        <script>
            window.onload = function () {
                mostrarDetalle(
                        "<%= planes.stream().filter(p -> p.getIdPlan() == idPlanPorDefecto).findFirst().get().getNombre().replace("\"", "\\\"") %>",
                        `<%= planes.stream().filter(p -> p.getIdPlan() == idPlanPorDefecto).findFirst().get().getDescripcion().replace("\n", "<br>").replace("`", "\\`") %>`,
                        "<%= planes.stream().filter(p -> p.getIdPlan() == idPlanPorDefecto).findFirst().get().getDuracionMeses() %>",
                        "<%= planes.stream().filter(p -> p.getIdPlan() == idPlanPorDefecto).findFirst().get().getPrecio() %>"
                        );
            };
        </script>
        <script>
            function mostrarDetalle(nombre, descripcion, duracion, precio) {
                document.getElementById('nombrePlan').innerHTML = nombre;
                document.getElementById('descripcionPlan').innerHTML = descripcion;
                document.getElementById('duracionPlan').textContent = duracion;
                document.getElementById('precioPlan').textContent = precio;
                document.getElementById('inputIdPlan').value = document.querySelector('input[name="planSeleccionado"]:checked').value;
            }
        </script>
    </body>
</html>
