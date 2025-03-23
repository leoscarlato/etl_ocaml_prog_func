open Data_processing_functions
open Types

(** 
  Gera um arquivo CSV contendo os campos "order_id", "total_amount" e "total_taxes"
  a partir dos dados combinados de pedidos e seus itens.
  Cada linha da saída representa um pedido com o total da receita e o total de impostos pagos.
*)
let write_output_csv filename joined_data =
  let header = ["order_id"; "total_amount"; "total_taxes"] in
  let rows =
    List.map (fun (order, items) ->
      let total_amount, total_taxes = compute_totals items in
      [ string_of_int order.id;
        Printf.sprintf "%.2f" total_amount;
        Printf.sprintf "%.2f" total_taxes ]
    ) joined_data
  in
  Csv.save filename (header :: rows)
