import 'package:flutter/material.dart';
import 'package:market/components/cache_network_image_with_progress.dart';
import 'package:market/core/app_text_styles.dart';
import 'package:market/model/cart_product.dart';
import 'package:market/extensions/double_extension.dart';

class CartItemList extends StatelessWidget {
  final CartProduct cartProduct;

  const CartItemList({Key key, this.cartProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: 50,
                    child: CacheNetworkImageWithProgress(
                        imageUrl: cartProduct.product.image)),
                _buildDetails(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(cartProduct.totalValue.getCurrencyValue),
            )
          ],
        ),
      );

  Padding _buildDetails() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartProduct.product.name,
              style: AppTextStyles.textStyleSmallTitle,
            ),
            Row(
              children: [
                Text(
                  cartProduct.product.price,
                  style: AppTextStyles.textStyleSmallInfo,
                ),
                Text(
                  cartProduct.amountString,
                  style: AppTextStyles.textStyleSmallInfo,
                ),
              ],
            ),
          ],
        ),
      );
}
