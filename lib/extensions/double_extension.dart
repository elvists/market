import 'package:intl/intl.dart';

final formatCurrency = new NumberFormat.simpleCurrency(locale: "pt_br");

extension DoubleExtension on double {
  String get getCurrencyValue => formatCurrency.format(this);
}
