import 'package:flutter/material.dart';

import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hacker_news_provider/services/news_feed_service.dart';
import 'package:hacker_news_provider/services/newest_feed_service.dart';
import 'package:hacker_news_provider/services/settings_service.dart';
import 'package:hacker_news_provider/services/favorites_service.dart';
import 'package:hacker_news_provider/services/storage_service.dart';
import 'package:hacker_news_provider/screens/main_screen.dart';

void main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp(this.prefs);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(
          value: HnpwaClient(),
        ),
        Provider.value(
          value: StorageService(prefs),
        ),
        ChangeNotifierProvider.value(
          value: SettingsService(),
        ),
        ChangeNotifierProxyProvider<HnpwaClient, NewsFeedService>(
          builder: (context, client, newsFeedService) =>
              NewsFeedService(client),
        ),
        ChangeNotifierProxyProvider<HnpwaClient, NewestFeedService>(
          builder: (context, client, newsFeedService) =>
              NewestFeedService(client),
        ),
        ChangeNotifierProxyProvider<StorageService, FavoritesService>(
            builder: (context, storageService, favoritesService) {
          favoritesService = FavoritesService(storageService);
          favoritesService.loadFavorites();

          return favoritesService;
        }),
      ],
      child: Consumer<SettingsService>(
        builder: (context, settingsService, child) => MaterialApp(
          title: 'Hacker News',
          theme: ThemeData(
            primaryColor: Colors.orange,
            accentColor: Colors.orange,
            brightness: settingsService.value.useDarkTheme
                ? Brightness.dark
                : Brightness.light,
          ),
          home: MainScreen(),
        ),
      ),
    );
  }
}
