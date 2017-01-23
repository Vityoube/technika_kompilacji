		jump.i	#lab0
f:
		enter.i	#32
		leave
		return
p:
		enter	#200
		leave
		return
p:
		enter	#224
		leave
		return
lab0:
		call	#p
		push.r	#10.200000
		push.r	#5.400000
		push.i	#2
		call	#p
		exit
