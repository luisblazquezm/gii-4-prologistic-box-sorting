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

	pila_invalida(pila)
	pila_llena(pila)
	recursividad_acotada(integer)
	
	apilar(box,pila,pila)
	rellenar(lbox,almacen,almacen,integer)
	solucionar(lbox,almacen)

clauses
  		
  	recursividad_acotada(Nivel):-
  		Nivel <= 40.
  		
  	pila_llena(p(_, Actual, Limite)):-
  		Actual >= Limite.
  	
  	pila_invalida(p([Primera_caja|Otras_cajas], _, _)):-
  		not(Otras_cajas=[]),
  		Otras_cajas=[Segunda_caja|Pila],	
  		Primera_caja=b(Primera_ID,Primera_entrada,Primera_salida),
  		Segunda_caja=b(Segunda_ID,Segunda_entrada,Segunda_salida),
  		Segunda_salida < Primera_salida.
  		
  	apilar(Caja,PilaActual,NuevaPila):-
  		PilaActual=p(ListaCajas,Actual,Limite),
  		not(pila_llena(PilaActual)),
  		NuevoActual=Actual+1,
  		NuevaPila=p([Caja|ListaCajas],NuevoActual,Limite).
  		
  	rellenar([],Almacen,NuevoAlmacen,Nivel):-
  		recursividad_acotada(Nivel),
  		Almacen=NuevoAlmacen.
 
  	rellenar([Caja|RestoCajas],Almacen,NuevoAlmacen,Nivel):-
  		recursividad_acotada(Nivel),
  		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
  		apilar(Caja,Pila1,NuevaPila1),
  		not(pila_invalida(NuevaPila1)),
  		AlmacenTemp=alm(NuevaPila1,Pila2,Pila3,Pila4,Pila5),
  		NuevoNivel=Nivel+1,
  		rellenar(RestoCajas,AlmacenTemp,NuevoAlmacen,NuevoNivel).
  		
  	rellenar([Caja|RestoCajas],Almacen,NuevoAlmacen,Nivel):-
  		recursividad_acotada(Nivel),
  		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
  		apilar(Caja,Pila2,NuevaPila2),
  		not(pila_invalida(NuevaPila2)),
  		AlmacenTemp=alm(Pila1,NuevaPila2,Pila3,Pila4,Pila5),
  		NuevoNivel=Nivel+1,
  		rellenar(RestoCajas,AlmacenTemp,NuevoAlmacen,NuevoNivel).
  		
  	rellenar([Caja|RestoCajas],Almacen,NuevoAlmacen,Nivel):-
  		recursividad_acotada(Nivel),
  		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
  		apilar(Caja,Pila3,NuevaPila3),
  		not(pila_invalida(NuevaPila3)),
  		AlmacenTemp=alm(Pila1,Pila2,NuevaPila3,Pila4,Pila5),
  		NuevoNivel=Nivel+1,
  		rellenar(RestoCajas,AlmacenTemp,NuevoAlmacen,NuevoNivel).
  		
  	rellenar([Caja|RestoCajas],Almacen,NuevoAlmacen,Nivel):-
  		recursividad_acotada(Nivel),
  		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
  		apilar(Caja,Pila4,NuevaPila4),
  		not(pila_invalida(NuevaPila4)),
  		AlmacenTemp=alm(Pila1,Pila2,Pila3,NuevaPila4,Pila5),
  		NuevoNivel=Nivel+1,
  		rellenar(RestoCajas,AlmacenTemp,NuevoAlmacen,NuevoNivel).
  		
  	rellenar([Caja|RestoCajas],Almacen,NuevoAlmacen,Nivel):-
  		recursividad_acotada(Nivel),
  		Almacen=alm(Pila1,Pila2,Pila3,Pila4,Pila5),
  		apilar(Caja,Pila5,NuevaPila5),
  		not(pila_invalida(NuevaPila5)),
  		AlmacenTemp=alm(Pila1,Pila2,Pila3,Pila4,NuevaPila5),
  		NuevoNivel=Nivel+1,
  		rellenar(RestoCajas,AlmacenTemp,NuevoAlmacen,NuevoNivel).
  		
  	solucionar(ListaProd,Solucion):-
  		rellenar(
  			ListaProd,
  			alm(
				p([],0,4),
				p([],0,4),
				p([],0,4),
				p([],0,4),
				p([],0,4)
			),
			Solucion,
			0
		).
goal
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
  		Solucion
  	).
	
	/*
	solucionar(
		[
			b(9,1,4),b(1,1,4)
		],
  		Solucion
  	).
	*/
	
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
  	
  	/*
  	solucionar(
		[
			b(2,1,20),b(1,1,19),b(8,1,18),
			b(7,1,17),b(6,1,16),b(5,1,15),
			b(4,1,14),b(3,1,13),b(20,1,12),
			b(19,1,11),b(18,1,10),b(17,1,9),
			b(16,1,8),b(15,1,7),b(14,1,6),
			b(13,1,5),b(12,1,4),b(11,1,3),
			b(10,1,2),b(9,1,1)
			
		],
  		Solucion
  	).
  	*/
