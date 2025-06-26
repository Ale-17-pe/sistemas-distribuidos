/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.apiweb.aresfitnes.dao;

import com.apiweb.aresfitnes.Model.Matricula;
import com.apiweb.aresfitnes.utils.ConectaBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author ASPIRE 5 CI7 10MA
 */
public class MatriculaDAO {

    private final String INSERT_SQL = "INSERT INTO matricula (id_cliente, id_plan, id_pago, fecha_inicio, fecha_fin, estado) "
            + "VALUES (?, ?, ?, ?, ?, ?)";

    public boolean insertar(Matricula matricula) throws SQLException {
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = ConectaBD.abrir();
            stmt = conn.prepareStatement(INSERT_SQL);

            stmt.setInt(1, matricula.getIdCliente());
            stmt.setInt(2, matricula.getIdPlan());
            stmt.setInt(3, matricula.getIdPago());
            stmt.setDate(4, matricula.getFechaInicio());
            stmt.setDate(5, matricula.getFechaFin());
            stmt.setString(6, matricula.getEstado());

            int filas = stmt.executeUpdate();
            return filas > 0;

        } finally {
            if (stmt != null) {
                stmt.close();
            }
            ConectaBD.cerrar(conn);
        }
    }
}
