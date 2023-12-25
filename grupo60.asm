; *********************************************************************************
; * Projeto (versão final) de IAC
; * Grupo nº 60
; * Nomes: Ema Oliveira-199214, Guilherme Lopes-103653 e Tiago Deane-103811
; * Circuito: projeto60.cir
; *********************************************************************************

; *********************************************************************************
; * Constantes
; *********************************************************************************

; Cores
VERDE       EQU 0F0F0H    ; Verde em ARGB
AMARELO     EQU 0FEB0H    ; Amarelo em ARGB
VERMELHO    EQU 0FF00H    ; Vermelho em ARGB
CINZENTO    EQU 08FFFH    ; Cinzento em ARGB
AZUL        EQU 0C00DH    ; Azul em ARGB
ROXO        EQU 0FA2EH    ; Roxo em ARGB

; Endereços dos módulos
DISPLAYS    EQU 0A000H    ; endereço dos displays de 7 segmentos
TEC_LIN     EQU 0C000H    ; endereço das linhas do teclado
TEC_COL     EQU 0E000H    ; endereço das colunas do teclado

; Constantes extra para funcionamento do teclado
LINHA_T     EQU 8         ; linha a testar
MASCARA     EQU 0FH       ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado

; Comandos
ESQUERDA    EQU 0000H     ; move o boneco para a esquerda
DIREITA     EQU 0002H     ; move o boneco para a direita
MISSIL      EQU 0001H     ; dispara um missil
COMEÇA      EQU 000CH     ; começa o jogo
PAUSA       EQU 000DH     ; pausa o jogo
TERMINA     EQU 000EH     ; termina o jogo

; Atrasos
ATRASO           EQU 2000H      ; atraso para diminuir a velocidade do rover
ATRASO_EXPLOSAO  EQU 0FFFFH     ; atraso meteoro


; Colunas e linhas iniciais
COLUNA                  EQU 31  ; coluna onde o rover aparece quando o jogo comeca
LINHA_N                 EQU 27  ; linha onde o rover está
LINHA_M                 EQU 0   ; linha inicial dos meteoros e naves
LINHA_INICIAL_MISSIL    EQU 25  ; linha onde o missil comeca a aparecer

; Colunas onde meteoros podem aparecer
COLUNA_0 EQU 5
COLUNA_1 EQU 12
COLUNA_2 EQU 19
COLUNA_3 EQU 26
COLUNA_4 EQU 33
COLUNA_5 EQU 40
COLUNA_6 EQU 47
COLUNA_7 EQU 54

METEORO_BOM       EQU 0     ; constante para verificação se é meteoro ou nave inimiga
NAVE_INIMIGA      EQU 1     ; constante para verificação se é meteoro ou nave inimiga

; Linhas de evolução dos meteoros
LINHA_INICIAL_2    EQU 3
LINHA_PEQUENO      EQU 6
LINHA_MEDIO        EQU 9
LINHA_GRANDE       EQU 12

; Tamanho dos vários meteoros e naves
TAMANHO_INICIAL_1  EQU 1
TAMANHO_INICIAL_2  EQU 2
TAMANHO_GRANDE     EQU 5
TAMANHO_MEDIO      EQU 4
TAMANHO_PEQUENO    EQU 3

; Altura e largura do rover e dos meteoros
LARGURA_N   EQU 5           ; largura do rover
LARGURA_M   EQU 5           ; largura do meteoro

ALTURA_M    EQU 5           ; altura do meteoro
ALTURA_N    EQU 4           ; altura do rover

; Limites
LIMITE_DIREITO     EQU 59   ; limite direito do ecrã
LIMITE_ESQUERDO    EQU 0    ; limite esquerdo do ecrã
LIMITE_INFERIOR    EQU 31   ; limite inferior do ecrã
LIMITE_MISSIL      EQU 10   ; alcance máximo do míssil

; Constantes para display e cálculos relacionados
V_INICIAL_DISPLAYS  EQU 3F1H            ; valor inicial dos displays para que seja 95% após a primeira redução
FATOR               EQU 1000            ; fator de divisão para transformar hex em decimal

; Comandos do MediaCenter
COR_PIXEL               EQU 6010H
DEFINE_LINHA            EQU 600AH   ; endereço do comando para definir a linha
DEFINE_COLUNA           EQU 600CH   ; endereço do comando para definir a coluna
DEFINE_PIXEL            EQU 6012H   ; endereço do comando para escrever um pixel
APAGA_AVISO             EQU 6040H   ; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_ECRÃ              EQU 6002H   ; endereço do comando para apagar todos os pixels já desenhados
SELECIONA_CENARIO_FUNDO EQU 6042H   ; endereço do comando para selecionar uma imagem de fundo
TRANSIÇÃO_ENTRE_VIDEOS  EQU 6056H   ; especifica um padrão de transição entre vídeos (0- no fading; 1 - very slow; 2 - slow; 3 - fast; 4 - very fast)
SELECIONA_SOM           EQU 6048H   ; seleciona um som para tocar
TOCA_SOM                EQU 605AH   ; toca o som seleciona
CICLO_SOM_VIDEO         EQU 605CH   ; endereço do comando para reproduzir o som/vídeo especificado em ciclo até ser parado
TERMINA_SOM_VIDEO       EQU 6066H   ; termina a reprodução do som/vídeo especificado

; Números de vídeos
START_SCREEN      EQU 0      ; animação de início do jogo
PAUSED_SCREEN     EQU 1      ; animação do jogo pausado
GAME_OVER         EQU 2      ; animação de quando perde o jogo
JOGO_TERMINADO    EQU 3      ; animação de quando termina o jogo

; Números de sons
SOM_MISSIL        EQU 4      ; som do disparo do míssil
EXPL_METEORO_BOM  EQU 5      ; som da explosão do meteoro bom
EXPL_NAVE_INIMIGA EQU 6      ; som da explosão da nave inimiga
EXPL_ROVER        EQU 7      ; som da explosão do rover
MENU_SOUND       EQU 8       ; som de início, pausa e de terminar o jogo

