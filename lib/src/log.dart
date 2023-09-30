import 'options.dart';

/// Logger interface.
///
/// See:
/// * [LogImpl] - implementation using [print].
abstract class ILog {
  /// Sets the [LogOptions] of this logger.
  set options(LogOptions options);

  /// Prints the [message] with optional [tag] at [LogLevel.fatal].
  void fatal(Object? message, [String? tag]);

  /// Prints the [message] with optional [tag] at [LogLevel.error].
  void error(Object? message, [String? tag]);

  /// Prints the [message] with optional [tag] at [LogLevel.warning].
  void warning(Object? message, [String? tag]);

  /// Prints the [message] with optional [tag] at [LogLevel.info].
  void info(Object? message, [String? tag]);

  /// Prints the [message] with optional [tag] at [LogLevel.debug].
  void debug(Object? message, [String? tag]);

  /// Prints the [message] with optional [tag] at [LogLevel.trace].
  void trace(Object? message, [String? tag]);
}
