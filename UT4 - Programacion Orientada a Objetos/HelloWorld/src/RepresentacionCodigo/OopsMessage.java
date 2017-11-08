package RepresentacionCodigo;


import EstadoPrograma.OopsState;
import Ejecucion.OopsObject;
import java.util.TreeSet;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pio
 */
public class OopsMessage extends OopsCode {
    private String selector;
    private OopsCode[] argumentos;
    private OopsCode receptor;

    public OopsMessage(String selector, OopsCode[] argumentos, OopsCode receptor) {
        this.selector = selector;
        this.argumentos = argumentos;
        this.receptor = receptor;
    }

    public String getSelector() {
        return selector;
    }

    public void setSelector(String selector) {
        this.selector = selector;
    }

    public OopsCode[] getArgumentos() {
        return argumentos;
    }

    public void setArgumentos(OopsCode[] argumentos) {
        this.argumentos = argumentos;
    }

    public OopsCode getReceptor() {
        return receptor;
    }

    public void setReceptor(OopsCode receptor) {
        this.receptor = receptor;
    }

    @Override
    public OopsObject evaluate(OopsState estado) {
        OopsObject receptor = this.getReceptor().evaluate(estado);
       // TreeSet<OopsObject> arbol = new TreeSet();
        OopsObject[] args= new OopsObject[this.getArgumentos().length];
        for(int i=0;i<args.length;i++){
            args[i]=this.getArgumentos()[i].evaluate(estado);
        }
        return receptor.respond(estado,selector, args);
        //return this.getReceptor().respond(this.getSelector(), this.getArgumentos());
    }

    @Override
    public String toString() {
        String args="";
        for(OopsCode i: argumentos){
            args+=i.toString()+",";
        }
        return selector + "(" + receptor  + "," +  args.substring(0, args.length() - 1 )+ ')';
    }

    @Override
    public OopsObject respond(OopsState estado, String selector, OopsObject[] argumentos) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    
}
