import 'package:flutter/material.dart';

import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:provider/provider.dart';

import 'package:hacker_news_provider/services/news_feed_service.dart';
import 'package:hacker_news_provider/services/newest_feed_service.dart';
import 'package:hacker_news_provider/services/settings_service.dart';
import 'package:hacker_news_provider/screens/main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(
          value: HnpwaClient(),
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
        )
      ],
      child: Consumer<SettingsService>(
        builder: (context, settingsService, child) => MaterialApp(
          title: 'Hacker News',
          theme: ThemeData(
            primaryColor: Colors.blue,
            accentColor: Colors.blue,
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
