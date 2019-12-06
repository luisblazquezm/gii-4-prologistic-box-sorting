/*****************************************************************************

		Copyright (c) My Company

 Project:  STORAGEHOUSE
 FileName: STORAGEHOUSE.PRO
 Purpose: No description
 Written by: Visual Prolog
 Comments:
******************************************************************************/

include "storagehouse.inc"

domains
	/* Dominios definidos en el enunciado */
	identificador=integer
	diaentrada=integer
	diasalida=integer
	actual=integer
	limite=integer
	box=b(identificador, diaentrada, diasalida)
	lbox=box*
	pila=p(lbox,actual,limite)
	almacen=alm(pila,pila,pila,pila,pila)
	
predicates

	/* Permite incluir un nuevo elemento de tipo 'box' AL FINAL de una lista */
	extender_lbox_inverso(lbox,lbox,lbox)

	/* Predicados de estado de la pila */
	pila_invalida(pila)
	pila_llena(pila)
	pila_vacia(pila)
	
	/* Incluir nueva caja en el extremo de la pila (sin tener en cuenta el orden 
	 * de salida).
	 */
	apilar_caja_en_pila(box,pila,pila)
	
	/* Coger una caja de la lista de produccion 'lbox' y meterla en un lugar 
	 * disponible y que respete las restricciones (limite de las pilas y fechas
	 * de salida) en el almacen.
	 */
	colocar_cajas_en_almacen(lbox,almacen,almacen)
	
	/* Sacar una caja del almacen.
	 *
	 * Necesario para poder solucionar los casos en que una caja no se puede colocar
	 * en el estado actual del almacen.
	 */
	sacar_caja(almacen,almacen,lbox,lbox)
	
	/* Punto de entrada: 'Encontrar estado solucion del almacen para una lista de
	 * produccion dada'.
	 */
	solucionar(lbox,almacen)

