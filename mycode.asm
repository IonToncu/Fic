
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h  
.data 
;   initial data
    arr db 'a', 'b', 'c', 'd', 'e', 'f'
    freq db 5, 9, 12, 13, 16, 45
    size db 6
;  MinHeapNode 
    MinHeapNode_char_Data db 100 dup(?)   
    MinHeapNode_unsigned_freq db 100 dup(?) 
    MinHeapNode_MinHeapNode_left_index dw 100 dup(?) 
    MinHeapNode_MinHeapNode_right_index dw 100 dup(?)
;  MinHeap (or Huffman tree) 
    MinHeap_unsigned_size db 0 
    MinHeap_unsigned_capacity db 0 
    MinHeap_MinHeapNode_array db 100 dup(?)
;  HuffmanCodes fun var
    HuffmanCodes_arr db 100 dup(?)
    HuffmanCodes_top db 0
;  buildHuffmanTree fun var
    buildHuffmanTree_left db 0
    buildHuffmanTree_right db 0
    buildHuffmanTree_top db 0
    buildHuffmanTree_isSizeOne db 0
;   createAndBuildMinHeap fun var
    createAndBuildMinHeap_minHeap db 0
;   extractMin fun var
    extractMin_tmp dw 0
;   minHeapify fun var
    minHeapify_idx dw 0
    minHeapify_smallest dw 0
    minHeapify_left dw 0
    minHeapify_right dw 0  
;   buildMinHeap
    buildMinHeap_n dw 0

.code 
jmp main   

func: 
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov dx, [bp + 6] 
    mov ah, 2
    int 21h 
    mov dx, [bp + 4]   
    int 21h
    
    
    mov sp, bp
    pop bp
    ret 
    
    
createMinHeap:
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov dx, [bp + 4]
    mov MINHEAP_UNSIGNED_CAPACITY, dl
    mov dx, 0
    mov MINHEAP_UNSIGNED_SIZE, dl
    mov sp, bp
    pop bp
    ret

createAndBuildMinHeap:  
    mov al, size
    push ax
    call createMinHeap
    pop bx
    mov cl, size 
    mov ch, 0  
    mov ah, 2
createAndBuildMinHeap_loop2:    
    cmp ch, cl  
    je createAndBuildMinHeap_loop1 
    mov dl, ch
    ;add dl, '0' 
    ;int 21h
    inc ch 
    jmp createAndBuildMinHeap_loop2
createAndBuildMinHeap_loop1:  
    mov ch, size
    mov MINHEAP_UNSIGNED_SIZE, ch

    call buildMinHeap
    ret              
    

buildMinHeap:
    mov ax, 10h
    dec ax
    mov cx, 0x0002 
    div cl 
    mov cx, ax
    mov bx, 0
    cmp cx, bx
    je  buildMinHeap_loop1 
    push cx
    call minHeapify
    pop bx
    mov bx, 0    
    dec cx
buildMinHeap_loop1:
    
    ret     

minHeapify: 
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov ax, [bp + 4] 
    mov ah, 0
    mov minHeapify_idx, ax
    mov minheapify_smallest, ax
    mov bx, 2
    mul bx
    inc ax   
    mov minheapify_left, ax
    inc ax
    mov minheapify_right, ax
    
    mov ax, minheapify_left
    mov bh, MINHEAP_UNSIGNED_SIZE
    cmp bh, ah
    jl minheapify_loop1
        mov bx, minheapify_left
        mov bl, minheap_minheapnode_array[bx] 
        mov bh, 0
        mov ah, MINHEAPNODE_UNSIGNED_FREQ[bx]
        mov bx, minheapify_smallest
        mov bl, minheap_minheapnode_array[bx]
        mov ch, MINHEAPNODE_UNSIGNED_FREQ[bx]
        cmp ch, ah
        jl minheapify_loop1
            mov ax, minheapify_left
            mov minheapify_smallest, ax 
minheapify_loop1:

    mov ax, minheapify_right 
    mov bh, 0
    mov bl, MINHEAP_UNSIGNED_SIZE 
    mov ah, 0
    mov bh, ah
    cmp bl, al
    jl minheapify_loop2
        mov bx, minheapify_right
        mov bl, minheap_minheapnode_array[bx]
        mov bh, 0
        mov al, MINHEAPNODE_UNSIGNED_FREQ[bx]
        mov bx, minheapify_smallest
        mov bl, minheap_minheapnode_array[bx]
        mov cl, MINHEAPNODE_UNSIGNED_FREQ[bx]
        cmp cl, al
        jl minheapify_loop2
            mov ax, minheapify_right
            mov minheapify_smallest, ax 
minheapify_loop2:

    mov ax, minheapify_smallest
    mov bx, minheapify_idx
    cmp ax, bx
    je minheapify_loop3
        
          ;todo
minheapify_loop3:    
    
    mov sp, bp
    pop bp
    ret
    
     
    
main: proc  
      
    call createAndBuildMinHeap
    pop bx
endp






