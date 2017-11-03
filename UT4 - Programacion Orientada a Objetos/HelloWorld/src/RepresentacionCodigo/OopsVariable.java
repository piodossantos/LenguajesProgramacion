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
public class OopsVariable extends OopsCode {
    private String var;

    public String getVar() {
        return var;
    }

    public OopsVariable(String var) {
        this.var = var;
    }
    

    @Override
    public OopsObject evaluate(OopsState estado) {
        return estado.getEstado().get(var);
    }
}
