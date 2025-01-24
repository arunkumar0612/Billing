import 'dart:convert';
import 'package:get/get.dart';
import 'package:ssipl_billing/services/APIservices/ApiService.dart';
import 'package:ssipl_billing/utils/helpers/returns.dart';
import 'package:ssipl_billing/utils/helpers/encrypt_decrypt.dart';

class MyController extends GetxController {
  final ApiService apiService = ApiService();

  // Observable for loading state
  var isLoading = false.obs;

  Future<Map<String, dynamic>?> login(Map<String, dynamic> body, String API) async {
    isLoading.value = true;
    final configData = await loadConfigFile('assets/key.config');
    final apiKey = configData['APIkey'];
    final secret = configData['Secret'];

    final dataToEncrypt = jsonEncode(body);
    final encryptedData = EncryptWithAES.encryptWithAES(secret, dataToEncrypt);
    final requestData = {
      "APIkey": apiKey,
      "Secret": secret,
      "querystring": encryptedData,
    };
    final response = await apiService.postData(API, requestData);

    isLoading.value = false;

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = EncryptWithAES.decryptWithAES(secret.substring(0, 16), encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{
        "statusCode": response.statusCode!
      };
      decodedResponse.addEntries(result.entries.map((e) => MapEntry(e.key, e.value)));

      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {
        "statusCode": response.statusCode,
        "message": "Server Error"
      };
      return reply;
    }
  }
}