clauses
	/* ========================================================================== *
	 * extender_lbox_inverso						      *
	 * ========================================================================== */
	 
	/* Caso 1: Añadir una lista al final de una lista vacía.
	 *
	 * Resultado: La lista a añadir.
	 */
	extender_lbox_inverso([], Lista, NuevaLista):-
		Lista=NuevaLista.

	/* Caso 2: Añadir una lista al final de una lista NO vacía
	 *
	 * Resultado: El de concatenar las colas de las listas, manteniendo la misma
	 *            cabeza.
	 */
	extender_lbox_inverso([H|Cola],Lista2,[H|NuevaCola]):-
		extender_lbox_inverso(Cola, Lista2, NuevaCola).
  	
  	
  	/* ========================================================================== *
	 * pila_vacia	                					      *
	 * ========================================================================== */
  	pila_vacia(p(_, Actual, _)):-
  		Actual = 0.
  		
  	/* ========================================================================== *
	 * pila_llena	                 					      *
	 * ========================================================================== */
  	pila_llena(p(_, Actual, Limite)):-
  		Actual >= Limite.
  	
  	/* ========================================================================== *
	 * pila_invalida                 					      *
	 * ========================================================================== */
	 
	/* La pila se considera invalida si cumple las siguientes condiciones:
	 *     1. Hay mas de una caja en la pila.
	 *     2. Las cajas estan mal ordenadas atendiendo a la fecha de salida.
	 *        Dado que este predicado se usa siempre que se coloca una caja,
	 *        basta con comprobar que la caja del extremo de la pila esta bien
	 *        ordenada en relacion a la segunda.
	 */
  	pila_invalida(p([Primera_caja|Otras_cajas], _, _)):-
  		not(Otras_cajas=[]),
  		Otras_cajas=[Segunda_caja|_],	
  		Primera_caja=b(_,_,Primera_salida),
  		Segunda_caja=b(_,_,Segunda_salida),
  		Segunda_salida < Primera_salida.
  	
  	/* ========================================================================== *
	 * apilar_caja_en_pila                 					      *
	 * ========================================================================== */
	
	/* Se puede apilar una caja en la pila si esta no esta llena. El control del
	 * orden de salida se realiza en otra parte.
	 */		
  	apilar_caja_en_pila(Caja,PilaActual,NuevaPila):-
  		not(pila_llena(PilaActual)),
  		PilaActual=p(ListaCajas,Actual,Limite),
  		NuevoActual=Actual+1, /*<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Da error en esta asignación */
  		NuevaPila=p([Caja|ListaCajas],NuevoActual,Limite).
  	/* NOTA: ya he comprobado que no se debe al caso de que la pila este vacia: añadiendo
  	 *       un predicado para eso, sigue dando 'stack overflow'
  	 */
  	
  	/* ========================================================================== *
	 * colocar_cajas_en_almacen            					      *
	 * ========================================================================== */
	
	/* Caso 0: la lista de produccion esta vacia.
	 *
	 * En este caso, el almacen se queda como esta.
	 */
  	colocar_cajas_en_almacen([],Almacen,NuevoAlmacen):-
  		Almacen=NuevoAlmacen.
 
 	/* Casos 1 - 5: Colocar una caja de la lista de produccion en el almacen
 	 *               (en la pila 1, ..., 5).
 	 * --------------------------------------------------------------------------------------
 	 * Se puede colocar las cajas si se cumplen las siguientes condiciones:
 	 *     1. El limite de recursividad no se ha superado.
 	 *     2. Puedo apilar la primera caja en alguna pila (esto es, hay algun hueco todavia).
 	 *     3. El resultado de apilar la caja no es incorrecto (esto es, se respeta
 	 *        el orden de salida de las cajas).
 	 *     4. Puedo colocar el resto de cajas siguiendo el mismo proceso y respetando las
 	 *        condiciones 1 - 3. 
 	 */
  	colocar_cajas_en_almacen([Caja|RestoCajas],Almacen,NuevoAlmacen):-
  		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
  		apilar_caja_en_pila(Caja,Pila1,NuevaPila1),
  		not(pila_invalida(NuevaPila1)),
  		AlmacenTemp=alm(NuevaPila1,Pila2,Pila3,Pila4,Pila5),
  		colocar_cajas_en_almacen(RestoCajas,AlmacenTemp,NuevoAlmacen).
  		
  	colocar_cajas_en_almacen([Caja|RestoCajas],Almacen,NuevoAlmacen):-
  		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
  		apilar_caja_en_pila(Caja,Pila2,NuevaPila2),
  		not(pila_invalida(NuevaPila2)),
  		AlmacenTemp=alm(Pila1,NuevaPila2,Pila3,Pila4,Pila5),
  		colocar_cajas_en_almacen(RestoCajas,AlmacenTemp,NuevoAlmacen).
  		
  	colocar_cajas_en_almacen([Caja|RestoCajas],Almacen,NuevoAlmacen):-
  		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
  		apilar_caja_en_pila(Caja,Pila3,NuevaPila3),
  		not(pila_invalida(NuevaPila3)),
  		AlmacenTemp=alm(Pila1,Pila2,NuevaPila3,Pila4,Pila5),
  		colocar_cajas_en_almacen(RestoCajas,AlmacenTemp,NuevoAlmacen).
  		
  	colocar_cajas_en_almacen([Caja|RestoCajas],Almacen,NuevoAlmacen):-
  		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
  		apilar_caja_en_pila(Caja,Pila4,NuevaPila4),
  		not(pila_invalida(NuevaPila4)),
  		AlmacenTemp=alm(Pila1,Pila2,Pila3,NuevaPila4,Pila5),
  		colocar_cajas_en_almacen(RestoCajas,AlmacenTemp,NuevoAlmacen).
  		
  	colocar_cajas_en_almacen([Caja|RestoCajas],Almacen,NuevoAlmacen):-
  		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
  		apilar_caja_en_pila(Caja,Pila5,NuevaPila5),
  		not(pila_invalida(NuevaPila5)),
  		AlmacenTemp=alm(Pila1,Pila2,Pila3,Pila4,NuevaPila5),
  		colocar_cajas_en_almacen(RestoCajas,AlmacenTemp,NuevoAlmacen).
  		
  	/* Caso 6: No es posible colocar la primera caja de la lista en ninguna pila
  	 *
  	 * En este caso, se puede colocar las cajas en el almacen si se cumple que,
  	 * tras descubrir que no puedo colocar una caja, puedo dar marcha atras del
  	 * modo siguiente:
  	 *
  	 *     1. Puedo retirar una caja del almacen y colocarla al final de la lista
  	 *        de produccion (ver nota abajo)
  	 *     2. Puedo colocar la lista de produccion a continuacion siguiendo el metodo
  	 *        definido por este predicado en sus casos 0 - 5.
  	 *
  	 * Nota: Las cajas se retiran por defecto de la pila numero 1 (ver funcionamiento
  	 *       del predicado 'sacar_caja'); en el caso limite, la pila queda vacia, caso
  	 *       en el que siempre es posible colocar una caja.
  	 */
  	colocar_cajas_en_almacen([Caja|RestoCajas],Almacen,NuevoAlmacen):-
  		Almacen=alm(_,_,_,_,Pila5),
  		apilar_caja_en_pila(Caja,Pila5,NuevaPila5),
  		pila_invalida(NuevaPila5),
  		sacar_caja(Almacen,AlmacenActualizado,RestoCajas,NuevaListaProduccion),
  		colocar_cajas_en_almacen([Caja|NuevaListaProduccion],AlmacenActualizado,NuevoAlmacen).
  	
  	/* ========================================================================== *
	 * sacar_caja               			        		      *
	 * ========================================================================== */
	 
	/* Caso 1: si la pila esta vacia, el almacen queda en el mismo estado */
  	sacar_caja(Almacen,NuevoAlmacen,ListaProduccion,NuevaListaProduccion):-
  		Almacen=alm(Pila1,_,_,_,_),
  		pila_vacia(Pila1),
  		NuevoAlmacen=Almacen,
  		NuevaListaProduccion=ListaProduccion.
  	
  	/* Caso 2: si la pila no esta vacia, el proceso es (en terminos de codigo):
  	 *
  	 *     1. Crear una nueva pila con tamaño N - 1, siendo N el tamaño actual
  	 *        de la pila, que contenga todas las cajas de la pila menos la primera.
  	 *     2. Actualizar el estado del almacen con la nueva pila.
  	 *     3. Crear la nueva lista de produccion, que contiene la caja retirada al
  	 *        final de la lista de cajas que contenia previamente.
  	 *
  	 * Se retiran las cajas siempre de la primera pila; de este modo, en el caso
  	 * limite, la pila quedara vacia y siempre sera posible colocar una caja
  	 */
  	sacar_caja(Almacen,NuevoAlmacen,ListaProduccion,NuevaListaProduccion):-
  		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
  		Pila1=p([PrimeraCaja|RestoCajas], Actual, Limite),
  		NuevoActual=Actual-1,
  		NuevaPila1=p(RestoCajas, NuevoActual, Limite),
  		NuevoAlmacen=alm(NuevaPila1,Pila2,Pila3,Pila4,Pila5),
  		extender_lbox_inverso(ListaProduccion,[PrimeraCaja],NuevaListaProduccion).
  	
  	/* ========================================================================== *
	 * solucionar               			        		      *
	 * ========================================================================== */
	 
	/* El estado inicial se encuentra a nivel 0 de recursividad, y parte de un almacen
	 * vacio.
	 */
  	solucionar(ListaProd,Almacen):-
  		colocar_cajas_en_almacen(
  			ListaProd,
  			Almacen,
			Solucion
		),
		write("\n\n"), write(Solucion), write("\n\n").
	
goal
	/*solucionar([b(5,5,5),b(4,4,4),b(3,3,3),b(2,2,2),b(1,1,1)],Solucion).*/

	/*	
	solucionar(
		[
			b(1,1,1),b(2,2,2),b(3,3,3),
			b(4,4,4),b(5,5,5),b(6,6,6),
			b(7,7,7),b(8,8,8),b(9,9,9),
			b(10,10,10),b(11,11,11),b(12,12,12),
			b(13,13,13),b(14,14,14),b(15,15,15),
			b(16,16,16),b(17,17,17),b(18,18,18),
			b(19,19,19),b(20,20,20)
		],
  		Solucion
  	).
  	*/
	
	solucionar(
		[
			b(9,1,17),b(10,1,17),b(11,1,17),
			b(12,1,17),b(13,1,17),b(14,1,17),
			b(15,1,17),b(16,1,17),b(17,1,17),
			b(18,1,17),b(19,1,17),b(20,1,17),
			b(3,1,18),b(4,1,18),b(5,1,18),
			b(6,1,18),b(7,1,18),b(8,1,18),
			b(1,1,19),b(2,1,19)
		],
  		alm(p([],0,4),p([],0,4),p([],0,4),p([],0,4),p([],0,4))
  	).
