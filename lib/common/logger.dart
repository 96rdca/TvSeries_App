import 'package:logger/logger.dart';

Logger getLogger(String className) =>
    Logger(printer: SimpleLogPrinter(className));

class SimpleLogPrinter extends LogPrinter {
  final String className;

  SimpleLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];

    final message = color!('$emoji $className - ${event.message}');
    return [message];
  }
}
