[`log_me`]
========

[`log_me`] is a simple logger utility with configurable <font color="red">c</font><font color="orange">o</font><font color="yellow">l</font><font color="green">o</font><font color="cyan">r</font><font color="purple">s</font> and log levels out of the box, using simple `print` under the hood.

__Note__, that your console must support [ANSI escape codes](https://en.wikipedia.org/wiki/ANSI_escape_code) for colors to be visible.

![Screenshot](/screenshot.png "Screenshot")

* [Getting started](#getting-started)
* [Usage](#usage)
* [Configuration](#configuration)
* [Roadmap](#roadmap)




## Getting started

1. Add the package to your dependencies:

```yaml
dependencies:
  log_me: ^0.1.0
```

or

```yaml
dependencies:
  log_me:
    git: https://github.com/lapuske/log_me.git
```

2. Import the package and use it:

```dart
import 'package:log_me/log_me.dart';

void main() {
  Log.print('Hello, world!');
}
```

or

```dart
import 'package:log_me/log_me.dart' as me;

void main() {
  me.Log.print('Hello, world!');
}
```




## Usage

Detailed example is provided within `/example` directory.

```dart
import 'package:log_me/log_me.dart';

void main() {
  // Optional configuration.
  Log.options = LogOptions(level: LogLevel.all);

  // Prints the provided message at info level.
  Log.info('Hello, world!');

  // Prints the provided message as the error.
  Log.error('Error happened, sadly...');

  // Prints the provided message at debug level.
  //
  // `toString()` is invoked on every object, so you can pass anything there.
  Log.debug([0, 1, 2]);
}
```




## Configuration


### <font color="red">C</font><font color="orange">o</font><font color="yellow">l</font><font color="green">o</font><font color="cyan">r</font><font color="purple">s</font>

- White
- Black
- Red
- Yellow
- Blue
- Magenta
- Cyan


### Levels

- All
- Fatal
- Error
- Warning
- Info
- Debug
- Trace



### Options

```dart
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
```




## Roadmap

- [ ] 1. File output.
- [ ] 2. Sentry integration.




[`log_me`]: https://pub.dev/packages/log_me