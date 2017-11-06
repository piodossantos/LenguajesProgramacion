package Ejecucion;


import Ejecucion.OopsMethod;
import Ejecucion.OopsObject;
import java.util.HashMap;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pio
*/

public class OopsBoolean extends OopsObject {
  
    private final boolean valor;
    
    private static final HashMap<String,OopsMethod> metodos = new HashMap<>();
    static{
        metodos.put("&", new OopsAnd("&"));
        metodos.put("!", new OopsNot("!"));
        metodos.put("|", new OopsOr("|"));
    }
    
    @Override
    public  OopsObject respond(String selector, OopsObject[] argumentos) {
        OopsObject result = null;
        OopsMethod temporal=OopsBoolean.metodos.get(selector);
        if (temporal!=null){
            result = temporal.evaluate(this, argumentos);
        }
        return result;
    }
    
    public OopsBoolean (boolean valor){
        this.valor = valor;
    }
    
    public boolean getValor (){
        return valor;
    }


    @Override
    public String toString() {
        return "Boolean " + valor;
    }
    
    
    
    
    
    
}
