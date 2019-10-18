import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:hacker_news_provider/providers.dart';
import 'package:hacker_news_provider/services/settings_service.dart';
import 'package:hacker_news_provider/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp(this.prefs);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: initializeProviders(prefs),
      child: Consumer<SettingsService>(
        builder: (context, settingsService, child) => MaterialApp(
          title: 'Hacker News',
          theme: ThemeData(
            primaryColor: Colors.orange,
            accentColor: Colors.orange,
            brightness: settingsService.value.useDarkTheme
                ? Brightness.dark
                : Brightness.light,
          ),
          home: MainScreen(),
        ),
      ),
    );
  }
}
