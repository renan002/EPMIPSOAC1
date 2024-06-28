.data
numero: .word 123456
msg1: .asciiz "O número de algarismos é: "

.text
.globl main
main:
    la $t0, numero # carrega o endereço do número em $t0
    lw $t1, ($t0) # carrega o valor do número em $t1
    li $t2, 0 # inicializa o contador de algarismos em 0

loop:
    beq $t1, $zero, end # se o número for zero, sai do loop
    divu $t1, $t1, 10 # divide o número por 10 para obter o próximo algarismo
    addi $t2, $t2, 1 # incrementa o contador de algarismos
    j loop # volta ao início do loop

end:
    la $a0, msg1 # carrega a mensagem de saída
    li $v0, 4 # código de serviço para imprimir string
    syscall # imprime a mensagem

    move $a0, $t2 # move o número de algarismos para $a0
    li $v0, 1 # código de serviço para imprimir inteiro
    syscall # imprime o número de algarismos

    li $v0, 10 # código de serviço para encerrar o programa
    syscall # encerra o programa