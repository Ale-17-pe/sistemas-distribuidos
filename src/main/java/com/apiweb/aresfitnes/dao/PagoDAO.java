/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.apiweb.aresfitnes.dao;

import com.apiweb.aresfitnes.Model.Pago;
import com.apiweb.aresfitnes.utils.ConectaBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author ASPIRE 5 CI7 10MA
 */
public class PagoDAO {
    private final String INSERT_SQL = "INSERT INTO pago (fecha_pago, monto, metodo_pago, referencia_pago, estado_pago) "
            + "VALUES (?, ?, ?, ?, ?)";

    public int insertar(Pago pago) throws SQLException {
        int idGenerado = -1;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConectaBD.abrir();
            stmt = conn.prepareStatement(INSERT_SQL, Statement.RETURN_GENERATED_KEYS);

            // Para fecha, si usas java.util.Date:
            // stmt.setTimestamp(1, new java.sql.Timestamp(pago.getFechaPago().getTime()));

            // Si usas LocalDateTime en Pago:
            // stmt.setTimestamp(1, java.sql.Timestamp.valueOf(pago.getFechaPago()));

            // Aquí te pongo para java.util.Date, cambia según tu implementación:
            stmt.setTimestamp(1, pago.getFechaPago());
            stmt.setDouble(2, pago.getMonto());
            stmt.setString(3, pago.getMetodoPago());
            stmt.setString(4, pago.getReferenciaPago());
            stmt.setString(5, pago.getEstadoPago());

            int filas = stmt.executeUpdate();

            if (filas > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    idGenerado = rs.getInt(1);
                }
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            ConectaBD.cerrar(conn);
        }

        return idGenerado;
    }
}
