import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:ssipl_billing/services/APIservices/api_service.dart';
import 'package:ssipl_billing/utils/helpers/returns.dart';
import 'package:ssipl_billing/utils/helpers/encrypt_decrypt.dart';
import '../../controllers/IAM_actions.dart';

class Invoker extends GetxController {
  final ApiService apiService = ApiService();
  final SessiontokenController sessiontokenController = Get.find<SessiontokenController>();
  Future<Map<String, dynamic>?> IAM(Map<String, dynamic> body, String API) async {
    final configData = await Returns.loadConfigFile('assets/key.config');
    final apiKey = configData['APIkey'];
    final secret = configData['Secret'];

    final dataToEncrypt = jsonEncode(body);
    final encryptedData = AES.encryptWithAES(secret, dataToEncrypt);
    final requestData = {
      "APIkey": apiKey,
      "Secret": secret,
      "querystring": encryptedData,
    };
    final response = await apiService.postData(API, requestData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(secret.substring(0, 16), encryptedResponse);
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

  Future<Map<String, dynamic>?> GetbyToken(String API) async {
    final requestData = {
      "STOKEN": sessiontokenController.sessiontokenModel.sessiontoken.value
    };
    final response = await apiService.postData(API, requestData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{
        "statusCode": response.statusCode!
      };
      decodedResponse.addEntries(
        result.entries.map(
          (e) => MapEntry(e.key, e.value),
        ),
      );
      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {
        "statusCode": response.statusCode,
        "message": "Server Error"
      };
      return reply;
    }
  }

  Future<Map<String, dynamic>?> GetbyQueryString(Map<String, dynamic> body, String API) async {
    final dataToEncrypt = jsonEncode(body);
    final encryptedData = AES.encryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), dataToEncrypt);

    Map<String, dynamic> formData = {
      "STOKEN": sessiontokenController.sessiontokenModel.sessiontoken.value,
      "querystring": encryptedData
    };
    final response = await apiService.postData(API, formData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), encryptedResponse);
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

  Future<Map<String, dynamic>?> multiPart(File file, String API) async {
    FormData formData = FormData({
      "file": MultipartFile(file, filename: file.path.split('/').last), // Attach file
      "STOKEN": sessiontokenController.sessiontokenModel.sessiontoken.value,
    });
    final response = await apiService.postMulter(API, formData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{
        "statusCode": response.statusCode!
      };
      decodedResponse.addEntries(
        result.entries.map(
          (e) => MapEntry(e.key, e.value),
        ),
      );

      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {
        "statusCode": response.statusCode,
        "message": "Server Error"
      };
      return reply;
    }
  }

  Future<Map<String, dynamic>> Multer(String Token, String body, File file, String API) async {
    final encryptedData = AES.encryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), body);

    FormData formData = FormData({
      "file": MultipartFile(file, filename: file.path.split('/').last), // Attach file
      "STOKEN": sessiontokenController.sessiontokenModel.sessiontoken.value,
      "querystring": encryptedData
    });
    final response = await apiService.postMulter(API, formData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), encryptedResponse);
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
