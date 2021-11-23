
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h  
.data 
   MAX_TREE_HT  db 100  
;  MinHeapNode 
    MinHeapNode_char_Data db 100 dup(?)   
    MinHeapNode_unsigned_freq db 100 dup(?) 
    MinHeapNode_MinHeapNode_left_index db 100 dup(?) 
    MinHeapNode_MinHeapNode_right_index db 100 dup(?)
;  MinHeap (or Huffman tree) 
    MinHeap_unsigned_size db 100 dup(?) 
    MinHeap_unsigned_capacity db 100 dup(?) 
    MinHeap_MinHeapNode_index db 100 dup(?)

.code
main proc
   

endp
    
newNode:
    xor ax, ax

    ret
    
createMinHeap:
    xor ax, ax

    ret
     
swapMinHeapNode:  
    xor ax, ax

    ret




