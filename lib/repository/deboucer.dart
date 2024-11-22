import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int miliscecond;
  VoidCallback? action;
  Timer? _timer;
  Debouncer({required this.miliscecond});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: miliscecond), action);
  }
}
