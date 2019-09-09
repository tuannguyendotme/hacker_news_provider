import 'package:flutter/material.dart';

import 'package:hnpwa_client/hnpwa_client.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:hacker_news_provider/screens/favorites_screen.dart';
import 'package:hacker_news_provider/screens/newest_screen.dart';
import 'package:hacker_news_provider/screens/news_screen.dart';
import 'package:hacker_news_provider/screens/settings_screen.dart';
import 'package:hacker_news_provider/services/favorites_service.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
      ),
      body: TabBarView(
        children: [
          NewsScreen((item) => _showBottomSheet(context, item)),
          NewestScreen((item) => _showBottomSheet(context, item)),
          FavoritesScreen(
              (item) => _showBottomSheet(context, item, isRemove: true)),
          SettingsScreen(),
        ],
        controller: _tabController,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return SizedBox(
      height: 80,
      child: Material(
        color: Theme.of(context).primaryColor,
        child: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Container(
                height: 100,
                child: Column(
                  children: <Widget>[
                    Icon(Icons.new_releases),
                    Text('News'),
                  ],
                ),
              ),
            ),
            Tab(
              child: Column(
                children: <Widget>[
                  Icon(Icons.trending_up),
                  Text('Newest'),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: <Widget>[
                  Icon(Icons.favorite),
                  Text('Favorites'),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: <Widget>[
                  Icon(Icons.settings),
                  Text('Settings'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, FeedItem item,
      {bool isRemove = false}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: const Color(0xFF737373),
        height: 200,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
            ),
          ),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(isRemove ? Icons.delete : Icons.favorite),
                title: Text('${isRemove ? 'Remove from' : 'Add to'} favorites'),
                onTap: () {
                  final favoritesService =
                      Provider.of<FavoritesService>(context, listen: false);

                  if (isRemove) {
                    favoritesService.removeItem(item);
                  } else {
                    favoritesService.addItem(item);
                  }

                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Open in browser'),
                onTap: () async {
                  Navigator.of(context).pop();

                  await launch(item.url);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () {
                  Navigator.of(context).pop();

                  Share.share(item.url);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
