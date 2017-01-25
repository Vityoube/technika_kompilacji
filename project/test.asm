		jump.i	#lab0
f:
		enter.i	#116
		mov.i	8, #2
		mov.i	100, #2
		mov.i	104, #3
		mul.i	292, 100, 104
		realtoint.i	296, 108
		add.i	300, 292, 296
		add.i	304, 300, 120
		mov.i	120, 304
		mov.r	108, #5.100000
		leave
		return
p:
		enter	#308
		leave
		return
p:
		enter	#332
		call	#p
		leave
		return
lab0:
		call	#p
		realtoint.r	336, #0.200000
		mov.i	8, 336
		realtoint.r	340, #3.100000
		add.i	344, #2, 340
		mov.i	12, 344
		mov.i	48, 36
		push.i	#8
		push.i	#12
		push.r	#20
		call.i	#f
		incsp.i	#116
		mov.i	8, 116
		inttoreal.i	348, 28
		mov.r	52, 348
		mov.r	60, 356
		mov.r	68, 364
		mov.r	76, 372
		mov.r	84, 380
		mov.r	92, 388
		jl.i	8, 12, #lab1
		mov.i	396, #0
		jump.i	#lab2
lab1:
		mov.i	396, #1
lab2:
		je.i	396, #0, #lab3
		mov.i	8, #3
		jump.i	#lab4
lab3:
		and.i	400, 12, 16
		jl.i	8, 400, #lab4
		mov.i	404, #0
		jump.i	#lab5
lab4:
		mov.i	404, #1
lab5:
		je.i	404, #0, #lab6
