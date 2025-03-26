open OUnit2
open Projeto_etl.Types
open Projeto_etl.Data_processing_functions

(** Testa a função filter_orders, verificando se ela filtra corretamente os pedidos com base no status e na origem.
    Neste teste, esperamos que dois pedidos com status "complete" e origem "O" sejam retornados. *)
let test_filter_orders _ =
  let orders = [
    { id = 1; client_id = 101; order_date = "2024-01-01"; status = "complete"; origin = "O" };
    { id = 2; client_id = 102; order_date = "2024-01-02"; status = "pending"; origin = "P" };
    { id = 3; client_id = 103; order_date = "2024-01-03"; status = "complete"; origin = "O" };
  ] in
  let result = filter_orders orders "complete" "O" in
  assert_equal 2 (List.length result)
;;

(** Testa filter_orders com um status e origem que não combinam com nenhum pedido.
    Espera-se uma lista vazia como resultado. *)
let test_filter_orders_no_match _ =
  let orders = [
    { id = 1; client_id = 101; order_date = "2024-01-01"; status = "complete"; origin = "O" };
    { id = 2; client_id = 102; order_date = "2024-01-02"; status = "pending"; origin = "P" };
  ] in
  let result = filter_orders orders "cancelled" "P" in
  assert_equal 0 (List.length result)
;;

(** Testa a função join_orders_items, que realiza um inner join entre listas de pedidos e itens de pedido.
    Verifica se a junção associa corretamente os itens aos seus respectivos pedidos. Espera-se que
    o pedido 1 possua 2 itens associados e o pedido 2 possua 1 item. *)
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

(** Testa join_orders_items com um pedido que não possui itens correspondentes.
    Espera-se que o pedido apareça no resultado com uma lista vazia de itens. *)
let test_join_orders_items_with_no_items _ =
  let orders = [
    { id = 1; client_id = 101; order_date = "2024-01-01"; status = "complete"; origin = "O" };
    { id = 2; client_id = 102; order_date = "2024-01-02"; status = "pending"; origin = "P" };
  ] in
  let items = [
    { order_id = 1; product_id = 1; quantity = 2; price = 10.0; tax = 0.1 };
  ] in
  let joined = join_orders_items orders items in
  let items_order1 = List.assoc (List.nth orders 0) joined in
  let items_order2 = List.assoc (List.nth orders 1) joined in
  assert_equal 1 (List.length items_order1);
  assert_equal 0 (List.length items_order2)
;;

(** Testa join_orders_items com um item que tem order_id inválido.
    Esse item deve ser ignorado na junção. *)
let test_join_orders_items_with_invalid_item _ =
  let orders = [
    { id = 1; client_id = 101; order_date = "2024-01-01"; status = "complete"; origin = "O" };
  ] in
  let items = [
    { order_id = 999; product_id = 5; quantity = 1; price = 100.0; tax = 0.2 };
  ] in
  let joined = join_orders_items orders items in
  let items_order1 = List.assoc (List.nth orders 0) joined in
  assert_equal 0 (List.length items_order1)
;;

(** Testa a função compute_totals, que calcula o total da receita e dos impostos com base na lista de itens de pedido.
    Neste caso, espera-se que o total da receita seja 50.0 e o total de impostos seja 8.0. *)
let test_compute_totals _ =
  let items = [
    { order_id = 1; product_id = 1; quantity = 2; price = 10.0; tax = 0.1 };
    { order_id = 1; product_id = 2; quantity = 1; price = 30.0; tax = 0.2 };
  ] in
  let total_amount, total_taxes = compute_totals items in
  assert_equal 50.0 total_amount ~printer:string_of_float;
  assert_equal 8.0 total_taxes ~printer:string_of_float
;;

(** Testa compute_totals com uma lista vazia de itens.
    Espera-se total_amount e total_taxes iguais a 0.0. *)
let test_compute_totals_empty _ =
  let total_amount, total_taxes = compute_totals [] in
  assert_equal 0.0 total_amount ~printer:string_of_float;
  assert_equal 0.0 total_taxes ~printer:string_of_float
;;

(** Testa compute_totals com item que tem quantidade zero e outro com preço zero.
    Espera-se que esses itens não contribuam para o total. *)
let test_compute_totals_zero_values _ =
  let items = [
    { order_id = 1; product_id = 1; quantity = 0; price = 50.0; tax = 0.1 };
    { order_id = 1; product_id = 2; quantity = 2; price = 0.0; tax = 0.15 };
  ] in
  let total_amount, total_taxes = compute_totals items in
  assert_equal 0.0 total_amount ~printer:string_of_float;
  assert_equal 0.0 total_taxes ~printer:string_of_float
;;

let suite =
  "Testes para funções puras selecionadas" >::: [
    "filter_orders" >:: test_filter_orders;
    "filter_orders_no_match" >:: test_filter_orders_no_match;
    "join_orders_items" >:: test_join_orders_items;
    "join_orders_items_with_no_items" >:: test_join_orders_items_with_no_items;
    "join_orders_items_with_invalid_item" >:: test_join_orders_items_with_invalid_item;
    "compute_totals" >:: test_compute_totals;
    "compute_totals_empty" >:: test_compute_totals_empty;
    "compute_totals_zero_values" >:: test_compute_totals_zero_values;
  ]
;;


let () = run_test_tt_main suite
