import 'package:flutter/foundation.dart';

import 'package:hacker_news_provider/models/settings.dart';
import 'package:hacker_news_provider/services/storage_service.dart';

class SettingsService with ChangeNotifier {
  final StorageService storageService;

  Settings value = Settings.initial();

  SettingsService(this.storageService);

  void toggleTheme() {
    value = value.copyWith(useDarkTheme: !value.useDarkTheme);
    notifyListeners();

    storageService.saveSettings(value);
  }

  void loadSettings() {
    value = storageService.loadSettings();
  }
}
