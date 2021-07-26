import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bloc/cart/cart_bloc.dart';
import 'package:market/bloc/cart/cart_event.dart';
import 'package:market/bloc/cart/cart_state.dart';
import 'package:market/components/cache_network_image_with_progress.dart';
import 'package:market/core/app_text_styles.dart';
import 'package:market/model/product.dart';
import 'package:market/screens/home/components/cart_button.dart';
import 'package:provider/provider.dart';

class ProductItemList extends StatelessWidget {
  final Product product;

  const ProductItemList({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    width: 100,
                    child:
                        CacheNetworkImageWithProgress(imageUrl: product.image)),
                _buildContent(),
              ],
            ),
            _buildProductCartColumn(context)
          ],
        ),
      );

  Padding _buildContent() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: AppTextStyles.textStyleTitle,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.price,
                  style: AppTextStyles.textStyleInfo,
                ),
              ],
            ),
          ],
        ),
      );

  _buildProductAmount() {
    return BlocBuilder<CartBloc, CartState>(
        buildWhen: (context, state) => state is CartLoadedState,
        builder: (context, state) {
          if (state is CartLoadedState) {
            var productFromCart = state.cartProducts.singleWhere(
                (it) => it.product.id == product.id,
                orElse: () => null);
            return Container(
                child: Text(productFromCart == null
                    ? "0"
                    : productFromCart.amount.toString()));
          }
          return Container();
        });
  }

  _buildProductCartColumn(BuildContext context) {
    return Row(
      children: [
        CartButton(
            icon: Icons.add_circle,
            onPressed: () {
              context
                  .read<CartBloc>()
                  .add(CartProductAddedEvent(product: product));
            }),
        _buildProductAmount(),
        CartButton(
            icon: Icons.remove_circle,
            onPressed: () {
              context
                  .read<CartBloc>()
                  .add(CartProductRemovedEvent(product: product));
            }),
      ],
    );
  }
}
