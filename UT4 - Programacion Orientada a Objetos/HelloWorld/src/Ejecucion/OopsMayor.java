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
public class OopsMayor extends OopsMethod {

    public OopsMayor(String selector) {
        super(selector);
    }

    
    @Override
    public OopsObject evaluate(OopsState estado, OopsObject self, OopsObject[] argumentos) {
        return new OopsBoolean(((OopsInteger)self).getValor()>
                ((OopsInteger)argumentos[0]).getValor());
    }
    
}

