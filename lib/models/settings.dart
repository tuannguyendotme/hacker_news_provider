class Settings {
  final bool useDarkTheme;

  Settings({this.useDarkTheme});

  Settings.initial() : useDarkTheme = false;

  Settings copyWith({bool useDarkTheme}) {
    return Settings(
      useDarkTheme: useDarkTheme ?? this.useDarkTheme,
    );
  }
}
