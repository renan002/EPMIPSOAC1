.data
$valor1: .word 123456     # Declara o n�mero original na se��o de dados
$n: .word 3                 # Declara o n�mero de d�gitos a serem extra�dos na se��o de dados
$valor2: .word 456
$encaixa .asciiz "Encaixa"
$nencaixa .asciiz "Nao Encaixa"

.text
.globl main
main:
    jal get_n
fim:
    beq 
get_last_n_digits:
    # Carrega o n�mero e o valor de n
    lw $t1, $valor1         # Carrega o endere�o de 'numero' em $t0
    la $t2, ($a0)           # Carrega o endere�o de 'n' em $t0

    # Calcula a pot�ncia de 10 com base em n
    li $t3, 1              # Inicializa $t3 com 1 (pot�ncia de 10)
    move $t4, $t2          # Copia o valor de 'n' em $t4 para o loop
loop_n_digits:
    beq $t4, $zero, end_loop_n_digits # Sai do loop quando $t4 for 0
    mul $t3, $t3, 10       # Multiplica $t3 por 10 para calcular a pot�ncia
    addi $t4, $t4, -1      # Decrementa $t4 (contador do loop)
    j loop_n_digits                # Volta para o in�cio do loop
    
   
end_loop_n_digits:

    # Extrai os �ltimos n d�gitos
    div $t1, $t3           # Divide $t1 (n�mero original) por $t3 (pot�ncia de 10)
    mfhi $t1               # Move o resto da divis�o (�ltimos n d�gitos) para $t1

    # Imprimir o resultado
    move $a0, $t1          # Move o resultado (�ltimos n d�gitos) para $a0 (argumento da syscall)
    j fim
    
    
get_n:
    lw $t1, $valor2 # carrega o endere�o do n�mero em $t0
    li $t2, 0 # inicializa o contador de algarismos em 0
    
loop_get_n:
    beq $t1, $zero, end_get_n # se o n�mero for zero, sai do loop
    divu $t1, $t1, 10 # divide o n�mero por 10 para obter o pr�ximo algarismo
    addi $t2, $t2, 1 # incrementa o contador de algarismos
    j loop_get_n # volta ao in�cio do loop

end_get_n:
    move $a0, $t2 # move o n�mero de algarismos para $a0
    j get_last_n_digits