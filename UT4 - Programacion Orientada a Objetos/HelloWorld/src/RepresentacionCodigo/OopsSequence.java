package RepresentacionCodigo;


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

    OopsCode[] prueba;
    @Override
    public OopsObject evaluate(OopsState estado) {
        //recorre todo y devuelve el resultado de la ultima secuencia. despues de haberlo evaluados todos
        for(int i=0;i<prueba.length;i++){
          if(i==(prueba.length-1)){
            return (OopsObject) prueba[i].evaluate(estado);
          }
          prueba[i].evaluate(estado);
        }
        return null;
    }
    
}
