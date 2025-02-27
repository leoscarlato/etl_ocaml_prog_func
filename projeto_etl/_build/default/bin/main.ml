open Etl_lib.Order_functions
 
let () =
  let orders = read_orders "data/order.csv" in
  List.iter (fun order ->
    print_endline (string_of_order order)
  ) orders