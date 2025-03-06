open Order_functions
(* open Order_item_functions *)
open Data_processing_functions
(* open Types *)
 
let () =
  let orders = read_orders "data/order.csv" in
  (* let order_items = read_order_items "data/order_item.csv" in *)
  (* List.iter (fun order -> print_endline (string_of_order order)) orders;
  List.iter (fun order_item -> print_endline (string_of_order_item order_item)) order_items *)
  let filtered_orders = filter_orders orders "Complete" "O" in
  List.iter string_of_order filtered_orders;