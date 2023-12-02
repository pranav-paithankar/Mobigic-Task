// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _lightmode = true;

  bool get lightmode => _lightmode;

  void setchange() {
    _lightmode = !_lightmode;
    notifyListeners();
  }
}
