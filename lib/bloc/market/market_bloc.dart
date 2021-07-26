import 'dart:async';

import 'package:market/service/market_service.dart';
import 'package:bloc/bloc.dart';
import 'package:market/model/product.dart';

import 'market_event.dart';
import 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final MarketService marketService;

  MarketBloc({MarketService service})
      : marketService = service ?? MarketService(),
        super(MarketInitial());

  @override
  Stream<MarketState> mapEventToState(
    MarketEvent event,
  ) async* {
    try {
      if (event is ItemsListFetchEvent) {
        yield ProductsListFetchingState();
        List<Product> items = await marketService.getAllProducts();
        yield ProductsListFetchedState(products: items);
      }
      if (event is ItemsListFilterEvent) {
        yield ProductsListFilteringState();
        List<Product> itemsFiltered = await marketService
            .filterProducts(event.text, products: event.products);
        yield ProductsListFilteredState(products: itemsFiltered);
      }
    } catch (e) {
      yield MarketErrorState(exception: e);
    }
  }
}
