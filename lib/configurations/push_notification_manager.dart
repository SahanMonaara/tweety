import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tweety/utils/injection_container.dart';

import 'app_shared_data.dart';

class PushNotificationsManager {
  final sharedData = sl<AppSharedData>();
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  getFCMToken() async {
    String sharedToken = sharedData.getData(FCM_TOKEN);
    if (sharedToken == null) {
      String? token = await firebaseMessaging.getToken();
      print("New FirebaseMessaging token:$token");

      if (token != null && token.isNotEmpty) {
        await sharedData.setData(FCM_TOKEN, token);
        return;
      } else
        getFCMToken();
    } else
      return;
  }
}
