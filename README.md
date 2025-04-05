# Projeto ETL 🔧

## Contextualização
ETL é um acrônimo para Extract, Transform, Load (Extração, Transformação e Carga). Trata-se de um
processo utilizado para coletar dados de diversas fontes, incluindo fontes não estruturadas,
transformá-los por meio de conversões, limpeza e aplicação de regras ou cálculos, e, por fim,
armazená-los em um destino processado e estruturado.

O objetivo deste projeto ETL é processar dados a partir de um recurso (um arquivo CSV), aplicando
transformações e armazenando o resultado em um outro recurso (um novo arquivo CSV).
O projeto se baseia em duas tabelas que representam uma pequena parte de um software de
gestão: uma tabela de pedidos e outra contendo os itens de cada pedido.

![image](https://github.com/user-attachments/assets/de53e103-23d6-4f9c-b912-512afb1ffe24)

O gestor gostaria de receber um arquivo CSV que contém 3 campos: `order_id` , `total_amount` e
`total_taxes` . `total amount` contém o total do pedido, ou seja, o somatório da receita de todos os
itens de um pedido.

O gestor gostaria de poder parametrizar a saída para `status` e `origin` específicos dos pedidos.

Exemplo: `status` : complete, `origin` : online (O).<br>
Saída em CSV:
```csv
order_id,total_amount,total_taxes
1,1345.88,20.34
5,34.54,2.35
14,334.44,30.4
```

## Estrutura do Projeto

A estrutura básica segue a separação entre funções puras e impuras:

- **Arquivo `types.ml`**  
  Define tipos e registros para armazenar os dados de `Order` e `OrderItem`.

- **Arquivo `order_functions.ml` e `order_item_functions.ml`**
  Contém as funções responsáveis por realizar a leitura dos arquivos CSV originais, e suas respectivas transformações aos tipos definidos no arquivo `types.ml`.

- **Arquivo `data_processing_functions.ml`**  
  Contém funções puras para realizar as seguintes operações:
  1. Filtragem da lista de pedidos com base em status e origem desejados pelo usuário.
  2. Junção das tabelas, associando cada pedido à lista de itens com o mesmo `order_id`.
  3. Cálculo do total de receita e taxas para uma lista de itens.  
  
- **Arquivo `output_functions.ml`** (funções de escrita, impuras)  
  Cuida da gravação do resultado final em CSV.

- **Arquivo `main.ml`**  
  Ponto de entrada do sistema. Faz a chamada ao pipeline ETL completo:
  1. Extrai os dados via leitura de arquivos CSV.  
  2. Transforma (filtro e agregações).  
  3. Grava o resultado em CSV ou banco.

Cada etapa (Extract, Transform, Load) segue organizada de forma a manter funções puras para manipulação de dados e funções impuras estritamente para realizar a leitura e criação de arquivos CSV (ponto inicial e final do fluxo do projeto).

## Instruções de Uso

1. **Clonar o repositório**:
   ```bash
   git clone https://github.com/leoscarlato/etl_ocaml_prog_func
   ``` 
2. **Instalar dependências**:
   - OPAM Package (OCaml)
   - Dune (versão maior ou igual à 3.17)
   - OUnit2
   - CSV  
3. **Compilar** o projeto:
   ```bash
   cd projeto-etl/
   dune build
   ```
4. **Executar** o projeto:
   ```bash
   dune exec projeto-etl
   ```
   Para alterar os dados de `status` e `origin`, basta atualizá-los no arquivo `main.ml`.
   
6. **Verificar** saída:<br>
   Para analisar o resultado gerado, após a execução do projeto, o arquivo final será gerado na pasta `data` com o nome `output.csv`.

## Cumprimento de requisitos
Todos os requisitos obrigatórios foram abordados e cumpridos neste projeto, enquanto que dentre os requisitos opcionais os seguintes foram implementados:
- Organizar o projeto ETL utilizando `dune`
- Documentar todas as funções geradas via formato `docstring`
- Gerar arquivos de testes completos para as funções puras.

## Observações sobre o uso de IA generativa
Para a construção deste projeto, foi realizado o uso de aplicativos de IA generativa, como ChatGPT e Claude, para as seguintes finalidades:
- Construção de testes unitários e docstrings para os métodos utilizados no projeto
- Refatoração e correção de códigos (solução de problemas)
- Explicações de conceitos teóricos referentes ao projeto
   
