/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package EstadoPrograma;

import Ejecucion.OopsObject;
import Ejecucion.OopsObject;

/**
 *
 * @author pio
 */
public class OopsCell {
    public OopsObject valor;
    public OopsCell(OopsObject valor) {
        this.valor = valor;
    }

    @Override
    public String toString() {
        return "OopsCell " + valor.toString();
    }
    
}
