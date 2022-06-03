import 'package:intl/intl.dart';

extension StringExtension on String {
  String removeAllHtmlTags() {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return replaceAll(exp, '');
  }

  String parseTime() {
    if (isEmpty) return '';

    final timeFormat = DateFormat.jm();
    return timeFormat.format(DateFormat("hh:mm").parse(this));
  }
}
