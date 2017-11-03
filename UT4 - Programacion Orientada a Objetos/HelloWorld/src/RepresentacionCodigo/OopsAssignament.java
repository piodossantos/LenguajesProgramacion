package RepresentacionCodigo;


import Ejecucion.OopsObject;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pio
 */
public class OopsAssignament extends OopsCode{
    String identificador;
    OopsCode valor;

    public OopsAssignament(String identificador, OopsCode valor) {
        this.identificador = identificador;
        this.valor = valor;
    }

    public String getIdentificador() {
        return identificador;
    }

    public void setIdentificador(String identificador) {
        this.identificador = identificador;
    }

    public OopsCode getValor() {
        return valor;
    }

    public void setValor(OopsCode valor) {
        this.valor = valor;
    }
    
    @Override
    public OopsObject evaluate(OopsState estado) {
        OopsObject cualquiera = valor.evaluate(estado);
        estado.getEstado().put(identificador, cualquiera);
        return cualquiera;
    }
    
}
