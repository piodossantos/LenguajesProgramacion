package RepresentacionCodigo;


import EstadoPrograma.OopsState;
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
public class OopsSequence extends OopsCode {

    private OopsCode[] secuencia;

    public OopsCode[] getPrueba() {
        return secuencia;
    }

    public OopsSequence(OopsCode[] prueba) {
        this.secuencia = prueba;
    }
    
    
    @Override
    public OopsObject evaluate(OopsState estado) {
        //recorre todo y devuelve el resultado de la ultima secuencia. despues de haberlo evaluados todos
        for(int i=0;i<secuencia.length;i++){
          if(i==(secuencia.length-1)){
            return (OopsObject) secuencia[i].evaluate(estado);
          }
          secuencia[i].evaluate(estado);
        }
        return null;
    }

    @Override
    public String toString() {
        String resultado="";
        for(OopsCode c: this.secuencia){
            resultado+= c.toString()+"\n";
        }
        return resultado;
    }

    @Override
    public OopsObject respond(OopsState estado, String selector, OopsObject[] argumentos) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
