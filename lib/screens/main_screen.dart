import 'package:flutter/material.dart';
import 'package:hacker_news_provider/screens/favorite_screen.dart';
import 'package:hacker_news_provider/screens/newest_screen.dart';
import 'package:hacker_news_provider/screens/news_screen.dart';
import 'package:hacker_news_provider/screens/settings_screen.dart';
import 'package:hnpwa_client/hnpwa_client.dart';

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
          FavoriteScreen(),
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
        color: Colors.blue,
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
                  Text('Favorite'),
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

  void _showBottomSheet(BuildContext context, FeedItem item) {
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
                leading: Icon(Icons.favorite),
                title: Text('Add to favorite'),
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Open link'),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
