package RepresentacionCodigo;


import EstadoPrograma.OopsCell;
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
public class OopsAssignment extends OopsCode{
    String identificador;
    OopsCode valor;

    public OopsAssignment(String identificador, OopsCode valor) {
        this.identificador = identificador;
        this.valor = valor;
    }

    public String getIdentificador() {
        return identificador;
    }

    public void setIdentificador(String identificador) {
        this.identificador = identificador;
    }

    public OopsCode getValor() {
        return valor;
    }

    public void setValor(OopsCode valor) {
        this.valor = valor;
    }
    
    @Override
    public OopsObject evaluate(OopsState estado) {
        OopsObject resultado = valor.evaluate(estado);
        if(estado.getEstado().containsKey(identificador)){
            estado.getEstado().get(identificador).valor=resultado;
        }else{
            estado.getEstado().put(identificador, new OopsCell(resultado));
        }
        return resultado;
    }

    @Override
    public String toString() {
        return identificador + " <- " + valor ;
    }



    
    
    
}
