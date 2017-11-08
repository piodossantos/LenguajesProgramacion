package Ejecucion;


import EstadoPrograma.OopsState;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pio
 */
public class OopsNot extends OopsMethod {

    public OopsNot(String selector) {
        super(selector);
    }

    
    @Override
    public OopsObject evaluate(OopsState estado, OopsObject self, OopsObject[] argumentos) {
        return new OopsBoolean(!((OopsBoolean)self).getValor());
    }
    
}