; #######################################################################
; * ZONA DE DADOS
; #######################################################################
    place 1000H

; Reserva do espaço para as pilhas dos processos
pilha:
    STACK 200H              ; espaço reservado para a pilha do programa principal
                                ; (400H bytes, pois são 200H words)
SP_inicial_princ:           ; este é o endereço com que o SP deve ser inicializado.

    STACK 100H
SP_inicial_teclado:

    STACK 100H
SP_inicial_rover:     

    STACK 100H
SP_inicial_display:

    STACK 100H
SP_inicial_meteoro:

    STACK 100H
SP_inicial_missil:

    STACK 100H
SP_evoca_meteoro:

tecla_carregada:          ; LOCK que guarda a tecla carregada
    LOCK 0        

tecla_continua:           ; LOCK que guarda a tecla continua a ser carregada
LOCK 0

ha_colisao:               ; LOCK que testa se ocorreu colisão
    LOCK 0

evento_int_0:
    LOCK 0                ; LOCK para a rotina de interrupção comunicar ao processo meteoro que a interrupção ocorreu
evento_int_1:
    LOCK 0                ; LOCK para a rotina de interrupção comunicar ao processo missil que a interrupção ocorreu
evento_int_2:
    LOCK 0                ; LOCK para a rotina de interrupção comunicar ao processo boneco que a interrupção ocorreu

evoca_meteoro:            ; guarda o número de meteoros a serem evocados
    WORD 0

testa_missil:             ; testa se há um míssil no ecrã
    WORD 0

testa_colisao:            ; testa se ocorreu uma colisão
    WORD 0

coluna_rover:             ; coluna atual do rover
    WORD 0

valor_display:                      ; guarda o valor atual do display para utilização nos processos e rotinas
    WORD V_INICIAL_DISPLAYS

estado_jogo:                        ; 0 = não começou, 1 = pausado, 2 = a correr, 3 = perdeu
    WORD 0

; Tabela das rotinas de interrupção
tab:
    WORD rot_int_0                  ; rotina de atendimento da interrupção 0
    WORD rot_int_1                  ; rotina de atendimento da interrupção 1
    WORD rot_int_2                  ; rotina de atendimento da interrupção 2
   

DEF_ROVER:                          ; tabela que define a rover (cor, largura, pixels)
    WORD    LARGURA_N
    WORD    0, 0, AMARELO, 0, 0
    WORD    AMARELO, 0, AMARELO, 0, AMARELO
    WORD    AMARELO, AMARELO, AMARELO, AMARELO, AMARELO
    WORD    0, AMARELO, 0, AMARELO, 0

DEF_TAMANHO_METEORO:
    WORD TAMANHO_GRANDE, TAMANHO_MEDIO, TAMANHO_PEQUENO

DEF_METEORO_INICIAL_1:              ; tabela que define o primeiro estado do meteoro
    WORD    1
    WORD    CINZENTO

DEF_METEORO_INICIAL_2:              ; tabela que define o segundo estado do meteoro
    WORD    2
    WORD    CINZENTO, CINZENTO
    WORD    CINZENTO, CINZENTO

DEF_METEORO:                        ; tabela que define o meteoro de tamanho máximo
    WORD    5
    WORD    0, VERDE, VERDE, VERDE, 0
    WORD    VERDE, VERDE, VERDE, VERDE, VERDE
    WORD    VERDE, VERDE, VERDE, VERDE, VERDE
    WORD    VERDE, VERDE, VERDE, VERDE, VERDE
    WORD    0, VERDE, VERDE, VERDE, 0

DEF_METEORO_BOM_MEDIO:              ; tabela que define o tamanho medio do meteoro
    WORD    4
    WORD    0, VERDE, VERDE, 0
    WORD    VERDE, VERDE, VERDE, VERDE
    WORD    VERDE, VERDE, VERDE, VERDE
    WORD    0, VERDE, VERDE, 0

DEF_METEORO_BOM_PEQUENO:            ; tabela que define o tamanho pequeno do meteoro
    WORD    3
    WORD    0, VERDE, 0
    WORD    VERDE, VERDE, VERDE
    WORD    0, VERDE, 0

DEF_NAVE_GRANDE:                    ; tabela que define o tamanho grande da nave
    WORD    5
    WORD    VERMELHO, 0, 0, 0, VERMELHO
    WORD    VERMELHO, 0, VERMELHO, 0, VERMELHO
    WORD    0, VERMELHO, VERMELHO, VERMELHO, 0
    WORD    VERMELHO, 0, 0, 0, VERMELHO
    WORD    VERMELHO, 0, 0, 0, VERMELHO

DEF_NAVE_MEDIA:                     ; tabela que define o tamanho medio da nave
    WORD    4
    WORD    VERMELHO, 0, 0, VERMELHO
    WORD    VERMELHO, 0, 0, VERMELHO
    WORD    0, VERMELHO, VERMELHO, 0
    WORD    VERMELHO, 0, 0, VERMELHO

DEF_NAVE_PEQUENA:                   ; tabela que define o tamanho pequeno da nave
    WORD    3
    WORD    VERMELHO, 0, VERMELHO
    WORD    0, VERMELHO, 0
    WORD    VERMELHO, 0, VERMELHO

DEF_EXPLOSAO:                       ; tabela que define o efeito explosao
    WORD    5
    WORD    0, AZUL, 0, AZUL, 0
    WORD    AZUL, 0, AZUL, 0, AZUL
    WORD    0, AZUL, 0, AZUL, 0
    WORD    AZUL, 0, AZUL, 0, AZUL
    WORD    0, AZUL, 0, AZUL, 0

DEF_MISSIL:                         ; tabela que define o missil
    WORD    1
    WORD    ROXO

; *********************************************************************************
; * Código
; *********************************************************************************
    PLACE 0

