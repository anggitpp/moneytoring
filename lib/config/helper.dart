import 'package:intl/intl.dart';

class Helper {
  static String getFormattedCurrency(double value, {String symbol = 'IDR '}) {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: symbol, decimalDigits: 0)
        .format(value);
  }

  static String getFormattedDate(String date,
      {String format = 'E dd/MM/yyyy'}) {
    final formatter = DateFormat(format);

    return formatter.format(DateTime.parse(date));
  }
}
