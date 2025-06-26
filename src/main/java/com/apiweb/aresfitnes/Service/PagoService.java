/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.apiweb.aresfitnes.Service;

import com.apiweb.aresfitnes.dto.ResultadoPagoDTO;

/**
 *
 * @author ASPIRE 5 CI7 10MA
 */
public class PagoService {

     public ResultadoPagoDTO validarPago(String metodo, String numeroTarjeta, String fecha, String cvv, String titular, String numeroYape) {
        if ("tarjeta".equals(metodo)) {
            if (numeroTarjeta != null && numeroTarjeta.matches("\\d{16}")
                    && cvv != null && cvv.matches("\\d{3}")
                    && fecha != null && fecha.matches("^(0[1-9]|1[0-2])/\\d{2}$")
                    && titular != null && titular.trim().length() >= 6) {
                return new ResultadoPagoDTO(true, "VISA-" + System.currentTimeMillis());
            }
        } else if ("yape".equals(metodo)) {
            if (numeroYape != null && numeroYape.matches("\\d{9}")) {
                return new ResultadoPagoDTO(true, "YAPE-" + numeroYape);
            }
        }

        return new ResultadoPagoDTO(false, null);
    }

    
}