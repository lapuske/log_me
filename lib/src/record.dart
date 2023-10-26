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

    return buffer.toString();
  }

  @override
  String toString() => format();
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
