import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:hnpwa_client/hnpwa_client.dart';

import 'package:hacker_news_provider/services/storage_service.dart';

class FavoritesService with ChangeNotifier {
  final StorageService storageService;
  List<FeedItem> _items = [];

  FavoritesService(this.storageService);

  UnmodifiableListView<FeedItem> get items => UnmodifiableListView(_items);

  void loadFavorites() {
    _items = storageService.loadFavorites();
    notifyListeners();
  }

  void addItem(FeedItem item) {
    final index = _items.indexWhere((i) => i.id == item.id);

    if (index == -1) {
      _items.add(item);
    } else {
      _items[index] = item;
    }

    notifyListeners();

    storageService.saveFavorites(items);
  }

  void removeItem(FeedItem item) {
    final index = _items.indexWhere((i) => i.id == item.id);

    if (index == -1) {
      return;
    }

    _items.removeAt(index);
    notifyListeners();

    storageService.saveFavorites(items);
  }
}
