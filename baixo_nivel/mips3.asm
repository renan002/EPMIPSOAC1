.data
$valor1: .word 123456     # Declara o número original na seção de dados
$valor2: .word 456
$encaixa: .asciiz "Encaixa"
$nencaixa: .asciiz "Nao Encaixa"

.text
.globl main
main:
    lw $s0, $valor1
    lw $s1, $valor2
    move $a0, $s1
    
    jal get_n
    
    move $a0, $v0 # Move o valor de 'n' para $s0
    move $a1, $s0
    jal get_last_n_digits
    beq $v0,$s1,deu_bom #Verifica se o retorno de get_last_n_digits e igual a valor2

    la $a0,$nencaixa
    li $v0, 4
    syscall
    li $v0, 10
    syscall
    
deu_bom:
    la $a0,$encaixa

    li $v0, 4
    syscall
    li $v0, 10
    syscall

get_last_n_digits:
    # Salva os registradores na pilha
    addi $sp, $sp, -4
    sw $s0, 0($sp) #Ultimos N digitos de $a1

    # Calcula a potência de 10 com base em n
    li $t1, 1              # Inicializa $t1 com 1 (potência de 10)
    move $t2, $a0          # Copia o valor de 'n' em $t1 para o loop
loop_n_digits:
    beq $t2, $zero, end_loop_n_digits # Sai do loop quando $t4 for 0
    mul $t1, $t1, 10       # Multiplica $t3 por 10 para calcular a potência
    addi $t2, $t2, -1      # Decrementa $t4 (contador do loop)
    j loop_n_digits        # Volta para o início do loop

end_loop_n_digits:
    # Extrai os últimos n dígitos
    div $a1, $t1           # Divide $t0 (número original) por $t1 (potência de 10)
    mfhi $s0               # Move o resto da divisão (últimos n dígitos) para $s0
    
    move $v0, $s0         # Move o resultado (últimos n dígitos) para $a0 (argumento da syscall)

    # Restaura os registradores da pilha
    lw $s0, 0($sp)
    addi $sp, $sp, 4
    jr $ra                 # Retorna da função

get_n:
    addi $sp, $sp, -4
    sw $s0, 0($sp)
    li $s0, 0
    move $t0, $a0

loop_get_n:
    beq $t0, $zero, end_get_n # Se o número for zero, sai do loop
    div $t0, $t0, 10       # Divide o número por 10 para obter o próximo algarismo
    addi $s0, $s0, 1       # Incrementa o contador de algarismos
    j loop_get_n           # Volta ao início do loop

end_get_n:
    move $v0, $s0          # Move o número de algarismos para $a0 (retorno da função)

    # Restaura os registradores da pilha
    lw $s0, 0($sp)
    addi $sp, $sp, 4
    jr $ra                 # Retorna da função