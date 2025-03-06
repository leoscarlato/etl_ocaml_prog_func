type order_item = {
  order_id: int;
  product_id: int;
  quantity: int;
  price: float;
  tax: float;
}

let read_order_items filename =
  let csv = Csv.load filename in
  match csv with
  | [] ->[]  
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
let string_of_order_item order_item =
  Printf.sprintf "Pedido: %d, Produto: %d, Quantidade: %d, Preço: %.2f, Taxa: %.2f"
  order_item.order_id order_item.product_id order_item.quantity order_item.price order_item.tax