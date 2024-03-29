
import EstadoPrograma.OopsState;
import Ejecucion.OopsInteger;
import Ejecucion.OopsObject;
import Ejecucion. *;
import EstadoPrograma.OopsCell;
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
        NewMain.pruebaPrimitivas(numeros, booleanos);
        NewMain.test2(numeros, booleanos);
        NewMain.pruebaIf(numeros,booleanos);
    }
    public static void pruebaIf(HashMap<Integer,OopsValor> numeros, HashMap<String,OopsValor> booleanos){
        System.out.print("\nPRUEBA IF : \n\n");
        OopsAssignment a1 = new OopsAssignment("i", numeros.get(1));
        OopsCode[] listaT = {new OopsAssignment("i", numeros.get(2))} ;
        OopsCode[] listaF = {new OopsAssignment("i", numeros.get(3))} ;

        OopsBlock iftrue = new OopsBlock (listaT);
        OopsBlock ifFalse = new OopsBlock (listaF);
        
        OopsCode []ifTF = {new OopsValor(iftrue),new OopsValor(ifFalse)};
        
        OopsCode []lista_sec={a1,new OopsMessage("IF",ifTF,booleanos.get("Verdadero"))};
                OopsSequence secuencia = new OopsSequence(lista_sec);
                System.out.println("CASO TRUE");
        System.out.println(secuencia.toString());
        System.out.println(secuencia.evaluate(new OopsState()));
        
                OopsCode []lista_sec2={a1,new OopsMessage("IF",ifTF,booleanos.get("Falso"))};
                OopsSequence secuencia2 = new OopsSequence(lista_sec2);
                System.out.println("CASO FALSE");
        System.out.println(secuencia2.toString());
        System.out.println(secuencia2.evaluate(new OopsState()));
        
        
        
    }
    public static void pruebaPrimitivas(HashMap<Integer,OopsValor> numeros, HashMap<String,OopsValor> booleanos){        
        System.out.print("\nPRUEBA ENTEROS : \n\n");
        OopsCode argINT[] = {numeros.get(3)};
        OopsCode []lista_operacion_Enteros = {
            new OopsMessage ("+",argINT,numeros.get(5)),
            new OopsMessage ("-",argINT,numeros.get(5)),
            new OopsMessage ("*",argINT,numeros.get(5)),
            new OopsMessage ("/",argINT,numeros.get(5)),
            new OopsMessage (">",argINT,numeros.get(5)),
            new OopsMessage ("<",argINT,numeros.get(5)),
            new OopsMessage ("<=",argINT,numeros.get(5)),
            new OopsMessage (">=",argINT,numeros.get(5)),
            new OopsMessage ("==",argINT,numeros.get(5)),
            new OopsMessage ("!=",argINT,numeros.get(5)),
        };
        for(OopsCode m: lista_operacion_Enteros){
            System.out.println(m.toString());
            System.out.println(m.evaluate(new OopsState()).toString());
        }
        System.out.println("Ejecucion anterior pero en Secuencia");
        OopsSequence si = new OopsSequence(lista_operacion_Enteros);
        System.out.println(si.toString());
        System.out.println(si.evaluate(new OopsState()).toString());
        
        //Test Booleanos
        System.out.print("\nPRUEBA BOOLEANOS : \n\n");
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

    private static void test2(HashMap<Integer, OopsValor> numeros, HashMap<String, OopsValor> booleanos) {
               System.out.print("\nPRUEBA ASIGNACIONES Y BLOQUE : \n\n");

        HashMap<String,OopsCell> elementos  = new HashMap<>();

        //Inicial
        OopsAssignment a1 = new OopsAssignment("i",numeros.get(3));
        OopsAssignment a2 = new OopsAssignment("j",numeros.get(4));

        //Construccion de un bloque
            OopsCode c1[] = {numeros.get(1)};
            OopsMessage s1 = new OopsMessage("+", c1, new OopsVariable("i"));
            OopsMessage s2 = new OopsMessage("+", c1, new OopsVariable("j"));

        OopsAssignment b1 = new OopsAssignment("i",s1);
        OopsAssignment b2 = new OopsAssignment("j",s2);

        OopsCode []lista_bloque = {b1,b2};
        OopsBlock bloque = new OopsBlock(lista_bloque);
        
        OopsCode []lista_sec = {a1,a2,bloque};
        
        OopsSequence secuencia = new OopsSequence(lista_sec);
        
        OopsState estado = new OopsState(elementos);
        
        System.out.println(secuencia.toString());
        System.out.println(secuencia.evaluate(estado).toString());
        System.out.println(estado.toString());
    }
    
}
