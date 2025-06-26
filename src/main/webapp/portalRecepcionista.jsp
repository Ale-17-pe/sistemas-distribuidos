<%-- 
    Document   : portalRecepcionista
    Created on : 22 jun. 2025, 20:57:19
    Author     : ASPIRE 5 CI7 10MA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.apiweb.aresfitnes.Model.Usuario"%>
<%@page session="true"%>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuarioLogeado");
    if (usuario == null) {
        response.sendRedirect("login.jsp?error=no_autenticado");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>AresFitness - Recepcionista</title>
        <link rel="stylesheet" href="Css/recepcion.css">
        <link rel="icon" href="Imagenes/logo.png" type="image/png">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    </head>
    <body>
        <div class="reception-container">
            <!-- Sidebar -->
            <aside class="reception-sidebar">
                <div class="sidebar-header">
                    <a href="index.jsp"><img src="Imagenes/logo.png" alt="Logo AresFitness" class="reception-logo"></a>
                    <h2>Panel de Recepcionista</h2>
                </div>

                <nav class="sidebar-nav">
                    <ul>
                        <li class="active" data-section="dashboard">
                            <a href="#">
                                <i class="fas fa-tachometer-alt"></i>
                                <span>Inicio</span>
                            </a>
                        </li>
                        <li data-section="asistencias">
                            <a href="#">
                                <i class="fas fa-clipboard-check"></i>
                                <span>Registro Asistencias</span>
                            </a>
                        </li>
                        <li data-section="clientes">
                            <a href="#">
                                <i class="fas fa-users"></i>
                                <span>Clientes</span>
                            </a>
                        </li>
                        <li data-section="pagos">
                            <a href="#">
                                <i class="fas fa-cash-register"></i>
                                <span>Registro de Pagos</span>
                            </a>
                        </li>
                    </ul>
                </nav>

                <div class="sidebar-footer">
                    <div class="reception-profile">
                        <img src="Imagenes/Imagen 2.jpg" alt="Reception Avatar">
                        <div class="profile-info">
                            <strong>Recepcionista</strong>
                            <small>Turno MaÃ±ana</small>
                        </div>
                    </div>
                    <a href="LogoutServlet" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Cerrar SesiÃ³n</span>
                    </a>
                </div>
            </aside>

            <!-- Main Content -->
            <main class="reception-main">
                <header class="reception-header">
                    <div class="header-left">
                        <button class="menu-toggle">
                            <i class="fas fa-bars"></i>
                        </button>
                        <h1 id="section-title">Inicio</h1>
                    </div>

                    <div class="header-right">
                        <div class="search-box">
                            <input type="text" placeholder="Buscar cliente..." id="client-search">
                            <button><i class="fas fa-search"></i></button>
                        </div>
                        <div class="notifications">
                            <button class="notification-btn">
                                <i class="fas fa-bell"></i>
                                <span class="badge danger">2</span>
                            </button>
                        </div>
                    </div>
                </header>

                <div class="reception-content">
                    <!-- SecciÃ³n Inicio (Dashboard) -->
                    <section class="content-section" id="dashboard-section">
                        <div class="stats-section">
                            <div class="stat-card">
                                <div class="stat-icon primary">
                                    <i class="fas fa-user-clock"></i>
                                </div>
                                <div class="stat-info">
                                    <h3 id="current-checkins">0</h3>
                                    <p>Clientes actuales</p>
                                </div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon success">
                                    <i class="fas fa-clipboard-list"></i>
                                </div>
                                <div class="stat-info">
                                    <h3 id="today-checkins">0</h3>
                                    <p>Asistencias hoy</p>
                                </div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon warning">
                                    <i class="fas fa-exclamation-circle"></i>
                                </div>
                                <div class="stat-info">
                                    <h3 id="expiring-memberships">0</h3>
                                    <p>MembresÃ­as por vencer</p>
                                </div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-icon info">
                                    <i class="fas fa-dumbbell"></i>
                                </div>
                                <div class="stat-info">
                                    <h3 id="next-class">-</h3>
                                    <p>PrÃ³xima clase</p>
                                </div>
                            </div>
                        </div>

                        <div class="quick-actions">
                            <h3>Acciones rÃ¡pidas</h3>
                            <div class="action-buttons">
                                <button class="action-btn large" id="quick-checkin">
                                    <i class="fas fa-user-plus"></i>
                                    <span>Registrar asistencia</span>
                                </button>
                                <button class="action-btn large" id="quick-payment">
                                    <i class="fas fa-money-bill-wave"></i>
                                    <span>Registrar pago</span>
                                </button>
                                <button class="action-btn large" id="quick-client">
                                    <i class="fas fa-user-edit"></i>
                                    <span>Agregar cliente</span>
                                </button>
                            </div>
                        </div>

                        <div class="current-clients">
                            <div class="section-header">
                                <h3>Clientes actuales en el gimnasio</h3>
                                <button class="secondary-btn small" id="refresh-clients">
                                    <i class="fas fa-sync-alt"></i>
                                    <span>Actualizar</span>
                                </button>
                            </div>
                            <div class="clients-grid" id="current-clients-list">
                                <!-- Clientes se cargarÃ¡n dinÃ¡micamente -->
                                <div class="empty-state">
                                    <i class="fas fa-user-slash"></i>
                                    <p>No hay clientes en el gimnasio actualmente</p>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- SecciÃ³n Registro de Asistencias -->
                    <section class="content-section" id="asistencias-section" style="display:none;">
                        <div class="section-header">
                            <h3>Registro de Asistencias</h3>
                            <button class="primary-btn small" id="new-checkin">
                                <i class="fas fa-plus"></i>
                                <span>Nuevo registro</span>
                            </button>
                        </div>

                        <div class="checkin-methods">
                            <div class="method-card active" data-method="manual">
                                <i class="fas fa-keyboard"></i>
                                <h4>Manual</h4>
                                <p>Buscar cliente por nombre o ID</p>
                            </div>
                            <div class="method-card" data-method="qr">
                                <i class="fas fa-qrcode"></i>
                                <h4>EscÃ¡ner QR</h4>
                                <p>Escanear cÃ³digo de membresÃ­a</p>
                            </div>
                            <div class="method-card" data-method="biometric">
                                <i class="fas fa-fingerprint"></i>
                                <h4>BiomÃ©trico</h4>
                                <p>Registro por huella digital</p>
                            </div>
                        </div>

                        <div class="manual-checkin" id="manual-checkin-form">
                            <div class="form-group">
                                <label for="client-search-checkin">Buscar cliente:</label>
                                <div class="search-combo">
                                    <input type="text" id="client-search-checkin" placeholder="Nombre, apellido o ID de cliente">
                                    <button class="search-btn"><i class="fas fa-search"></i></button>
                                </div>
                            </div>

                            <div class="client-results" id="client-results-container" style="display:none;">
                                <table class="client-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Nombre</th>
                                            <th>MembresÃ­a</th>
                                            <th>Estado</th>
                                            <th>AcciÃ³n</th>
                                        </tr>
                                    </thead>
                                    <tbody id="client-results-body">
                                        <!-- Resultados de bÃºsqueda se cargarÃ¡n aquÃ­ -->
                                    </tbody>
                                </table>
                            </div>

                            <div class="selected-client" id="selected-client-container" style="display:none;">
                                <div class="client-info">
                                    <img src="../Imagenes/user-default.jpg" alt="Foto cliente" id="checkin-client-img">
                                    <div class="client-details">
                                        <h4 id="checkin-client-name">-</h4>
                                        <p>ID: <span id="checkin-client-id">-</span></p>
                                        <p>MembresÃ­a: <span id="checkin-client-membership">-</span></p>
                                        <p>Vencimiento: <span id="checkin-client-expiry">-</span></p>
                                    </div>
                                </div>
                                <button class="primary-btn" id="confirm-checkin">
                                    <i class="fas fa-check-circle"></i>
                                    <span>Confirmar asistencia</span>
                                </button>
                            </div>
                        </div>

                        <div class="qr-checkin" id="qr-checkin-form" style="display:none;">
                            <div class="qr-scanner-container">
                                <div class="qr-scanner" id="qr-scanner">
                                    <div class="scanner-placeholder">
                                        <i class="fas fa-qrcode"></i>
                                        <p>Activando cÃ¡mara para escanear cÃ³digo QR...</p>
                                    </div>
                                </div>
                                <div class="scanner-instructions">
                                    <h4>Instrucciones:</h4>
                                    <ol>
                                        <li>Pida al cliente que muestre su cÃ³digo QR (app o tarjeta fÃ­sica)</li>
                                        <li>Enfocar el cÃ³digo dentro del Ã¡rea delimitada</li>
                                        <li>El sistema registrarÃ¡ automÃ¡ticamente la asistencia</li>
                                    </ol>
                                    <button class="secondary-btn">
                                        <i class="fas fa-question-circle"></i>
                                        <span>Ayuda</span>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="biometric-checkin" id="biometric-checkin-form" style="display:none;">
                            <div class="biometric-container">
                                <div class="fingerprint-reader">
                                    <i class="fas fa-fingerprint"></i>
                                    <p>Coloque su dedo en el lector</p>
                                </div>
                                <div class="biometric-instructions">
                                    <h4>Instrucciones:</h4>
                                    <ol>
                                        <li>El cliente debe registrar su huella previamente en el sistema</li>
                                        <li>Colocar el dedo Ã­ndice en el lector biomÃ©trico</li>
                                        <li>Mantener hasta que se confirme el registro</li>
                                    </ol>
                                    <button class="secondary-btn">
                                        <i class="fas fa-question-circle"></i>
                                        <span>Ayuda</span>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="today-checkins">
                            <div class="section-header">
                                <h3>Asistencias registradas hoy</h3>
                                <button class="secondary-btn small">
                                    <i class="fas fa-print"></i>
                                    <span>Imprimir reporte</span>
                                </button>
                            </div>
                            <div class="table-responsive">
                                <table class="checkin-table">
                                    <thead>
                                        <tr>
                                            <th>Hora</th>
                                            <th>Cliente</th>
                                            <th>MÃ©todo</th>
                                            <th>DuraciÃ³n</th>
                                            <th>Recepcionista</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>08:15 AM</td>
                                            <td>
                                                <div class="user-info">
                                                    <img src="../Imagenes/user1.jpg" alt="User 1">
                                                    <span>Juan PÃ©rez</span>
                                                </div>
                                            </td>
                                            <td><span class="badge primary">QR</span></td>
                                            <td>1h 25m</td>
                                            <td>MarÃ­a GÃ³mez</td>
                                        </tr>
                                        <!-- MÃ¡s registros de asistencias -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>

                    <!-- SecciÃ³n Clientes -->
                    <section class="content-section" id="clientes-section" style="display:none;">
                        <div class="section-header">
                            <h3>GestiÃ³n de Clientes</h3>
                            <button class="primary-btn small" id="new-client-btn">
                                <i class="fas fa-user-plus"></i>
                                <span>Nuevo cliente</span>
                            </button>
                        </div>

                        <div class="filters-bar">
                            <div class="filter-group">
                                <label for="client-filter">Filtrar por:</label>
                                <select id="client-filter">
                                    <option>Todos</option>
                                    <option>Activos</option>
                                    <option>Inactivos</option>
                                    <option>MembresÃ­a por vencer</option>
                                </select>
                            </div>

                            <div class="filter-group">
                                <label for="client-sort">Ordenar por:</label>
                                <select id="client-sort">
                                    <option>Nombre</option>
                                    <option>Fecha registro</option>
                                    <option>MembresÃ­a</option>
                                    <option>Vencimiento</option>
                                </select>
                            </div>

                            <div class="search-group">
                                <input type="text" placeholder="Buscar clientes..." id="client-search-input">
                                <button><i class="fas fa-search"></i></button>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="client-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre</th>
                                        <th>Contacto</th>
                                        <th>MembresÃ­a</th>
                                        <th>Vencimiento</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>#1001</td>
                                        <td>
                                            <div class="user-info">
                                                <img src="../Imagenes/user1.jpg" alt="User 1">
                                                <span>Juan PÃ©rez</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="contact-info">
                                                <span>juan.perez@example.com</span>
                                                <small>987654321</small>
                                            </div>
                                        </td>
                                        <td>Premium</td>
                                        <td>15/06/2024</td>
                                        <td><span class="status-badge active">Activo</span></td>
                                        <td>
                                            <button class="action-btn view"><i class="fas fa-eye"></i></button>
                                            <button class="action-btn edit"><i class="fas fa-edit"></i></button>
                                        </td>
                                    </tr>
                                    <!-- MÃ¡s filas de clientes -->
                                </tbody>
                            </table>
                        </div>

                        <div class="pagination">
                            <button class="pagination-btn disabled"><i class="fas fa-chevron-left"></i></button>
                            <button class="pagination-btn active">1</button>
                            <button class="pagination-btn">2</button>
                            <button class="pagination-btn">3</button>
                            <button class="pagination-btn"><i class="fas fa-chevron-right"></i></button>
                        </div>
                    </section>

                    <!-- SecciÃ³n Registro de Pagos -->
                    <section class="content-section" id="pagos-section" style="display:none;">
                        <div class="section-header">
                            <h3>Registro de Pagos</h3>
                            <button class="primary-btn small" id="new-payment-btn">
                                <i class="fas fa-plus"></i>
                                <span>Nuevo pago</span>
                            </button>
                        </div>

                        <div class="payment-form-container" id="payment-form-container" style="display:none;">
                            <form id="payment-form">
                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="payment-client">Cliente:</label>
                                        <div class="search-combo">
                                            <input type="text" id="payment-client" placeholder="Buscar cliente...">
                                            <button type="button" class="search-btn"><i class="fas fa-search"></i></button>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="payment-type">Tipo de pago:</label>
                                        <select id="payment-type">
                                            <option value="">Seleccionar...</option>
                                            <option value="membership">MembresÃ­a</option>
                                            <option value="product">Producto</option>
                                            <option value="service">Servicio</option>
                                            <option value="other">Otro</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="payment-amount">Monto (S/):</label>
                                        <input type="number" id="payment-amount" step="0.01" min="0">
                                    </div>

                                    <div class="form-group">
                                        <label for="payment-method">MÃ©todo de pago:</label>
                                        <select id="payment-method">
                                            <option value="cash">Efectivo</option>
                                            <option value="credit">Tarjeta CrÃ©dito</option>
                                            <option value="debit">Tarjeta DÃ©bito</option>
                                            <option value="transfer">Transferencia</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="payment-notes">Notas:</label>
                                    <textarea id="payment-notes" rows="2"></textarea>
                                </div>

                                <div class="form-actions">
                                    <button type="button" class="secondary-btn" id="cancel-payment">Cancelar</button>
                                    <button type="submit" class="primary-btn">Registrar pago</button>
                                </div>
                            </form>
                        </div>

                        <div class="today-payments">
                            <div class="section-header">
                                <h3>Pagos registrados hoy</h3>
                                <div class="total-payments">
                                    <span>Total hoy:</span>
                                    <strong>S/ 1,245.50</strong>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="payment-table">
                                    <thead>
                                        <tr>
                                            <th>Hora</th>
                                            <th>Cliente</th>
                                            <th>Tipo</th>
                                            <th>Monto</th>
                                            <th>MÃ©todo</th>
                                            <th>Recepcionista</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>09:30 AM</td>
                                            <td>Juan PÃ©rez</td>
                                            <td>MembresÃ­a Premium</td>
                                            <td>S/ 89.00</td>
                                            <td><span class="badge success">Tarjeta</span></td>
                                            <td>MarÃ­a GÃ³mez</td>
                                            <td>
                                                <button class="action-btn view"><i class="fas fa-receipt"></i></button>
                                            </td>
                                        </tr>
                                        <!-- MÃ¡s registros de pagos -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </section>

                    <!-- SecciÃ³n Horarios de Clases -->
                    <section class="content-section" id="horarios-section" style="display:none;">
                        <div class="section-header">
                            <h3>Horarios de Clases</h3>
                            <div class="date-navigation">
                                <button class="nav-btn"><i class="fas fa-chevron-left"></i></button>
                                <span class="current-week">Semana del 20 al 26 de Mayo</span>
                                <button class="nav-btn"><i class="fas fa-chevron-right"></i></button>
                            </div>
                        </div>

                        <div class="schedule-view">
                            <div class="schedule-filters">
                                <div class="filter-group">
                                    <label for="class-type">Tipo de clase:</label>
                                    <select id="class-type">
                                        <option value="">Todas</option>
                                        <option value="yoga">Yoga</option>
                                        <option value="spinning">Spinning</option>
                                        <option value="crossfit">CrossFit</option>
                                        <option value="zumba">Zumba</option>
                                        <option value="pilates">Pilates</option>
                                    </select>
                                </div>

                                <div class="filter-group">
                                    <label for="class-instructor">Instructor:</label>
                                    <select id="class-instructor">
                                        <option value="">Todos</option>
                                        <option value="1">Carlos RodrÃ­guez</option>
                                        <option value="2">Ana MartÃ­nez</option>
                                        <option value="3">Luis GarcÃ­a</option>
                                    </select>
                                </div>
                            </div>

                            <div class="weekly-schedule">
                                <div class="schedule-header">
                                    <div class="day-header">Hora</div>
                                    <div class="day-header">Lunes</div>
                                    <div class="day-header">Martes</div>
                                    <div class="day-header">MiÃ©rcoles</div>
                                    <div class="day-header">Jueves</div>
                                    <div class="day-header">Viernes</div>
                                    <div class="day-header">SÃ¡bado</div>
                                </div>

                                <div class="schedule-body">
                                    <!-- Filas de horarios se generarÃ¡n dinÃ¡micamente -->
                                    <div class="time-slot">
                                        <div class="time-cell">6:00 AM</div>
                                        <div class="day-cell">
                                            <div class="class-event yoga">
                                                <span class="class-title">Yoga Matutino</span>
                                                <span class="class-instructor">Ana MartÃ­nez</span>
                                                <span class="class-capacity">12/15</span>
                                            </div>
                                        </div>
                                        <div class="day-cell"></div>
                                        <div class="day-cell">
                                            <div class="class-event yoga">
                                                <span class="class-title">Yoga Matutino</span>
                                                <span class="class-instructor">Ana MartÃ­nez</span>
                                                <span class="class-capacity">8/15</span>
                                            </div>
                                        </div>
                                        <div class="day-cell"></div>
                                        <div class="day-cell"></div>
                                        <div class="day-cell"></div>
                                    </div>

                                    <!-- MÃ¡s filas de horarios -->
                                </div>
                            </div>
                        </div>

                        <div class="class-details" id="class-details-container" style="display:none;">
                            <div class="details-header">
                                <h4 id="class-detail-title">Yoga Matutino</h4>
                                <button class="close-details"><i class="fas fa-times"></i></button>
                            </div>

                            <div class="details-content">
                                <div class="detail-row">
                                    <span class="detail-label">Instructor:</span>
                                    <span class="detail-value" id="class-detail-instructor">Ana MartÃ­nez</span>
                                </div>

                                <div class="detail-row">
                                    <span class="detail-label">Horario:</span>
                                    <span class="detail-value" id="class-detail-time">Lunes y MiÃ©rcoles, 6:00 AM - 7:00 AM</span>
                                </div>

                                <div class="detail-row">
                                    <span class="detail-label">Capacidad:</span>
                                    <span class="detail-value" id="class-detail-capacity">12/15 inscritos</span>
                                </div>

                                <div class="detail-row">
                                    <span class="detail-label">Requisitos:</span>
                                    <span class="detail-value" id="class-detail-requirements">Traer tapete y toalla</span>
                                </div>

                                <div class="registered-clients">
                                    <h5>Clientes inscritos</h5>
                                    <div class="clients-list" id="class-clients-list">
                                        <!-- Lista de clientes inscritos -->
                                    </div>
                                </div>
                            </div>

                            <div class="details-actions">
                                <button class="secondary-btn">
                                    <i class="fas fa-print"></i>
                                    <span>Lista de asistencia</span>
                                </button>
                                <button class="primary-btn">
                                    <i class="fas fa-user-plus"></i>
                                    <span>Inscribir cliente</span>
                                </button>
                            </div>
                        </div>
                    </section>
                </div>
            </main>
        </div>

        <script src="JS/recepcioista.js"></script>
    </body>
</html>
