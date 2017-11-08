/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejecucion;

import EstadoPrograma.OopsState;
import Ejecucion.OopsObject;
import Ejecucion.OopsMethod;
import Ejecucion.*;
import RepresentacionCodigo.*;
import java.util.HashMap;

/**
 *
 * @author pio
 */
public class OopsClass extends OopsObject {
    
    public static final OopsClass CLASS = new OopsClass("MetaClass",null); 
    
    private String identificador;
    private HashMap<String,OopsMethod> metodos;
    
    
    public OopsMethod method(String selector){
        return metodos.get(selector);
    }

    public OopsClass(String identificador, HashMap<String, OopsMethod> metodos) {
        this.identificador = identificador;
        this.metodos = metodos;
    }


    @Override
    public String toString() {
        return "OopsClass " +  identificador;
    }

    public String getIdentificador() {
        return identificador;
    }

    @Override
    public OopsObject respond(OopsState estado, String selector, OopsObject[] argumentos) {
        return this;
    }
    
    
    
}
