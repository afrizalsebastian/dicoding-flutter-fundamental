import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app_fundamental_1/common/navigation.dart';
import 'package:restaurant_app_fundamental_1/provider/schedule_provider.dart';
import 'package:restaurant_app_fundamental_1/ui/homepage/home_page.dart';
import 'package:restaurant_app_fundamental_1/ui/restaurant/detail_restaurant.dart';
import 'package:restaurant_app_fundamental_1/ui/settings/settings_page.dart';
import 'package:restaurant_app_fundamental_1/utils/background_service.dart';
import 'package:restaurant_app_fundamental_1/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailRestaurant.routeName: (context) => DetailRestaurant(
            ModalRoute.of(context)?.settings.arguments as String),
        SettingsPage.routeName: (context) =>
            ChangeNotifierProvider<SchedulingProvider>(
              create: (_) => SchedulingProvider(),
              child: const SettingsPage(),
            ),
      },
    );
  }
}
