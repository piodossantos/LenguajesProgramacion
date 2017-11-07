/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejercicio_3_3;

import Ejecucion.OopsObject;
import RepresentacionCodigo.OopsCode;
import RepresentacionCodigo.OopsState;
import java.util.HashMap;

/**
 *
 * @author pio
 */
public class OopsBlock extends OopsCode {
    
    private OopsCode[] secuencia;

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
        return salida.replace('\n', '.')+" ]";
    }
    
}