open Etl_lib.Order_functions

(* let () =
  print_endline (Etl.hello_etl()) *)

let string_of_order order =
  Printf.sprintf "Pedido %d, Cliente %d, Data: %s, Status: %s, Origem: %s"
    order.id order.client_id order.order_date order.status order.origin
 
let () =
  let orders = read_orders "data/order.csv" in
  List.iter (fun order ->
    print_endline (string_of_order order)
  ) orders