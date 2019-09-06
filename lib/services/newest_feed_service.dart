import 'package:flutter/foundation.dart';

import 'package:hnpwa_client/hnpwa_client.dart';

class NewestFeedService with ChangeNotifier {
  final HnpwaClient client;
  List<FeedItem> items = [];

  NewestFeedService(this.client);

  Future<void> fetch() async {
    final feed = await client.newest();

    items = feed.items;
    notifyListeners();
  }
}
