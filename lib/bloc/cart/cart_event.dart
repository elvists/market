import 'package:equatable/equatable.dart';
import 'package:market/model/cart_product.dart';
import 'package:meta/meta.dart';
import 'package:market/model/product.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitEvent extends CartEvent {
  const CartInitEvent();
}

class CartCheckoutEvent extends CartEvent {
  final List<CartProduct> cartProducts;

  const CartCheckoutEvent({@required this.cartProducts});

  @override
  List<Object> get props => [cartProducts];
}

class CartProductAddedEvent extends CartEvent {
  final Product product;

  const CartProductAddedEvent({@required this.product});

  @override
  List<Object> get props => [product];
}

class CartProductRemovedEvent extends CartEvent {
  final Product product;

  const CartProductRemovedEvent({@required this.product});

  @override
  List<Object> get props => [product];
}
