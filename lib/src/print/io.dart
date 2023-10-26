import '../color.dart';

void display(String text, LogColor color) {
  print(text.color(color));
}

/// Extension adding ability to retrieve [String] with ANSI escape codes.
extension on String {
  /// Returns this [String] with ANSI escape codes for the [color].
  String color(LogColor color) {
    return switch (color) {
      LogColor.none => this,
      LogColor.black => '\x1B[30m$this\x1B[0m',
      LogColor.red => '\x1B[31m$this\x1B[0m',
      LogColor.green => '\x1B[32m$this\x1B[0m',
      LogColor.yellow => '\x1B[33m$this\x1B[0m',
      LogColor.blue => '\x1B[34m$this\x1B[0m',
      LogColor.magenta => '\x1B[35m$this\x1B[0m',
      LogColor.cyan => '\x1B[36m$this\x1B[0m',
      LogColor.white => '\x1B[37m$this\x1B[0m',
    };
  }
}
