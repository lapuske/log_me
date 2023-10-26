import 'color.dart';
import 'print/io.dart' if (dart.library.html) 'print/web.dart';
import 'record.dart';

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
    this.output = defaultOutput,
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
  ///
  /// Set [LogColors.none], to completely omit ANSI escape codes from the
  /// output.
  final LogColors colors;

  /// Callback, called when a new [LogRecord] is retrieved.
  ///
  /// If not specified, then logger uses the [defaultOutput].
  ///
  /// Note, that you may invoke the [defaultOutput] in this callback:
  ///
  /// ```dart
  /// output: (record, options) {
  ///   final File file = File('log.txt');
  ///
  ///   file.writeAsStringSync(
  ///     '${record.format(options.copyWith(colors: LogColors.none))}\n',
  ///     mode: FileMode.append,
  ///   );
  ///
  ///   LogOptions.defaultOutput(record, options);
  /// }
  /// ```
  final void Function(LogRecord record, LogOptions options) output;

  /// Creates the new [LogOptions] with the non-`null` fields overwritten.
  LogOptions copyWith({
    LogLevel? level,
    bool? dateStamp,
    bool? timeStamp,
    bool? levelStamp,
    bool? utc,
    LogColors? colors,
    void Function(LogRecord record, LogOptions options)? output,
  }) =>
      LogOptions(
        level: level ?? this.level,
        dateStamp: dateStamp ?? this.dateStamp,
        timeStamp: timeStamp ?? this.timeStamp,
        levelStamp: levelStamp ?? this.levelStamp,
        utc: utc ?? this.utc,
        colors: colors ?? this.colors,
        output: output ?? this.output,
      );

  /// Invokes [print] with [LogRecord.format], if [LogLevel] is higher or equal
  /// to the [LogOptions.level] set.
  ///
  /// Intended to be used as a default [output].
  static void defaultOutput(LogRecord record, LogOptions options) {
    if (record.level.index <= options.level.index) {
      // ignore: avoid_print
      display(record.format(options), record.level.color(options.colors));
    }
  }
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

  /// [LogColors] with [LogColor.none] set everywhere.
  static const LogColors none = LogColors(
    fatal: LogColor.none,
    error: LogColor.none,
    warning: LogColor.none,
    info: LogColor.none,
    debug: LogColor.none,
    trace: LogColor.none,
  );

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
