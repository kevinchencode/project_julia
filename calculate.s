#unisigned int iterate(complex_num r4-r5)
#complex_num equation(complex_num r4-r5)

.equ maxiter, 128
.equ threshold, 4

iterate:
	addi sp, sp, -32
	stw  r16, 0(sp)
	stw  r17, 4(sp)
	stw  r18, 8(sp)
	stw  r4,  12(sp)
	stw  r5,  16(sp)

	movi r6, maxiter
	movi r7, threshold
	movi r16, 0

	iterate_loop:
		beq r6, r16, iterate_loop_done
		call complex_magnitude
		bgt r2, threshold, iterate_loop_done
		call equation
		br iterate_loop
	iterate_loop_done:

	ldw  r5,  16(sp)
	ldw  r4,  12(sp)
	ldw  r18, 8(sp)
	ldw  r17, 4(sp)
	ldw  r16, 0(sp)
	addi sp, sp, 32
	ret


equation:
	addi sp, sp, -12
	stw  ra, 0(sp)
	stw  r4, 4(sp)
	stw  r5, 8(sp)

	mov  r6, r4
	mov  r7, r5
	call complex_multiply
	mov  r4, r2
	mov  r5, r3

	ldw  r5, 8(sp)
	ldw  r4, 4(sp)
	ldw  ra, 0(sp)
	addi sp, sp, 12