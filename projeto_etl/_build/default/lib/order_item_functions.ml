open Types

(** Lê um arquivo CSV de itens de pedido e converte cada linha em um record do tipo "order_item". *)
let read_order_items filename =
  let csv = Csv.load filename in
  match csv with
  | [] -> []  
  | _header :: rows ->
      List.map (fun row ->
        match row with
        | [order_id_str; product_id_str; quantity; price; tax] ->
            { order_id = int_of_string order_id_str;
              product_id = int_of_string product_id_str;
              quantity = int_of_string quantity;
              price = float_of_string price;
              tax = float_of_string tax;
            }
        | _ -> failwith "csv inválido"
      ) rows