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
    mov x3, 0
    mov x4, 0
    bl Pintarpixel
    bl fondoNoche

    // MARIO
    mov x3, 305
    mov x4, 340
    bl Pintarpixel
    bl dibujarmario

	mov x28, x3

    // GPIO
    //mov x24,0
    
    loop1:
    //leo_gpio://uso registros 10 y 11
	
	mov x9, GPIO_BASE                //direccion del GPIO a x9
	str wzr, [x9, GPIO_GPFSEL0]     //GPIO como solo lectura
	ldr w10, [x9, GPIO_GPLEV0]
	and w13, w10, 0b100				
	cmp w27,w13
	b.eq loop1	


    // fondo noche
    mov x3, 0
    mov x4, 0
    bl Pintarpixel
    bl fondoNoche

	// recuperando la posicion

	mov x3, x28

    // MARIO
	sub x3, x3, 0b1
	mov x4, 340
    bl Pintarpixel
    bl dibujarmario

	mov x28, x3


	//mov w27, w13
	//cbz w27, loop1
	//cmp w24,0
	//cb.ne fondoNoche
	//cbnz w13, fondoDia//
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
