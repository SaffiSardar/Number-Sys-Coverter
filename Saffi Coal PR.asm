; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

.model small
.stack 100h


.data  

nameid db "SAFFI SARDAR___F2022266742 $"
notice db "!! Please dont enter data greater than 1FFF, I have not optimized the code to handle left most bit manipulation,because doing so will exceed decimal conversion to 5 character which is not allowed by traditionally using registers, Thanks.                                                                                                                                        METHOD OF USE: input= _ _ _ _,dont put greater then 1 in left most hex !!$"

ultbit dw ?
titles db "WELCOME TO NUMBER SYSTEM CONVERSION MENU $" 
 
    
one db "1. Decimal to Binary $";--------------------------------------
onep dw "Enter Decimal to convert it into binary! $"  
 
 
two db "2. Decimal to Octal $";--------------------------------------                      
twop db "Enter Decimal to convert it into octal! $"
b1 db ? 
 
three db "3. Decimal to Hexadecimal $";--------------------------------------              
threep db "Enter Decimal to convert it into hexadecimal! $"
 
 
four db "4. Binary to Decimal $";--------------------------------------                    
fourp db "Enter binary to convert it into decimal! $"
bin2 dw ? 
saved dw ?
 
five db "5. Octal to Decimal $";--------------------------------------                     
fivep db "Enter octal to convert it into decimal! $"
 
 
six db "6. Hexadecimal to Decimal $";--------------------------------------                
sixp db "Enter Hexadecimal to convert it into decimal! $"
 
 
seven db "7. Binary to Hexadecimal $";--------------------------------------               
sevenp db "Enter Binary to convert it into hexadecimal! $"
bin dw ?
bin1 dw ?
 
 
eight db "8. Hexadecimal to Binary $";--------------------------------------               
eightp db "Enter Hexadecimal to convert it into binary! $" 
ALT dw ?
 
 
nine db "9. Exit $"                  
newline db 13,10," $"

