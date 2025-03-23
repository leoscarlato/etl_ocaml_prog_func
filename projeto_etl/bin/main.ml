open Projeto_etl.Order_functions
open Projeto_etl.Order_item_functions
open Projeto_etl.Data_processing_functions
open Projeto_etl.Output_functions

(** 
    Ponto inicial do programa:
    1. Leitura dos arquivos CSV ("order" e "order_item")
    2. Filtragem de acordo com os campos "status" e "origin" (neste caso com os valores "Pending" e "O", respectivamente)
    3. Junção das ordens com seus respectivos itens
    4. Escrita dos dados processados em um novo arquivo CSV (chamado de "output")
*)
let () =
  let orders = read_orders "data/order.csv" in
  let order_items = read_order_items "data/order_item.csv" in
  let filtered_orders = filter_orders orders "Pending" "O" in
  let joined_data = join_orders_items filtered_orders order_items in
  write_output_csv "data/output.csv" joined_data;
