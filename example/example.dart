import 'package:log_me/log_me.dart';
import 'dart:io';

void main() {
  // Set the options (optional).
  Log.options = LogOptions(
    level: LogLevel.all, // Default is [LogLevel.info].
    timeStamp: false, // Default is `true`.
    dateStamp: false, // Default is `true`.
    levelStamp: false, // Default is `true`.
    colors: LogColors(
      fatal: LogColor.red, // Default is [LogColor.red].
      error: LogColor.red, // Default is [LogColor.red].
      warning: LogColor.yellow, // Default is [LogColor.yellow].
      info: LogColor.black, // Default is [LogColor.green].
      debug: LogColor.blue, // Default is [LogColor.blue].
      trace: LogColor.magenta, // Default is [LogColor.magenta].
    ),
    output: (record, options) {
      // This is the default output.
      //
      // You may use this callback to do something with the record, or to output
      // it through a different medium (to a file, e.g.).
      LogOptions.defaultOutput(record, options);
    },
  );

  // No stamps, only message
  Log.info('No stamps, only black message');

  // Set different options in runtime.
  Log.options = LogOptions(
    level: LogLevel.all, // Default is [LogLevel.info].
    timeStamp: true, // Default is `true`.
    dateStamp: false, // Default is `true`.
    levelStamp: false, // Default is `true`.
  );

  // 07:22:45.000621 [Tag]: Time stamp and message
  Log.info('Time stamp and message', 'Tag');

  // Set different options in runtime.
  Log.options = LogOptions(
    level: LogLevel.all, // Default is [LogLevel.info].
    timeStamp: true, // Default is `true`.
    dateStamp: true, // Default is `true`.
    levelStamp: false, // Default is `true`.
  );

  // 2023-09-30 07:23:13.000396 [Tag]: Time stamp and message
  Log.info('Time stamp and message', 'Tag');

  // Set different options in runtime.
  Log.options = LogOptions(
    level: LogLevel.all, // Default is [LogLevel.info].
    utc: false, // Default is `true`.
    output: (record, options) {
      // File to log records to.
      final File file = File('log.txt');

      // Appends the [file] with [LogRecord.format]ted record.
      file.writeAsStringSync(
        // Note, that you may use the different [LogOptions] here in order, for
        // example, to see different outputs in the console and in the file.
        //
        // Just remember, that ANSI escape codes won't render the colors, it's
        // mostly a console only feature, so be sure to use [LogColors.none].
        //
        // Notice, that EVERY record calls this function, so you must check the
        // [LogLevel]s by yourself, whether you want this record to be written
        // to a file, or not.
        '${record.format(options.copyWith(colors: LogColors.none))}\n',
        mode: FileMode.append,
      );

      // Invokes the default output (simply a [print] invoke, if record's level
      // is higher or equal to the [LogOptions.level] set).
      LogOptions.defaultOutput(record, options);
    },
  );

  // 2023-09-30 10:23:50.000019 INFO [Tag]: Time stamp and message
  Log.info('Time stamp and message', 'Tag');

  // Set different options in runtime.
  Log.options = LogOptions(level: LogLevel.all);

  // 2023-09-30 07:19:55.000059 FATAL: Fatal error ocurred
  Log.fatal('Fatal error ocurred');

  // 2023-09-30 07:19:55.000101 ERROR: Error ocurred
  Log.error('Error ocurred');

  // 2023-09-30 07:30:14.000829 WARNING: Warning to notice
  Log.warning('Warning to notice');

  // 2023-09-30 07:19:55.000117 INFO: Information
  Log.info('Information');

  // 2023-09-30 07:19:55.000154 DEBUG: Debug specific log
  Log.debug('Debug specific log');

  // 2023-09-30 07:19:55.000196 TRACE: Trace specific log
  Log.trace('Trace specific log');
}
