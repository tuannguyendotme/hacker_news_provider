import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:hacker_news_provider/services/news_feed_service.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
      ),
      body: FutureBuilder(
        initialData: [],
        future: _newsFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<NewsFeedService>(
                    builder: (context, service, child) => ListView.builder(
                        itemCount: service.items.length,
                        itemBuilder: (context, index) {
                          final item = service.items[index];

                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(item.commentsCount.toString()),
                            ),
                            title: Text(item.title),
                            subtitle: Text(
                                '${item.timeAgo} by ${item.user != null ? item.user : 'Unknown User'}'),
                          );
                        }),
                  ),
      ),
    );
  }
}
