/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejecucion;

/**
 *
 * @author pio
 */
public class OopsIfTrue extends OopsMethod{

    public OopsIfTrue(String selector) {
        super(selector);
    }

    @Override
    public OopsObject evaluate(OopsObject self, OopsObject[] argumentos) {
        OopsBoolean condicion = (OopsBoolean) argumentos[0];
        if(condicion.getValor()==true){
            return argumentos[1];
        }
        return null;
    }
    
}
