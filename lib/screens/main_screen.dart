import 'package:flutter/material.dart';
import 'package:hacker_news_provider/screens/newest_screen.dart';
import 'package:hacker_news_provider/screens/news_screen.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final List<Widget> _screens = [
    NewestScreen(),
    NewsScreen(),
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _screens.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hacker News'),
      ),
      body: TabBarView(
        children: _screens,
        controller: _tabController,
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          controller: _tabController,
          tabs: <Widget>[
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
                  Icon(Icons.new_releases),
                  Text('News'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
