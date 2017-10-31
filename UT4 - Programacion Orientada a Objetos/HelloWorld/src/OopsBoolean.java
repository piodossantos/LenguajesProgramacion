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
  
    private boolean valor;
    
    
    @Override
    public OopsObject respond(String selector, OopsObject[] argumentos) {
        OopsObject result = null;
        switch (selector){
            case "negacion":
                result = negacion();
                break;
            case "and":
                result = and (((OopsBoolean) argumentos[0]).getValor());
                break;
            case "or":
                result = or (((OopsBoolean) argumentos[0]).getValor());
                break;
        }
        return result;
    }
    
    public OopsBoolean (boolean valor){
        this.valor = valor;
    }
    
    public boolean getValor (){
        return valor;
    }
    
    
    public OopsBoolean negacion(){
        return new OopsBoolean(!(this.getValor()));
    }
    
    public OopsBoolean and (boolean b){
        return new OopsBoolean((this.getValor()) && b);
    }
    
    
    public OopsBoolean or (boolean b){
        return new OopsBoolean((this.getValor()) || b);
    }
    
    
    
    
    
    
}
