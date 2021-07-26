import 'dart:convert';

import 'package:market/model/cart_product.dart';

abstract class CartUtil {
  static double calculateTotalCart(List<CartProduct> cartProducts) {
    return cartProducts.fold(
        0, (previousValue, element) => previousValue + element.totalValue);
  }

  static String encode(List<CartProduct> cartProducts) => json.encode(
        cartProducts
            .map<Map<String, dynamic>>((cartProduct) => cartProduct.toJson())
            .toList(),
      );
  static List<CartProduct> decode(String cartProduct) =>
      (json.decode(cartProduct) as List<dynamic>)
          .map<CartProduct>((item) => CartProduct.fromJson(item))
          .toList();
}
