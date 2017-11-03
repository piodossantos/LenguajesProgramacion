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
    public OopsObject respond(String selector, OopsObject[] argumentos) {

        switch(selector){
            case "+":
                OopsInteger a = (OopsInteger) argumentos[0];
                return new OopsInteger(a.getValor()+this.getValor());
            case "-":
                return new OopsInteger(((OopsInteger) argumentos[0]).getValor()-this.getValor());
            case "*":
                OopsInteger c = (OopsInteger) argumentos[0];
                return new OopsInteger(c.getValor()*this.getValor());
            case "/":
                OopsInteger d = (OopsInteger) argumentos[0];
                return new OopsInteger(d.getValor()/this.getValor());
            case "<":
                OopsInteger e = (OopsInteger) argumentos[0];
                return new OopsBoolean(e.getValor()>this.getValor());
            case ">":
                OopsInteger f = (OopsInteger) argumentos[0];
                return new OopsBoolean(f.getValor()<this.getValor());
            case ">=":
                OopsInteger g = (OopsInteger) argumentos[0];
                return new OopsBoolean(g.getValor()<=this.getValor());
            case "<=":
                OopsInteger h = (OopsInteger) argumentos[0];
                return new OopsBoolean(h.getValor()>=this.getValor());
            case "==":
                OopsInteger i = (OopsInteger) argumentos[0];
                return new OopsBoolean(i.getValor()==this.getValor());
            case "!=":
                OopsInteger j = (OopsInteger) argumentos[0];
                return new OopsBoolean(j.getValor()!=this.getValor());
        }
        return null;     
    }

    @Override
    public String toString() {
        return "OopsInteger{" + "valor=" + valor + '}';
    }
    
    
}
