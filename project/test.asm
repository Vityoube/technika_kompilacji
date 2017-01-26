		jump.i	#lab0
f:
		enter.i	#116
		mov.i	8, #2
		mov.i	100, #2
		mov.i	104, #3
		mul.i	292, 100, 104
		realtoint.i	300, 108
		add.i	304, 296, 300
		add.i	312, 308, 120
		mov.i	120, 312
		mov.r	108, #5.100000
		leave
		return
p:
		enter	#316
		leave
		return
p:
		enter	#340
		call	#p
		leave
		return
lab0:
		call	#p
		read.i	8
		read.i	12
		read.i	36
		realtoint.r	344, #0.200000
		mov.i	8, 344
		realtoint.r	348, #3.100000
		add.i	352, #2, 348
		mov.i	12, 352
		mov.i	48, 36
		push.i	#8
		push.i	#12
		push.r	#20
		call.i	#f
		incsp.i	#116
		mov.i	8, 116
		inttoreal.i	356, 28
		mov.r	52, 356
		mov.r	60, 364
		mov.r	68, 372
		mov.r	76, 380
		mov.r	84, 388
		mov.r	92, 396
		jl.i	8, 12, #lab1
		mov.i	404, #0
		jump.i	#lab2
lab1:
		mov.i	404, #1
lab2:
		je.i	404, #0, #lab3
		jl.i	408, 0, #lab3
		mov.i	408, #0
		jump.i	#lab4
lab3:
		mov.i	408, #1
lab4:
		je.i	408, #0, #lab5
		mov.i	8, #3
		jump.i	#lab6
lab5:
		jl.i	8, 12, #lab6
		mov.i	416, #0
		jump.i	#lab7
lab6:
		mov.i	416, #1
lab7:
		je.i	416, #0, #lab8
		jl.i	16, 0, #lab8
		mov.i	424, #0
		jump.i	#lab9
lab8:
		mov.i	424, #1
lab9:
		and.i	432, 420, 428
		jl.i	432, 0, #lab10
		mov.i	432, #0
		jump.i	#lab11
lab10:
		mov.i	432, #1
lab11:
		je.i	432, #0, #lab12
		jl.i	440, 0, #lab12
		mov.i	440, #0
		jump.i	#lab13
lab12:
		mov.i	440, #1
lab13:
		je.i	440, #0, #lab14
		write.i	#10
		write.i	28
		write.r	20
lab14:
		write.i	8
lab15:
lab16:
		jl.i	8, 12, #lab17
		mov.i	448, #0
		jump.i	#lab18
lab17:
		mov.i	448, #1
lab18:
		je.i	448, #0, #lab19
		jump.i	#lab18
lab19:
		add.i	452, 8, #3
		mov.i	8, 452
lab20:
		jl.i	8, 32, #lab21
		mov.i	456, #0
		jump.i	#lab22
lab21:
		mov.i	456, #1
lab22:
		je.i	456, #0, #lab23
		jl.i	460, 0, #lab23
		mov.i	460, #0
		jump.i	#lab24
lab23:
		mov.i	460, #1
lab24:
		je.i	460, #0, #lab25
		sub.i	468, 8, #3
		mov.i	8, 468
		jump.i	#lab20
		realtoint.i	472, 20
		mov.i	12, 472
		jump.i	#lab16
lab25:
		push.r	#10.200000
		push.r	#5.400000
		push.i	#2
		call	#p
		exit