inicializacoes:
    MOV  SP, SP_inicial_princ           ; inicializa SP para a palavra a seguir
                                            ; à última da pilha

    MOV  BTE, tab                       ; inicializa BTE (registo de Base da Tabela de Exceções)

    MOV [APAGA_AVISO], R1               ; apaga o aviso de nenhum cenário selecionado (o valor de R1 não é relevante)
    MOV [APAGA_ECRÃ], R1                ; apaga todos os pixels já desenhados (o valor de R1 não é relevante)
    MOV R1, 0                           ; 0 = número do vídeo da "start screen"
    MOV [evoca_meteoro], R1
    MOV [testa_missil], R1
    MOV [testa_colisao], R1
    MOV [estado_jogo], R1
    MOV [CICLO_SOM_VIDEO], R1            ; toca o vídeo da "start screen"
    CALL teclado                         ; cria o processo teclado

    EI0                    ; permite interrupções 0
    EI1                    ; permite interrupções 1
    EI2                    ; permite interrupções 2
    EI                     ; permite interrupções (geral)
    MOV R7, LINHA_M        ; linha de referência do meteoro
    
; *********************************************************************************
; * Processo teclado
; *********************************************************************************
PROCESS SP_inicial_teclado

teclado:
    MOV R11, R1           ; registo onde guardo a linha atual
    MOV R1, R11           ; recuperar o valor da linha
    MOV R2, TEC_LIN       ; endereço do periférico das linhas
    MOV R3, TEC_COL       ; endereço do periférico das colunas
    MOV R4, LINHA_T       ; linha a testar


escolhe_linha:            ; neste ciclo verifica-se qual a linha que está a ser premida
    CMP R1, 1        
    JZ linha2
 
    CMP R1, 2  
    JZ linha3

    CMP R1, 4  
    JZ linha4

    JMP linha1

espera_tecla:             ; neste ciclo espera-se até uma tecla ser premida
    YIELD

    MOV R11, R1
    
    MOVB [R2], R1         ; escreve no periférico de saída (linhas)
    MOVB R0, [R3]         ; lê do periférico de entrada (colunas)
    PUSH R5
    MOV R5, MASCARA       ; a máscara isola os 4 bits de menor peso, ao ler as colunas do teclado
    AND R0, R5            ; elimina bits para além dos bits 0-3
    POP R5
    CMP R0, 0             ; ha tecla premida?
    JZ escolhe_linha      ; se nenhuma tecla premida, repete
    JMP altera_linha

altera_linha:             ; conta o número de SHRs até 0:
    SHR R1, 1
    ADD R9, 1             ; registo contador das linhas

    CMP R1, 0
    JNZ altera_linha      ; enquanto R1 não for zero, repete o ciclo

    JMP altera_coluna     ; caso contrário, passa ao próximo passo

altera_coluna:            ; conta o numero de SHRs ate 0:
    SHR R0, 1
    ADD R10, 1            ; registo contador de colunas

    CMP R0, 0
    JNZ altera_coluna     ; enquanto R0 nao for zero, altera o valor da linha
    JMP identifica_tecla  ; caso contrário, exibe o valor desejado no display

identifica_tecla:         ; identifica qual tecla está a ser premida

    MOV R1, R9            ; valor do contador de linhas para R1
    SUB R1, 1             ; passa o numero da linha para R1

    MOV R0, R10           ; valor do contador de colunas para R0
    SUB R0, 1             ; passa o numero da coluna para R0

    PUSH R8               ; guarda o valor de R8
    MOV R8, 4
    MUL R1, R8            ; 4 * linhas
    POP R8                ; recupera o valor de R8
    ADD R1, R0            ; obtém-se o número desejado (4 * linhas + colunas)
    MOV [tecla_carregada], R1
    MOV R7, R1
    JMP verificacao_de_comandos

; *********************************************************************************
; * Saltos que passam para a linha seguinte
; * (no caso da linha 4, retorna à linha 1):
; *********************************************************************************

linha1:
    MOV R1, 1
    JMP espera_tecla
linha2:
    MOV R1, 2
    JMP espera_tecla
linha3:
    MOV R1, 4
    JMP espera_tecla
linha4:
    MOV R1, R4              ; R4 = LINHA_T = 8
    JMP espera_tecla

; *********************************************************************************
; * Verificação de comandos
; *********************************************************************************

verificacao_de_comandos:
    MOV R9, 0
    MOV R10, 0
; verificação do comando de começar o jogo
    PUSH R7
    MOV R7, COMEÇA
    CMP R1, R7                      ; verifica se a tecla carregada é C
    POP R7
    JZ começa_jogo
    
; verificação do comando de pausar o jogo
    PUSH R7
    MOV R7, PAUSA
    CMP R1, R7                     ; verifica se a tecla carregada e D
    POP R7
    JZ pausa_jogo

; verificação do comando de terminar o jogo
    PUSH R7
    MOV R7, TERMINA        
    CMP R1, R7                      ; verifica se a tecla carregada é E
    POP R7
    JZ termina_jogo
; verificação do comando do míssil
    MOV R7, R1
    PUSH R7
    MOV R7, MISSIL
    CMP R1, R7                      ; verifica se a tecla carregada é 1
    POP R7
    JZ dispara_missil
   
    JMP ha_tecla

; Comandos
começa_jogo:
    PUSH R1
    PUSH R2
    PUSH R3
    MOV R1, estado_jogo         ; lê o estado do jogo (0 = não começou, 1 = pausado,
                                    ; 2 = a correr e 3 = perdeu)
    MOV R3, [R1]            
    MOV R2, 2
    CMP R3, R2                               ; verifica se o jogo já começou
    JZ ja_começou
    MOV [R1], R2
    MOV R1, 0
    MOV [TERMINA_SOM_VIDEO], R1              ; encerra a produção do vídeo inicial
    MOV [SELECIONA_CENARIO_FUNDO], R1        ; coloca o cenario do jogo 
    MOV R1, MENU_SOUND                       ; som do menu
    CALL toca_som_R1                         ; toca o som especificado em R1
    CALL desenha_rover_inicio                ; cria o processo rover
    CALL inicio_display                      ; cria o processo display
    CALL valor_aleatorio                     ; cria o processo meteoro
    CALL valor_aleatorio                     ; cria o processo meteoro
    CALL valor_aleatorio                     ; cria o processo meteoro
    CALL valor_aleatorio                     ; cria o processo meteoro
    CALL ciclo_evoca_meteoro
