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
    private int valor;

    public OopsInteger(int valor) {
        this.valor = valor;
    }

    public int getValor() {
        return valor;
    }

    public void setValor(int valor) {
        this.valor = valor;
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
                OopsBoolean e = (OopsBoolean) argumentos[0];
                return new OopsInteger(e.getValor()<this.getValor());
            case ">":
                OopsBoolean f = (OopsBoolean) argumentos[0];
                return new OopsInteger(f.getValor()>this.getValor());
            case ">=":
                OopsBoolean g = (OopsBoolean) argumentos[0];
                return new OopsInteger(g.getValor()>=this.getValor());
            case "<=":
                OopsBoolean h = (OopsBoolean) argumentos[0];
                return new OopsInteger(h.getValor()<=this.getValor());
            case "==":
                OopsBoolean i = (OopsBoolean) argumentos[0];
                return new OopsInteger(i.getValor()==this.getValor());
            case "!=":
                OopsBoolean j = (OopsBoolean) argumentos[0];

                return new OopsInteger(j.getValor()!=this.getValor());
        }
        return null;     
    }
    
}
