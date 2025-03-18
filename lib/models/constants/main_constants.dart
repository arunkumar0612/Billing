import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:ssipl_billing/utils/helpers/support_functions.dart';

class Main {
  var MQTT_client = MqttServerClient.withPort("192.168.0.200", generateRandomString(6), 1558);
}
