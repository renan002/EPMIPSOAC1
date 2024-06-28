.text
.globl get_last_n_digits

get_last_n_digits:
    lw $t0,$valor1
    lw $t1,$valor2
    # Verificar se n é válido (0 <= n <= 10)
    addi $sp, $sp, -8             # Alocar espaço na pilha para variáveis locais
    sw $ra, 4($sp)                # Salvar registrador de retorno
    sw $t0, 0($sp)                # Salvar argumento a na pilha
    sw $t1, 4($sp)                # Salvar argumento n na pilha

    blt $t1, $zero, fim_funcao    # Se n < 0, pular para o fim
    bgt $t1, 10, fim_funcao       # Se n > 10, pular para o fim

    # Inicializar variável para armazenar os últimos dígitos
    move $t2, $zero               # Inicializar variável de resultado com 0

loop:
    # Verificar se a é zero
    beqz $t0, fim_loop            # Se a for zero, pular para o fim do loop

    # Obter o último dígito de a (usando divisão e subtração)
    div $t3, $t0, 10             # Quociente da divisão por 10 (a sem o último dígito)
    mulo $t4, $t0, $t3             # Multiplicar a pelo quociente
    sub $t3, $t0, $t4             # t3 = a - (a / 10 * 10) = last digit

    # Deslocar os últimos dígitos para a esquerda (multiplicar por 10)
    sll $t2, $t2, 2             # Deslocamento para a esquerda (x10)

    # Adicionar o último dígito de a aos últimos dígitos acumulados
    add $t2, $t2, $t3             # Acrescentar o dígito extraído

    # Dividir a por 10 para remover o último dígito (já obtido)
    move $t0, $t3                 # t0 já tem o último dígito obtido no passo anterior

    j loop                        # Continuar o loop

fim_loop:
    # Retornar os últimos N dígitos
    move $a0, $t2                 # Colocar resultado em $a0 para retorno

fim_funcao:
    # Liberar espaço na pilha e retornar
    lw $ra, 4($sp)                # Carregar registrador de retorno
    addi $sp, $sp, 8             # Desalocar espaço na pilha
    jr $ra                       # Retornar

.end get_last_n_digits

.data
$valor1: .word 123456
$valor2: .word 4
