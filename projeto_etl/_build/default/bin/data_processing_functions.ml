open Types

let filter_orders order desired_status desired_origin =
  List.filter (fun o ->
    o.status = desired_status && o.origin = desired_origin
  ) order