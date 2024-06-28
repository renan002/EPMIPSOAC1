.data
numero: .word 123456
msg1: .asciiz "O n�mero de algarismos �: "

.text
.globl main
main:
    la $t0, numero # carrega o endere�o do n�mero em $t0
    lw $t1, ($t0) # carrega o valor do n�mero em $t1
    li $t2, 0 # inicializa o contador de algarismos em 0

loop:
    beq $t1, $zero, end # se o n�mero for zero, sai do loop
    divu $t1, $t1, 10 # divide o n�mero por 10 para obter o pr�ximo algarismo
    addi $t2, $t2, 1 # incrementa o contador de algarismos
    j loop # volta ao in�cio do loop

end:
    la $a0, msg1 # carrega a mensagem de sa�da
    li $v0, 4 # c�digo de servi�o para imprimir string
    syscall # imprime a mensagem

    move $a0, $t2 # move o n�mero de algarismos para $a0
    li $v0, 1 # c�digo de servi�o para imprimir inteiro
    syscall # imprime o n�mero de algarismos

    li $v0, 10 # c�digo de servi�o para encerrar o programa
    syscall # encerra o programa