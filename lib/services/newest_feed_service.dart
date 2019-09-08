import 'package:flutter/foundation.dart';

import 'package:hnpwa_client/hnpwa_client.dart';

import 'package:hacker_news_provider/app_exception.dart';

class NewestFeedService with ChangeNotifier {
  final HnpwaClient client;
  List<FeedItem> items = [];

  NewestFeedService(this.client);

  Future<void> fetch() async {
    try {
      final feed = await client.newest();

      items = feed.items;
      notifyListeners();
    } catch (e) {
      throw AppException('Fail to load newest feed');
    }
  }
}
