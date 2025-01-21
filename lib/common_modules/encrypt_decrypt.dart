// ignore_for_file: no_logic_in_create_state, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EncryptWithAES extends StatefulWidget {
  const EncryptWithAES({super.key});
  static String SESSIONTOKEN = "15b97917-b296-11ed-997a-b42e9923";
  String encryptWithAES(String key, String plainText) {
    final cipherKey = encrypt.Key.fromUtf8(key);
    final encrypter = encrypt.Encrypter(encrypt.AES(cipherKey, mode: encrypt.AESMode.cbc));
    final iv = encrypt.IV.fromUtf8(key.substring(0, 16)); // Use an IV with the correct length
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final encryptedBase64 = encrypted.base64;
    return encryptedBase64;
  }

  String decryptWithAES(String key, String encryptedData) {
    final cipherKey = encrypt.Key.fromUtf8(key);
    final encrypter = encrypt.Encrypter(encrypt.AES(cipherKey, mode: encrypt.AESMode.cbc));
    final iv = encrypt.IV.fromUtf8(key.substring(0, 16)); // Use an IV with the correct length

    final encrypted = encrypt.Encrypted.fromBase64(encryptedData);
    return encrypter.decrypt(encrypted, iv: iv);
  }

//   Future<void> Token_write_Function(
//       Map<String, dynamic> decodedResponse) async {
//     final valueToToken = decodedResponse["Value"].toString();
//     await const FlutterSecureStorage().write(key: 'Value', value: valueToToken);
//   }

// //example
// //valueToToken : 7a9c070a-cb09-11ee-9b9f-b42e9923474d
//   Future<void> check_stored_token() async {
//     final valueToToken = await const FlutterSecureStorage().read(key: 'Value');

//     if (valueToToken != null) {
//       if (kDebugMode) {
//         print("SessionToken is Stored : $valueToToken");
//       }
//     } else {
//       if (kDebugMode) {
//         print('Session Token is not Stored');
//       }
//     }
//   }

  Future<String?> get_stored_token() async {
    return SESSIONTOKEN;
  }

//   Future<void> data_write_function(Map<String, dynamic> decodedResponse) async {
//     final valueToStore = decodedResponse['Value'].toString();
//     await const FlutterSecureStorage()
//         .write(key: 'StoredValue', value: valueToStore);
//   }

//   Future<String?> get_stored_data() async {
//     String? storedValue =
//         await const FlutterSecureStorage().read(key: 'StoredValue');
//     return storedValue;
//   }

//   Future<void> check_stored_data() async {
//     String? storedValue =
//         await const FlutterSecureStorage().read(key: 'StoredValue');

//     if (storedValue != null) {
//       if (kDebugMode) {
//         print('Data is stored: $storedValue');
//       }
//     } else {
//       if (kDebugMode) {
//         print('Data is not stored.');
//       }
//     }
//   }

//   Future<void> write_devicecount(int num) async {
//     final valueToStore = num.toString();
//     await const FlutterSecureStorage()
//         .write(key: 'devicecount', value: valueToStore);
//   }

//   Future<String?> get_devicecount() async {
//     String? storedValue =
//         await const FlutterSecureStorage().read(key: 'devicecount');
//     return storedValue;
//   }

//   Future<void> write_error_code(String? error) async {
//     final errortype = error;
//     await const FlutterSecureStorage()
//         .write(key: 'ErrorCode', value: errortype);
//   }

//   Future<String?> get_error_code() async {
//     String? errortype =
//         await const FlutterSecureStorage().read(key: 'ErrorCode');
//     return errortype;
//   }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}
