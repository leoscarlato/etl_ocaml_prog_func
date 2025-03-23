open Types

(** Lê um arquivo CSV de pedidos e converte cada linha em um record do tipo "order". *)
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
