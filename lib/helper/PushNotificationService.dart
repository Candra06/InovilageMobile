import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  static Future initialize(FlutterLocalNotificationsPlugin plugins) async {
    var androidInit = AndroidInitializationSettings('mipmap/ic_launcher');
    var initSettings = InitializationSettings(android: androidInit);
    await plugins.initialize(initSettings);
  }

  static Future showBigTextNotif({
    var id = 0,
    required String title,
    required String body,
    var payload,
    required FlutterLocalNotificationsPlugin fln,
  }) async {
     AndroidNotificationDetails androidPlatformChannelSpecifics =
    new AndroidNotificationDetails(
      'you_can_name_it_whatever1',
      'channel_name',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
      importance: Importance.max,
      priority: Priority.high,
    );

    var not= NotificationDetails(android: androidPlatformChannelSpecifics,
        
    );
    await fln.show(0, title, body,not );
  }
}
