import 'package:flutter/foundation.dart';
import 'package:hacker_news_provider/models/settings.dart';

class SettingsService with ChangeNotifier {
  Settings value = Settings.initial();

  void toggleTheme() {
    value = value.copyWith(useDarkTheme: !value.useDarkTheme);
    notifyListeners();
  }
}
