package Ejecucion;

import EstadoPrograma.OopsState;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pio
 */
public abstract class OopsMethod {
   private String selector;

    public OopsMethod(String selector) {
        this.selector = selector;
    }

    public String getSelector() {
        return selector;
    }
   
    public abstract OopsObject evaluate(OopsState estado, OopsObject self,OopsObject[] argumentos);
}
