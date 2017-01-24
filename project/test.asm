		jump.i	#lab0
f:
		enter.i	#68
		mov.i	56, #2
		mov.i	52, #3
		realtoint.r	244, #5.100000
		mov.i	52, 244
		add.i	248, 56, 56
		mov.i	52, 252
		leave
		return
p:
		enter	#256
		leave
		return
p:
		enter	#280
		leave
		return
lab0:
		call	#p
		realtoint.r	284, #0.200000
		mov.i	8, 284
		realtoint.r	288, #3.100000
		add.i	292, #2, 288
		mov.i	12, 292
		mov.i	296, #1
		inttoreal.i	300, #1
		mov.r	-1462579056, 300
		mov.i	48, 36
		push.i	#8
		push.i	#12
		push.r	#20
		call.i	
		incsp.i	#68
		mov.i	8, 68
		push.r	#10.200000
		push.r	#5.400000
		push.i	#2
		call	#p
		exit
