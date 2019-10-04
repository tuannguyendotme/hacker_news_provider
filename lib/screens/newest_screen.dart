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

class _NewestScreenState extends State<NewestScreen>
    with AutomaticKeepAliveClientMixin {
  NewestFeedService _service;
  Future _newestFuture;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _service = Provider.of<NewestFeedService>(context, listen: false);
    _newestFuture = _service.fetch();

    _scrollController = ScrollController();
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_service.hasMore) {
          await _service.fetch();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return FutureBuilder(
        initialData: [],
        future: _newestFuture,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.done:
              return snapshot.hasError
                  ? Center(
                      child: Text(snapshot.error.toString()),
                    )
                  : Consumer<NewestFeedService>(
                      builder: (context, service, child) => RefreshIndicator(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: service.hasMore
                              ? service.items.length + 1
                              : service.items.length,
                          itemBuilder: (context, index) {
                            if (index == service.items.length) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final item = service.items[index];

                            return FeedItemListTile(
                              feedItem: item,
                              onLongPress: widget.onFeedItemLongPress,
                            );
                          },
                        ),
                        onRefresh: _service.fetch,
                      ),
                    );

            default:
              return Center(
                child: Text('Something went wrong.'),
              );
          }
        });
  }

  @override
  bool get wantKeepAlive => true;
}