.code
     
      mov ax, @data
      mov ds, ax 
    mov ah, 9
    lea dx, nameid
    int 21h    
    lea dx, notice
    int 21h   
    lea dx, newline
    int 21h
    lea dx, newline
    int 21h
    lea dx, newline
    int 21h
        
      
      
       
    ;Choice Menu
    mov ah, 9
    lea dx, titles
    int 21h    
    lea dx, newline
    int 21h
    lea dx, one 
    int 21h
    lea dx, newline
    int 21h
    lea dx, two 
    int 21h
    lea dx, newline
    int 21h
    lea dx, three 
    int 21h
    lea dx, newline
    int 21h
    lea dx, four 
    int 21h
    lea dx, newline
    int 21h
    lea dx, five 
    int 21h
    lea dx, newline
    int 21h
    lea dx, six 
    int 21h
    lea dx, newline
    int 21h
    lea dx, seven 
    int 21h
    lea dx, newline
    int 21h
    lea dx, eight 
    int 21h
    lea dx, newline
    int 21h
    lea dx, nine 
    int 21h
    lea dx, newline
    int 21h 
    
    ;Choice input
    mov ah,1
    int 21h
    sub al,30h 
    mov cl,al
    mov ah,9
    lea dx, newline
    int 21h 
    
            
    ;Getting into chosen choice
    cmp cl,1
    je onec
    cmp cl,2
    je twoc
    cmp cl,3
    je threec
    cmp cl,4
    je fourc
    cmp cl,5
    je fivec
    cmp cl,6
    je sixc
    cmp cl,7
    je sevenc
    cmp cl,8
    je eightc
    cmp cl,9
    je ninec
      
    ;performing calculation
    onec:    
     
     mov ah,9
     lea dx, onep
     int 21h
         
     mov ah,1    ;input First Num (auto deci to hex because of mul)
     int 21h
     sub al,30h
     mov ah,0
     mov bx,1000
     mul bx 
     mov ultbit,ax
     
     
     mov ah,1              ;input Second Num
     int 21h
     sub al,30h
     mov ah,0
     mov bx,100
     mul bx    
     add ultbit,ax
     
     
     mov ah,1                     ;input Third Num
     int 21h
     sub al,30h
     mov ah,0
     mov bx,10
     mul bx    
     add ultbit,ax
                  
      mov ah,1                          ;input Fourth Num
     int 21h
     sub al,30h
     mov ah,0
     add ultbit,ax
     
     mov ah,9                                  ;newline
     lea dx,newline
     int 21h
     
     repeat:                                    ;outputting binary by shl operator
     
     inc cl
     shl ultbit,1
     jc carry
     mov ah,2
     mov dl,'0'
     int 21h
     cmp cl,17
    je end
     jmp repeat
     carry:
     mov ah,2
     mov dl,'1'
     int 21h   
    cmp cl,17
     je end
     jmp repeat
     end:
    
     jmp ninec
    
    twoc: 
    
     mov ah,9
     lea dx, twop
     int 21h
         
     mov ah,1     ;input First Num (auto deci to hex because of mul)
     int 21h
     sub al,30h
     mov ah,0
     mov bx,1000
     mul bx 
     mov ultbit,ax
     
     
     mov ah,1          ;input Second Num (auto deci to hex because of mul)
     int 21h
     sub al,30h
     mov ah,0
     mov bx,100
     mul bx    
     add ultbit,ax
     
     
     mov ah,1           ;input Third Num (auto deci to hex because of mul)
     int 21h
     sub al,30h
     mov ah,0
     mov bx,10
     mul bx    
     add ultbit,ax
                  
      mov ah,1
     int 21h             ;input Four Num (auto deci to hex because of mul)
     sub al,30h
     mov ah,0
     add ultbit,ax 
   
     
     mov cx,5
     
     mov ah,9
     lea dx,newline
     int 21h
     
     mov b1,0                     ;making comb of left most 3 bit set and ouptutting
     shl ultbit,1
     jnc nexts
     mov b1,1
    
     nexts:
     
    
     floopy:
     
     mov b1,0 
     shl ultbit,1
     jnc next
     mov b1,4
     next:
     shl ultbit,1
     jnc next1
     add b1,2 
     next1:   
     shl ultbit,1
     jnc next2
     add b1,1 
     next2: 
     mov ah,2
     mov dl,b1
     add dl,30h                        ;making six combs of 3 bits and outputting
     mov b1,0
     int 21h
     loop floopy
     
    
     
     
     jmp ninec
    
    threec:    
     
     mov ah,9
     lea dx, threep
     int 21h   
     
      mov ah,1    ;input First Num (auto deci to hex because of mul)
     int 21h
     sub al,30h
     mov ah,0
     mov bx,1000
     mul bx 
     mov ultbit,ax
     
     
     mov ah,1              ;input Second Num
     int 21h
     sub al,30h
     mov ah,0
     mov bx,100
     mul bx    
     add ultbit,ax
     
     
     mov ah,1                     ;input Third Num
     int 21h
     sub al,30h
     mov ah,0
     mov bx,10
     mul bx    
     add ultbit,ax
                  
      mov ah,1                          ;input Fourth Num
     int 21h
     sub al,30h
     mov ah,0
     add ultbit,ax
     
     mov ah,9                                  ;newline
     lea dx,newline
     int 21h 
      
     mov cx,4
     mov b1,0
     
       floopys:
                           ;making six combs of 4 bits and outputting
     mov b1,0 
     shl ultbit,1
     jnc nextss
     mov b1,8
     nextss:
     shl ultbit,1
     jnc next1s
     add b1,4 
     next1s:   
     shl ultbit,1
     jnc next2s
     add b1,2 
     next2s:   
     shl ultbit,1
     jnc next3s
     add b1,1
     next3s:   
     mov ah,2
     mov dl,b1
     cmp dl,10
     jge alpha
     add dl,30h
     jmp movie
     alpha:
     add dl,37h
     movie:
     int 21h  
     loop floopys
    
     jmp ninec
       
    fourc:    
     
     mov ah,9
     lea dx, fourp
     int 21h 
     
      
    mov ah,1
     int 21h
     sub al,30h
     
     mov dx,1
     mov bin,0 
     
     mov cx,15
     poopys:   
     mov ah,1
     int 21h
     sub al,30h
     cmp al,0
     jne pddd
     jmp pexti
     pddd:   
     add bin,dx
     pexti:  
     mov ax,2
     mul dx
     mov dx,ax
     loop poopys
     mov dx,bin
     
     mov cx,16
     mov bin1,0
     peverseit:
                   
        shr bin1,1
        rcl dx,1
        
        jc petit
        jmp pextii
        
        petit:
        or bin1,1000000000000000b   
        pextii:
     loop peverseit 
                
                
     shr bin1,1
     
     mov ah,9                                  ;newline
     lea dx,newline
     int 21h
      
      mov cx,bin1
     mov bin2,cx 
      
     
     mov cx,4
     mov b1,0
     
       ploopysss:
                             ;making six combs of 4 bits and outputting
     mov b1,0 
     shl bin1,1
     jnc pextsss
     mov b1,8
     pextsss:
     shl bin1,1
     jnc pext1ss
     add b1,4 
     pext1ss:   
     shl bin1,1
     jnc pext2ss
     add b1,2 
     pext2ss:   
     shl bin1,1
     jnc pext3ss
     add b1,1
     pext3ss: 
     mov ah,2
     mov dl,b1
     cmp dl,10
     jge plphas
     add dl,30h
     jmp povies
     plphas:
     add dl,37h
     povies:
     int 21h
     loop ploopysss 
     
     mov ah,9                                  ;newline
     lea dx,newline
     int 21h    
     mov saved,0h
     
     ;MAX HEX 1FFF BECAUSE CANT SAVE AND OUPTUT MORE THAN 4 CHARACTERS, WHEREAS >1 PRODUCES 5 DECI CHARACTER
    
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax 
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     
     ;reverse deci
     
     mov dx,saved
     mov cx,16
     mov bin1,0
     eeverseit:
                   
        shr bin1,1
        rcl dx,1
        
        jc eetit
        jmp eextii
        
        eetit:
        or bin1,1000000000000000b   
        eextii:
     loop eeverseit
     
     ;outputting deci
     mov cx,bin1
     mov saved,cx
     
     mov cx,4
     mov b1,0
     
       eloopysss:
                             ;making six combs of 4 bits and outputting
     mov b1,0 
     shl saved,1
     jnc eextsss
     mov b1,1
     eextsss:
     shl saved,1
     jnc eext1ss
     add b1,2 
     eext1ss:   
     shl saved,1
     jnc eext2ss
     add b1,4 
     eext2ss:   
     shl saved,1
     jnc eext3ss
     add b1,8
     eext3ss: 
     mov ah,2
     mov dl,b1
     cmp dl,10
     jge elphas
     add dl,30h
     jmp eovies
     elphas:
     add dl,37h
     eovies:
     int 21h
     loop eloopysss
    
     jmp ninec
    
    fivec:    
      
     ;enter only 4 octals bc deci cant output more than 4 decis     
          
     mov ah,9
     lea dx, fivep
     int 21h  
     
     mov ah,1
     int 21h 
     sub al,30h  
     mov ah,0h
     mov ALT,ax
     shl ALT,3 
     
     MOV CX,3
     
     mov ah,1
     int 21h 
     sub al,30h  
     mov ah,0h
     OR ALT,AX
     shl ALT,3   
     
     mov ah,1
     int 21h 
     sub al,30h  
     mov ah,0h
     OR ALT,AX
     shl ALT,3   
     
     mov ah,1
     int 21h 
     sub al,30h  
     mov ah,0h
     OR ALT,AX
     
     
     
     
     
     
     mov cx,ALT
     mov bin1, cx
     
     mov ah,9                                  ;newline
     lea dx,newline
     int 21h
      
      mov cx,bin1
     mov bin2,cx 
      
     
     mov cx,4
     mov b1,0
     
       rloopysss:
                             ;making six combs of 4 bits and outputting
     mov b1,0 
     shl bin1,1
     jnc rextsss
     mov b1,8
     rextsss:
     shl bin1,1
     jnc rext1ss
     add b1,4 
     rext1ss:   
     shl bin1,1
     jnc rext2ss
     add b1,2 
     rext2ss:   
     shl bin1,1
     jnc rext3ss
     add b1,1
     rext3ss: 
     mov ah,2
     mov dl,b1
     cmp dl,10
     jge rlphas
     add dl,30h
     jmp rovies
     rlphas:
     add dl,37h
     rovies:
     int 21h
     loop rloopysss 
     
     mov ah,9                                  ;newline
     lea dx,newline
     int 21h    
     mov saved,0h
     
     ;MAX HEX 1FFF BECAUSE CANT SAVE AND OUPTUT MORE THAN 4 CHARACTERS, WHEREAS >1 PRODUCES 5 DECI CHARACTER
    
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax 
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     
     ;reverse deci
     
     mov dx,saved
     mov cx,16
     mov bin1,0
     teverseit:
                   
        shr bin1,1
        rcl dx,1
        
        jc tetit
        jmp textii
        
        tetit:
        or bin1,1000000000000000b   
        textii:
     loop teverseit
     
     ;outputting deci
     mov cx,bin1
     mov saved,cx
     
     mov cx,4
     mov b1,0
     
       tloopysss:
                             ;making six combs of 4 bits and outputting
     mov b1,0 
     shl saved,1
     jnc textsss
     mov b1,1
     textsss:
     shl saved,1
     jnc text1ss
     add b1,2 
     text1ss:   
     shl saved,1
     jnc text2ss
     add b1,4 
     text2ss:   
     shl saved,1
     jnc text3ss
     add b1,8
     text3ss: 
     mov ah,2
     mov dl,b1
     cmp dl,10
     jge tlphas
     add dl,30h
     jmp tovies
     tlphas:
     add dl,37h
     tovies:
     int 21h
     loop tloopysss
     
     
     
     
     
     
     
     
     
    
     jmp ninec
    
    sixc:    
     
     mov ah,9
     lea dx, sixp
     int 21h 
     
      
      
              
              

    ;HEX INPUT 
    XOR DX,DX
    mov ah,1
    int 21h  
    cmp al,39h
    jg capa
    
    sub al,30h
    jmp nnext
    
    capa:  
    cmp al,46h
    jg smalla
    
    sub al,37h
    jmp nnext
    
    smalla:
    cmp al,66h
    
    sub al,57h
    jmp nnext   
    
    nnext:
    mov ah,0
    add dx,ax 

    mov cx,3
          
    fLOPY:
    mov ax,10h
    mul dx
    mov dx,ax

    mov ah,1
    int 21h   
    
     cmp al,39h
    jg capaL
    
    sub al,30h
    jmp nnextL
    
    capaL:  
    cmp al,46h
    jg smallaL
    
    sub al,37h
    jmp nnextL
    
    smallaL:
    cmp al,66h
    
    sub al,57h
    jmp nnextL   
    
    nnextL:
    
    mov ah,0
    add dx,ax 

    loop fLOPY
    
    mov bin1,dx
          
      
     mov ah,9                                  ;newline
     lea dx,newline
     int 21h    
      
      
      
      
      mov cx,bin1
     mov bin2,cx 
      
     
     mov cx,4
     mov b1,0
     
       qloopysss:
                             ;making six combs of 4 bits and outputting
     mov b1,0 
     shl bin1,1
     jnc qextsss
     mov b1,8
     qextsss:
     shl bin1,1
     jnc qext1ss
     add b1,4 
     qext1ss:   
     shl bin1,1
     jnc qext2ss
     add b1,2 
     qext2ss:   
     shl bin1,1
     jnc qext3ss
     add b1,1
     qext3ss: 
     mov ah,2
     mov dl,b1
     cmp dl,10
     jge qlphas
     add dl,30h
     jmp qovies
     qlphas:
     add dl,37h
     qovies:
     int 21h
     loop qloopysss 
     
     mov ah,9                                  ;newline
     lea dx,newline
     int 21h    
     mov saved,0h
     
     ;MAX HEX 1FFF BECAUSE CANT SAVE AND OUPTUT MORE THAN 4 CHARACTERS, WHEREAS >1 PRODUCES 5 DECI CHARACTER
    
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax 
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     
     ;reverse deci
     
     mov dx,saved
     mov cx,16
     mov bin1,0
     qeverseit:
                   
        shr bin1,1
        rcl dx,1
        
        jc qetit
        jmp qextii
        
        qetit:
        or bin1,1000000000000000b   
        qextii:
     loop qeverseit
     
     ;outputting deci
     mov cx,bin1
     mov saved,cx
     
     mov cx,4
     mov b1,0
     
       wloopysss:
                             ;making six combs of 4 bits and outputting
     mov b1,0 
     shl saved,1
     jnc wextsss
     mov b1,1
     wextsss:
     shl saved,1
     jnc wext1ss
     add b1,2 
     wext1ss:   
     shl saved,1
     jnc wext2ss
     add b1,4 
     wext2ss:   
     shl saved,1
     jnc wext3ss
     add b1,8
     wext3ss: 
     mov ah,2
     mov dl,b1
     cmp dl,10
     jge wlphas
     add dl,30h
     jmp wovies
     wlphas:
     add dl,37h
     wovies:
     int 21h
     loop wloopysss
    
     jmp ninec
    
    sevenc:    
     
     mov ah,9
     lea dx, sevenp
     int 21h 
     
     mov ah,1
     int 21h
     sub al,30h
     
     mov dx,1
     mov bin,0 
     
     mov cx,15
     loopys:   
     mov ah,1
     int 21h
     sub al,30h
     cmp al,0
     jne addd
     jmp nexti
     addd:   
     add bin,dx
     nexti:  
     mov ax,2
     mul dx
     mov dx,ax
     loop loopys
     mov dx,bin
     
     mov cx,16
     mov bin1,0
     reverseit:
                   
        shr bin1,1
        rcl dx,1
        
        jc setit
        jmp nextii
        
        setit:
        or bin1,1000000000000000b   
        nextii:
     loop reverseit 
                
                
     shr bin1,1
     
     mov ah,9                                  ;newline
     lea dx,newline
     int 21h 
      
     
     mov cx,4
     mov b1,0
     
       floopysss:
                             ;making six combs of 4 bits and outputting
     mov b1,0 
     shl bin1,1
     jnc nextsss
     mov b1,8
     nextsss:
     shl bin1,1
     jnc next1ss
     add b1,4 
     next1ss:   
     shl bin1,1
     jnc next2ss
     add b1,2 
     next2ss:   
     shl bin1,1
     jnc next3ss
     add b1,1
     next3ss: 
     mov ah,2
     mov dl,b1
     cmp dl,10
     jge alphas
     add dl,30h
     jmp movies
     alphas:
     add dl,37h
     movies:
     int 21h
     loop floopysss 
     
     
     
    
     jmp ninec
    
    eightc:  
     
     mov ah,9
     lea dx, eightp
     int 21h 
     
     
    ;HEX INPUT 
    XOR DX,DX
    mov ah,1
    int 21h  
    cmp al,39h
    jg capaz
    
    sub al,30h
    jmp nnextz
    
    capaz:  
    cmp al,46h
    jg smallaz
    
    sub al,37h
    jmp nnextz
    
    smallaz:
    cmp al,66h
    
    sub al,57h
    jmp nnextz   
    
    nnextz:
    mov ah,0
    add dx,ax 

    mov cx,3
          
    fLOPYz:
    mov ax,10h
    mul dx
    mov dx,ax

    mov ah,1
    int 21h   
    
     cmp al,39h
    jg capaLz
    
    sub al,30h
    jmp nnextLz
    
    capaLz:  
    cmp al,46h
    jg smallaLz
    
    sub al,37h
    jmp nnextLz
    
    smallaLz:
    cmp al,66h
    
    sub al,57h
    jmp nnextLz   
    
    nnextLz:
    
    mov ah,0
    add dx,ax 

    loop fLOPYz
    
    mov bin1,dx 
    mov ALT,dx
          
      
     mov ah,9                                  ;newline
     lea dx,newline
     int 21h    
      
      
      
      
      mov cx,bin1
     mov bin2,cx 
      
     
     mov cx,4
     mov b1,0
     
       qloopysssz:
                             ;making six combs of 4 bits and outputting
     mov b1,0 
     shl bin1,1
     jnc qextsssz
     mov b1,8
     qextsssz:
     shl bin1,1
     jnc qext1ssz
     add b1,4 
     qext1ssz:   
     shl bin1,1
     jnc qext2ssz
     add b1,2 
     qext2ssz:   
     shl bin1,1
     jnc qext3ssz
     add b1,1
     qext3ssz: 
     mov ah,2
     mov dl,b1
     cmp dl,10
     jge qlphasz
     add dl,30h
     jmp qoviesz
     qlphasz:
     add dl,37h
     qoviesz:
     int 21h
     loop qloopysssz 
     
     mov ah,9                                  ;newline
     lea dx,newline
     int 21h    
     mov saved,0h
     
     ;MAX HEX 1FFF BECAUSE CANT SAVE AND OUPTUT MORE THAN 4 CHARACTERS, WHEREAS >1 PRODUCES 5 DECI CHARACTER
    
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax 
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx
     shl saved,4
     mov bin2,ax
     xor dx,dx
     mov ax,bin2
     mov cx, 10
     div cx
     mov bin1,dx
     or saved,dx 
     
      mov ah,9                                  ;newline
     lea dx,newline
     int 21h
     
     mov cx,16     
     seefoloop:
     shl ALT,1
     jc outp:
     mov ah,2
     mov dl,'0'
     int 21h
     jmp nexxt
     outp:
     mov ah,2
     mov dl,'1'
     int 21h
     nexxt:
     loop seefoloop 
     
     ;alt me binary pera he
    
     
     jmp ninec
    
    ninec: 
    
     
    
    mov ah,4Ch
    int 21h

ret