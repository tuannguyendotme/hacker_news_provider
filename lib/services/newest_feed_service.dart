import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:hnpwa_client/hnpwa_client.dart';

import 'package:hacker_news_provider/app_exception.dart';

class NewestFeedService with ChangeNotifier {
  static final int _maxPage = 12;

  final HnpwaClient client;

  List<FeedItem> _items = [];
  int _currentPage = 1;

  NewestFeedService(this.client);

  bool get hasMore => _currentPage <= _maxPage;

  UnmodifiableListView<FeedItem> get items => UnmodifiableListView(_items);

  Future<void> fetch() async {
    try {
      final feed = await client.newest();

      _items.addAll(feed.items);
      notifyListeners();

      _currentPage++;
    } catch (e) {
      throw AppException('Fail to load newest feed');
    }
  }
}
