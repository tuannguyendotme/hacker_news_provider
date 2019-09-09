import 'dart:convert';
import 'dart:core';

import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hacker_news_provider/models/settings.dart';

class StorageService {
  static final String _favoritesKey = 'favorites';
  static final String _useDarkThemeKey = 'useDarkTheme';

  final SharedPreferences prefs;

  StorageService(this.prefs);

  Future<void> saveFavorites(List<FeedItem> items) async {
    final itemsAsString = items.map((i) {
      Map<String, dynamic> feedItemData = {
        'id': i.id,
        'title': i.title,
        'points': i.points,
        'user': i.user,
        'time': i.time,
        'time_ago': i.timeAgo,
        'comments_count': i.commentsCount,
        'type': i.type.toString(),
        'url': i.url,
        'domain': i.domain,
      };

      return json.encode(feedItemData);
    }).toList();

    await prefs.setStringList(_favoritesKey, itemsAsString);
  }

  List<FeedItem> loadFavorites() {
    final itemsAsString = prefs.getStringList(_favoritesKey);

    if (itemsAsString == null) {
      return [];
    }

    return itemsAsString.map((i) => FeedItem.fromJson(json.decode(i))).toList();
  }

  Future<void> saveSettings(Settings settings) async {
    await prefs.setBool(_useDarkThemeKey, settings.useDarkTheme);
  }

  Settings loadSettings() {
    final Settings settings = Settings.initial();

    return settings.copyWith(useDarkTheme: prefs.getBool(_useDarkThemeKey));
  }
}
