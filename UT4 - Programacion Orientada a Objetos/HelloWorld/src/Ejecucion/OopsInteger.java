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
    private static final HashMap<String,OopsMethod> metodos = new HashMap<>();
    static{
        metodos.put("+", new OopsSuma("+"));
        metodos.put("-", new OopsResta("-"));
        metodos.put("*", new OopsProducto("*"));
        metodos.put("/", new OopsDivision("/"));
        metodos.put(">", new OopsMayor(">"));
        metodos.put("<", new OopsMenor("<"));
        metodos.put("<=", new OopsMenorIgual("<="));
        metodos.put(">=", new OopsMayorIgual(">="));
        metodos.put("==", new OopsIgual("=="));
        metodos.put("!=", new OopsDistinto("!="));


    }

    public OopsInteger(int valor) {
        this.valor = valor;
    }

    public int getValor() {
        return valor;
    }


   @Override
    public  OopsObject respond(String selector, OopsObject[] argumentos) {
        OopsObject result = null;
        OopsMethod temporal=OopsInteger.metodos.get(selector);
        if (temporal!=null){
            result = temporal.evaluate(this, argumentos);
        }
        return result;
    }

    @Override
    public String toString() {
        return "Integer" + valor;
    }
    
    
}
