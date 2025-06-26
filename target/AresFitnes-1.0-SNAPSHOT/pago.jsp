<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
<%@ page import="com.apiweb.aresfitnes.Model.Plan" %>
<%@ page import="com.apiweb.aresfitnes.Model.Cliente" %>
<%@ page import="com.apiweb.aresfitnes.Model.Usuario" %>

<%
    Plan plan = (Plan) session.getAttribute("PlanSeleccionado");
    Cliente cliente = (Cliente) session.getAttribute("clienteTemp");
    Usuario usuario = (Usuario) session.getAttribute("usuarioTemp");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AresFitness - Proceso de Pago</title>
        <link rel="icon" href="Imagenes/logo.png" type="image/png">
        <link rel="stylesheet" href="Css/pago.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="payment-container">
            <header class="payment-header">
                <a href="Index.jsp" class="logo-link">
                    <img src="Imagenes/logo.png" alt="AresFitness Logo" class="logo">
                </a>
                <div class="payment-steps">
                    <div class="step active">
                        <div class="step-number">1</div>
                        <div class="step-title">Información</div>
                    </div>
                    <div class="step active">
                        <div class="step-number">2</div>
                        <div class="step-title">Pago</div>
                    </div>
                    <div class="step">
                        <div class="step-number">3</div>
                        <div class="step-title">Confirmación</div>
                    </div>
                </div>
            </header>

            <div class="payment-content">
                <aside class="order-summary">
                    <h3>Resumen de tu Membresía</h3>
                    <div class="membership-card">
                        <div class="membership-header">
                            <h4>Membresía Elegida: <%= plan.getNombre()%></h4>
                            <div class="membership-price">
                                S/<%= plan.getPrecio() %>
                            </div>
                        </div>
                        <ul class="membership-features">
                            <li><i class="fas fa-check"></i> Duración: <%= plan.getDuracionMeses() %> mes(es)</li>
                            <li><i class="fas fa-check"></i> <%= plan.getDescripcion() %></li>
                        </ul>
                    </div>

                    <div class="membership-card mt-3">
                        <h4>Datos del Cliente</h4>
                        <ul class="membership-features">
                            <li><i class="fas fa-user"></i> <%= cliente.getNombre() %> <%= cliente.getApellido() %></li>
                            <li><i class="fas fa-venus-mars"></i> <%= cliente.getGenero() %></li>
                            <li><i class="fas fa-phone"></i> <%= cliente.getTelefono() %></li>
                            <li><i class="fas fa-envelope"></i> <%= cliente.getCorreo() %></li>
                        </ul>
                    </div>
                </aside>

                <main class="payment-form">
                    <h2>Métodos de Pago</h2>
                    <form id="formPago" action="PagoServlet" method="post">
                        <input type="hidden" name="metodoPago" id="metodoPago" value="tarjeta">
                        <div class="payment-methods">
                            <div class="method-tabs">
                                <button type="button" class="method-tab active" data-method="tarjeta">Tarjeta</button>
                                <button type="button" class="method-tab" data-method="yape">Yape</button>
                            </div>

                            <!-- Tarjeta -->
                            <div class="method-content active" id="tarjeta">
                                <div class="form-group">
                                    <label>Número de tarjeta</label>
                                    <input type="text" id="numeroTarjeta" name="numeroTarjeta" placeholder="0000 0000 0000 0000">
                                </div>
                                <div class="form-row">
                                    <input type="text" id="fechaVencimiento" name="fechaVencimiento" placeholder="MM/AA">
                                    <input type="text" id="cvv" name="cvv" placeholder="CVV">
                                </div>
                                <div class="form-group">
                                    <label>Nombre del titular</label>
                                    <input type="text" id="titular" name="titular">
                                </div>
                            </div>

                            <!-- Yape -->
                            <div class="method-content" id="yape">
                                <p>Escanea el siguiente código QR o ingresa tu número Yape:</p>
                                <img src="Imagenes/qr-yape.png" class="qr-code" alt="QR Yape">
                                <input type="text" id="numeroYape" name="numeroYape" placeholder="999999999">
                            </div>
                        </div>

                        <div class="form-group checkbox-group">
                            <input type="checkbox" id="terminos">
                            <label for="terminos">Acepto los <a href="#">Términos</a> y la <a href="#">Política</a></label>
                        </div>

                        <button type="submit" class="submit-btn">Pagar S/<%= plan.getPrecio() %></button>
                    </form>
                </main>
            </div>
        </div>

        <script>
            // Cambiar método de pago
            document.querySelectorAll('.method-tab').forEach(btn => {
                btn.addEventListener('click', () => {
                    document.querySelectorAll('.method-tab').forEach(b => b.classList.remove('active'));
                    document.querySelectorAll('.method-content').forEach(c => c.classList.remove('active'));
                    btn.classList.add('active');
                    document.getElementById(btn.dataset.method).classList.add('active');
                    document.getElementById("metodoPago").value = btn.dataset.method;
                });
            });

            // Validación
            document.getElementById("formPago").addEventListener("submit", function (event) {
                const metodo = document.getElementById("metodoPago").value;
                const terminos = document.getElementById("terminos");
                if (!terminos.checked) {
                    alert("Debes aceptar los términos y condiciones.");
                    event.preventDefault();
                    return;
                }

                if (metodo === "tarjeta") {
                    const numero = document.getElementById("numeroTarjeta").value.trim();
                    const fecha = document.getElementById("fechaVencimiento").value.trim();
                    const cvv = document.getElementById("cvv").value.trim();
                    const titular = document.getElementById("titular").value.trim();
                    if (!/^\d{16}$/.test(numero)) {
                        alert("Número de tarjeta inválido. Debe tener 16 dígitos.");
                        event.preventDefault();
                        return;
                    }
                    if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(fecha)) {
                        alert("Fecha inválida. Usa MM/AA.");
                        event.preventDefault();
                        return;
                    }
                    if (!/^\d{3}$/.test(cvv)) {
                        alert("CVV inválido.");
                        event.preventDefault();
                        return;
                    }
                    if (titular.length < 6) {
                        alert("Nombre de titular muy corto.");
                        event.preventDefault();
                        return;
                    }
                } else if (metodo === "yape") {
                    const numeroYape = document.getElementById("numeroYape").value.trim();
                    if (!/^\d{9}$/.test(numeroYape)) {
                        alert("Número Yape inválido.");
                        event.preventDefault();
                        return;
                    }
                }
            });
        </script>

    </body>
</html>
