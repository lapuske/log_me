import 'options.dart';

/// Single record of logging.
class LogRecord {
  LogRecord(
    this.message, {
    this.tag,
    DateTime? at,
    this.level = LogLevel.info,
  }) : at = at ?? DateTime.now();

  /// Optional tag of this [LogRecord].
  final String? tag;

  /// Message of this [LogRecord].
  final String message;

  /// [DateTime] associated with this [LogRecord].
  final DateTime at;

  /// [LogLevel] of this [LogRecord].
  final LogLevel level;

  /// Returns the formatted [String] representation of this [LogRecord]
  /// according to the provided [options].
  String format([LogOptions options = const LogOptions()]) {
    final StringBuffer buffer = StringBuffer();
    final List<String> headers = [];

    if (options.dateStamp) {
      headers.add((options.utc ? at.toUtc() : at).date);
    }

    if (options.timeStamp) {
      headers.add((options.utc ? at.toUtc() : at).time);
    }

    if (options.levelStamp) {
      headers.add(level.name.toUpperCase());
    }

    if (tag != null) {
      headers.add('[$tag]');
    }

    final String header = headers.isEmpty ? '' : '${headers.join(' ')}: ';

    final List<String> lines = message.split('\n');
    for (int i = 0; i < lines.length; ++i) {
      buffer.write('$header${lines[i]}');
      if (i != lines.length - 1) {
        buffer.write('\n');
      }
    }

    return buffer.toString().color(level.color(options.colors));
  }

  @override
  String toString() => format();
}

/// Extension adding ability to retrieve [LogColor] from the [LogLevel].
extension on LogLevel {
  /// Returns [LogColor] associated with this [LogLevel] according to the
  /// provided [colors].
  LogColor color(LogColors colors) {
    return switch (this) {
      LogLevel.fatal => colors.fatal,
      LogLevel.error => colors.error,
      LogLevel.warning => colors.warning,
      LogLevel.info => colors.info,
      LogLevel.debug => colors.debug,
      LogLevel.trace => colors.trace,

      // Shouldn't be invoked.
      LogLevel.off => LogColor.none,
      LogLevel.all => LogColor.none,
    };
  }
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

/// Extension adding ability to retrieve date only or time only parts of
/// [DateTime].
extension on DateTime {
  /// Returns date only part of this [DateTime].
  String get date {
    return '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  /// Returns time only part of this [DateTime].
  String get time {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}.${microsecond.toString().padLeft(6, '0')}';
  }
}
