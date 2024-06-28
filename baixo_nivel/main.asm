.text
.globl get_last_n_digits

get_last_n_digits:
    lw $t0,$valor1
    lw $t1,$valor2
    # Verificar se n � v�lido (0 <= n <= 10)
    addi $sp, $sp, -8             # Alocar espa�o na pilha para vari�veis locais
    sw $ra, 4($sp)                # Salvar registrador de retorno
    sw $t0, 0($sp)                # Salvar argumento a na pilha
    sw $t1, 4($sp)                # Salvar argumento n na pilha

    blt $t1, $zero, fim_funcao    # Se n < 0, pular para o fim
    bgt $t1, 10, fim_funcao       # Se n > 10, pular para o fim

    # Inicializar vari�vel para armazenar os �ltimos d�gitos
    move $t2, $zero               # Inicializar vari�vel de resultado com 0

loop:
    # Verificar se a � zero
    beqz $t0, fim_loop            # Se a for zero, pular para o fim do loop

    # Obter o �ltimo d�gito de a (usando divis�o e subtra��o)
    div $t3, $t0, 10             # Quociente da divis�o por 10 (a sem o �ltimo d�gito)
    mulo $t4, $t0, $t3             # Multiplicar a pelo quociente
    sub $t3, $t0, $t4             # t3 = a - (a / 10 * 10) = last digit

    # Deslocar os �ltimos d�gitos para a esquerda (multiplicar por 10)
    sll $t2, $t2, 2             # Deslocamento para a esquerda (x10)

    # Adicionar o �ltimo d�gito de a aos �ltimos d�gitos acumulados
    add $t2, $t2, $t3             # Acrescentar o d�gito extra�do

    # Dividir a por 10 para remover o �ltimo d�gito (j� obtido)
    move $t0, $t3                 # t0 j� tem o �ltimo d�gito obtido no passo anterior

    j loop                        # Continuar o loop

fim_loop:
    # Retornar os �ltimos N d�gitos
    move $a0, $t2                 # Colocar resultado em $a0 para retorno

fim_funcao:
    # Liberar espa�o na pilha e retornar
    lw $ra, 4($sp)                # Carregar registrador de retorno
    addi $sp, $sp, 8             # Desalocar espa�o na pilha
    jr $ra                       # Retornar

.end get_last_n_digits

.data
$valor1: .word 123456
$valor2: .word 4
