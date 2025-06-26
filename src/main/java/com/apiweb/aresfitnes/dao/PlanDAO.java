/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.apiweb.aresfitnes.dao;

import com.apiweb.aresfitnes.Model.Plan;
import com.apiweb.aresfitnes.utils.ConectaBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ASPIRE 5 CI7 10MA
 */
public class PlanDAO {

    public List<Plan> obtenerTodos() {
        List<Plan> lista = new ArrayList<>();
        String sql = "SELECT * FROM plan";
        Connection conn = null;

        try {
            conn = ConectaBD.abrir();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Plan p = new Plan();
                p.setIdPlan(rs.getInt("id_plan"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setDuracionMeses(rs.getInt("duracion_meses"));
                p.setPrecio(rs.getDouble("precio"));
                lista.add(p);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            ConectaBD.cerrar(conn); // ahora sí se cierra bien
        }

        return lista;
    }

    private final String SELECT_BY_ID = "SELECT id_plan, nombre, descripcion, duracion_meses, precio FROM plan WHERE id_plan = ?";

    public Plan obtenerPorId(int idPlan) throws SQLException {
        Plan plan = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConectaBD.abrir();
            stmt = conn.prepareStatement(SELECT_BY_ID);
            stmt.setInt(1, idPlan);
            rs = stmt.executeQuery();

            if (rs.next()) {
                plan = new Plan();
                plan.setIdPlan(rs.getInt("id_plan"));
                plan.setNombre(rs.getString("nombre"));
                plan.setDescripcion(rs.getString("descripcion"));
                plan.setDuracionMeses(rs.getInt("duracion_meses"));
                plan.setPrecio(rs.getDouble("precio"));
            }
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            ConectaBD.cerrar(conn);
        }

        return plan;
    }
}
