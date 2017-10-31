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
    private OopsObject[] argumentos;
    private OopsObject receptor;

    public OopsMessage(String selector, OopsObject[] argumentos, OopsObject receptor) {
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

    public OopsObject[] getArgumentos() {
        return argumentos;
    }

    public void setArgumentos(OopsObject[] argumentos) {
        this.argumentos = argumentos;
    }

    public OopsObject getReceptor() {
        return receptor;
    }

    public void setReceptor(OopsObject receptor) {
        this.receptor = receptor;
    }
    
}