ja_começou:
    POP R3
    POP R2
    POP R1
    JMP ha_tecla

; (PAUSA NÃO 100% FUNCIONAL - IMPOSSÍVEL DE CONTINUAR O JOGO APÓS SUSPENDER)
pausa_jogo:
    PUSH R1
    PUSH R2
    MOV R1, [estado_jogo]               ; lê o estado do jogo
    MOV R2, 2
    CMP R1, R2                          ; verifica se o jogo já começou
    JZ suspende_jogo
    MOV R1, [estado_jogo]               ; lê o estado do jogo

    MOV R2, 1
    CMP R1, R2                          ; verifica se o jogo já começou
    JZ continua_jogo
    JMP fim_pausa_jogo
suspende_jogo:
    MOV R1, MENU_SOUND                  ; som do menu
    CALL toca_som_R1                    ; toca o som especificado em R1
    MOV R1, 1                           ; 1 também é o número do vídeo do jogo pausado
    MOV R2, estado_jogo
    MOV [R2], R1                        ; estado 1 = jogo pausado
    MOV [CICLO_SOM_VIDEO], R1           ; toca o vídeo do jogo pausado
    JMP fim_pausa_jogo
continua_jogo:
    MOV R1, 2
    MOV R2, estado_jogo            
    MOV [R2], R1
    MOV R1, 0
    MOV [TERMINA_SOM_VIDEO], R1
    JMP fim_pausa_jogo
fim_pausa_jogo:
    POP R2
    POP R1
    JMP ha_tecla

; (TERMINAR JOGO NÃO 100% FUNCIONAL - IMPOSSÍVEL DE COMEÇAR UM NOVO APÓS TERMINAR)
termina_jogo:
    PUSH R1
    PUSH R2
    PUSH R3
    MOV R1, estado_jogo
    MOV R3, [R1]                ; R3 é o estado atual do jogo
    MOV R2, 2                       ; estado 2 = já começou
    CMP R3, R2
    POP R3
    JNZ fim_termina_jogo        ; se o jogo ainda não começou, não faz nada
    MOV R2, 4
    MOV [R1], R2                ; muda o estado de jogo para 4 (terminou)
    POP R2
    POP R1
    JMP terminou                ; ciclo final
fim_termina_jogo:
    POP R2
    POP R1
    JMP ha_tecla

dispara_missil:
    PUSH R7
    PUSH R8
    MOV R7, [testa_missil]      ; testa se já há um míssil na tela  (0 se não houver nenhum míssil 
                                    ; na tela, 1 se já existir um míssil na tela)
    MOV R8, 0
    CMP R7, R8
    POP R8
    POP R7
    JNZ ha_tecla                  ; se não for 0, vai pro ha_tecla (pois já há um míssil na tela)
    PUSH R7
    MOV R7, 1
    MOV [testa_missil], R7        ; muda o valor da WORD para 1 (para disparar o míssil)
    POP R7
    CALL desenha_missil_inicio    ; chama um processo míssil
    JMP ha_tecla
; Fim dos comandos

ha_tecla:                       ; neste ciclo espera-se até NENHUMA tecla estar premida
    YIELD

    MOV [tecla_continua], R7
    MOV R1, R11                 ; R1 tinha sido alterado (altera_out)
    MOVB [R2], R1               ; escrever no periférico de saída (linhas)
    MOVB R0, [R3]               ; ler do periférico de entrada (colunas)
    PUSH R5
    MOV R5, MASCARA             ; a máscara isola os 4 bits de menor peso, ao ler as colunas do teclado
    AND R0, R5                  ; elimina bits para além dos bits 0-3
    POP R5
    CMP R0, 0                   ; há tecla premida?
    JNZ ha_tecla                ; se ainda houver uma tecla premida, espera até não haver
    JMP escolhe_linha           ; repete ciclo

; *********************************************************************************
; * Processo rover
; *********************************************************************************

PROCESS SP_inicial_rover

desenha_rover_inicio:
    CALL espera_estado_2        ; espera o jogo estar em estado 2 (a correr)

    MOV R8, COLUNA
    MOV R1, LINHA_N             ; guarda o valor da linha onde a rover se encontra
    MOV R2, COLUNA              ; guarda o valor da coluna atual da rover
    MOV R4, DEF_ROVER           ; registo que define o boneco da rover
    MOV R5, [R4]                ; guarda o valor da largura da rover
    MOV R6, R5                  ; registo auxiliar para o valor da largura da rover
    MOV R7, ALTURA_N            ; guarda o valor da altura da rover
    CALL desenha_boneco         ; rotina que desenha o boneco da rover

rover:
    CALL espera_estado_2        ; espera o jogo estar em estado 2 (a correr)

    PUSH R1
    MOV [coluna_rover], R8
    MOV R9, [tecla_continua]    ; tecla_continua -> sempre move para a direita
                                    ; tecla_carregada -> nao funciona continuamente
    MOV R1, DIREITA             ; verifica se a tecla pressionada é mover para a direita
    CMP R9, R1
    JZ direita
    MOV R1, ESQUERDA            ; verifica se a tecla pressionada é mover para a esquerda
    CMP R9, R1
    JZ esquerda
    POP R1
    JMP rover

direita:
    MOV R10, 1                      ; escolhe o sentido de mover para a direita
    MOV R1, LIMITE_DIREITO          ; guarda o valor do limite direito do ecrã
    CMP R8, R1                      ; verifica se a coluna de referência da rover está no limite direito do ecrã
    POP R1
    JZ rover
    JMP move_rover

esquerda:
    MOV R10, -1                     ; escolhe o sentido de mover para a esqurda
    MOV R1, LIMITE_ESQUERDO         ; guarda o valor do limite esquerdo do ecrã
    CMP R8, R1                      ; verifica se a coluna de referência da rover está no limite esquerdo do ecrã
    POP R1                          ; JMP move_rover não necessário
    JZ rover

