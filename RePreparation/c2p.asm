@thumb
	push {lr}
	mov	r0, #52		;;iõBGM
	ldr  r1, =$08002570
	mov  lr, r1
	@dcw $F800
	pop {pc}