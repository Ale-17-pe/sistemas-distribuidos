/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.apiweb.aresfitnes.dto;

/**
 *
 * @author ASPIRE 5 CI7 10MA
 */
public class ResultadoPagoDTO {
    private boolean valido;
    private String referencia;

    public ResultadoPagoDTO(boolean valido, String referencia) {
        this.valido = valido;
        this.referencia = referencia;
    }

    public boolean isValido() {
        return valido;
    }

    public String getReferencia() {
        return referencia;
    }
}
