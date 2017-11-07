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
    
    

    
    @Override
    public  OopsObject respond(String selector, OopsObject[] argumentos) {
        OopsObject result = null;
        OopsMethod temporal=this.getClase().method(selector);
        if (temporal!=null){
            result = temporal.evaluate(this, argumentos);
        }
        return result;
    }
    
    public OopsBoolean (boolean valor){
        super( new OopsClass("OopsBoolean",new HashMap(){
            {
                put("&", new OopsAnd("&"));
                put("!", new OopsNot("!"));
                put("|", new OopsOr("|"));
                put("ifTrue",new OopsIfTrue("ifTrue"));
            }
        }));
        this.valor = valor;

    }

    public OopsBoolean(boolean valor, OopsClass clase) {
        super(clase);
        this.valor = valor;
    }
    
    
    public boolean getValor (){
        return valor;
    }


    @Override
    public String toString() {
        return this.getClase().getIdentificador()+" " + valor;
    }
    
    
    
    
    
    
}
