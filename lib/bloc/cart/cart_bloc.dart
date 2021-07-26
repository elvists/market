import 'dart:async';
import 'dart:io';

import 'package:market/model/cart_product.dart';
import 'package:market/model/product.dart';
import 'package:market/service/cart_service.dart';
import 'package:market/service/market_service.dart';
import 'package:bloc/bloc.dart';

import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartService cartService;

  CartBloc({MarketService service})
      : cartService = service ?? CartService(),
        super(CartInitial());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartInitEvent) {
      yield* _mapCartStartedToState();
    }
    if (event is CartProductAddedEvent) {
      yield* _mapCartProductAddedToState(event.product, state);
    }
    if (event is CartProductRemovedEvent) {
      yield* _mapCartProductRemovedToState(event.product, state);
    }
    if (event is CartCheckoutEvent) {
      yield* _mapCartCheckoutToState(event.cartProducts);
    }
  }

  Stream<CartState> _mapCartCheckoutToState(
      List<CartProduct> cartProducts) async* {
    yield CartCheckingOutState();
    try {
      File file = await cartService.checkout(cartProducts);
      yield CartCheckoutSuccessState(file: file);
    } catch (e) {
      yield CartErrorState(exception: e);
    }
  }

  Stream<CartState> _mapCartStartedToState() async* {
    yield CartLoadingState();
    try {
      final items = await cartService.loadCartProducts();
      yield CartLoadedState(cartProducts: items);
    } catch (e) {
      yield CartErrorState(exception: e);
    }
  }

  Stream<CartState> _mapCartProductAddedToState(
    Product product,
    CartState state,
  ) async* {
    try {
      if (state is CartLoadedState) {
        yield CartChangingState(cartProducts: state.cartProducts);
        await cartService.addProductToCart(product,
            cartList: state.cartProducts);
        yield CartLoadedState(cartProducts: state.cartProducts);
      }
    } catch (e) {
      yield CartErrorState(exception: e);
    }
  }

  Stream<CartState> _mapCartProductRemovedToState(
    Product product,
    CartState state,
  ) async* {
    try {
      if (state is CartLoadedState) {
        yield CartChangingState(cartProducts: state.cartProducts);
        await cartService.removeProductToCart(product,
            cartList: state.cartProducts);
        yield CartLoadedState(cartProducts: state.cartProducts);
      }
    } catch (e) {
      yield CartErrorState(exception: e);
    }
  }
}