move_rover:
    MOV R2, R8                      ; guarda o valor da coluna de referência da rover
    MOV R6, R5                      ; registo auxiliar para o valor da largura da rover
    MOV R1, LINHA_N
    CALL apaga_boneco               ; rotina que apaga o boneco no ecrã
    ADD R8, R10                     ; atualiza o valor da coluna de referência da rover
    MOV R2, R8                      ; guarda o valor da coluna de referência da rover
    CALL desenha_boneco             ; rotina que desenha o boneco no ecrã
    PUSH R1
    MOV R1, ATRASO
    CALL atraso                     ; rotina de atraso, para a rover movimentar-se mais devagar
    POP R1
    JMP rover     

; *********************************************************************************
; * Processo míssil
; *********************************************************************************

PROCESS SP_inicial_missil

desenha_missil_inicio:
    CALL espera_estado_2             ; espera o jogo estar em estado 2 (a correr)

    MOV R8, [coluna_rover]           ; lê a coluna do rover
    ADD R8, 2                        ; centraliza a coluna no rover
    MOV R1, LINHA_INICIAL_MISSIL     ; lê a linha inicial do míssil
    MOV R2, R8                
    MOV R4, DEF_MISSIL
    MOV R5, [R4]                ; lê a largura 
    MOV R6, R5                  ; guarda a largura 
    MOV R7, R5                  ; lê a altura (igual à largura)
    CALL desenha_boneco         ; desenha o míssil
    CALL diminui_display_5      ; atirar um míssil reduz a energia em 5%
    PUSH R1
    MOV R1, SOM_MISSIL          ; som do disparo do míssil
CALL toca_som_R1                ; rotina que toca o som especificado em R1
    POP R1

ciclo_missil:
    CALL espera_estado_2        ; espera o jogo estar em estado 2 (a correr)

    MOV R9, [evento_int_1]      ; bloqueia o processo até ocorrer uma interrupção
    MOV R10, LIMITE_MISSIL    
    CALL apaga_boneco        
    PUSH R1
    MOV R1, 0FA2EH              ; lê a cor roxa
    CMP R11, R1                 ; verifica se a cor roxa foi apagada
    POP R1
    JNZ reinicia_missil        
    SUB R1, 1                   ; decrementa a linha do missíl
    CMP R1, R10                 ; verifica se o míssil já está no seu alcance máximo
    JZ reinicia_missil
    MOV R5, [R4]                ; lê a largura 
    MOV R6, R5                  ; guarda a largura 
    MOV R7, R5                  ; lê a altura (igual à largura)
    CALL desenha_boneco
    JMP ciclo_missil

reinicia_missil:
    MOV R1, 0            
    MOV [testa_missil], R1      ; pode ser disparado outro míssil 
    JMP fim_missil

fim_missil:
    RET

; *********************************************************************************
; * Processos meteoros
; *********************************************************************************
PROCESS SP_evoca_meteoro

ciclo_evoca_meteoro:
    CALL espera_estado_2        ; espera o jogo estar em estado 2 (a correr)
    YIELD
    MOV R1, [evoca_meteoro]     ; obtém o número de meteoros a serem evocados
    MOV R2, 0
    CMP R1, R2                  ; verifica se existem meteoros por ser evocados
    JNZ evoca_meteoros
    JMP ciclo_evoca_meteoro     ; repete o ciclo

evoca_meteoros:
    CALL espera_estado_2        ; espera o jogo estar em estado 2 (a correr)
    CALL valor_aleatorio        ; cria um novo processo meteoro
    SUB R1, 1                   ; decrementa o número de meteoros a serem evocados
    CMP R1, R2                  ; verifica se ainda existem meteoros a serem evocados
    JNZ evoca_meteoros          ; repete o ciclo
    MOV [evoca_meteoro], R1     ; o número de meteoros a serem evocados volta a ser 0
    JMP ciclo_evoca_meteoro     ; repete o ciclo
    
PROCESS SP_inicial_meteoro

valor_aleatorio:            ; início do processo meteoro
    CALL espera_estado_2    ; espera o jogo estar em estado 2 (a correr)

    PUSH R1
    PUSH R2
    MOV R1, [TEC_COL]
    SHR R1, 13              ; R1 é um número aleatório entre 0 e 7
    MOV R3, R1
    SHR R3, 1               ; R3 é um número aleatório entre 0 e 3, para verificar se é bom ou mau
    MOV R2, 7
    MUL R1, R2
    ADD R1, 5
    MOV R8, R1              ; R8 será um número aleatório da série "5 - 12 - 19 - 26 - 33 - 40 - 47 - 54"
                                ; que representa a coluna onde o meteoro vai aparecer
    POP R2
    POP R1
    
desenha_meteoro_inicio:
    MOV R1, LINHA_M                  ; guarda o valor da linha atual do meteoro
    MOV R2, R8                       ; registo da coluna do meteoro
    MOV R4, DEF_METEORO_INICIAL_1    ; registo que define o meteoro
    MOV R5, [R4]                     ; guarda o valor da largura do meteoro
    MOV R6, R5                       ; registo auxiliar para o valor da largura da nave
    MOV R7, R5                       ; guarda o valor da altura do meteoro
    CALL desenha_boneco              ; rotina que desenha o boneco do meteoro

ciclo_meteoro:
    CALL espera_estado_2        ; espera o jogo estar em estado 2 (a correr)

    MOV R9, [evento_int_0]      ; verifica se a interrupcao do meteoro ocorreu    
    CALL apaga_boneco           ; apaga o meteoro atual 
    PUSH R1
    MOV R1, 0FA2EH              ; endereço da cor roxa
    CMP R11, R1                 ; se R11 for 1 significa que o missil colidiu com um meteoro/nave 
    POP R1    
    JZ aumenta_energia          ; houve colisao
    ADD R1, 1                   ; atualiza linha atual do meteoro

    MOV R11, LIMITE_INFERIOR
    CMP R1, R11
    JZ fim_meteoro

    MOV R11, LINHA_INICIAL_2
    CMP R1, R11
    JZ meteoro_inicial_2
    MOV R11, METEORO_BOM        ; METEORO_BOM = 0
    CMP R3, R11                 ; se R3 for 0 será um meteoro bom, caso contrário será uma nave inimiga
    
    JNZ nave
