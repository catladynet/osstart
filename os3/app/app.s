.code32
.global start
start:
        movl $((80*3+0)*2), %edi                #在第3行第0列打印
        movb $0x0c, %ah                         #黑底红字
        movb $72, %al                           #72为H的ASCII码
        movw %ax, %gs:(%edi)                    #写显存   
        movl $((80*3+1)*2), %edi                #在第3行第1列打印
        movb $101, %al                          #101为e的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
        movl $((80*3+2)*2), %edi                #在第3行第2列打印
        movb $108, %al                          #108为l的ASCII码
        movw %ax, %gs:(%edi)                 
        movl $((80*3+3)*2), %edi               
        movb $108, %al                          #108为l的ASCII码
        movw %ax, %gs:(%edi)                    
        movl $((80*3+4)*2), %edi             
        movb $111, %al                          #111为o的ASCII码
        movw %ax, %gs:(%edi)                    
        movl $((80*3+5)*2), %edi               
        movb $44, %al                           #44为,的ASCII码
        movw %ax, %gs:(%edi)                    
        movl $((80*3+6)*2), %edi                
        movb $87, %al                           #87为W的ASCII码
        movw %ax, %gs:(%edi)                    
        movl $((80*3+7)*2), %edi                
        movb $111, %al                          #111为o的ASCII码
        movw %ax, %gs:(%edi)                    
        movl $((80*3+8)*2), %edi                
        movb $114, %al                          #114为r的ASCII码
        movw %ax, %gs:(%edi)                    
        movl $((80*3+9)*2), %edi                
        movb $108, %al                          #108为l的ASCII码
        movw %ax, %gs:(%edi)                    
        movl $((80*3+10)*2), %edi               
        movb $100, %al                          #100为d的ASCII码
        movw %ax, %gs:(%edi)                    
        movl $((80*3+11)*2), %edi               
        movb $33, %al                           #33为!的ASCII码
        movw %ax, %gs:(%edi)                    
1:      hlt                                     
        jmp 1b                                  #无限循环