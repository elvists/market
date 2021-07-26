import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:market/model/cart_product.dart';
import 'package:market/model/product.dart';
import 'package:meta/meta.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoadingState extends CartState {}

class CartCheckingOutState extends CartState {}

class CartCheckoutSuccessState extends CartState {
  final File file;

  const CartCheckoutSuccessState({@required this.file});

  @override
  List<Object> get props => [this.file];
}

class CartLoadedState extends CartState {
  final List<CartProduct> cartProducts;

  const CartLoadedState({@required this.cartProducts});

  @override
  List<Object> get props => [this.cartProducts];
}

class CartChangingState extends CartState {
  final List<CartProduct> cartProducts;

  const CartChangingState({@required this.cartProducts});

  @override
  List<Object> get props => [this.cartProducts];
}

class CartErrorState extends CartState {
  final Exception exception;

  const CartErrorState({@required this.exception});

  @override
  List<Object> get props => [exception];
}