meteoro:                        ; verifica se os meteoros atingiram uma linha de crescimento
    MOV R11, LINHA_PEQUENO    
    CMP R1, R11
    JZ meteoro_pequeno
    MOV R11, LINHA_MEDIO
    CMP R1, R11
    JZ meteoro_medio
    MOV R11, LINHA_GRANDE
    CMP R1, R11
    JZ meteoro_grande
    JMP desce_meteoro
nave:                           ; verifica se as naves atingiram uma linha de crescimento
    MOV R11, LINHA_PEQUENO
    CMP R1, R11
    JZ nave_pequena
    MOV R11, LINHA_MEDIO
    CMP R1, R11
    JZ nave_media
    MOV R11, LINHA_GRANDE
    CMP R1, R11
    JZ nave_grande

desce_meteoro:
    MOV R5, [R4]                ; guarda o valor da largura do meteoro
    MOV R6, R5                  ; registo auxiliar para o valor da largura da nave
    MOV R7, R5                  ; guarda o valor da altura do meteoro
    CALL desenha_boneco         ; muda o valor de R11 para 0 ou 1
    PUSH R1
    MOV R1, ROXO
    CMP R11, R1                 ; se R11 for 1 significa que o missil colidiu com um meteoro/nave
    POP R1    
    JZ aumenta_energia
    PUSH R1
    MOV R1, AMARELO
    CMP R11, R1                 ; se R11 for 1 significa que o missil colidiu com um meteoro/nave
    POP R1    
    JZ aumenta_energia_2x
    JMP ciclo_meteoro

aumenta_energia:                ; colisão do missil com nave inimiga
    PUSH R1
    MOV R1, NAVE_INIMIGA        ; NAVE_INIMIGA = 1
    CMP R10, R1
    POP R1
    JNZ missil_meteoro_bom
    PUSH R1
    MOV R1, EXPL_NAVE_INIMIGA   ; som da explosão da nave inimiga
    CALL toca_som_R1            ; toca o som especificado em R1
    POP R1                      ; restaura o valor de R1
    CALL aumenta_display_5      ; aumenta o valor da energia em 5%
    JMP colisao

aumenta_energia_2x:             ; colisão do rover com meteoro bom
    
    PUSH R1
    MOV R1, 0
    CMP R10, R1
    POP R1
    JNZ destroi_nave
    CALL aumenta_display_5      ; aumenta o valor do display em 5%
    CALL aumenta_display_5      ; aumenta o valor do display em mais 5%
    CALL apaga_boneco
    MOV R1, EXPL_METEORO_BOM    ; som da explosão do meteoro bom
    CALL toca_som_R1            ; toca o som especificado em R1
    MOV R8, [coluna_rover]
    MOV R1, LINHA_N             ; guarda o valor da linha onde a rover se encontra
    MOV R2, R8                  ; guarda o valor da coluna atual da rover
    MOV R4, DEF_ROVER           ; registo que define o boneco da rover
    MOV R5, [R4]                ; guarda o valor da largura da rover
    MOV R6, R5                  ; registo auxiliar para o valor da largura da rover
    MOV R7, ALTURA_N            ; guarda o valor da altura da rover
    CALL desenha_boneco         ; rotina que desenha o boneco da rover
    JMP fim_meteoro
    
missil_meteoro_bom:
    PUSH R1
    MOV R1, EXPL_METEORO_BOM    ; som da explosão do meteoro bom
    CALL toca_som_R1
    POP R1
    JMP colisao

colisao:
    CALL apaga_boneco
    
    MOV R4, DEF_EXPLOSAO
    MOV R5, [R4]                ; guarda o valor da largura do meteoro
    MOV R6, R5                  ; registo auxiliar para o valor da largura da nave
    MOV R7, R5                  ; guarda o valor da altura do meteoro
    CALL desenha_boneco
    PUSH R1
    MOV R1, ATRASO_EXPLOSAO
    CALL atraso
    POP R1
    CALL apaga_boneco
    JMP fim_meteoro
    
; atualização de tabelas
meteoro_inicial_2:        
    MOV R4, DEF_METEORO_INICIAL_2
    JMP desce_meteoro

meteoro_pequeno:
    MOV R10, 0
    MOV R4, DEF_METEORO_BOM_PEQUENO
    JMP desce_meteoro

meteoro_medio:
    MOV R4, DEF_METEORO_BOM_MEDIO
    JMP desce_meteoro

meteoro_grande:
    MOV R4, DEF_METEORO
    JMP desce_meteoro

nave_pequena:
    MOV R10, 1
    MOV R4, DEF_NAVE_PEQUENA
    JMP desce_meteoro

nave_media:
    MOV R4, DEF_NAVE_MEDIA
    JMP desce_meteoro

nave_grande:
    MOV R4, DEF_NAVE_GRANDE
    JMP desce_meteoro

destroi_nave:
    PUSH R1
    MOV R1, EXPL_ROVER        ; som da explosão do rover
    CALL toca_som_R1          ; rotina que toca o som especificado em R1
    POP R1
    JMP perdeu

fim_meteoro:
    MOV R1, [evoca_meteoro]        
    ADD R1, 1                   ; se o meteoro desapareceu é necessário atualizar o número de meteoros na tela
                                    ; de meteoros na tela
    MOV [evoca_meteoro], R1
    RET

; *********************************************************************************
; * Processo display
; *********************************************************************************

PROCESS SP_inicial_display

inicio_display:
    CALL espera_estado_2            ; espera o jogo estar em estado 2 (a correr)

    MOV R4, DISPLAYS                ; endereço do periférico dos displays
    MOV R5, 100H                    ; registro que guarda o valor atual do display
    MOV [R4], R5                    ; escreve 100 nos displays
    MOV R5, V_INICIAL_DISPLAYS      ; R5 guarda o valor do display. 3F1H é utilizado para que 
                                        ; o valor do display seja 95 após o primeiro ciclo
    MOV R6, valor_display           ; para rotinas fora do processo utilizarem como referência
    MOV [R6], R5

