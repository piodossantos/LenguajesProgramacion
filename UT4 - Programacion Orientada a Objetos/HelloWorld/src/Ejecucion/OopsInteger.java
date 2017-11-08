
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
public class OopsInteger extends OopsObject {
    private final int valor;
    public static final OopsClass CLASS = new OopsClass("OopsInteger",new HashMap(){{
            
          put("+", new OopsSuma("+"));
                put("-", new OopsResta("-"));
                put("*", new OopsProducto("*"));
                put("/", new OopsDivision("/"));
                put(">", new OopsMayor(">"));
                put("<", new OopsMenor("<"));
                put("<=", new OopsMenorIgual("<="));
                put(">=", new OopsMayorIgual(">="));
                put("==", new OopsIgual("=="));
                put("!=", new OopsDistinto("!="));
            
        }});
    public OopsInteger(int valor) {
        this.valor = valor;
    }

    public int getValor() {
        return valor;
    }


   @Override
    public  OopsObject respond(OopsState estado, String selector, OopsObject[] argumentos) {
        OopsObject result = null;
        OopsMethod temporal=OopsInteger.CLASS.method(selector);
        if (temporal!=null){
            result = temporal.evaluate( estado, this, argumentos);
        }
        return result;
    }

    @Override
    public String toString() {
        return OopsInteger.CLASS.getIdentificador()+" " + valor;
    }
    
    
}
