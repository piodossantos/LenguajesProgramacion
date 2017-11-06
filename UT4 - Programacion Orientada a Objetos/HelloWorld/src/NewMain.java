
import Ejecucion. *;
import RepresentacionCodigo.*;
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
public class NewMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        HashMap<String,OopsValor> booleanos = new HashMap<>();
        booleanos.put("Verdadero", new OopsValor(new OopsBoolean(true)));
        booleanos.put("Falso",  new OopsValor(new OopsBoolean(false)));
        HashMap<Integer,OopsValor> numeros = new HashMap<>();
        for(int i=0;i<100;i++){
            numeros.put(i,new OopsValor( new OopsInteger(i) ));
        }
        
        
        //Test Booleanos
        //Lista de Argumentos
        OopsCode argumentos[] = {booleanos.get("Verdadero")};
        //Mensajes
        OopsCode[] trampa= {new OopsMessage("&",argumentos,booleanos.get("Falso"))};

        OopsCode []lista_operaciones_Booleanas = {
            new OopsMessage("|",trampa,booleanos.get("Falso")),
            new OopsMessage("!",argumentos,booleanos.get("Falso"))
        };
        //SecuenciaBooleano
        OopsSequence sb = new OopsSequence(lista_operaciones_Booleanas);
        
        System.out.println(sb.toString()); 
        OopsBoolean res =  (OopsBoolean) sb.evaluate(new OopsState());
        System.out.println(res);
    }
    
}
