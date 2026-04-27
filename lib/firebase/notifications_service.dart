
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// 🔹 Init
  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(settings);

    /// 🔹 Timezone setup (IMPORTANT)
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
  }

  /// 🔹 Instant Notification (Test)
  static Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    const NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        'instant_channel',
        'Instant Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      details,
    );
  }

  /// 🔹 Scheduled Notification
static Future<void> scheduleNotification({
  required int id,
  required String title,
  required String body,
  required DateTime scheduledTime,
}) async {
  final tz.TZDateTime tzTime =
      tz.TZDateTime.from(scheduledTime, tz.local);



  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tzTime,
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'event_channel',
        'Event Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),


  androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}
  /// 🔹 Cancel one
  static Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  /// 🔹 Cancel all
  static Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
