import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

class Lgi {
  static const isEnable = true;

  static void p(String text, {bool isShortDir = true}) {
    if (!isEnable) {
      return;
    }
    String currentStackTrace = StackTrace.current.toString();
    final stResult = isShortDir
        ? _getClassAndMethod(currentStackTrace)
        : _getSecondPackage(currentStackTrace);
    final time = DateTime.now().toIso8601String();
    log(
      text == null || text.isEmpty
          ? '$time [$stResult]'
          : '$time [$stResult] >> $text',
    );
  }

  static void err({
    @required dynamic error,
    String s = '',
    bool isShortDir = true,
  }) {
    if (!isEnable) {
      return;
    }
    String currentStackTrace = StackTrace.current.toString();
    final stResult = isShortDir
        ? _getClassAndMethod(currentStackTrace)
        : _getSecondPackage(currentStackTrace);
    final time = DateTime.now().toIso8601String();
    log(' $time [$stResult] >> ${error?.toString()}${s != null ? ' ::: $s' : ''}',
        error: error, zone: Zone.current, stackTrace: StackTrace.current);
  }

  static String _getSecondPackage(String st) {
    final arr = st.split('#');
    String result = arr[2].substring(arr[2].indexOf('(package'));
    return result.trim();
  }

  static String _getClassAndMethod(String st) {
    try {
      String st1 = st.substring(st.indexOf('#1') + 2);
      String result = st1
          .substring(0, st1.indexOf(' ('))
          .trim()
          .replaceAll('<anonymous closure>', '');
      return result;
    } catch (error) {
      log('Something went wrong', error: error);
    }
    return 'stacktrace parse error';
  }
}
