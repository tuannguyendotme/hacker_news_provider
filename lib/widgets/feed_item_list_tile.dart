import 'package:flutter/material.dart';

import 'package:hnpwa_client/hnpwa_client.dart';

class FeedItemListTile extends StatelessWidget {
  final FeedItem item;
  final Function onLongPress;

  FeedItemListTile(this.item, this.onLongPress);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(item.points.toString()),
      ),
      title: Text(item.title),
      subtitle: Text(
          '${item.timeAgo} by ${item.user != null ? item.user : 'Unknown User'}'),
      onLongPress: () => this.onLongPress(item),
    );
  }
}
