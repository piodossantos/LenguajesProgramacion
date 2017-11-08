package RepresentacionCodigo;


import EstadoPrograma.OopsState;
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

   

    @Override
    public OopsObject respond(OopsState estado, String selector, OopsObject[] argumentos) {
        throw new UnsupportedOperationException("Metodo NO Soportado."); 
    }

    
   public abstract OopsObject evaluate(OopsState estado);

    
   @Override
    public abstract String toString();
    //To change body of generated methods, choose Tools | Templates.

}
