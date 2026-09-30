
tmp/ghost.o:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000000000000 <ltmp0>:
       0: a9bf7bfd     	stp	x29, x30, [sp, #-0x10]!
       4: 910003fd     	mov	x29, sp
       8: 6b00003f     	cmp	w1, w0
       c: 1a9f17e0     	cset	w0, eq
      10: a8c17bfd     	ldp	x29, x30, [sp], #0x10
      14: d65f03c0     	ret
