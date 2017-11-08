package Ejecucion;


import EstadoPrograma.OopsState;
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
    
    public static final OopsClass CLASS = new OopsClass("OopsBoolean",new HashMap(){{
            
                put("&", new OopsAnd("&"));
                put("!", new OopsNot("!"));
                put("|", new OopsOr("|"));
                put("IF",new OopsIF("IF"));
            
        }});

    
    @Override
    public  OopsObject respond(OopsState estado, String selector, OopsObject[] argumentos) {
        OopsObject result = null;
        OopsMethod temporal=OopsBoolean.CLASS.method(selector);
        if (temporal!=null){
            result = temporal.evaluate(estado,this, argumentos);
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
        return OopsBoolean.CLASS.getIdentificador()+" " + valor;
    }
    
    
    
    
    
    
}
