package Ejecucion;


import Ejecucion.OopsMethod;
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
public class OopsDistinto extends OopsMethod {

    public OopsDistinto(String selector) {
        super(selector);
    }

    
    @Override
    public OopsObject evaluate(OopsObject self, OopsObject[] argumentos) {
        return new OopsBoolean(((OopsInteger)self).getValor()!=
                ((OopsInteger)argumentos[0]).getValor());
    }
    
}
