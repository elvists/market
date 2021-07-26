import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market/bloc/cart/cart_bloc.dart';
import 'package:market/bloc/cart/cart_event.dart';
import 'package:market/bloc/cart/cart_state.dart';
import 'package:market/components/loading_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:market/core/app_text_styles.dart';
import 'package:market/model/cart_product.dart';
import 'package:market/screens/cart/components/cart_list.dart';
import 'package:market/extensions/double_extension.dart';
import 'package:market/util/cart_util.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class CartPage extends StatefulWidget {
  final CartBloc cartBloc;

  CartPage({Key key, this.cartBloc}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartProduct> _cartProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).cartTitle),
      ),
      body: SafeArea(
        child: BlocConsumer(
          listener: (context, state) {
            if (state is CartCheckoutSuccessState) {
              OpenFile.open(state.file.path);
            }
          },
          bloc: widget.cartBloc,
          builder: (context, state) {
            if (state is CartLoadedState) {
              _cartProducts = state.cartProducts;
              return Column(
                children: [
                  CartList(cartProducts: _cartProducts),
                  _buildTotalValue(),
                  _buildCheckoutButton(),
                ],
              );
            }
            if (state is CartCheckoutSuccessState) {
              return Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Pedido finalizado com sucesso!",
                        style: AppTextStyles.textStyleTitle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0),
                        child: ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context).backButton)),
                      )
                    ],
                  ),
                ),
              );
            }
            return LoadingIndicator();
          },
        ),
      ),
    );
  }

  _buildTotalValue() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Total: ",
            style: AppTextStyles.textStyleTitle,
          ),
          Text(
            CartUtil.calculateTotalCart(_cartProducts).getCurrencyValue,
            style: AppTextStyles.textStyleTitle,
          ),
        ],
      ),
    );
  }

  _buildCheckoutButton() {
    return ElevatedButton(
        onPressed: _cartProducts.length > 0 ? _onPressCheckoutButton : null, child: Text(AppLocalizations.of(context).checkoutButton));
  }

  _onPressCheckoutButton() async {
    if (await Permission.storage.request().isGranted) {
      widget.cartBloc.add(CartCheckoutEvent(cartProducts: _cartProducts));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context).permissionDeniedMessage)));
    }
  }
}
