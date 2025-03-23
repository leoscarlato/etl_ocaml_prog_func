open OUnit2
open Projeto_etl.Types
open Projeto_etl.Data_processing_functions

let test_filter_orders _ =
  let orders = [
    { id = 1; client_id = 101; order_date = "2024-01-01"; status = "complete"; origin = "O" };
    { id = 2; client_id = 102; order_date = "2024-01-02"; status = "pending"; origin = "P" };
    { id = 3; client_id = 103; order_date = "2024-01-03"; status = "complete"; origin = "O" };
  ] in
  let result = filter_orders orders "complete" "O" in
  assert_equal 2 (List.length result)
;;

let test_join_orders_items _ =
  let orders = [
    { id = 1; client_id = 101; order_date = "2024-01-01"; status = "complete"; origin = "O" };
    { id = 2; client_id = 102; order_date = "2024-01-02"; status = "pending"; origin = "P" };
  ] in
  let items = [
    { order_id = 1; product_id = 1; quantity = 2; price = 10.0; tax = 0.1 };
    { order_id = 1; product_id = 2; quantity = 1; price = 20.0; tax = 0.15 };
    { order_id = 2; product_id = 3; quantity = 3; price = 5.0; tax = 0.2 };
  ] in
  let joined = join_orders_items orders items in
  let items_order1 = List.assoc (List.nth orders 0) joined in
  let items_order2 = List.assoc (List.nth orders 1) joined in
  assert_equal 2 (List.length items_order1);
  assert_equal 1 (List.length items_order2)
;;

let test_compute_totals _ =
  let items = [
    { order_id = 1; product_id = 1; quantity = 2; price = 10.0; tax = 0.1 };
    { order_id = 1; product_id = 2; quantity = 1; price = 30.0; tax = 0.2 };
  ] in
  let total_amount, total_taxes = compute_totals items in
  assert_equal 50.0 total_amount ~printer:string_of_float;
  assert_equal 8.0 total_taxes ~printer:string_of_float
;;

let suite =
  "Testes para funções puras selecionadas" >::: [
    "filter_orders" >:: test_filter_orders;
    "join_orders_items" >:: test_join_orders_items;
    "compute_totals" >:: test_compute_totals;
  ]
;;

let () = run_test_tt_main suite
