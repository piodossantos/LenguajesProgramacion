package Ejecucion;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pio
 */
public abstract class OopsObject {
   private final OopsClass clase;

    public OopsObject(OopsClass clase) {
        this.clase = clase;
    }

    public OopsClass getClase() {
        return clase;
    }
   
   public abstract OopsObject respond(String selector,OopsObject[] argumentos);
}
