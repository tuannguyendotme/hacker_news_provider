import 'package:flutter/material.dart';
import 'package:hacker_news_provider/widgets/feed_item_list_tile.dart';

import 'package:provider/provider.dart';

import 'package:hacker_news_provider/services/favorites_service.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer<FavoritesService>(
      builder: (context, favoritesService, child) {
        final items = favoritesService.items;

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) => FeedItemListTile(
            feedItem: items[index],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
