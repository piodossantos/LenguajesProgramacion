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
public class OopsInteger extends OopsObject {
    private final int valor;

    public OopsInteger(int valor) {
        super( new OopsClass("OopsInteger",new HashMap(){
            {
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
            }
        }));
        this.valor = valor;
    }

    public int getValor() {
        return valor;
    }


   @Override
    public  OopsObject respond(String selector, OopsObject[] argumentos) {
        OopsObject result = null;
        OopsMethod temporal=this.getClase().method(selector);
        if (temporal!=null){
            result = temporal.evaluate(this, argumentos);
        }
        return result;
    }

    @Override
    public String toString() {
        return this.getClase().getIdentificador()+" " + valor;
    }
    
    
}
