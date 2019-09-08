import 'package:flutter/material.dart';

import 'package:hnpwa_client/hnpwa_client.dart';

class FeedItemListTile extends StatelessWidget {
  final FeedItem feedItem;
  final Function onLongPress;

  FeedItemListTile({
    @required this.feedItem,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(feedItem.points.toString()),
      ),
      title: Text(feedItem.title),
      subtitle: Text(
          '${feedItem.timeAgo} by ${feedItem.user != null ? feedItem.user : 'Unknown User'}'),
      onLongPress: () {
        if (this.onLongPress != null) {
          this.onLongPress(feedItem);
        }
      },
    );
  }
}
