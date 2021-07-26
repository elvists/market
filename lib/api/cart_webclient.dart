import 'dart:io';

import 'package:flutter/services.dart';
import 'package:market/model/cart_product.dart';
import 'package:path_provider/path_provider.dart';

class CartWebClient {
  Future<File> checkout(List<CartProduct> cartProducts) async {
    //Enviar carrinho para o backend finalizar o pedido e gerar o comprovante
    final byteData = await rootBundle.load('assets/pdf/checkout.pdf');

    final file = File('${(await getApplicationDocumentsDirectory()).path}/checkout.pdf');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
