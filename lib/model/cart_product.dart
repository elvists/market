import 'package:market/model/product.dart';

class CartProduct {
  int amount;
  Product product;

  CartProduct({this.amount = 1, this.product});

  CartProduct.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }

  get amountString => " x ${this.amount.toString()}";

  double get totalValue => product.value * amount;
}
