package Ejecucion;

import EstadoPrograma.OopsState;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author pio
 */
public abstract class OopsObject {

   public abstract OopsObject respond(OopsState estado, String selector,OopsObject[] argumentos);
}
