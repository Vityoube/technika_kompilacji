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
		mov.i	348, #1
		inttoreal.i	352, 348
		mov.r	20, 352
		mov.i	48, 36
		push.i	#8
		push.i	#12
		push.r	#20
		call.i	� �+�
		incsp.i	#116
		mov.i	8, 116
		inttoreal.i	360, 28
		mov.r	52, 360
		mov.r	60, 368
		mov.r	68, 376
		mov.r	76, 384
		mov.r	84, 392
		mov.r	92, 400
		push.r	#10.200000
		push.r	#5.400000
		push.i	#2
		call	#p
		exit
