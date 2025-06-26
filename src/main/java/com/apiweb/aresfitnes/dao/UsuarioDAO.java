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
public class UsuarioDAO {

    private final String INSERT_SQL = "INSERT INTO usuario (dni, contraseña, tipo_usuario) VALUES (?, ?, ?)";

    // Inserta usuario y retorna el id generado
    public int insertar(Usuario usuario) throws SQLException {
        int idGenerado = -1;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = ConectaBD.abrir();
            stmt = conn.prepareStatement(INSERT_SQL, Statement.RETURN_GENERATED_KEYS);

            stmt.setString(1, usuario.getDni());
            stmt.setString(2, usuario.getContraseña());
            stmt.setString(3, usuario.getTipoUsuario());

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

    // (Opcional) Verifica si ya existe un usuario con ese DNI
    public boolean existeDni(String dni) throws SQLException {
        String sql = "SELECT COUNT(*) FROM usuario WHERE dni = ?";
        try (Connection conn = ConectaBD.abrir(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, dni);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    
    public Usuario validar(String dni, String contrasena) throws SQLException {
        Usuario usuario = null;

        Connection conn = ConectaBD.abrir();
        String sql = "SELECT * FROM usuario WHERE dni = ? AND contraseña = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, dni);
        stmt.setString(2, contrasena);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            usuario = new Usuario();
            usuario.setIdUsuario(rs.getInt("id_usuario"));
            usuario.setDni(rs.getString("dni"));
            usuario.setContraseña(rs.getString("contraseña"));
            usuario.setTipoUsuario(rs.getString("tipo_usuario"));
        }

        ConectaBD.cerrar(conn);
        return usuario;
    }
    
    
    public ClienteDTO obetenerClienteDTO(Usuario usuario) {
    ClienteDAO clienteDAO = new ClienteDAO();
    
    // Buscar cliente por el idUsuario
    Cliente cliente = clienteDAO.buscarPorIdUsuario(usuario.getIdUsuario());

    // Si encuentra el cliente, construir y devolver el DTO
    if (cliente != null) {
        return new ClienteDTO(
            cliente.getNombre(),
            cliente.getApellido(),
            cliente.getCorreo(),
            cliente.getTelefono(),
            cliente.getDireccion(),
            cliente.getFechaNacimiento(),
            cliente.getGenero(),
            usuario.getDni()
        );
    }

    return null; // o puedes lanzar una excepción si lo prefieres
}
}
