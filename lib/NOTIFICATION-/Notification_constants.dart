import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:ssipl_billing/UTILS/helpers/support_functions.dart';

class NotificationModel {
  var MQTT_client = MqttServerClient.withPort("192.168.0.200", generateRandomString(6), 1883);
  final notifications = <String>[].obs;
  final isHovered = false.obs;
}
