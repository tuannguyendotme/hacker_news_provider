import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hacker_news_provider/services/newest_feed_service.dart';
import 'package:hacker_news_provider/widgets/feed_item_list_tile.dart';

class NewestScreen extends StatefulWidget {
  final Function onFeedItemLongPress;

  const NewestScreen(this.onFeedItemLongPress);

  @override
  _NewestScreenState createState() => _NewestScreenState();
}

class _NewestScreenState extends State<NewestScreen> {
  NewestFeedService _service;
  Future _newestFuture;

  @override
  void initState() {
    super.initState();

    _service = Provider.of<NewestFeedService>(context, listen: false);
    _newestFuture = _service.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future: _newestFuture,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<NewestFeedService>(
                  builder: (context, service, child) => RefreshIndicator(
                    child: ListView.builder(
                      itemCount: service.items.length,
                      itemBuilder: (context, index) {
                        final item = service.items[index];

                        return FeedItemListTile(
                          feedItem: item,
                          onLongPress: widget.onFeedItemLongPress,
                        );
                      },
                    ),
                    onRefresh: _service.fetch,
                  ),
                ),
    );
  }
}
