import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:hnpwa_client/hnpwa_client.dart';

import 'package:hacker_news_provider/app_exception.dart';

class NewsFeedService with ChangeNotifier {
  final HnpwaClient client;

  List<FeedItem> _items = [];
  int _currentPage = 1;
  bool _hasMore = true;

  NewsFeedService(this.client);

  bool get hasMore => _hasMore;

  UnmodifiableListView<FeedItem> get items => UnmodifiableListView(_items);

  Future<void> fetch() async {
    try {
      final feed = await client.news(page: _currentPage);

      _hasMore = feed.hasNextPage;

      _items.addAll(feed.items);
      notifyListeners();

      _currentPage++;
    } catch (e) {
      throw AppException('Failed to load news feed');
    }
  }
}
