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

	almacen_invalido(almacen)
	pila_invalida(pila)
	pila_llena(pila)
	
	apilar(box, pila, pila)
	ordenar_cajas(lbox, lbox)
	
	rellenar(lbox,almacen)
	
	escribir(pila)
clauses

	escribir(P):-
		write(P).
	

  	almacen_invalido(alm(P1, P2, P3, P4, P5)):-
  		pila_invalida(P1);
  		pila_invalida(P2);
  		pila_invalida(P3);
  		pila_invalida(P4);
  		pila_invalida(P5).
  		
  	pila_llena(p(_, Actual, Limite)):-
  		Actual >= Limite.
  	
  	pila_invalida(p(Lista, Actual, Limite)):-
  		pila_llena(p(Lista, Actual, Limite)).
  	
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
  		
  	ordenar_cajas([UnaCaja],ListaOrdenada):-
  		ListaOrdenada=[UnaCaja].
  		
  	ordenar_cajas([b(BID1, BIn1, BOut1)|RestoDeCajas], ListaOrdenada):-
  		RestoDeCajas=[b(BID2, BIn2, BOut2)|OtrasCajas],
  		BOut1 <= BOut2,
  		ListaOrdenada=[b(BID1, BIn1, BOut1)|RestoDeCajas].
  		
  	ordenar_cajas([b(BID1, BIn1, BOut1)|RestoDeCajas], ListaOrdenada):-
  		RestoDeCajas=[b(BID2, BIn2, BOut2)|OtrasCajas],
  		BOut2 < BOut1,
  		ListaTemp=[b(BID1, BIn1, BOut1)|OtrasCajas],
  		ordenar_cajas(ListaTemp, ListaOrdenadaTemp),
  		ListaOrdenada=[b(BID2, BIn2, BOut2)|ListaOrdenadaTemp].
  		
  	
  	apilar(b(BID1, BIn1, BOut1), p(Lista, Actual, Limite), NuevaPila):-
  		not(pila_llena(p(Lista, Actual, Limite))),
  		ordenar_cajas([b(BID1, BIn1, BOut1)|Lista], PilaOrdenada),
  		NuevoActual=Actual+1,
  		NuevaPila=p(PilaOrdenada,NuevoActual,Limite).
  		
  	rellenar([],Almacen):-
  		Almacen=alm(
  			p([],0,4),
  			p([],0,4),
  			p([],0,4),
  			p([],0,4),
  			p([],0,4)
  		).
 
  	rellenar(ListaProd,Almacen):-
  		Almacen=alm(
  			p(CajasP1,ActualP1,LimiteP1),
  			p(CajasP2,ActualP2,LimiteP2),
  			p(CajasP3,ActualP3,LimiteP3),
  			p(CajasP4,ActualP4,LimiteP4),
  			p(CajasP5,ActualP5,LimiteP5)),
  		
  		
  		

goal

	/*
	almacen_invalido(
		alm(
		p([b(1,1,1),b(1,1,2),b(1,1,3)],3,4),
		p([b(1,2,1)],1,4),
		p([b(1,3,3),b(1,3,2)],2,4),
		p([b(1,4,1)],1,4),
		p([b(1,5,1)],1,4)
		)
	).
	*/

	apilar(
		b(104,1,4),
		p([b(1,1,1),b(1,1,2),b(1,1,3),b(1,1,4)],3,4),
		P
	).
