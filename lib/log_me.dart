/// Colorful logger utility.
library;

import 'dart:core';

import 'src/log.dart';
import 'src/log_impl.dart';

export 'src/options.dart';

/// Logger logging its records to the console.
// ignore: non_constant_identifier_names
ILog Log = LogImpl();
