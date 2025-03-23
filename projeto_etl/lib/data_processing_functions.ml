open Types

let filter_orders order desired_status desired_origin =
  List.filter (fun o ->
    o.status = desired_status && o.origin = desired_origin
  ) order

let join_orders_items orders items =
  List.map (fun order ->
    let items_for_order =
      List.filter (fun item -> item.order_id = order.id) items
    in
    (order, items_for_order)
  ) orders

let compute_totals (items) =
  List.fold_left (fun (acc_amount, acc_tax) item ->
    let revenue = item.price *. float_of_int item.quantity in
    let tax_value = revenue *. item.tax in
    (acc_amount +. revenue, acc_tax +. tax_value)
  ) (0.0, 0.0) items