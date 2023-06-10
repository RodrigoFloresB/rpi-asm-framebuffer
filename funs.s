.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32


Pintarpixel:  //x3 = x     x4 = y
 
 	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
	mov x0, 640			//x0 = 640
	mul x0, x0, x4			// x0 = x0 * x4	
	add x0, x0, x3			// x0 = (x0 * x4) + x3	
	lsl x0, x0, 2			// x0 = 4 * [x3 + (x0 * x4)] 
	add x0, x0, x20			// x0 = direccion-framebuffer +  4 * [x3 + (x0 * x4)]
 	ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

    br lr
    
delay:
	movz x9, 0xfff,lsl 16 
	movk x9, 0xffff, lsl 00
	loop:
	sub x9, x9, 1
	cbnz x9, loop
	
	br lr

//   ---------------------------------------------------------  
 
dibujarcielo:  //x3= x x4 = y x1/x9=Ancho x2/x8=Alto  w10 = color
 
 	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]

 
 	mov x12, x0    // x12 = direccion del pixel N
 	mov x8, x2	// x8 = tamano Y
 	
 	loopaC:
    mov x9, x1	        // x9 = tamano X
    mov x11, x12	// x11 = x12 = direccion del pixel N                    //x11 auxiliar
     	 
    colorearC:	
	stur w10,[x12]       // coloreo el pixel N
	add x12,x12,4	   // siguiente pixel
	sub x9,x9,1	  // resto contador X
	cbnz x9,colorearC	// si no termino la fila, realizo el salto colorear
    add x10, x10, 1
	mov x12, x11   	// x12 = direccion del pixel N
	sub x8, x8, 1		// decremento contador Y
	add x12, x12,2560	// x12 = voy hacia el pixel de abajo del pixel N
	cbnz x8,loopaC		// si no es la ultima fila, hago el salto loopa
	
 	ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

    br lr
   
   //  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
//  ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
 dibujarcuadrado:  //x3= x x4 = y x1/x9=Ancho x2/x8=Alto  w10 = color
 
 	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]

 
 	mov x12, x0    // x12 = direccion del pixel N
 	mov x8, x2	// x8 = tamano Y
 	
 	loopa:
    mov x9, x1	        // x9 = tamano X
    mov x11, x12	// x11 = x12 = direccion del pixel N                    //x11 auxiliar
     	 
    colorear:	
	stur w10,[x12]          // coloreo el pixel N
	add x12,x12,4	        // siguiente pixel
	sub x9,x9,1	        // resto contador X
	cbnz x9,colorear        // si no termino la fila, realizo el salto colorear
        mov x12, x11           // x12 = direccion del pixel N
	sub x8, x8, 1		// decremento contador Y
	
	add x12, x12,2560	// x12 = voy hacia el pixel de abajo del pixel N
	cbnz x8,loopa		// si no es la ultima fila, hago el salto loopa
	
 	ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

    br lr
    // --------------------------------------------------------------------------------------------------------------------------------------------------------------------  
    dibujarLuna:
    
    sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]

	mov x7, x3
	mov x8, x4
	add x5, x4,x1		// con x5 me fijo si llego a final de Y
	add x6, x3,x1		// con x6 me fijo si llega al final de X
					          
	mov x15, x3
	mov x16, x4
	sub x3, x3, x1      // Inicio X		
		
resetYL:

	cmp x3, x6
	b.gt end
	sub x4, x5, x1
	sub x4, x4, x1  // Inicio Y
        

cirloopL:
	cmp x4,x5
	b.eq next_fila

	sub x9, x3, x15			   
	mul x9, x9, x9				// x9 = (x0.fila - x3)**2 	
		
	sub x11, x4, x16			   
	mul x11, x11, x11			// x11 = (x0.columna - x4)**2

	add x13, x9, x11			// x13 = (x0.fila - x1)*2 + (x0.columna - x2)*2

	mov x12, x1
	mul x12, x12, x12			// x12 = radio**2

	cmp x12, x13
	
	B.GE color					//si x13 <= x12 
	B skip
