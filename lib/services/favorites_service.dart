import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:hnpwa_client/hnpwa_client.dart';

class FavoritesService with ChangeNotifier {
  List<FeedItem> _items = [];

  UnmodifiableListView<FeedItem> get items => UnmodifiableListView(_items);

  void addItem(FeedItem item) {
    final inFavorites = _items.contains((i) => i.id == item.id);

    if (inFavorites) {
      return;
    }

    _items.add(item);
    notifyListeners();
  }

  void removeItem(FeedItem item) {
    final index = _items.indexWhere((i) => i.id == item.id);

    if (index != -1) {
      _items.removeAt(index);
      notifyListeners();
    }
  }
}
