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
public class OopsValor extends OopsCode {
    private final OopsObject valor;

    public OopsObject getValor() {
        return valor;
    }

    public OopsValor(OopsObject valor) {
        this.valor = valor;
    }
    
    @Override
    public OopsObject evaluate(OopsState estado) {
        return this.getValor();
    }

    @Override
    public String toString() {
        return valor.toString() ;
    }

    @Override
    public OopsObject respond(OopsState estado, String selector, OopsObject[] argumentos) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
}
