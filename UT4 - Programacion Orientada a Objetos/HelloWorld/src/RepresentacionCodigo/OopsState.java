package RepresentacionCodigo;




import Ejecucion.OopsObject;
import java.util.HashMap;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pio
 */
public class OopsState{
    private HashMap<String,OopsObject> estado;

    public HashMap<String, OopsObject> getEstado() {
        return estado;
    }

    public void setEstado(HashMap<String, OopsObject> estado) {
        this.estado = estado;
    }

    public OopsState() {
        this.estado=new HashMap<>();
    }
    
    public OopsState(HashMap<String,OopsObject> estado) {
        this.estado = estado;
    }
    
    public void put(String clave,OopsObject valor){
        estado.put(clave, valor);
    }

    @Override
    public String toString() {
        return "OopsState{" + "estado=" + estado + '}';
    }
    
}
