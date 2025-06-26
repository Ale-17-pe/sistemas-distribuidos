<%-- 
    Document   : ejercicios
    Created on : 23 jun. 2025, 12:09:58
    Author     : ASPIRE 5 CI7 10MA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="com.apiweb.aresfitnes.Model.Ejercicio"%>
<%
    List<Ejercicio> ejercicios = (List<Ejercicio>) request.getAttribute("listaEjercicios");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ejecricios</title>
    </head>
    <body>
        <h2>Lista de Ejercicios</h2>
<ul>
    <% for (Ejercicio e : ejercicios) { %>
        <li>
            <strong><%= e.getNombre() %></strong> (<%= e.getGrupoMuscular() %>)<br>
            <%= e.getDescripcion() %> - <%= e.getDuracion() %>
        </li>
    <% } %>
</ul>
    </body>
</html>
