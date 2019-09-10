import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:hnpwa_client/hnpwa_client.dart';

import 'package:hacker_news_provider/app_exception.dart';

class NewsFeedService with ChangeNotifier {
  static final int _maxPage = 10;

  final HnpwaClient client;

  List<FeedItem> _items = [];
  int _currentPage = 1;

  NewsFeedService(this.client);

  bool get hasMore => _currentPage <= _maxPage;

  UnmodifiableListView<FeedItem> get items => UnmodifiableListView(_items);

  Future<void> fetch() async {
    try {
      final feed = await client.news(page: _currentPage);

      _items.addAll(feed.items);
      notifyListeners();

      _currentPage++;
    } catch (e) {
      throw AppException('Failed to load news feed');
    }
  }
}
