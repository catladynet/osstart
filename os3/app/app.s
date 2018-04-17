.code32
.global start
start:
        movl $((80*5+0)*2), %edi                #在第5行第0列打印
        movb $0x0c, %ah                         #黑底红字
        movb $72, %al                           #72为H的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
1:      hlt
        jmp 1b   
        movb $101, %al                           #101为e的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
        movb $108, %al                           #108为l的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
        movb $108, %al                           #108为l的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
        movb $111, %al                           #111为o的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
        movb $44, %al                           #44为,的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
        movb $87, %al                           #87为W的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
        movb $111, %al                           #111为o的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
        movb $114, %al                           #114为r的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
        movb $108, %al                           #108为l的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
        movb $100, %al                           #100为d的ASCII码
        movw %ax, %gs:(%edi)                    #写显存
        movb $33, %al                           #33为!的ASCII码
        movw %ax, %gs:(%edi)                    #写显存