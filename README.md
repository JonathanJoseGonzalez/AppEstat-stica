# Projeto Estatístico em Ruby

## Descrição

Este é um aplicativo de cálculos estatísticos desenvolvido em Ruby. Ele permite que o usuário insira dados, suas frequências ou classes, e obtenha várias métricas estatísticas, como variância, desvio padrão, coeficiente de variação e distribuição normal. O aplicativo é modular e pode ser facilmente expandido para incluir novos tipos de cálculos.

## Funcionalidades

1. **Entrada de Dados**:
   - O usuário pode inserir dados pontuais com frequências ou dados agrupados em classes.
   
2. **Cálculos Estatísticos**:
   - **Média**: Calcula a média dos dados inseridos.
   - **Variância e Desvio Padrão**: Fornece a variância e o desvio padrão dos dados.
   - **Coeficiente de Variação**: Mede a dispersão relativa dos dados.
   - **Distribuição Normal**: Calcula a área acumulada (CDF) para um valor específico.

3. **Reinício de Dados**:
   - Caso o usuário deseje corrigir os dados, ele pode reiniciar o processo e inserir novos valores.

## Estrutura de Arquivos

A estrutura modular facilita a adição de novas funcionalidades. Abaixo, a organização dos arquivos:

```plaintext
projeto_estatistico/
├── app.rb                  # Arquivo principal do programa
├── estatistica/            # Pasta contendo módulos de cálculos específicos
│   ├── base_estatistica.rb # Contém a classe base para entrada e cálculo de média
│   ├── variancia.rb        # Módulo para cálculos de variância e desvio padrão
│   ├── coeficiente_variacao.rb  # Módulo para cálculo do coeficiente de variação
│   ├── distribuicao_normal.rb   # Módulo para cálculo da distribuição normal
│   ├── calculo_factory.rb  # Fábrica para gerenciar cálculos adicionais
└── README.md               # Documentação do projeto
