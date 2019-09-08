import 'package:flutter/material.dart';
import 'package:hacker_news_provider/services/settings_service.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final SettingsService settingsService =
        Provider.of<SettingsService>(context);

    return ListView(
      children: <Widget>[
        SwitchListTile(
          title: Text('Use dark theme'),
          value: settingsService.value.useDarkTheme,
          activeColor: Theme.of(context).accentColor,
          onChanged: (bool newValue) {
            settingsService.toggleTheme();
          },
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
