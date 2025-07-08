import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:ssipl_billing/API/api_service.dart';
import 'package:ssipl_billing/UTILS/helpers/encrypt_decrypt.dart';
import 'package:ssipl_billing/UTILS/helpers/returns.dart';

import '../IAM/controllers/IAM_actions.dart';

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
      final result = <String, int>{"statusCode": response.statusCode!};
      decodedResponse.addEntries(result.entries.map((e) => MapEntry(e.key, e.value)));
      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {"statusCode": response.statusCode, "message": "Server Error"};
      return reply;
    }
  }

  Future<Map<String, dynamic>?> GetbyToken(String API) async {
    final requestData = {"STOKEN": sessiontokenController.sessiontokenModel.sessiontoken.value};
    final response = await apiService.postData(API, requestData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{"statusCode": response.statusCode!};
      decodedResponse.addEntries(
        result.entries.map(
          (e) => MapEntry(e.key, e.value),
        ),
      );
      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {"statusCode": response.statusCode, "message": "Server Error"};
      return reply;
    }
  }

  Future<Map<String, dynamic>?> GetbyQueryString(Map<String, dynamic> body, String API) async {
    final dataToEncrypt = jsonEncode(body);
    final encryptedData = AES.encryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), dataToEncrypt);

    Map<String, dynamic> formData = {"STOKEN": sessiontokenController.sessiontokenModel.sessiontoken.value, "querystring": encryptedData};
    final response = await apiService.postData(API, formData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{"statusCode": response.statusCode!};
      decodedResponse.addEntries(result.entries.map((e) => MapEntry(e.key, e.value)));
      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {"statusCode": response.statusCode, "message": "Server Error"};
      return reply;
    }
  }

  Future<Map<String, dynamic>?> multiPart(File? file, String API) async {
    FormData formData = FormData({
      if (file != null) "file": MultipartFile(file, filename: file.path.split('/').last), // Attach file
      "STOKEN": sessiontokenController.sessiontokenModel.sessiontoken.value,
    });
    final response = await apiService.postMulter(API, formData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{"statusCode": response.statusCode!};
      decodedResponse.addEntries(
        result.entries.map(
          (e) => MapEntry(e.key, e.value),
        ),
      );

      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {"statusCode": response.statusCode, "message": "Server Error"};
      return reply;
    }
  }

  Future<Map<String, dynamic>> Multer(String token, String body, List<File>? files, String api) async {
    final sessionToken = sessiontokenController.sessiontokenModel.sessiontoken.value;
    final encryptedData = AES.encryptWithAES(sessionToken.substring(0, 16), body);

    final formDataMap = <String, dynamic>{
      "STOKEN": sessionToken,
      "querystring": encryptedData,
    };

    // Add file(s) if provided
    if (files != null && files.isNotEmpty) {
      if (files.length == 1) {
        formDataMap["file"] = MultipartFile(files[0], filename: files[0].path.split('/').last);
      } else {
        formDataMap["files"] = files.map((file) {
          return MultipartFile(file, filename: file.path.split('/').last);
        }).toList();
      }
    }

    final formData = FormData(formDataMap);
    final response = await apiService.postMulter(api, formData);

    if (response.statusCode == 200) {
      final encryptedResponse = response.body['encryptedResponse'];
      final decrypted = AES.decryptWithAES(sessionToken.substring(0, 16), encryptedResponse);
      final decoded = jsonDecode(decrypted);
      decoded["statusCode"] = response.statusCode!;
      return decoded;
    } else {
      return {"statusCode": response.statusCode, "message": "Server Error"};
    }
  }

  Future<Map<String, dynamic>> SendByQuerystring(String body, String API) async {
    final encryptedData = AES.encryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), body);

    final requestData = {
      "STOKEN": sessiontokenController.sessiontokenModel.sessiontoken.value,
      "querystring": encryptedData,
    };

    final response = await apiService.post(API, requestData);

    if (response.statusCode == 200) {
      final responseData = response.body;
      String encryptedResponse = responseData['encryptedResponse'];
      final decryptedResponse = AES.decryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), encryptedResponse);
      Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);
      final result = <String, int>{"statusCode": response.statusCode!};
      decodedResponse.addEntries(result.entries.map((e) => MapEntry(e.key, e.value)));

      return decodedResponse;
    } else {
      Map<String, dynamic> reply = {"statusCode": response.statusCode, "message": "Server Error"};
      return reply;
    }
  }

  Future<Map<String, dynamic>> MultiSeperateFiles(
    String token,
    String body,
    Map<String, dynamic> files,
    // File? logoFile,
    // File? regFile,
    // File? panFile,
    // File? chequeFile,
    String api,
  ) async {
    final sessionToken = sessiontokenController.sessiontokenModel.sessiontoken.value;
    final encryptedData = AES.encryptWithAES(sessionToken.substring(0, 16), body);

    final formDataMap = <String, dynamic>{
      "STOKEN": sessionToken,
      "querystring": encryptedData,
    };
    files.forEach((key, value) {
      formDataMap[key] = value;
    });

    // Attach each file separately with appropriate key
    // if (logoFile != null) {
    //   formDataMap["logo_upload"] = MultipartFile(regFile, filename: logoFile.path.split('/').last);
    // }
    // if (regFile != null) {
    //   formDataMap["registration_certificate"] = MultipartFile(regFile, filename: regFile.path.split('/').last);
    // }

    // if (panFile != null) {
    //   formDataMap["pan_upload"] = MultipartFile(panFile, filename: panFile.path.split('/').last);
    // }

    // if (chequeFile != null) {
    //   formDataMap["cancelled_cheque"] = MultipartFile(chequeFile, filename: chequeFile.path.split('/').last);
    // }

    // Convert map to FormData and send request
    final formData = FormData(formDataMap);
    final response = await apiService.postMulter(api, formData);

    if (response.statusCode == 200) {
      final encryptedResponse = response.body['encryptedResponse'];
      final decrypted = AES.decryptWithAES(sessionToken.substring(0, 16), encryptedResponse);
      final decoded = jsonDecode(decrypted);
      decoded["statusCode"] = response.statusCode!;
      return decoded;
    } else {
      return {"statusCode": response.statusCode, "message": "Server Error"};
    }
  }
}
