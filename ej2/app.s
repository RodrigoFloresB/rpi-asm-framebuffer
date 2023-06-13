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
	
    mov x27,0     
    							//mov x13, 0 // Para gpio  

    // fondo noche
    bl Calcularpixel
    bl fondoNoche
	
	mov x3, 0
	mov x4, 410
	bl Calcularpixel
	bl portalparametrizado

    // MARIO
    mov x3, 305
    mov x4, 400
    bl Calcularpixel
    bl dibujarmario

	// Pos inicial pj
    mov x28, x3 // x
	mov x29, x4 // y

    // GPIO
    //mov x24,0
    
    loop1:
    //leo_gpio://uso registros 10 y 11
	
	mov x9, GPIO_BASE                //direccion del GPIO a x9
	str wzr, [x9, GPIO_GPFSEL0]     //GPIO como solo lectura
	ldr w10, [x9, GPIO_GPLEV0]
	// Filtrado de teclas
	and w27,w10,0b10		// w27 : w
	and w13,w10,0b100		// w13 : a 
	and w25,w10,0b1000		// w25 : s
	and w14,w10,0b10000		// w14 : d	
	and w26,w10,0b100000	// w26 : espacio

	
	cmp w27, 0
	b.ne teclaW
	///////////////////////////
	cmp w13,0				// &w13 = 0 ? Si no lo es, se va a "TeclaA"
	b.ne teclaA 
	///////////////////////////
	cmp w25,0
	b.ne teclaS
	///////////////////////////
	cmp w14,0
	b.ne teclaD

	///////////////////////////
	cmp w26,0
	b.ne saltar

	b.eq loop1


teclaW:
	bl delay2
    // fondo noche
    bl Calcularpixel
    bl fondoNoche

	// recuperando la posicion

	mov x3, x28
	mov x4, x29

    // MARIO 
	sub x4, x4, 1
    bl Calcularpixel
    bl dibujarmario

	mov x28, x3
	mov x29, x4
		
	mov x3, 0
	mov x4, 410
	bl Calcularpixel
	bl portalparametrizado


	cbz x3, resetW
	resetW:
	mov x3, 640

										
	b loop1

teclaS:
	bl delay2
    // fondo noche
    bl Calcularpixel
    bl fondoNoche

	// recuperando la posicion

	mov x3, x28
	mov x4, x29

    // MARIO 
	add x4, x4, 1
    bl Calcularpixel
    bl dibujarmario

	mov x28, x3
	mov x29, x4
		
	mov x3, 0
	mov x4, 410
	bl Calcularpixel
	bl portalparametrizado


	cbz x3, resetS
	resetS:
	mov x3, 640

										
	b loop1								

teclaA:
	bl delay2

    // fondo noche
    mov x3, 0
    mov x4, 0
    bl Calcularpixel
    bl fondoNoche

	// recuperando la posicion

	mov x3, x28
	mov x4, x29

    // MARIO 
	sub x3, x3, 1
    bl Calcularpixel
    bl dibujarmario

	mov x28, x3
	mov x29, x4
		
	mov x3, 0
	mov x4, 410
	bl Calcularpixel
	bl portalparametrizado


	cbz x3, resetx
	resetx:
	mov x3, 640
										
	b loop1									
	
teclaD: 
	bl delay2
	    // fondo noche
    mov x3, 0
    mov x4, 0
    bl Calcularpixel
    bl fondoNoche

	// recuperando la posicion

	mov x3, x28
	mov x4, x29

    // MARIO
	add x3, x3, 1
    bl Calcularpixel
    bl dibujarmario

	mov x28, x3
	mov x29, x4

		
	mov x3, 0
	mov x4, 410
	bl Calcularpixel
	bl portalparametrizado

	cbz x3, resetxx

	resetxx:
	mov x3, 640

										//mov w27, w13
	b loop1		
	
saltar:
	bl delay2

	
	// fondo noche
    bl Calcularpixel
    bl fondoNoche

	// recuperando la posicion

	mov x3, x28
	mov x4, x29
	sub x4, x4, 40
    bl Calcularpixel
    bl dibujarmario

	mov x3, 0
	mov x4, 410
	bl Calcularpixel
	bl portalparametrizado
    
	bl delay //Espera antes de volver al piso
     
	bl Calcularpixel
    bl fondoNoche

	mov x3, x28
	mov x4, x29
	bl Calcularpixel
	bl dibujarmario

	mov x28, x3
	mov x29, x4

	mov x3, 0
	mov x4, 410
	bl Calcularpixel
	bl portalparametrizado

	cbz x3, resetxxxx

	resetxxxx:
	mov x3, 640
				
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
