open Types

let read_orders filename =
  let csv = Csv.load filename in
  match csv with
  | [] -> []  
  | _ :: rows ->
      List.map (fun row ->
        match row with
        | [id_str; client_id_str; order_date; status; origin] ->
            { id = int_of_string id_str;
              client_id = int_of_string client_id_str;
              order_date = order_date;
              status = status;
              origin = origin;
            }
        | _ -> failwith "csv invalido"
      ) rows

        
let string_of_order order =
  Printf.printf "Pedido %d, Cliente %d, Data: %s, Status: %s, Origem: %s\n"
    order.id order.client_id order.order_date order.status order.origin     