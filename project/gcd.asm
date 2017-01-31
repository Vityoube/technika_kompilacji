		jump.i	#lab0
gcd:
		enter.i	#40
		jl.i	36, 0, #gcd1
		mov.i	48, #0
		jump.i	#gcd2
gcd1:
		mov.i	48, #1
gcd2:
		jl.i	52, 0, #gcd3
		mov.i	52, #0
		jump.i	#gcd4
gcd3:
		mov.i	52, #1
gcd4:
		je.i	52, #0, #gcd5
		mov.i	44, 32
		jump.i	#gcd6
gcd5:
