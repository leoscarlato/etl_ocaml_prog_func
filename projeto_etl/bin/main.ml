open Etl_lib.Order_functions
open Etl_lib.Order_item_functions
 
let () =
  let orders = read_orders "data/order.csv" in
  let order_items = read_order_items "data/order_item.csv" in
  List.iter (fun order -> print_endline (string_of_order order)) orders;
  List.iter (fun order_item -> print_endline (string_of_order_item order_item)) order_items