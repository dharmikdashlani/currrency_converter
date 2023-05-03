import 'package:flutter/material.dart';
import 'package:currency/modal/theme_changer_modal.dart';

class ThemeController extends ChangeNotifier {
  ThemeChanger t = ThemeChanger(isDark: false);

  setDark() {
    t.isDark = !t.isDark;
    notifyListeners();
  }
}