colorL:		
	BL Pintarpixel	// then pintar pixel
	stur w10,[x0]
	
	
	
skipL:
	add x4, x4, #1
	                         // avanza pixel
	B cirloop
next_filaL:
	add x3, x3, #1
	B resetY
	
endL: 
	mov x3, x7
	mov x4, x8
	
	
    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

    br lr

	ret
	
 
dibujarCirculo:
/*
	parametros:
				centro = (x3, x4);  x3 es la columna, x4 la fila
				radio = x1
				w10 = color
						
	comportamiento:
				x0 empieza en esquina superior izquierdo del cuadrado que contiene el circulo
				y va recorriendo el cuadrado y si se cumple que x0 esta dentro del circulo dado por
					(x0.fila - x3)*2 + (x0.columna - x4)2 <= x1*2
					\------x9-----/     \------x11-----/   \--x12--/
					   \-------------x13-------------/							 
				se pinta el pixel

*/              

	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]

	mov x7, x3
	mov x8, x4
	add x5, x4,x1		// con x5 me fijo si llego a final de Y
	add x6, x3,x1		// con x6 me fijo si llega al final de X
					          
	mov x15, x3
	mov x16, x4
	sub x3, x3, x1      // Inicio X		
		
resetY:
	cmp x3, x6
	b.gt end
	sub x4, x5, x1
	sub x4, x4, x1      // Inicio Y
cirloop:
	cmp x4,x5
	b.eq next_fila

	sub x9, x3, x15			   
	mul x9, x9, x9				// x9 = (x0.fila - x3)**2 	
		
	sub x11, x4, x16			   
	mul x11, x11, x11			// x11 = (x0.columna - x4)**2

	add x13, x9, x11			// x13 = (x0.fila - x1)*2 + (x0.columna - x2)*2

	mov x12, x1
	mul x12, x12, x12			// x12 = radio**2

	cmp x12, x13
	B.GE color					//si x13 <= x12 
	B skip
color:		
	BL Pintarpixel				// then pintar pixel
	stur w10,[x0]	
skip:
	add x4, x4, #1				// avanza pixel
	B cirloop
next_fila:
	add x3, x3, #1
	B resetY
end:
	mov x3, x7
	mov x4, x8
	
    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

    br lr

dibujartriangulo: 
 
 	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
	
 	mov x8, x2   // 
 	mov x5, 1

 	loopat:
    mov x9, x5
    mov x11, x0
     	 
    coloreart:	
	stur w10,[x0]	   
	add x0,x0,4	   
	sub x9,x9,1	  
	cbnz x9,coloreart
	mov x0, x11   
	sub x8, x8, 1
	sub x0, x0, 2564
	add x5, x5, 2
	cbnz x8,loopat
	
 	ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

    br lr
 
dibujartrianguloparte2: 
 
 	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]

 	mov x8, x2
 	mov x5, 1
 	loopat2:
    mov x9, x5
    mov x11, x0
     	 
    coloreart2:	
	stur w10,[x0]	   
	add x0,x0,4	   
	sub x9,x9,1	  
	cbnz x9,coloreart2
	mov x0, x11   
	sub x8, x8, 1
	add x0, x0, 2556
	add x5, x5, 2
	cbnz x8,loopat2
	
 	ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

    br lr        

grietas:  // parametro : x0 = direccion-pixel-comienzo   

	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
	mov x12, x0

	pinto :
	stur w10,[x12]
	add x12,x12,641
	sub x5,x5,1
	cbnz x5,pinto 
	ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

    br lr
        	
grietas2 : 	// parametro : x0 = direccion-pixel-comienzo   

	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
	mov x12, x0

	pinto2 :
	stur w10,[x12]
	add x12,x12,639
	sub x5,x5,1
	cbnz x5,pinto2 		 
	ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

    br lr

