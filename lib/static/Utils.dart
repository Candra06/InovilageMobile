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
