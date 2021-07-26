import 'package:flutter/material.dart';
import 'package:market/core/app_text_styles.dart';
import 'package:market/model/cart_product.dart';

import 'cart_item_list.dart';

class CartList extends StatelessWidget {
  final List<CartProduct> cartProducts;

  const CartList({Key key, this.cartProducts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cartProducts.length == 0) {
      return Center(
          child: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Text(
          "Não há itens no seu carrinho",
          style: AppTextStyles.textStyleTitle,
        ),
      ));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: cartProducts.length,
        itemExtent: 70,
        itemBuilder: (context, index) {
          return CartItemList(cartProduct: cartProducts[index]);
        },
      ),
    );
  }
}
