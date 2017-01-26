		jump.i	#lab0
lab0:
lab1:
		jl.i	48, 84, #lab2
		mov.i	96, #0
		jump.i	#lab3
lab2:
		mov.i	96, #1
lab3:
		je.i	96, #0, #lab4
		jl.i	100, 0, #lab4
		mov.i	100, #0
		jump.i	#lab5
lab4:
		mov.i	100, #1
lab5:
		je.i	100, #0, #lab6
		add.i	108, 48, #3
		mov.i	48, 108
		jump.i	#lab1
lab6:
		exit