diminui_display_processo:
    CALL espera_estado_2            ; espera o jogo estar em estado 2 (a correr)

    MOV R1, [evento_int_2]          ; bloqueia o processo até ocorrer uma interrupção
    MOV R1, 32H                     ; valor para subtrair do display
    MOV R5, [R6]                    ; obtém o valor atual do display
    SUB R5, R1                      ; faz a subtração (R5 guarda o valor do display)
    MOV [R6], R5                    ; atualiza o valor do display universalmente na WORD
    MOV R1, R5                      ; R1 toma o valor de R5
    CALL hex_para_dec               ; converte R1 para decimal, R5 continua em hexadecimal
    MOV [R4], R1                    ; atualiza o valor no display
    CALL energia_0                  ; verifica se a energia chegou a 0, e faz perder o jogo 
;caso afirmativo
    JMP diminui_display_processo

; *********************************************************************************
; * Rotinas
; *********************************************************************************

; *********************************************************************************
; * toca_som_R1: toca o som com o número especificado em R1
; *********************************************************************************

toca_som_R1:
    MOV [SELECIONA_SOM], R1
    MOV [TOCA_SOM], R1
    RET

; *********************************************************************************
; * atraso: rotina que cria um atraso através de ciclos repetidos contados
; *********************************************************************************

atraso:
    PUSH R11
    MOV R11, R1               ; Registo R1 tem o valor do atraso
ciclo_atraso:
    SUB R11, 1
    JNZ ciclo_atraso          ; repete este ciclo até R11 chegar a 0
    POP R11
    RET

; *********************************************************************************
; * hex_para_dec: rotina que converte um valor R1 hexadecimal em decimal
; * Argumentos de entrada: R1 = valor para transformar em decimal (recebe do processo do display)
; *********************************************************************************

hex_para_dec:
    PUSH R2
    PUSH R3
    PUSH R4
    PUSH R5
    MOV R4, 0                  ; resultado (irá passar o seu valor para R1 no fim)
    MOV R2, FATOR              ; fator de divisão (começa em 1000 decimal)
    MOV R5, 10
ciclo_hex_dec:
    MOD R1, R2                 ; R1 é o valor para converter
    DIV R2, R5
    CMP R2, R5
    JLT fim_hex_dec            ; se o fator for menor que 10, termina o ciclo
    MOV R3, R1
    DIV R3, R2                 ; R3 é um dígito do valor decimal
    SHL R4, 4                  ; desloca para dar espaço ao novo digito
    OR R4, R3                  ; vai compondo o resultado
    JMP ciclo_hex_dec
fim_hex_dec:
    MOV R1, R4
    POP R5
    POP R4
    POP R3
    POP R2
    RET

; *********************************************************************************
; * diminui_display_5: rotina que diminui o valor do display em 5%
; *********************************************************************************

diminui_display_5:
    PUSH R1
    PUSH R4
    PUSH R5
    PUSH R6

    MOV R4, DISPLAYS              ; endereço do periférico dos displays
    MOV R6, valor_display         ; para rotinas fora do processo utilizarem como referência
    MOV R5, [R6]                  ; R5 é o valor atual dos displays

    MOV R1, 32H                   ; valor para subtrair do display
    SUB R5, R1                    ; faz a subtração (R5 guarda o valor do display)
    MOV [R6], R5                  ; atualiza o valor do display universalmente na WORD
    MOV R1, R5                    ; R1 toma o valor de R5
    CALL hex_para_dec             ; converte R1 para decimal, R5 continua em hexadecimal
    MOV [R4], R1                  ; atualiza o valor no display
    
    CALL energia_0

    POP R6
    POP R5
    POP R4
    POP R1
    RET

; *********************************************************************************
; * aumenta_display_5: rotina que aumenta o valor do display em 5%
; *********************************************************************************

aumenta_display_5:
    PUSH R1
    PUSH R4
    PUSH R5
    PUSH R6

    MOV R1, V_INICIAL_DISPLAYS
    MOV R4, 64H
    SUB R1, R4
    MOV R4, DISPLAYS                  ; endereço do periférico dos displays
    MOV R6, valor_display             ; para rotinas fora do processo utilizarem como referência
    MOV R5, [R6]                      ; R5 é o valor atual dos displays

    CMP R5, R1
    JGT maior_que_95

    MOV R1, 32H                       ; valor para adicionar ao display
    ADD R5, R1                        ; faz a subtração (R5 guarda o valor do display)
    MOV [R6], R5                      ; atualiza o valor do display universalmente na WORD
    MOV R1, R5                        ; R1 toma o valor de R5
    CALL hex_para_dec                 ; converte R1 para decimal, R5 continua em hexadecimal
    MOV [R4], R1                      ; atualiza o valor no display
    JMP fim_aumenta_display

maior_que_95:
    MOV R1, V_INICIAL_DISPLAYS
    MOV [R6], R1                      ; volta ao valor inicial do display
    MOV R1, 100H                      ; se o valor for maior que 95, põe o display como 100H
    MOV [R4], R1

fim_aumenta_display:
    POP R6
    POP R5
    POP R4
    POP R1
    RET

; *********************************************************************************
; * energia_0: rotina que verifica se a energia chegou a 0, e pula para o ciclo "perdeu" neste caso
; *********************************************************************************

energia_0:
    PUSH R1
    PUSH R2
    MOV R1, [valor_display]    
    MOV R2, 16H
    CMP R1, R2                
    POP R2
    POP R1
    JLT perdeu                ; se o valor no display é menor que 16H, perdeu
    RET

; *********************************************************************************
; * espera_estado_2: rotina que fica em loop até o jogo estar ativo
; *********************************************************************************

espera_estado_2:
    PUSH R1
    PUSH R2
    MOV R1, 2
loop_estado:
    MOV R2, [estado_jogo]       ; fica preso neste loop até o valor da WORD estado_jogo ser 2
    CMP R1, R2                      ; (estado 2 = começou o jogo)
    JNZ loop_estado
    
    POP R2
    POP R1
    RET

