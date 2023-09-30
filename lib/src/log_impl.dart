import 'dart:async';

import 'log.dart';
import 'options.dart';

/// Implementation of the logger.
class LogImpl extends ILog {
  LogImpl({LogOptions? options}) : _options = options ?? const LogOptions() {
    _controller.stream.listen((e) {
      // ignore: avoid_print
      print(
        e.format(
          dateStamp: _options.dateStamp,
          timeStamp: _options.timeStamp,
          levelStamp: _options.levelStamp,
          utc: _options.utc,
          colors: _options.colors,
        ),
      );
    });
  }

  /// Currently set [LogOptions] of this logger.
  LogOptions _options;

  /// [StreamController] of [_LogRecord] for processing (e.g. printing).
  final StreamController<_LogRecord> _controller = StreamController(sync: true);

  @override
  set options(LogOptions options) => _options = options;

  @override
  void fatal(Object? message, [String? tag]) =>
      _add(_LogRecord(message.toString(), tag: tag, level: LogLevel.fatal));

  @override
  void error(Object? message, [String? tag]) =>
      _add(_LogRecord(message.toString(), tag: tag, level: LogLevel.error));

  @override
  void warning(Object? message, [String? tag]) =>
      _add(_LogRecord(message.toString(), tag: tag, level: LogLevel.warning));

  @override
  void info(Object? message, [String? tag]) =>
      _add(_LogRecord(message.toString(), tag: tag, level: LogLevel.info));

  @override
  void debug(Object? message, [String? tag]) =>
      _add(_LogRecord(message.toString(), tag: tag, level: LogLevel.debug));

  @override
  void trace(Object? message, [String? tag]) =>
      _add(_LogRecord(message.toString(), tag: tag, level: LogLevel.trace));

  /// Adds the [record] to the [_controller].
  void _add(_LogRecord record) {
    if (record.level.index <= _options.level.index) {
      _controller.add(record);
    }
  }
}

class _LogRecord {
  _LogRecord(
    this.message, {
    this.tag,
    DateTime? at,
    this.level = LogLevel.info,
  }) : at = at ?? DateTime.now();

  final String? tag;
  final String message;
  final DateTime at;
  final LogLevel level;

  String format({
    bool dateStamp = true,
    bool timeStamp = true,
    bool levelStamp = true,
    bool utc = true,
    LogColors colors = const LogColors(),
  }) {
    final StringBuffer buffer = StringBuffer();
    final List<String> headers = [];

    if (dateStamp) {
      headers.add((utc ? at.toUtc() : at).date);
    }

    if (timeStamp) {
      headers.add((utc ? at.toUtc() : at).time);
    }

    if (levelStamp) {
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

    return buffer.toString().color(level.color(colors));
  }

  @override
  String toString() => format();
}

extension on LogLevel {
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

extension on String {
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

extension on DateTime {
  String get date {
    return '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
  }

  String get time {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}.${microsecond.toString().padLeft(6, '0')}';
  }
}
