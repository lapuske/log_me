import 'dart:js_interop';

import '../color.dart';

@JS('console.log')
external void Function(Object?, Object?) log;

void display(String text, LogColor color) {
  log('%c$text', 'color: ${color.name}');
}


// import 'dart:js_interop';

// import '../color.dart';

// @JS('console.log')
// external void Function(Object?, Object?) log;

// // void display(List<(String, LogColor)> values) {
// void display(String text, LogColor color) {
//   log('%c$text', color.name);

//   // callMethod(window.console, 'log', ['%c$text', 'color: ${color.name}']);

//   // log(
//   //   values.map((e) {
//   //     if (e.$2 != LogColor.none) {
//   //       return '%c${e.$1}';
//   //     }

//   //     return e.$1;
//   //   }).join(''),
//   //   '',
//   // );

//   // log('%c$text', 'color: ${color.name}');
// }
