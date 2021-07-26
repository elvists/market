import 'package:equatable/equatable.dart';
import 'package:market/model/product.dart';
import 'package:meta/meta.dart';

abstract class MarketEvent extends Equatable {
  const MarketEvent();

  @override
  List<Object> get props => [];
}

class ItemsListFetchEvent extends MarketEvent {
  const ItemsListFetchEvent();
}

class ItemsListFilterEvent extends MarketEvent {
  final String text;
  final List<Product> products;

  const ItemsListFilterEvent({@required this.text, this.products});

  @override
  List<Object> get props => [text, products];
}
