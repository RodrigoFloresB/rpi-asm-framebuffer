	.equ SCREEN_WIDTH,   640
	.equ SCREEN_HEIGH,   480
	.equ BITS_PER_PIXEL, 32

	.equ GPIO_BASE,    0x3f200000
	.equ GPIO_GPFSEL0, 0x00
	.equ GPIO_GPLEV0,  0x34


	.include "funs.s"
    
	.globl main

main:

	// x0 contiene la direccion base del framebuffer
	mov x20, x0 // Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------
           
    mov x13, 0 // Para gpio  

    fondoNoche:

    mov x27, x13

    // CIELO
    movz x10, 0x00, lsl 16
    movk x10, 0x0033, lsl 00
    mov x1, 640  //Tamaño X
    mov x2, 120// Tamaño Y
    mov x3, 0  //Posicion X
    mov x4, 0 //Posicion Y     
    BL Pintarpixel
    BL dibujarcielo
        
    // LUNA2
	movz x10, 0x00, lsl 16  
	movk x10, 0x0033, lsl 00
    mov x4, 50 
    mov x3, 70	
    mov x1, 41
    BL Pintarpixel		
    BL dibujarLuna    
     
	// MEDIA LUNA (LUNA TAPADA)
    movz x10, 0xc0, lsl 16  
    movk x10, 0xc0c0, lsl 00
	mov x4, 50  
    mov x3, 70	
    mov x1, 38  	
    BL Pintarpixel			
    BL dibujarLuna
    
    //   crater
	movz x10, 0xa0, lsl 16  
	movk x10, 0xa0a0, lsl 00
    mov x4, 30
    mov x3, 70	
    mov x1, 4
    BL Pintarpixel		
    BL dibujarLuna
    
    //   crater 2
	movz x10, 0xa0, lsl 16  
	movk x10, 0xa0a0, lsl 00
    mov x4, 50
    mov x3, 70
    mov x1, 3
    BL Pintarpixel		
    BL dibujarLuna
    
    //   crater 3
	movz x10, 0xa0, lsl 16  
	movk x10, 0xa0a0, lsl 00
    mov x4, 80
    mov x3, 65	
    mov x1, 3
    BL Pintarpixel		
    BL dibujarLuna
    
    //   crater 4
	movz x10, 0xa0, lsl 16  
	movk x10, 0xa0a0, lsl 00
    mov x4, 60
    mov x3, 83	
    mov x1, 4
    BL Pintarpixel		
    BL dibujarLuna
    
	//   crater 5
	movz x10, 0xa0, lsl 16  
	movk x10, 0xa0a0, lsl 00
    mov x4, 40
    mov x3, 85
    mov x1, 4
    BL Pintarpixel		
    BL dibujarLuna
    
	//   crater 6
	movz x10, 0xa0, lsl 16  
	movk x10, 0xa0a0, lsl 00
    mov x4, 30
    mov x3, 50
    mov x1, 3
    BL Pintarpixel		
    BL dibujarLuna
    
    //   crater 7
	movz x10, 0xa0, lsl 16  
	movk x10, 0xa0a0, lsl 00
    mov x4, 70
    mov x3, 50
    mov x1, 3
    BL Pintarpixel		
    BL dibujarLuna
    
    //   crater 8
	movz x10, 0xa0, lsl 16  
	movk x10, 0xa0a0, lsl 00
    mov x4, 55
    mov x3, 55
    mov x1, 3
    BL Pintarpixel		
    BL dibujarLuna
    
    // EDI 1 
    movz x10, 0xe5, lsl 16 
    movk x10, 0xaa7a, lsl 00
    mov x1, 210   //Tamaño X
    mov x2, 260 // Tamaño Y
    mov x3, 0  //Posicion X
    mov x4, 120  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado
    
    // EDI 2
	movz x10, 0x2f, lsl 16 
    movk x10, 0x3699, lsl 00
    mov x1, 220   //Tamaño X
    mov x2, 290 // Tamaño Y
    mov x3, 210  //Posicion X
    mov x4, 90  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado 
          
    // EDI 3
    movz x10, 0x78, lsl 16 
    movk x10, 0x0828, lsl 00
    mov x1, 210   //Tamaño X
    mov x2, 260 // Tamaño Y
    mov x3, 430 //Posicion X
    mov x4, 120  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado
    
	// CONTORNOS DE LOS EDIFICIOS
    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 210   //Tamaño X
    mov x2, 5 // Tamaño Y
    mov x3, 0 //Posicion X
    mov x4, 120  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 230   //Tamaño X
    mov x2, 5 // Tamaño Y
    mov x3, 205 //Posicion X
    mov x4, 90  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 210 //Tamaño X
    mov x2, 5 // Tamaño Y
    mov x3, 430 //Posicion X
    mov x4, 120  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 5  //Tamaño X
    mov x2, 290 // Tamaño Y
    mov x3, 210 //Posicion X
    mov x4, 90  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado
	
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 5  //Tamaño X
    mov x2, 290 // Tamaño Y
    mov x3, 425 //Posicion X
    mov x4, 90  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado
       
    // TECHO EDI 3
    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 85  
    mov x2, 85  
    mov x3, 550 
    mov x4, 40
    BL Pintarpixel
    BL dibujartrianguloparte2

    movz x10, 0x78, lsl 16 
    movk x10, 0x0828, lsl 00
    mov x1, 75  
    mov x2, 75  
    mov x3, 550 
    mov x4, 50
    BL Pintarpixel
    BL dibujartrianguloparte2

    // VENTANAS
    // VENTANA EDI 1
    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 105  //Tamaño X
    mov x2, 80 // Tamaño Y
    mov x3, 52 //Posicion X
    mov x4, 180//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    movz x10, 0xff, lsl 16 
    movk x10, 0xf200, lsl 00
    mov x1, 95  //Tamaño X
    mov x2, 70 // Tamaño Y
    mov x3, 57 //Posicion X
    mov x4, 185//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    // VENTANA EDI 2 
    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 105  //Tamaño X
    mov x2, 100 // Tamaño Y
    mov x3, 265 //Posicion X
    mov x4, 155//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    movz x10, 0xff, lsl 16 
    movk x10, 0xf200, lsl 00
    mov x1, 95  //Tamaño X
    mov x2, 90 // Tamaño Y
    mov x3, 270 //Posicion X
    mov x4, 160//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 125  //Tamaño X
    mov x2, 20 // Tamaño Y
    mov x3, 255 //Posicion X
    mov x4, 255//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    // VENTANA EDI 3
    movz x10, 0x00, lsl 16
    movk x10, 0x0000, lsl 00
    mov x4, 210 // posicion Y
    mov x1, 50  // radio		
    mov x3, 550	// posicion X
    BL Pintarpixel			
    BL dibujarCirculo

    movz x10, 0xff, lsl 16
    movk x10, 0xf200, lsl 00
    mov x4, 210 // posicion Y
    mov x1, 45  // radio		
    mov x3, 550	// posicion X
    BL Pintarpixel			
    BL dibujarCirculo

    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 5  //Tamaño X
    mov x2, 99 // Tamaño Y
    mov x3, 549 //Posicion X
    mov x4, 161//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 99  //Tamaño X
    mov x2, 5 // Tamaño Y
    mov x3, 501 //Posicion X
    mov x4, 210//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    // MARIO
    mov x3, 305
    mov x4, 340
    BL Pintarpixel
    BL dibujarmario
     

	// PORTAL IZQ
	// CONTORNO PORTAL
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 50 //Tamaño X
    mov x2, 70  // Tamaño Y
    mov x3, 0 //Posicion X
    mov x4, 310 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo
	
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 20 //Tamaño X
    mov x2, 80  // Tamaño Y
    mov x3, 50 //Posicion X
    mov x4, 300 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

	// PORTAL
	movz x10, 0x00, lsl 16 
    movk x10, 0xff00, lsl 00
    mov x1, 40 //Tamaño X
    mov x2, 60  // Tamaño Y
    mov x3, 5 //Posicion X
    mov x4, 315 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

	movz x10, 0x00, lsl 16 
    movk x10, 0xff00, lsl 00
    mov x1, 10 //Tamaño X
    mov x2, 70  // Tamaño Y
    mov x3, 55 //Posicion X
    mov x4, 305 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

	// PORTAL DER
	// CONTORNO PORTAL
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 50 //Tamaño X
    mov x2, 70  // Tamaño Y
    mov x3, 590 //Posicion X
    mov x4, 310 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo
	
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 20 //Tamaño X
    mov x2, 80  // Tamaño Y
    mov x3, 570 //Posicion X
    mov x4, 300 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

	// PORTAL
	movz x10, 0x00, lsl 16 
    movk x10, 0xff00, lsl 00
    mov x1, 40 //Tamaño X
    mov x2, 60  // Tamaño Y
    mov x3, 595 //Posicion X
    mov x4, 315 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

	movz x10, 0x00, lsl 16 
    movk x10, 0xff00, lsl 00
    mov x1, 10 //Tamaño X
    mov x2, 70  // Tamaño Y
    mov x3, 575 //Posicion X
    mov x4, 305 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

    //CALLE
    movz x10, 0x40, lsl 16 
    movk x10, 0x4040, lsl 00
    mov x1, 640   //Tamaño X
    mov x2, 100  // Tamaño Y
    mov x3, 0    //Posicion X
    mov x4, 380   //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

	// CONTORNO CALLE 
    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 640   //Tamaño X
    mov x2, 5  // Tamaño Y
    mov x3, 0    //Posicion X
    mov x4, 380   //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    // grietas-derecha
    mov x3, 50
    mov x4, 400
    mov x5, 250
    BL Pintarpixel
	BL grietas    	
	
	mov x3, 110
	mov x4,410
	mov x5, 200
	BL Pintarpixel
	BL grietas    	
	
    // grietas-izquierda
    mov x3, 70
    mov x4, 400
    mov x5, 250
    BL Pintarpixel
	BL grietas2 
    	
    mov x3, 150
    mov x4, 400
    mov x5, 250
    BL Pintarpixel
	BL grietas2 
	


    // GPIO
    mov x24,0
      
    loop1:
    //leo_gpio://uso registros 10 y 11
	
	mov x9, GPIO_BASE                //direccion del GPIO a x9
	str wzr, [x9, GPIO_GPFSEL0]     //GPIO como solo lectura
	ldr w10, [x9, GPIO_GPLEV0]
	and w13, w10, 0b10
	cmp w27,w13
	b.eq loop1
	mov w27, w13
	cbz w27, loop1
	cmp w24,0
	b.eq fondoDia
	b.ne fondoNoche
	cbnz w13, fondoDia

	b loop1
    

    //  -------------------------------------
    
	fondoDia:     
    
    mov x27, x13 // Para gpio

    // CIELO

    movz x10, 0x12, lsl 16
    movk x10, 0xbdc9, lsl 00
    mov x1, 640  //Tamaño X
    mov x2, 120// Tamaño Y
    mov x3, 0  //Posicion X
    mov x4, 0 //Posicion Y     
    BL Pintarpixel
    BL dibujarcuadrado
	
	// SOL
    movz x10, 0xe0, lsl 16  
    movk x10, 0xc83f, lsl 00
	mov x4, 50  
    mov x3, 70	
    mov x1, 38  	
    BL Pintarpixel			
    BL dibujarLuna
	
    // EDI 1 
    movz x10, 0xe5, lsl 16 
    movk x10, 0xaa7a, lsl 00
    mov x1, 210   //Tamaño X
    mov x2, 260 // Tamaño Y
    mov x3, 0  //Posicion X
    mov x4, 120  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado
    
    // EDI 2
	movz x10, 0x2f, lsl 16 
    movk x10, 0x3699, lsl 00
    mov x1, 220   //Tamaño X
    mov x2, 290 // Tamaño Y
    mov x3, 210  //Posicion X
    mov x4, 90  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado 
          
    // EDI 3
    movz x10, 0x78, lsl 16 
    movk x10, 0x0828, lsl 00
    mov x1, 210   //Tamaño X
    mov x2, 260 // Tamaño Y
    mov x3, 430 //Posicion X
    mov x4, 120  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado
    
	// CONTORNOS DE LOS EDIFICIOS
    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 210   //Tamaño X
    mov x2, 5 // Tamaño Y
    mov x3, 0 //Posicion X
    mov x4, 120  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 230   //Tamaño X
    mov x2, 5 // Tamaño Y
    mov x3, 205 //Posicion X
    mov x4, 90  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 210 //Tamaño X
    mov x2, 5 // Tamaño Y
    mov x3, 430 //Posicion X
    mov x4, 120  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 5  //Tamaño X
    mov x2, 290 // Tamaño Y
    mov x3, 210 //Posicion X
    mov x4, 90  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado
	
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 5  //Tamaño X
    mov x2, 290 // Tamaño Y
    mov x3, 425 //Posicion X
    mov x4, 90  //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado
       
    // TECHO EDI 3
    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 85  
    mov x2, 85  
    mov x3, 550 
    mov x4, 40
    BL Pintarpixel
    BL dibujartrianguloparte2

    movz x10, 0x78, lsl 16 
    movk x10, 0x0828, lsl 00
    mov x1, 75  
    mov x2, 75  
    mov x3, 550 
    mov x4, 50
    BL Pintarpixel
    BL dibujartrianguloparte2

    // VENTANAS
    // VENTANA EDI 1
    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 105  //Tamaño X
    mov x2, 80 // Tamaño Y
    mov x3, 52 //Posicion X
    mov x4, 180//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    movz x10, 0xd1, lsl 16 
    movk x10, 0xe7ed, lsl 00
    mov x1, 95  //Tamaño X
    mov x2, 70 // Tamaño Y
    mov x3, 57 //Posicion X
    mov x4, 185//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    // VENTANA EDI 2 
    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 105  //Tamaño X
    mov x2, 100 // Tamaño Y
    mov x3, 265 //Posicion X
    mov x4, 155//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    movz x10, 0xd1, lsl 16 
    movk x10, 0xe7ed, lsl 00
    mov x1, 95  //Tamaño X
    mov x2, 90 // Tamaño Y
    mov x3, 270 //Posicion X
    mov x4, 160//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 125  //Tamaño X
    mov x2, 20 // Tamaño Y
    mov x3, 255 //Posicion X
    mov x4, 255//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    // VENTANA EDI 3
    movz x10, 0x00, lsl 16
    movk x10, 0x0000, lsl 00
    mov x4, 210 // posicion Y
    mov x1, 50  // radio		
    mov x3, 550	// posicion X
    BL Pintarpixel			
    BL dibujarCirculo

    movz x10, 0xd1, lsl 16 
    movk x10, 0xe7ed, lsl 00
    mov x4, 210 // posicion Y
    mov x1, 45  // radio		
    mov x3, 550	// posicion X
    BL Pintarpixel			
    BL dibujarCirculo

    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 5  //Tamaño X
    mov x2, 99 // Tamaño Y
    mov x3, 549 //Posicion X
    mov x4, 161//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 99  //Tamaño X
    mov x2, 5 // Tamaño Y
    mov x3, 501 //Posicion X
    mov x4, 210//Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

	// PORTAL IZQ
	// CONTORNO PORTAL
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 50 //Tamaño X
    mov x2, 70  // Tamaño Y
    mov x3, 0 //Posicion X
    mov x4, 310 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo
	
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 20 //Tamaño X
    mov x2, 80  // Tamaño Y
    mov x3, 50 //Posicion X
    mov x4, 300 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

	// PORTAL
	movz x10, 0x00, lsl 16 
    movk x10, 0xff00, lsl 00
    mov x1, 40 //Tamaño X
    mov x2, 60  // Tamaño Y
    mov x3, 5 //Posicion X
    mov x4, 315 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

	movz x10, 0x00, lsl 16 
    movk x10, 0xff00, lsl 00
    mov x1, 10 //Tamaño X
    mov x2, 70  // Tamaño Y
    mov x3, 55 //Posicion X
    mov x4, 305 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

	// PORTAL DER
	// CONTORNO PORTAL
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 50 //Tamaño X
    mov x2, 70  // Tamaño Y
    mov x3, 590 //Posicion X
    mov x4, 310 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo
	
	movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 20 //Tamaño X
    mov x2, 80  // Tamaño Y
    mov x3, 570 //Posicion X
    mov x4, 300 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

	// PORTAL
	movz x10, 0x00, lsl 16 
    movk x10, 0xff00, lsl 00
    mov x1, 40 //Tamaño X
    mov x2, 60  // Tamaño Y
    mov x3, 595 //Posicion X
    mov x4, 315 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

	movz x10, 0x00, lsl 16 
    movk x10, 0xff00, lsl 00
    mov x1, 10 //Tamaño X
    mov x2, 70  // Tamaño Y
    mov x3, 575 //Posicion X
    mov x4, 305 //Posicion Y
    BL Pintarpixel
    BL dibujarcielo

    //CALLE
    movz x10, 0x85, lsl 16 
    movk x10, 0x8585, lsl 00
    mov x1, 640   //Tamaño X
    mov x2, 100  // Tamaño Y
    mov x3, 0    //Posicion X
    mov x4, 380   //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado
    
	// CONTORNO CALLE 
    movz x10, 0x00, lsl 16 
    movk x10, 0x0000, lsl 00
    mov x1, 640   //Tamaño X
    mov x2, 5  // Tamaño Y
    mov x3, 0    //Posicion X
    mov x4, 380   //Posicion Y
    BL Pintarpixel
    BL dibujarcuadrado

    // grietas-derecha
    mov x3, 50
    mov x4, 400
    mov x5, 250
    BL Pintarpixel
	BL grietas    	
	
	mov x3, 110
	mov x4,410
	mov x5, 200
	BL Pintarpixel
	BL grietas    	
	
    // grietas-izquierda
    mov x3, 70
    mov x4, 400
    mov x5, 250
    BL Pintarpixel
	BL grietas2 
    	
    mov x3, 150
    mov x4, 400
    mov x5, 250
    BL Pintarpixel
	BL grietas2 

    mov x24, 1 // PARA GPIO
    b loop1
	
	// Ejemplo de uso de gpios
	mov x9, GPIO_BASE

	// Atención: se utilizan registros w porque la documentación de broadcom
	// indica que los registros que estamos leyendo y escribiendo son de 32 bits

	// Setea gpios 0 - 9 como lectura
	str wzr, [x9, GPIO_GPFSEL0]

	// Lee el estado de los GPIO 0 - 31
	ldr w10, [x9, GPIO_GPLEV0]

	// And bit a bit mantiene el resultado del bit 2 en w10 (notar 0b... es binario)
	// al inmediato se lo refiere como "máscara" en este caso:
	// - Al hacer AND revela el estado del bit 2
	// - Al hacer OR "setea" el bit 2 en 1
	// - Al hacer AND con el complemento "limpia" el bit 2 (setea el bit 2 en 0)
	and w11, w10, 0b00000010

	// si w11 es 0 entonces el GPIO 1 estaba liberado
	// de lo contrario será distinto de 0, (en este caso particular 2)
	// significando que el GPIO 1 fue presionado

	//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop
