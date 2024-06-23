.text
.globl main
main:
        lw $a1,$valor1
        lw $a2,$valor2
        sub $a0,$a1,$a2
        
        
        
        li $v0,1
        syscall
        li $v0,10
        syscall
.data
$valor1: .word 123456
$valor2: .word 456