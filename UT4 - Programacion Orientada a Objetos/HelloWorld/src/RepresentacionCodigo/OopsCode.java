package RepresentacionCodigo;


import Ejecucion.OopsClass;
import Ejecucion.OopsObject;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pio
 */
public abstract class OopsCode extends OopsObject {

    public OopsCode() {
        super(new OopsClass("OopsCode",null));
    }
    
    @Override
    public OopsObject respond(String selector, OopsObject[] argumentos) {
        return null;
    }

    
   public abstract OopsObject evaluate(OopsState estado);

    
   @Override
    public abstract String toString();
    //To change body of generated methods, choose Tools | Templates.

}
