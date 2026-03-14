import 'package:logger/logger.dart';

Logger makeLog(String tag) {
  final prefix = '[$tag]';

  return Logger(
    printer: PrefixPrinter(
      PrettyPrinter(
        colors: true,
        noBoxingByDefault: true,
        dateTimeFormat: DateTimeFormat.dateAndTime,
        methodCount: 0,
        lineLength: 80,
      ),
      trace: prefix,
      debug: prefix,
      info: prefix,
      warning: prefix,
      error: prefix,
      fatal: prefix,
    ),
  );
}
