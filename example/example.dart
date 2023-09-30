import 'package:log_me/log_me.dart';

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
    utc: false,
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
