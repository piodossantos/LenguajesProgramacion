/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package RepresentacionCodigo;

import Ejecucion.OopsObject;
import RepresentacionCodigo.OopsCode;
import EstadoPrograma.OopsState;
import java.util.HashMap;

/**
 *
 * @author pio
 */
public class OopsBlock extends OopsCode {
    
    public OopsCode[] secuencia;
    public String[] argumentosFormales;

    public OopsBlock(OopsCode[] secuencia) {
        this.secuencia = secuencia;
    }

    @Override
    public OopsObject evaluate(OopsState estadoInicial) {
        //Creo un nuevo contexto
        OopsState estado = new OopsState(new HashMap<>(estadoInicial.getEstado()));
        
        //Flujo normal
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
        String salida="[ ";
        for(OopsCode c: this.secuencia){
            salida+= c.toString()+". ";
        }
        return salida.replace('\n', '.').substring(0, salida.length() -2 )+" ]";
    }


    
}
