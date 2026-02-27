# Come Home

![Godot](https://img.shields.io/badge/Engine-Godot-478CBF?logo=godot-engine\&logoColor=white)
![GDScript](https://img.shields.io/badge/Language-GDScript-3E6AA8?logo=godot-engine\&logoColor=white)
![Status](https://img.shields.io/badge/Status-Testing-yellow)
![Version](https://img.shields.io/badge/Version-1.0.0-blue)
![Made by Jhessye](https://img.shields.io/badge/Made%20by-Jhessye%20Lorrayne-ff69b4)

>  Pixel Art Game desenvolvido na Godot Engine
>  Versão atual: **1.0.0 (Testing Phase)**

---

## História do Jogo

Um menino se perde na floresta.

Agora, você precisa ajudá-lo a superar desafios, enfrentar perigos e encontrar o caminho de volta para casa.

Durante a jornada, o jogador coleta itens, enfrenta inimigos e utiliza estratégias para sobreviver até conseguir finalmente… **voltar para casa.**

---

## Como jogar?

Baixe o arquivo "Come Home.exe"

---

## Principais Mecânicas

* Sistema de inventário persistente entre cenas
* Seleção de itens via teclado (1, 2, 3…)
* Destaque visual do slot ativo
* Alternância de seleção (clicar novamente remove o item ativo)
* Sistema de equipamentos:
  * 🗡️ Espada
  * 🛡️ Escudo
  * 🗺️ Mapa interativo
* Sistema de mapa global sobreposto à cena
* Combate com hitbox de ataque e dano
* Inimigos com comportamento automático
* Máquina de estados para player e inimigos
* Sistema de animações dinâmicas baseadas em estado físico + equipamento

---

## Seção Técnica

Este projeto foi estruturado utilizando conceitos importantes de desenvolvimento de jogos:

### Arquitetura

* State Machine separada em:

  * `PhysicalState` (IDLE, WALK, JUMP, ATTACK, DEFEND)
  * `EquipmentState` (NONE, SWORD, SHIELD, MAP)
* Máquina de estados para inimigos (WALK, ATTACK, HURT, DYING)
* Separação entre lógica de movimento e lógica de animação

### Sistema de Animação

* Animações dinâmicas montadas por string (`walk_sword`, `jump_shield`, etc.)
* Fallback automático caso animação não exista
* Controle manual de `flip_h` baseado na direção e sprite original
* Controle de término de animação via `animation_finished`

### Inventário

* Persistência entre cenas
* Controle de seleção por teclado
* Integração direta com o estado do personagem
* Mapa aberto via UI global sobreposta

### IA Inimiga

* Patrulha automática entre limites
* Detecção de proximidade via cálculo de distância
* Flip automático conforme direção
* Sistema de dano e morte após contagem de hits

---

## Estrutura do Projeto

```
game-come-home/
│
├── cenas/
├── script/
├── sprites/
├── songs/
├── items/
├── floresta/
├── home_1/
├── homepg/
├── bueiro/
└── theme/
```

---

## Status do Projeto

⚠️ O jogo ainda está em fase de testes.

Algumas funcionalidades podem apresentar bugs ou comportamentos em ajuste.
A versão 1.0.0 representa a consolidação da estrutura principal do jogo.

---

## Sobre a Desenvolvedora :)

Sou **Jhessye Lorrayne**, desenvolvedora em formação, apaixonada por lógica, sistemas e construção de mecânicas interativas.

Este projeto representa:

* Evolução prática em arquitetura de jogos
* Organização de código em GDScript
* Aplicação de lógica de estados
* Desenvolvimento completo de mecânicas do zero

---

## Próximos Passos

* Polimento de animações
* Balanceamento de combate
* Expansão do mapa
* Melhorias visuais e sonoras
* Refinamento do sistema de dano
* Correções gerais da versão 1.0.0

---

## Feedback

Sugestões são muito bem-vindas.
Esse projeto está em constante evolução !!
