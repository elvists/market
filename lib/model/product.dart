import 'package:market/extensions/double_extension.dart';

class Product {
  int id;
  String name;
  double value;
  String image;

  Product({this.id, this.name, this.value, this.image});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    data['image'] = this.image;
    return data;
  }

  get price => value.getCurrencyValue;
}
