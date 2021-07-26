import 'dart:io';

import 'package:market/api/cart_webclient.dart';
import 'package:market/core/app_shared_prefs_keys.dart';
import 'package:market/model/cart_product.dart';
import 'package:market/model/product.dart';
import 'package:market/util/shared_preferences_util.dart';

class CartService {
  final CartWebClient cartWebClient;

  CartService({CartWebClient webClient}) : cartWebClient = webClient ?? CartWebClient();

  Future addProductToCart(Product product, {List<CartProduct> cartList}) async {
    var productToAdd = cartList.singleWhere((it) => it.product.id == product.id, orElse: () => null);

    if (productToAdd != null) {
      productToAdd.amount++;
    } else {
      cartList.add(CartProduct(product: product));
    }
    await SharedPreferencesUtil.saveCart(cartList);
  }

  Future removeProductToCart(
    Product product, {
    List<CartProduct> cartList,
  }) async {
    var productToRemove = cartList.singleWhere((it) => it.product.id == product.id, orElse: () => null);
    if (productToRemove != null) {
      if (productToRemove.amount > 1) {
        productToRemove.amount--;
      } else {
        cartList.remove(productToRemove);
      }
    }

    await SharedPreferencesUtil.saveCart(cartList);
  }

  Future<List<CartProduct>> loadCartProducts() async {
    return await SharedPreferencesUtil.retrieveCart();
  }

  Future<File> checkout(List<CartProduct> cartProducts) async {
    File file = await cartWebClient.checkout(cartProducts);
    await clearCart();
    return file;
  }

  Future<void> clearCart() async {
    await SharedPreferencesUtil.removeKey(AppSharedPrefsKeys.cart);
  }
}
