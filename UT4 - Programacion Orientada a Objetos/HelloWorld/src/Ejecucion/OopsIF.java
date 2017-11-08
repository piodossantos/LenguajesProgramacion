/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Ejecucion;

import EstadoPrograma.OopsState;
import RepresentacionCodigo.OopsBlock;
import RepresentacionCodigo.OopsCode;

/**
 *
 * @author pio
 */
public class OopsIF extends OopsMethod{

    public OopsIF(String selector) {
        super(selector);
    }

    @Override
    public OopsObject evaluate(OopsState estado, OopsObject self, OopsObject[] argumentos) {
        OopsBoolean condicion = (OopsBoolean) self;
        if(condicion.getValor())
            return ((OopsBlock)argumentos[0]).evaluate(estado);
        return ((OopsBlock)argumentos[1]).evaluate(estado);
       
    }
    
}
