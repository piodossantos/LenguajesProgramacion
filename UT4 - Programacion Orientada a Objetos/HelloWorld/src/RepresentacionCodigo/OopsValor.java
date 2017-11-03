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
public class OopsValor extends OopsCode {
    private final OopsObject valor;

    public OopsObject getValor() {
        return valor;
    }

    public OopsValor(OopsObject valor) {
        this.valor = valor;
    }
    
    @Override
    public OopsObject evaluate(OopsState estado) {
        return this.getValor();
    }
    
}
