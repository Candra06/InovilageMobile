import 'package:intl/intl.dart';

String dateFormatDay(
  context, {
  required String format,
  required String value,
}) {
  try {
    final split = value.split(' ');
    return DateFormat(format, "id_ID").format(
      DateTime.parse(
        split[0],
      ),
    );
  } catch (e) {
    return value.toString();
  }
}

String formatrupiah({String amount = "0", String awalan = "RP"}) {
  try {
    final oCcy = NumberFormat("#,##0", "id_ID");
    return "$awalan ${oCcy.format(double.parse(amount))}";
  } catch (e) {
    return amount;
  }
}
