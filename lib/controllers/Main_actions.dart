import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:ssipl_billing/models/constants/main_constants.dart';
import 'package:ssipl_billing/utils/helpers/support_functions.dart';

class MainController extends GetxController {
  var mainModel = Main();

  @override
  void onInit() {
    super.onInit();
    initializeMqttClient();
  }

  void initializeMqttClient() {
    mainModel.MQTT_client = MqttServerClient.withPort("192.168.0.200", generateRandomString(6), 1558);
    // mainModel.MQTT_client.port = 1883;
    mainModel.MQTT_client.keepAlivePeriod = 60;
    mainModel.MQTT_client.onConnected = onConnected;
    mainModel.MQTT_client.onDisconnected = onDisconnected;

    connect();
  }

  Future<void> connect() async {
    try {
      await mainModel.MQTT_client.connect();
    } catch (e) {
      print("MQTT Connection Error: $e");
    }
  }

  void onConnected() {
    print("MQTT Connected");
  }

  void onDisconnected() {
    print("MQTT Disconnected");
  }
}
