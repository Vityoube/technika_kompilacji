        jump.i  #lab0                   ;jump.i  lab0
lab0:
        sub.i   #8,#1,40                ;sub.i   8,1,$t0
        mul.i   40,#4,40                ;mul.i   $t0,4,$t0
        add.i   #0,40,44                ;add.i   &a,$t0,$t1
        mov.i   #9,*44                  ;mov.i   9,$t1
        exit                            ;exit    