; *********************************************************************************
; * desenha_boneco: rotina que desenha um boneco. Recebe como argumentos
; * Tem como auxiliares as rotinas escreve_pixel, desenha_pixels e proxima_linha
; *********************************************************************************

desenha_boneco:
    PUSH R1
    PUSH R2                   ; R2 representa a coluna
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6
    PUSH R7

    ADD R4, 2                 ; endereço da cor do 1 pixel (2 porque a largura é uma word)
desenha_pixels:               ; desenha os pixels do boneco a partir da tabela
    MOV R3, [R4]              ; obtém a cor do próximo pixel do boneco
    CALL escreve_pixel        ; escreve cada pixel do boneco
    PUSH R1
    MOV R1, ROXO
    CMP R11, R1               ; se já existir um pixel no lugar que vai desenhar
    POP R1
    JZ fim_desenha_boneco
    PUSH R1
    MOV R1, AMARELO
    CMP R11, R1               ; se já existir um pixel no lugar que vai desenhar
    POP R1
    JZ fim_desenha_boneco
    ADD R4, 2                 ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD R2, 1                 ; próxima coluna
    SUB R5, 1                 ; menos uma coluna para tratar
    JNZ desenha_pixels        ; continua até percorrer toda a largura do objeto
    CALL proxima_linha        ; rotina proxima_linha que incrementa a linha a desenhar o boneco
    CMP R7, 0                 ; verifica se a altura do boneco atingiu 0
    JNZ desenha_pixels        ; senão, continua a desenhar os pixels na linha seguinte
fim_desenha_boneco:
    POP R7
    POP R6
    POP R5
    POP R4
    POP R3
    POP R2
    POP R1
    RET

; *********************************************************************************
; * apaga_boneco: rotina que apaga um boneco. Recebe como argumentos
; *
; * Tem como auxiliares as rotinas escreve_pixel e proxima_linha
; *********************************************************************************

apaga_boneco:
    PUSH R1
    PUSH R2               ; R2 representa a coluna
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6
    PUSH R7

    ADD R4, 2             ; endereço da cor do 1 pixel (2 porque a largura é uma word)
apaga_pixels:                 ; desenha os pixels do boneco a partir da tabela
    MOV R3, 0             ; obtém a cor do próximo pixel do boneco (será sempre zero, pois pretende-se apagar o boneco)
    CALL escreve_pixel    ; escreve cada pixel do boneco
    PUSH R1
    MOV R1, ROXO
    CMP R11, R1           ; se já existir um pixel no lugar que vai desenhar
    POP R1
    JZ fim_apaga_boneco

    ADD R4, 2             ; endereço da cor do próximo pixel (2 porque cada cor de pixel é uma word)
    ADD R2, 1             ; próxima coluna
    SUB R5, 1             ; menos uma coluna para tratar
    JNZ apaga_pixels      ; continua até percorrer toda a largura do objeto
    CALL proxima_linha
    CMP R7, 0
    JNZ apaga_pixels
fim_apaga_boneco:
    POP R7
    POP R6
    POP R5
    POP R4
    POP R3
    POP R2
    POP R1
    RET

proxima_linha:
    MOV R5, R6                 ; volta a colocar o registo da largura do boneco com o seu valor inicial
    MOV R2, R8                 ; volta a colocar o registo da coluna com o seu valor inicial
    ADD R1, 1                  ; próxima linha
    SUB R7, 1                  ; decrementa a altura do boneco
    RET

escreve_pixel:
    MOV [DEFINE_LINHA], R1      ; seleciona a linha
    MOV [DEFINE_COLUNA], R2     ; seleciona a coluna
    MOV R11, [COR_PIXEL]        ; R11 é 1 se tiver uma cor e 0 caso contrário
                                    ; ter uma cor = houve colisão
    MOV [DEFINE_PIXEL], R3      ; altera a cor do pixel na linha e coluna já selecionadas
    RET

; **********************************************************************
; ROT_INT_0 - Rotina de atendimento da interrupção 0
;            Move os meteoros presentes
; **********************************************************************
rot_int_0:
    MOV    [evento_int_0], R0    ; desbloqueia processo meteoro (qualquer registo serve)
    RFE

; **********************************************************************
; ROT_INT_1 - Rotina de atendimento da interrupção 1
;            Move o míssil (se este estiver presente)
; **********************************************************************
rot_int_1:
    MOV    [evento_int_1], R0    ; desbloqueia processo míssil (qualquer registo serve)
    RFE

; **********************************************************************
; ROT_INT_2 - Rotina de atendimento da interrupção 2
;            Diminui o valor da energia no display
; **********************************************************************
rot_int_2:
    MOV    [evento_int_2], R0    ; desbloqueia processo display (qualquer registo serve)
    RFE

; *********************************************************************************
;* Loops finais
; *********************************************************************************
terminou:
    PUSH R0
    PUSH R1
    PUSH R2
    MOV R1, 4
    MOV R2, estado_jogo
    MOV [R2], R1

    MOV R0, JOGO_TERMINADO
    MOV [APAGA_ECRÃ], R0
    MOV [CICLO_SOM_VIDEO], R0    ; toca o vídeo do jogo terminado
    MOV R1, EXPL_ROVER           ; som da explosão do rover
    CALL toca_som_R1             ; rotina que toca o som especificado em R1
    
    POP R2
    POP R1
    POP R0
    JMP fim

perdeu:
    PUSH R0
    PUSH R1
    PUSH R2
    MOV R1, 3                   ; estado do jogo a atualizar
    MOV R2, estado_jogo    
    MOV [R2], R1                ; atualiza o estado do jogo

    MOV R0, 2
    MOV [APAGA_ECRÃ], R0        ; apaga o ecrã
    MOV [CICLO_SOM_VIDEO], R0
    MOV R1, EXPL_ROVER          ; som da explosão do rover
    CALL toca_som_R1            ; rotina que toca o som especificado em R1
    
    POP R2
    POP R1
    POP R0
fim:
    JMP fim
