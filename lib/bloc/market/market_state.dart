import 'package:equatable/equatable.dart';
import 'package:market/model/product.dart';
import 'package:meta/meta.dart';

abstract class MarketState extends Equatable {
  const MarketState();

  @override
  List<Object> get props => [];
}

class MarketInitial extends MarketState {}

class ProductsListFetchingState extends MarketState {}

class ProductsListFilteringState extends MarketState {}

class ProductsListFetchedState extends MarketState {
  final List<Product> products;

  const ProductsListFetchedState({@required this.products});

  @override
  List<Object> get props => [this.products];
}

class ProductsListFilteredState extends MarketState {
  final List<Product> products;

  const ProductsListFilteredState({@required this.products});

  @override
  List<Object> get props => [this.products];
}

class MarketErrorState extends MarketState {
  final Exception exception;

  const MarketErrorState({@required this.exception});

  @override
  List<Object> get props => [exception];
}
