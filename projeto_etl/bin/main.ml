open Order_functions
open Order_item_functions
open Data_processing_functions
open Output_functions

let () =
  let orders = read_orders "data/order.csv" in
  let order_items = read_order_items "data/order_item.csv" in
  let filtered_orders = filter_orders orders "Pending" "O" in
  let joined_data = join_orders_items filtered_orders order_items in
  write_output_csv "data/output.csv" joined_data;
