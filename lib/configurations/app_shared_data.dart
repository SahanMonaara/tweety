import 'package:shared_preferences/shared_preferences.dart';

const ID = 'ID';

class AppSharedData {
  final SharedPreferences prefs;
  AppSharedData({required this.prefs});

  Future setData(String id, String value) async {
    await prefs.setString(id, value);
  }

  getData(String id) {
    return prefs.getString(id);
  }

  Future clearData(String id) async {
    await prefs.clear();
  }
}
