import 'package:flutter/material.dart';

import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:provider/provider.dart';

import 'package:hacker_news_provider/services/news_feed_service.dart';
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
        ChangeNotifierProxyProvider<HnpwaClient, NewsFeedService>(
          builder: (context, client, newsFeedService) =>
              NewsFeedService(client),
        )
      ],
      child: MaterialApp(
        title: 'Hacker News',
        home: MainScreen(),
        routes: {
          MainScreen.routeName: (_) => MainScreen(),
        },
      ),
    );
  }
}
