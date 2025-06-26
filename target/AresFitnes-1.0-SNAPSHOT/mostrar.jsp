<%-- 
    Document   : mostrar
    Created on : 23 jun. 2025, 12:32:13
    Author     : ASPIRE 5 CI7 10MA
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Lista de Ejercicios</title>
    </head>
    <body>
        <h2>Lista de Ejercicios</h2>
        <div id="listaEjercicios"></div>

        <script>
            // Recibe el JSON en formato String desde el servlet
            var jsonStr = `<%= request.getAttribute("jsonEjercicios") %>`;

            // Asegúrate que no sea null o vacío
            if (jsonStr && jsonStr.trim() !== "") {
                // Parsear JSON a objeto
                var ejercicios = JSON.parse(jsonStr);

                var contenedor = document.getElementById("listaEjercicios");

                ejercicios.forEach(function (ejercicio) {
                    var div = document.createElement("div");
                    div.innerHTML = "<h3>" + ejercicio.name + "</h3>" +
                            "<p>Grupo muscular: " + ejercicio.muscle + "</p>" +
                            "<p>Tipo: " + ejercicio.type + "</p>" +
                            "<hr>";
                    contenedor.appendChild(div);
                });
            } else {
                document.getElementById("listaEjercicios").innerText = "No hay ejercicios para mostrar.";
            }
        </script>
    </body>
</html>
