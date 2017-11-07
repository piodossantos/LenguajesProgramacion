/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejercicio_3_3;

import Ejecucion.*;
import RepresentacionCodigo.*;
import java.util.HashMap;

/**
 *
 * @author pio
 */
public class OopsClass extends OopsObject{
    private String identificador;
    private HashMap<String,OopsMethod> metodos;
    
    @Override
    public OopsObject respond(String selector, OopsObject[] argumentos) {
        OopsObject result = null;
        OopsMethod temporal=this.metodos.get(selector);
        if (temporal!=null){
            result = temporal.evaluate(this, argumentos);
        }
        return result;
    }

    public OopsClass(String identificador, HashMap<String, OopsMethod> metodos) {
        this.identificador = identificador;
        this.metodos = metodos;
    }
    
}
