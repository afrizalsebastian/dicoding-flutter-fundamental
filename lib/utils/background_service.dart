import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:restaurant_app_fundamental_1/api/api_services.dart';
import 'package:restaurant_app_fundamental_1/main.dart';
import 'package:restaurant_app_fundamental_1/model/list_restaurant.dart';
import 'package:restaurant_app_fundamental_1/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm Fired !');
    final NotificationHelper _notificationHelper = NotificationHelper();
    List<Restaurant> listRestaurants =
        (await ApiServices().getListRestaurant()).restaurants;

    Random rand = Random();
    int randomIndex = rand.nextInt(listRestaurants.length);

    Restaurant randomRestaurant = listRestaurants[randomIndex];
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, randomRestaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
