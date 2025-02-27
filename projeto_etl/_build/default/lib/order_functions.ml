type order = {
  id: int;
  client_id: int;
  order_date: string;
  status: string;
  origin: string;
}

let read_orders filename =
  let csv = Csv.load filename in
  match csv with
  | [] ->[]  
  | _header :: rows ->
      List.map (fun row ->
        match row with
        | [id_str; client_id_str; order_date; status; origin] ->
            { id = int_of_string id_str;
              client_id = int_of_string client_id_str;
              order_date;
              status;
              origin;
            }
        | _ -> failwith "csv invalido"
      ) rows
        
let string_of_order order =
  Printf.sprintf "Pedido %d, Cliente %d, Data: %s, Status: %s, Origem: %s"
    order.id order.client_id order.order_date order.status order.origin

      