import 'package:flutter/material.dart';

import 'db_enum.dart';

/// Theme preference saved in the profile.
enum AppThemeMode implements DbEnum {
  system('system', ThemeMode.system),
  light('light', ThemeMode.light),
  dark('dark', ThemeMode.dark);

  const AppThemeMode(this.dbValue, this.themeMode);

  @override
  final String dbValue;
  final ThemeMode themeMode;
}