estrella:

	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
	mov x7,x0   

	movz x10, 0xfc,lsl 16
	movk x10, 0xb814, lsl 00	
	mov x1, 5
	mov x2, 5
	bl dibujarcuadrado

	movz x10, 0xfc,lsl 16
	movk x10, 0xb814, lsl 00	
	mov x1, 10
	mov x2, 2
	bl dibujarcuadrado

	movz x10, 0xfc,lsl 16
	movk x10, 0xb814, lsl 00	
	mov x1, 2
	mov x2, 10
	bl dibujarcuadrado
		
    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

	br lr		

dibujarmario:    // x0 = direccion 

	sub sp, sp, #8 // Guardo el puntero de retorno en el stack
    stur lr, [sp]
      		
    mov x7,x0      
      		
    //cuerpo mario
	movz x10, 0xff,lsl 16
	movk x10, 0x0000, lsl 00	
	mov x1, 30
	mov x2, 40
	bl dibujarcuadrado
	
	//brazo izquierdo
		
	movz x10, 0x99,lsl 16
	movk x10, 0x4c00, lsl 00
	mov x1, 13
	mov x2, 13
		
	sub x0,x0,32

	BL dibujarcuadrado
        	
        	
    //brazo derecho
        	
	add x0,x0,132
        	
	bl dibujarcuadrado
        	
    // muneca derecha
        	
    mov x1, 5
	mov x2, 13
        	
    mov x7,5
    mov x6,4000
    mul x6,x6,x7
    add x6,x6,528
	add x0,x0,x6
        	
	bl dibujarcuadrado
        	
        	
        	
	// muneca izquierda
        	
    sub x0,x0,196
        	
	bl dibujarcuadrado
        	
    // cara
        	
	movz x10, 0xff,lsl 16
	movk x10, 0xb401, lsl 00
	mov x1, 20
	mov x2, 25
		
	mov x8,42
	mov x6,2000
	mul x6,x6,x8
	add x6,x6,412
		
	sub x0,x0,x6
		
	bl dibujarcuadrado
		
	// ojos
		
	movz x10, 0xffff,lsl 16
	movk x10, 0xffff, lsl 00	
	mov x1, 5
	mov x2, 5	
	mov x5,2000
	mov x6,5
	mul x5,x5,x6
	add x5, x5 ,280
		
	add x0,x0,x5
		
	bl dibujarcuadrado
		
	// pelo
		
	movz x10, 0x0,lsl 16
	movk x10, 0x0000, lsl 00
	mov x1, 15
	mov x2, 5	
	sub x0,x0,92
		
	bl dibujarcuadrado
		
	// orejas,nariz
		
	movz x10, 0xff,lsl 16
	movk x10, 0xb401, lsl 00	
	mov x1, 32
	mov x2, 6
		
	mov x5,5000
	lsl x5,x5,1
	add x5,x5,264
		
	add x0,x0,x5
		
	bl dibujarcuadrado
		
	// gorro
		
	movz x10, 0xff,lsl 16
	movk x10, 0x0000, lsl 00
	
	mov x1, 40
	mov x2, 6
		
	mov x5,4000
	mov x6,6
	mul x5,x5,x6
	add x5,x5,1612
		
	sub x0,x0,x5
		
	bl dibujarcuadrado
		
	// gorro-arriba
		
	mov x1, 25
	mov x2, 6
	mov x5,4000
	mov x6,3
	mul x5,x5,x6
	add x5,x5,772
		
	sub x0,x0,x5
		
	bl dibujarcuadrado
		
	// medio-pierna
		
	movz x10, 0x2f,lsl 16
	movk x10, 0x3699, lsl 00
		
	mov x1, 10
	mov x2, 17
	mov x5,2000
	mov x6,70
		
	mul x5,x5,x6
	add x5,x5,832
		
	add x0,x0,x5
		
	bl dibujarcuadrado
		
    ldur lr, [sp] // Recupero el puntero de retorno del stack
    add sp, sp, #8 

    br lr
	