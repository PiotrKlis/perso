import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@singleton
class PersoSharedPrefs {
  SharedPreferences? _prefs;

  Future<void> _init() async {
    _prefs ?? await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _init();
    await _prefs?.setString(key, value);
  }

  Future<String> getString(String key, {String defaultValue = ""}) async {
    await _init();
    return _prefs?.getString(key) ?? defaultValue;
  }

  Future<void> setInt(String key, int value) async {
    await _init();
    await _prefs?.setInt(key, value);
  }

  int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  Future<void> setBool(String key, bool value) async {
    await _init();
    await _prefs?.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  Future<void> setDouble(String key, double value) async {
    await _init();
    await _prefs?.setDouble(key, value);
  }

  Future<double> getDouble(String key, {double defaultValue = 0.0}) async {
    await _init();
    return _prefs?.getDouble(key) ?? defaultValue;
  }

  Future<void> remove(String key) async {
    await _init();
    await _prefs?.remove(key);
  }

  Future<void> clear() async {
    await _init();
    await _prefs?.clear();
  }
}
