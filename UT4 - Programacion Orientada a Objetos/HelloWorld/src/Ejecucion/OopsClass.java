/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejecucion;

import Ejecucion.*;
import RepresentacionCodigo.*;
import java.util.HashMap;

/**
 *
 * @author pio
 */
public class OopsClass{
    
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
    
    
    
}
