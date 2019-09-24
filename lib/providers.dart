import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hacker_news_provider/services/favorites_service.dart';
import 'package:hacker_news_provider/services/newest_feed_service.dart';
import 'package:hacker_news_provider/services/news_feed_service.dart';
import 'package:hacker_news_provider/services/settings_service.dart';
import 'package:hacker_news_provider/services/storage_service.dart';

List<SingleChildCloneableWidget> initializeProviders(SharedPreferences prefs) =>
    [
      Provider.value(
        value: HnpwaClient(),
      ),
      Provider.value(
        value: StorageService(prefs),
      ),
      ChangeNotifierProxyProvider<HnpwaClient, NewsFeedService>(
        builder: (context, client, newsFeedService) => NewsFeedService(client),
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
        },
      ),
      ChangeNotifierProxyProvider<StorageService, SettingsService>(
        builder: (context, storageService, settingsService) {
          settingsService = SettingsService(storageService);
          settingsService.loadSettings();

          return settingsService;
        },
      ),
    ];
