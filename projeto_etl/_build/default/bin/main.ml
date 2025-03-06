open Order_functions
open Order_item_functions
open Data_processing_functions
open Types
 
let () =
  let orders = read_orders "data/order.csv" in
  let order_items = read_order_items "data/order_item.csv" in
  let filtered_orders = filter_orders orders "Pending" "O" in
  let joined_data = join_orders_items filtered_orders order_items in

  List.iter (fun (order, items) ->
    let total_amount, total_taxes = compute_totals (items) in
    Printf.printf "\nPedido %d - Cliente %d - Total: R$ %.2f - Taxa: %.2f\n"
      order.id order.client_id total_amount total_taxes
  ) joined_data;