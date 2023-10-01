import 'dart:async';

import 'log.dart';
import 'options.dart';
import 'record.dart';

/// Implementation of the logger.
class LogImpl extends ILog {
  LogImpl({LogOptions? options}) : _options = options ?? const LogOptions() {
    _controller.stream.listen((e) => _options.output(e, _options));
  }

  /// Currently set [LogOptions] of this logger.
  LogOptions _options;

  /// [StreamController] of [LogRecord] for processing (e.g. printing).
  final StreamController<LogRecord> _controller = StreamController(sync: true);

  @override
  set options(LogOptions options) => _options = options;

  @override
  void fatal(Object? message, [String? tag]) =>
      _add(LogRecord(message.toString(), tag: tag, level: LogLevel.fatal));

  @override
  void error(Object? message, [String? tag]) =>
      _add(LogRecord(message.toString(), tag: tag, level: LogLevel.error));

  @override
  void warning(Object? message, [String? tag]) =>
      _add(LogRecord(message.toString(), tag: tag, level: LogLevel.warning));

  @override
  void info(Object? message, [String? tag]) =>
      _add(LogRecord(message.toString(), tag: tag, level: LogLevel.info));

  @override
  void debug(Object? message, [String? tag]) =>
      _add(LogRecord(message.toString(), tag: tag, level: LogLevel.debug));

  @override
  void trace(Object? message, [String? tag]) =>
      _add(LogRecord(message.toString(), tag: tag, level: LogLevel.trace));

  /// Adds the [record] to the [_controller].
  void _add(LogRecord record) {
    _controller.add(record);
  }
}
