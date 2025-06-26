/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.apiweb.aresfitnes.Service;

import com.apiweb.aresfitnes.Model.Cliente;
import com.apiweb.aresfitnes.Model.Usuario;

import java.time.LocalDate;
import java.time.Period;

public class ClienteService {

    /**
     * Valida que el cliente y usuario cumplen con las reglas de negocio
     *
     * @param cliente Objeto Cliente con los datos a validar
     * @param usuario Objeto Usuario con los datos a validar
     * @return true si pasa todas las validaciones, false si falla alguna
     */
    public boolean validarCliente(Cliente cliente, Usuario usuario) {
        if (!validarDni(usuario.getDni())) {
            System.out.println("DNI inválido.");
            return false;
        }

        if (!validarTelefono(cliente.getTelefono())) {
            System.out.println("Teléfono inválido.");
            return false;
        }

        if (!esMayorDeEdad(cliente.getFechaNacimiento())) {
            System.out.println("El cliente debe ser mayor de 18 años.");
            return false;
        }

        if (!validarDireccion(cliente.getDireccion())) {
            System.out.println("Dirección inválida.");
            return false;
        }

        if (!validarContrasena(usuario.getContraseña())) {
            System.out.println("Contraseña inválida.");
            return false;
        }

        return true;
    }

    /**
     * DNI debe tener exactamente 8 dígitos numéricos
     */
    public boolean validarDni(String dni) {
        if (dni == null) {
            return false;
        }
        return dni.matches("\\d{8}");
    }

    /**
     * Teléfono debe tener exactamente 9 dígitos numéricos
     */
    public boolean validarTelefono(String telefono) {
        if (telefono == null) {
            return false;
        }
        return telefono.matches("\\d{9}");
    }

    /**
     * La persona debe ser mayor o igual a 18 años
     */
    public boolean esMayorDeEdad(java.sql.Date fechaNacimiento) {
        if (fechaNacimiento == null) {
            return false;
        }

        LocalDate fechaNac = fechaNacimiento.toLocalDate(); // ✅ esto sí es válido
        LocalDate hoy = LocalDate.now();
        Period edad = Period.between(fechaNac, hoy);
        return edad.getYears() >= 18;
    }

    /**
     * La dirección debe tener al menos 5 caracteres y no estar vacía
     */
    public boolean validarDireccion(String direccion) {
        if (direccion == null) {
            return false;
        }
        return direccion.trim().length() >= 5;
    }

    /**
     * Contraseña debe tener al menos 8 caracteres
     */
    public boolean validarContrasena(String contrasena) {
        if (contrasena == null) {
            return false;
        }
        return contrasena.length() >= 8;
    }

    /**
     * Valida que dos contraseñas coincidan
     */
    public boolean contrasenasCoinciden(String contrasena, String confirmar) {
        if (contrasena == null || confirmar == null) {
            return false;
        }
        return contrasena.equals(confirmar);
    }
}
