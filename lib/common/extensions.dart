import 'package:intl/intl.dart';

extension Flatten on Iterable<bool> {
  bool flatten() => fold(
        true,
        (a, b) => a && b,
      );
}

extension MyCurrencyFormat on num {
  static final _currencyWithPrefixSignAndSymbol =
      NumberFormat(' \$ #,##0;- \$ #,##0');
  static final _currencyZero = NumberFormat('\$ #,##0', 'en_US');

  String toCurrencyFormat() {
    return this == 0
        ? _currencyZero.format(this)
        : _currencyWithPrefixSignAndSymbol.format(this);
  }
}
