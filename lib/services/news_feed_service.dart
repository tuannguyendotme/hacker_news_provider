import 'package:flutter/foundation.dart';

import 'package:hnpwa_client/hnpwa_client.dart';

class NewsFeedService with ChangeNotifier {
  final HnpwaClient client;
  List<FeedItem> items = [];

  NewsFeedService(this.client);

  Future<void> fetch() async {
    final feed = await client.news();

    items = feed.items;
    notifyListeners();
  }
}
