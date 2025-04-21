// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ssipl_billing/NOTIFICATION-/Notification_constants.dart';
import 'package:ssipl_billing/UTILS-/helpers/refresher.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

import '../IAM-/controllers/IAM_actions.dart';

class NotificationController extends GetxController {
  var notificationModel = NotificationModel();
  final LoginController loginController = Get.find<LoginController>();
  Timer? _reconnectTimer; // Timer for automatic reconnection
  final WindowsNotification winNotifyPlugin = WindowsNotification(applicationId: r"Enterprise & Resource Planning");

  @override
  void onInit() {
    super.onInit();
    initializeMqttClient();
  }

  // void bringAppToFront() {
  //   final hwnd = FindWindow(nullptr, TEXT("ERP_APP"));
  //   if (hwnd != 0) {
  //     ShowWindow(hwnd, SHOW_WINDOW_CMD.SW_RESTORE);
  //     SetForegroundWindow(hwnd);
  //   }
  // }

  Future<String> getImageBytes(String url) async {
    final supportDir = await getApplicationSupportDirectory();
    final cl = http.Client();
    final resp = await cl.get(Uri.parse(url));
    final bytes = resp.bodyBytes;
    final imageFile = File("${supportDir.path}/${DateTime.now().millisecond}.png");
    await imageFile.create();
    await imageFile.writeAsBytes(bytes);
    return imageFile.path;
  }

  Future<String> copyAssetImageToTemp(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    final file = File("${tempDir.path}/temp_image.png");

    await file.writeAsBytes(bytes);
    return file.path;
  }

  void showWithSmallImage(String message) async {
    final imagePath = await copyAssetImageToTemp('assets/images/tik.gif');

    NotificationMessage notificationMessage = NotificationMessage.fromPluginTemplate(
      "New Notification",
      "New Notification",
      message,
      image: imagePath,
      launch: 'C:\\Users\\COMP\\test\\build\\windows\\x64\\runner\\Release\\ERP.exe "$message"',
    );

    await winNotifyPlugin.showNotificationPluginTemplate(notificationMessage);
  }

  // void showNotificationDialog(BuildContext context, String message) {
  //   // ignore: unnecessary_null_comparison
  //   if (context == null) return; // Prevent null issues

  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // Prevent accidental closure
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Notification"),
  //         content: Text(message),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text("OK"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void initializeMqttClient() {
    notificationModel.MQTT_client = MqttServerClient.withPort('192.168.0.200', loginController.loginModel.userController.value.text, 1883);
    notificationModel.MQTT_client.logging(on: true);
    notificationModel.MQTT_client.keepAlivePeriod = 60;
    notificationModel.MQTT_client.onConnected = onConnected;
    notificationModel.MQTT_client.onDisconnected = onDisconnected;
    notificationModel.MQTT_client.setProtocolV311(); // Ensure compatibility with broker

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(loginController.loginModel.userController.value.text)
        .authenticateAs(loginController.loginModel.userController.value.text, loginController.loginModel.passwordController.value.text)
        .keepAliveFor(60)
        .startClean();
    notificationModel.MQTT_client.connectionMessage = connMessage;

    connect();
  }

  Future<void> connect() async {
    try {
      if (kDebugMode) {
        print("Connecting to MQTT Broker...");
      }
      await notificationModel.MQTT_client.connect();
      if (notificationModel.MQTT_client.connectionStatus!.state == MqttConnectionState.connected) {
        if (kDebugMode) {
          print("Successfully connected to MQTT broker.");
        }
        connectAndSubscribe();
      } else {
        if (kDebugMode) {
          print("Connection failed: ${notificationModel.MQTT_client.connectionStatus}");
        }
        startReconnectTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        print("MQTT Connection Error: $e");
      }
      startReconnectTimer();
    }
  }

  void onConnected() {
    if (kDebugMode) {
      print("MQTT Connected");
    }
    _reconnectTimer?.cancel(); // Cancel reconnect attempts if connected
  }

  void onDisconnected() {
    if (kDebugMode) {
      print("MQTT Disconnected");
    }
    startReconnectTimer();
  }

  void startReconnectTimer() {
    _reconnectTimer?.cancel(); // Ensure previous timer is canceled
    _reconnectTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (notificationModel.MQTT_client.connectionStatus!.state != MqttConnectionState.connected) {
        if (kDebugMode) {
          print("Attempting to reconnect...");
        }
        connect();
      } else {
        if (kDebugMode) {
          print("Reconnected successfully!");
        }
        _reconnectTimer?.cancel();
      }
    });
  }

  Future<void> connectAndSubscribe() async {
    try {
      if (notificationModel.MQTT_client.connectionStatus!.state == MqttConnectionState.connected) {
        if (kDebugMode) {
          print('Subscribing to topic: Notification');
        }
        notificationModel.MQTT_client.subscribe('Notification', MqttQos.atLeastOnce);
        notificationModel.MQTT_client.subscribe('refresh', MqttQos.atLeastOnce);

        notificationModel.MQTT_client.updates!.listen(
          (List<MqttReceivedMessage<MqttMessage>> messages) {
            for (var message in messages) {
              final recMessage = message.payload as MqttPublishMessage;
              final topic = message.topic;

              final String messageText = MqttPublishPayload.bytesToStringAsString(recMessage.payload.message);
              if (kDebugMode) {
                print('Received message: $messageText from topic: $topic');
              }

              if (topic == 'Notification') {
                react_to_MQTTlistener(topic, messageText);
                return;
              }
              if (topic == 'refresh') {
                react_to_MQTTlistener(topic, messageText);
                return;
              }
            }
          },
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('MQTT Exception: $e');
      }
    }
  }

  @override
  void onClose() {
    _reconnectTimer?.cancel(); // Cancel timer when controller is destroyed
    notificationModel.MQTT_client.disconnect();
    super.onClose();
  }

  void react_to_MQTTlistener(String topic, String message) async {
    final context = Get.context;
    if (topic == "Notification") {
      if (context != null) {
        // await Refresher().refreshAll();
      }
      if (!notificationModel.notifications.contains(message)) {
        notificationModel.notifications.add(message);
        showWithSmallImage(message);
      }
    } else if (topic == "refresh") {
      if (context != null) {
        await Refresher().refreshAll();
      }
      if (!notificationModel.notifications.contains(message)) {
        notificationModel.notifications.add(message);
      }
    }
  }

  void clearNotifications(String value) {
    notificationModel.notifications.remove(value);
  }

  void sampleNotifications() {
    notificationModel.notifications.addAll([
      ' New video from Flutter Explained: "Mastering GetX State Management"',
      ' Your comment got 25 likes on "Best Practices for Flutter UI"',
      ' John Doe uploaded a new video: "Building a gRPC Client in Flutter"',
      ' Don’t miss the Flutter Dev Summit 2025 — Live now!',
      ' You have a new reply on your comment: "This helped me so much!"',
    ]);
  }

  void addNotification(String message) {
    notificationModel.notifications.add(message);
  }

  void clearAllNotifications() {
    notificationModel.notifications.clear();
    update();
  }
}
