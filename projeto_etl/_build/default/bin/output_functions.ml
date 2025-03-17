open Data_processing_functions
open Types

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
