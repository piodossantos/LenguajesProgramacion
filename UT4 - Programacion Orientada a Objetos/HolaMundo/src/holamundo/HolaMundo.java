/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package holamundo;

import java.util.HashMap;

/**
 *
 * @author Equipo_1
 */
public class HolaMundo {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        System.out.println("Hola Programación Orientada a Objetos");
        HashMap<Integer,String> mapa = new HashMap<>();
        for (int i = 0; i < 10; i++) {
            mapa.put(i,"Numero "+i);
        }
        mapa.values().forEach((valor)->{
            System.out.println(valor);
        });
    }
    
}
