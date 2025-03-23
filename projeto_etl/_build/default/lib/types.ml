(** Record para representar os dados vindos do arquivo "order.csv" *)
type order = {
  id: int;
  client_id: int;
  order_date: string;
  status: string;
  origin: string;
}

(** Record para representar os dados vindos do arquivo "order_item.csv" *)
type order_item = {
  order_id: int;
  product_id: int;
  quantity: int;
  price: float;
  tax: float;
}