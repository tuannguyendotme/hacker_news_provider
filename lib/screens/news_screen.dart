import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hacker_news_provider/services/news_feed_service.dart';
import 'package:hacker_news_provider/widgets/feed_item_list_tile.dart';

class NewsScreen extends StatefulWidget {
  final Function onFeedItemLongPress;

  const NewsScreen(this.onFeedItemLongPress);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsFeedService _service;
  Future _newsFuture;

  @override
  void initState() {
    super.initState();

    _service = Provider.of<NewsFeedService>(context, listen: false);
    _newsFuture = _service.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future: _newsFuture,
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<NewsFeedService>(
              builder: (context, service, child) => RefreshIndicator(
                child: ListView.builder(
                  itemCount: service.items.length,
                  itemBuilder: (context, index) {
                    final item = service.items[index];

                    return FeedItemListTile(item, widget.onFeedItemLongPress);
                  },
                ),
                onRefresh: _service.fetch,
              ),
            ),
    );
  }
}
