import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:market/bloc/cart/cart_bloc.dart';
import 'package:market/bloc/cart/cart_event.dart';
import 'package:market/bloc/cart/cart_state.dart';
import 'package:market/bloc/market/market_bloc.dart';
import 'package:market/bloc/market/market_event.dart';
import 'package:market/bloc/market/market_state.dart';
import 'package:market/components/sidebar.dart';
import 'package:market/core/app_colors.dart';
import 'package:market/core/app_styles.dart';
import 'package:market/model/cart_product.dart';
import 'package:market/model/product.dart';
import 'package:market/routes.dart';

import 'components/products_list.dart';

class HomeContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MarketBloc(),
        ),
        BlocProvider(
          create: (_) => CartBloc(),
        )
      ],
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = [];
  List<Product> _productsFiltered;

  @override
  void initState() {
    _loadProducts();
    context.read<CartBloc>().add(CartInitEvent());
    super.initState();
  }

  void _loadProducts() => context.read<MarketBloc>().add(ItemsListFetchEvent());

  void _updateText(String search) {
    context.read<MarketBloc>().add(
          ItemsListFilterEvent(
            text: search,
            products: _products,
          ),
        );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: Sidebar(),
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).appTitle),
          actions: _buildActionsAppBar,
        ),
        body: SafeArea(
          child: BlocConsumer<MarketBloc, MarketState>(
            listener: (context, state) {
              if (state is ProductsListFetchedState) {
                _products = _productsFiltered = state.products;
              }
              if (state is ProductsListFilteredState) {
                _productsFiltered = state.products;
              }
            },
            builder: (context, state) {
              if (state is ProductsListFetchedState || state is ProductsListFilteredState) {
                return _buildScreen();
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      );

  List<Widget> get _buildActionsAppBar {
    return <Widget>[
      InkWell(
        onTap: _goToCartScreen,
        child: Stack(
          children: [
            Center(
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 40,
              ),
            ),
            BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              if (state is CartLoadedState) {
                var itemsCount = _countCartProducts(state.cartProducts);
                if (itemsCount != 0) {
                  return Positioned(
                    bottom: 1,
                    child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.all(Radius.circular(20))),
                        child: Center(child: Text(itemsCount.toString()))),
                  );
                }
              }
              return Container();
            })
          ],
        ),
      )
    ];
  }

  int _countCartProducts(List<CartProduct> cartProducts) {
    return cartProducts.fold(0, (previousValue, element) => previousValue + element.amount);
  }

  Column _buildScreen() => Column(
        children: [
          _buildFilter(),
          _buildListProducts(),
        ],
      );

  Expanded _buildListProducts() => Expanded(
        child: ProductsList(products: _productsFiltered),
      );

  Container _buildFilter() => Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                _buildSearchInput(),
              ],
            ),
          ),
        ),
      );

  Expanded _buildSearchInput() => Expanded(
        child: TextFormField(
          cursorColor: AppColors.blue,
          maxLines: 1,
          onChanged: (String text) => _updateText(text),
          decoration: AppStyles.inputDecoration(
            hint: AppLocalizations.of(context).searchHint,
            icon: Icons.search,
          ),
        ),
      );

  Future<void> _goToCartScreen() async {
    var cartBloc = context.read<CartBloc>();
    await Navigator.pushNamed(context, CartRoute, arguments: cartBloc);
    cartBloc.add(CartInitEvent());
  }
}
