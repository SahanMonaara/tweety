import 'package:shared_preferences/shared_preferences.dart';

const ID = 'ID';

class AppSharedData {
  final SharedPreferences prefs;
  AppSharedData({required this.prefs});

  /// Save data
  /// param String [value] and int [id]
  Future setData(String id, String value) async {
    await prefs.setString(id, value);
  }

  /// Fetch Data by id
  /// param int [id]
  getData(String id) {
    return prefs.getString(id);
  }

  /// Clear the shared pref
  Future clearData(String id) async {
    await prefs.clear();
  }
}
