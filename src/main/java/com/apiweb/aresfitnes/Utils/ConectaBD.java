package com.apiweb.aresfitnes.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConectaBD {

    private static final String URL = "jdbc:mysql://localhost:3306/aresfitnes";
    private static final String USUARIO = "root";
    private static final String PASSWORD = "tyu123onepiece";

    public static Connection abrir() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Nueva versión
            conn = DriverManager.getConnection(URL, USUARIO, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error al conectar a la BD:");
            e.printStackTrace();
        }
        return conn;
    }

    public static void cerrar(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            System.out.println("Error al cerrar la conexión:");
            e.printStackTrace();
        }
    }
}
