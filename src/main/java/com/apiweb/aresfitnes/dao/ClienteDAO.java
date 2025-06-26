/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.apiweb.aresfitnes.dao;

import com.apiweb.aresfitnes.Model.Cliente;
import com.apiweb.aresfitnes.Model.Usuario;
import com.apiweb.aresfitnes.dto.ClienteDTO;
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
public class ClienteDAO {

    public int insertar(Cliente cliente) throws SQLException {
        int idGenerado = -1;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        String INSERT_SQL = "INSERT INTO cliente (id_usuario, nombre, apellido, correo, telefono, direccion, fecha_nacimiento, genero) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn = ConectaBD.abrir();
            stmt = conn.prepareStatement(INSERT_SQL, Statement.RETURN_GENERATED_KEYS);

            stmt.setInt(1, cliente.getIdUsuario());
            stmt.setString(2, cliente.getNombre());
            stmt.setString(3, cliente.getApellido());
            stmt.setString(4, cliente.getCorreo());
            stmt.setString(5, cliente.getTelefono());
            stmt.setString(6, cliente.getDireccion());
            stmt.setDate(7, cliente.getFechaNacimiento());
            stmt.setString(8, cliente.getGenero());

            int filas = stmt.executeUpdate();

            if (filas > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    idGenerado = rs.getInt(1);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            ConectaBD.cerrar(conn);
        }
        return idGenerado;
    }

    public Cliente buscarPorIdUsuario(int idUsuario) {
        Cliente cliente = null;

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConectaBD.abrir();
            String sql = "SELECT * FROM cliente WHERE id_usuario = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUsuario);
            rs = stmt.executeQuery();

            if (rs.next()) {
                cliente = new Cliente();
                cliente.setIdCliente(rs.getInt("id_cliente")); // corregido
                cliente.setIdUsuario(rs.getInt("id_usuario")); // corregido
                cliente.setNombre(rs.getString("nombre"));
                cliente.setApellido(rs.getString("apellido"));
                cliente.setCorreo(rs.getString("correo"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setDireccion(rs.getString("direccion"));
                cliente.setFechaNacimiento(rs.getDate("fecha_nacimiento")); // corregido
                cliente.setGenero(rs.getString("genero"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                ConectaBD.cerrar(conn);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return cliente;
    }

}
