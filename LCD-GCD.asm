pchar	macro   para1		;輸出字元
	push    ax
        push    dx
        mov     dl,para1
        mov     ah,02h
        int     21h
        pop     dx
        pop     ax
        endm

pstring	macro   para2		;輸出字串
	push    ax
        push    dx
        mov     dx,offset para2
        mov     ah,09h
        int     21h
        pop     dx
        pop     ax
        endm

getkey	macro
        mov	ah,00h		;讀鍵盤
        int     16h
        cmp     al,1Bh
        je      L6
	pchar	al
        mov     bh,al
        mov     ah,00h
        int     16h
        cmp     al,1Bh
        je      L6
	pchar	al
        mov     bl,al
        sub	bh,30h		;將ASCII碼減30h變成正確數字
 	sub	bl,30h
 	mov	al,bh
 	mov	ah,0Ah
 	mul	ah
 	add	al,bl
	endm


.model small
.data
mes1	db	'Press ESC to exit',10,13,'$'
mes2	db	'Enter the first number:$'
mes3	db	'Enter the second number:$'
lcm	db	'LCM:$'
gcd	db	'GCD:$'
char1	db	0AH,0DH,'$'
.stack 1000h
.code
main proc 
	mov	ax,@data
        mov	ds,ax

L1:	pstring	mes1			;L1為讀鍵盤
	pstring	mes2
        getkey
        mov	ch,al
	mov 	dx,offset char1
	mov 	ah,09h
	int 	21h
	pstring	mes3	
        getkey
        mov 	cl,al
	mov 	dx,offset char1
	mov 	ah,09h
	int 	21h

	mov	al,cl			;將兩數相乘放入dx備用
	mul	ch
	mov	dx,ax
	
	cmp	ch,cl			;比較兩數大小判斷是否先計算或交換
	ja	L2			;大於就直接跳L2做除法
	jmp	L3			;否則跳L3做交換
L2:	mov	al,ch			;L2為輾轉相除法中的除法部分
	mov	ah,0
	div	cl
	mov	ch,ah
	mov	bl,0h
	cmp	bl,ch			;比較餘數是否為0
	je	L4
L3:	xchg	cl,ch			;L3為輾轉相除法中的交換部分
	jmp	L2
L4:	mov	bl,cl			;L4為將LCM與GCD轉為10進制
	mov	ch,0
	push	bx			;因GCD存在bl所以將bx先push到堆疊以免資料不見
	mov	ax,dx			;開始計算LCM
	mov	dx,0
	div	cx
	mov	cx,0Ah			;開始將LCM轉10進制
	div	cx
	mov	bx,dx
	mov	dx,0
	div	cx
	mov	cl,4
	shl	dx,cl
	add	bx,dx
	mov	cx,0Ah
	mov	dx,0
	div	cx
	mov	cl,8
	shl	dx,cl
	add	bx,dx
	mov	cl,12
	shl	ax,cl
	add	bx,ax
L5:	pstring	lcm			;L5為輸出結果
	mov	dx,bx			;開始輸出LCM
	mov 	cl,12
	shr 	dx,cl
	add 	dx,30h
	mov 	ah,02h
	int 	21h

	mov	dx,bx
	mov	cl,4
	shl	dx,cl
	mov	cl,12
	shr	dx,cl
	add	dx,30h
	mov	ah,02h
	int	21h

	mov	dx,bx
	mov	cl,8
	shl	dx,cl
	mov	cl,12
	shr	dx,cl
	add	dx,30h
	mov	ah,02h
	int	21h

	mov	dx,bx
	mov	cl,12
	shl	dx,cl
	mov	cl,12
	shr	dx,cl
	add	dx,30h
	mov	ah,02h
	int	21h
	mov	dx,offset char1
	mov	ah,09h
	int	21h

	pop	bx			;將原本計算好的GCD從堆疊裡取出
	pstring	gcd
	mov	al,bl			;開始輸出GCD
	mov	ah,0
	mov	cl,0Ah
	div	cl
	xchg	ah,al
	add	ah,30h
	add	al,30h
	mov	bx,ax

	mov	dx,ax
	mov	cl,8
	shr	dx,cl
	mov	ah,02h
	int	21h

	mov 	dx,bx
	mov 	cl,8
	shl 	dx,cl
	mov 	cl,8
	shr 	dx,cl
	mov 	ah,02h
	int 	21h
	mov 	dx,offset char1
	mov 	ah,09h
	int 	21h
	mov 	dx,offset char1
	mov 	ah,09h
	int 	21h
	jmp	L1			;跳回L1重新執行一次
L6:     mov	ax,4c00h		;L6為結束
        int	21h
main endp
end main