/// Level to log.
enum LogLevel {
  off,
  fatal,
  error,
  warning,
  info,
  debug,
  trace,
  all,
}

/// Options of the logger.
class LogOptions {
  const LogOptions({
    this.level = LogLevel.info,
    this.dateStamp = true,
    this.timeStamp = true,
    this.levelStamp = true,
    this.utc = true,
    this.colors = const LogColors(),
  });

  /// Indicator whether date of the records should be logged.
  ///
  /// Example:
  /// * `2023-09-30`
  final bool dateStamp;

  /// Indicator whether time of the records should be logged.
  ///
  /// Example:
  /// * `06:53:45.000030`
  final bool timeStamp;

  /// Indicator whether [LogLevel] of the records should be logged.
  ///
  /// Example:
  /// * `INFO`
  /// * `SEVERE`
  final bool levelStamp;

  /// Indicator whether date and/or time should be in UTC.
  ///
  /// Only meaningful, if [dateStamp] or [timeStamp] is `true`.
  final bool utc;

  /// Minimum [LogLevel] to log.
  final LogLevel level;

  /// [LogColors] of the logs.
  final LogColors colors;
}

/// [LogColor]s of the logs to print.
class LogColors {
  const LogColors({
    this.fatal = LogColor.red,
    this.error = LogColor.red,
    this.warning = LogColor.yellow,
    this.info = LogColor.green,
    this.debug = LogColor.blue,
    this.trace = LogColor.magenta,
  });

  /// [LogColor] of the [LogLevel.fatal].
  final LogColor fatal;

  /// [LogColor] of the [LogLevel.error].
  final LogColor error;

  /// [LogColor] of the [LogLevel.warning].
  final LogColor warning;

  /// [LogColor] of the [LogLevel.info].
  final LogColor info;

  /// [LogColor] of the [LogLevel.debug].
  final LogColor debug;

  /// [LogColor] of the [LogLevel.trace].
  final LogColor trace;
}

/// Available colors of the logs.
enum LogColor {
  none,
  green,
  red,
  yellow,
  blue,
  magenta,
  cyan,
  white,
  black,
}
