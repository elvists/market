import 'package:flutter/material.dart';
import 'package:market/model/product.dart';

import 'product_item_list.dart';

class ProductsList extends StatelessWidget {
  final List<Product> products;

  const ProductsList({
    Key key,
    @required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: products.length,
        itemExtent: 100,
        itemBuilder: (context, index) {
          return ProductItemList(product: products[index]);
        },
      );
}
