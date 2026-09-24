import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as timezone;

class NotificationService {
  static final notifications = FlutterLocalNotificationsPlugin();
  static Future<void> initialize() async {
    tz.initializeTimeZones();
    timezone.setLocalLocation(timezone.getLocation('Africa/Cairo'));
    print('Local timezone: ${timezone.local.name}');
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const init = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await notifications.initialize(settings: init);
  }

  static Future<void> requestPermission() async {
    final androidPlugin = notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final iosPlugin = notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    await androidPlugin?.requestNotificationsPermission();
    // await androidPlugin?.requestExactAlarmsPermission();
    await iosPlugin?.requestPermissions(alert: true, badge: true, sound: true);
  }

  static Future<void> scheduleReadingReminder({
    required int minute,
    required int hour,
  }) async {
    print('Scheduling notification: $hour:$minute');
    final now = timezone.TZDateTime.now(timezone.local);
    var scheduledDate = timezone.TZDateTime(
      timezone.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    print('Now: $now');
    print('Scheduled: $scheduledDate');
    const androidDetails = AndroidNotificationDetails(
      'versea_notifications',
      'Versea Notifications',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    await notifications.zonedSchedule(
      id: 1,
      title: 'وقت القراءة',
      body: 'حان وقت قراءة الكتاب المقدس',
      scheduledDate: scheduledDate,
      notificationDetails: NotificationDetails(android: androidDetails),
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
    final pending = await notifications.pendingNotificationRequests();

    print('Pending notifications: ${pending.length}');
  }
}
