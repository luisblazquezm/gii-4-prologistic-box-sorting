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
	identificador=integer
	diaentrada=integer
	diasalida=integer
	box=b(identificador, diaentrada, diasalida)
	lbox=box*
	
	actual=integer
	limite=integer
	pila=p(lbox,actual,limite)
	
	almacen=alm(pila,pila,pila,pila,pila)
	
predicates

	/*mueve(almacen,almacen)*/
	almacen_invalido(almacen)
	pila_invalida(pila)
	
	
	escribe(pila).
clauses

	escribe(P):-
		write(P).
	

  	almacen_invalido(alm(P1, P2, P3, P4, P5)):-
  		pila_invalida(P1);
  		pila_invalida(P2);
  		pila_invalida(P3);
  		pila_invalida(P4);
  		pila_invalida(P5).
  	
  	pila_invalida(p(_, Actual, Limite)):-
  		Actual > Limite.
  	
  	pila_invalida(p([Primera_caja|Otras_cajas], _, _)):-
  		Otras_cajas=[Segunda_caja|Pila],	
  		Primera_caja=b(Primera_ID,Primera_entrada,Primera_salida),
  		Segunda_caja=b(Segunda_ID,Segunda_entrada,Segunda_salida),
  		Segunda_salida < Primera_salida.
  		
  	pila_invalida(p([Primera_caja|Otras_cajas], Actual, Limite)):-
  		Otras_cajas=[Segunda_caja|Pila],	
  		Primera_caja=b(Primera_ID,Primera_entrada,Primera_salida),
  		Segunda_caja=b(Segunda_ID,Segunda_entrada,Segunda_salida),
  		pila_invalida(p(Otras_cajas, Actual, Limite)).
  	
  		

goal

	almacen_invalido(
		alm(
		p([b(1,1,1),b(1,1,2),b(1,1,3)],3,4),
		p([b(1,2,1)],1,4),
		p([b(1,3,3),b(1,3,2)],2,4),
		p([b(1,4,1)],1,4),
		p([b(1,5,1)],1,4)
		)
	).
