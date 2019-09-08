import 'package:flutter/foundation.dart';
import 'package:hacker_news_provider/app_exception.dart';

import 'package:hnpwa_client/hnpwa_client.dart';

class NewsFeedService with ChangeNotifier {
  final HnpwaClient client;
  List<FeedItem> items = [];

  NewsFeedService(this.client);

  Future<void> fetch() async {
    try {
      final feed = await client.news();

      items = feed.items;
      notifyListeners();
    } catch (e) {
      throw AppException('Failed to load news feed');
    }
  }
}
