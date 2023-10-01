/// Colorful logger utility.
library;

import 'dart:core';

import 'src/log.dart';
import 'src/log_impl.dart';
import 'src/options.dart';

export 'src/log.dart';
export 'src/options.dart';
export 'src/record.dart';

/// Logger logging its records to the console.
// ignore: non_constant_identifier_names
ILog Log = LogImpl();

/// Creates a logger with the provided [options].
///
/// Intended to be used instead of the global [Log]ger, for example, to create
/// multiple loggers, or to ignore the global [LogOptions] being changed by some
/// packages using it.
ILog createLogger({LogOptions? options}) => LogImpl(options: options);
