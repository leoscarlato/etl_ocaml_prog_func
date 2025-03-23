open Types

val filter_orders : order list -> string -> string -> order list
val join_orders_items : order list -> order_item list -> (order * order_item list) list
val compute_totals : order_item list -> float * float
