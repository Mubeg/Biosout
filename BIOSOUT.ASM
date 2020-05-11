.model tiny
.code
org 100h

start:		mov ax, 0003h
		int 10h 	; set video
		
		mov si, offset Msg
		mov cx, 1 	; number of chars
		mov bh, 00h 	; page 0
		mov bl, 04h	; color = 4 (cga), bgr = 0 (cga)
		mov dx, 0000h   ; line = 0; column = 0;

cycle_start:	mov ah, 09h 	; function = put

		mov al, [si]	; get char
		inc si		; increment si	

		inc dl		; column++

		cmp al, 10h     ; if(al == '\n')
		jne if_end
		inc dh		; line++
		mov dl, 00h	; column = 0

if_end:

		cmp al, '$'	; if(al == '$')
		je cycle_end	; break

		int 10h  	; print char
		mov ah, 02h	; function = set_cursor_pos
		int 10h		;
					
		jmp cycle_start	; continue	

cycle_end:
		mov ax, 4c00h
		int 21h

CR	equ 	13
LF	equ	10
CRLF	equ	CR, LF

Msg: db 'Hello world!', LF, 0, '$'


end		start