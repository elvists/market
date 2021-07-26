import 'package:market/api/market_webclient.dart';
import 'package:market/model/product.dart';
import 'package:meta/meta.dart';

class MarketService {
  final MarketWebClient marketWebClient;

  MarketService({MarketWebClient webClient})
      : marketWebClient = webClient ?? MarketWebClient();

  Future<List<Product>> getAllProducts() async {
    var data = await marketWebClient.getAllProducts();
    return (data as List).map((p) => Product.fromJson(p)).toList();
  }

  Future<List<Product>> filterProducts(String text,
      {@required List<Product> products}) async {
    return products
        .where((p) => p.name.toUpperCase().contains(text.toUpperCase()))
        .toList();
  }
}
