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

  /// Handles secure communication with an IAM (Identity and Access Management) API endpoint.
  ///
  /// This asynchronous function encrypts the request body, sends it to a specified
  /// API, and then decrypts the response, providing a secure way to interact with
  /// an IAM service. It uses AES encryption with keys loaded from a configuration file.
  ///
  /// **Parameters:**
  /// - `body`: A `Map<String, dynamic>` representing the data to be sent in the request body.
  /// - `API`: A `String` specifying the API endpoint to which the request will be sent.
  ///
  /// **Process:**
  /// 1.  **Load Configuration:**
  ///     - It asynchronously loads API key and secret from `assets/key.config` using `Returns.loadConfigFile`.
  /// 2.  **Encrypt Request Data:**
  ///     - The `body` is converted to a JSON string using `jsonEncode`.
  ///     - This JSON string is then encrypted using AES encryption with the loaded `secret` via `AES.encryptWithAES`.
  ///     - A `requestData` map is prepared, containing the `APIkey`, `Secret`, and the `encryptedData` as `querystring`.
  /// 3.  **Send Request:**
  ///     - `apiService.postData` is called to send a POST request to the specified `API` with the `requestData`.
  /// 4.  **Handle Response:**
  ///     - **If the `response.statusCode` is `200` (Success):**
  ///         - The `encryptedResponse` is extracted from the `response.body`.
  ///         - This encrypted response is then decrypted using AES with a substring of the `secret` (first 16 characters) via `AES.decryptWithAES`.
  ///         - The `decryptedResponse` string is parsed into a `Map<String, dynamic>` using `jsonDecode`.
  ///         - The original `statusCode` from the HTTP response is added to the `decodedResponse` map under the key "statusCode".
  ///         - The combined map is returned.
  ///     - **If the `response.statusCode` is not `200` (Error):**
  ///         - A `Map<String, dynamic>` named `reply` is created, containing the `statusCode` and a generic "Server Error" message.
  ///         - This `reply` map is returned, indicating an issue with the API call.
  ///
  /// @returns A `Future<Map<String, dynamic>?>` which resolves to a map containing the decrypted API response and the HTTP status code on success, or an error map on failure. Returns `null` if initial config loading fails.
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

  /// Fetches data from a specified API endpoint using a session token for authentication and decryption.
  ///
  /// This asynchronous function constructs a request containing a session token,
  /// sends it to the given API, and then decrypts the response using a portion
  /// of the same session token. It's designed for authenticated data retrieval
  /// where the session token doubles as a decryption key component.
  ///
  /// **Parameters:**
  /// - `API`: A `String` representing the API endpoint to which the GET request (logically, via POST) will be sent.
  ///
  /// **Process:**
  /// 1.  **Prepare Request Data:**
  ///     - A `requestData` map is created containing a single entry:
  ///       - `"STOKEN"`: The session token retrieved from `sessiontokenController.sessiontokenModel.sessiontoken.value`.
  /// 2.  **Send Request:**
  ///     - `await apiService.postData(API, requestData)` sends a POST request
  ///       to the specified `API` endpoint with the prepared `requestData`.
  ///       Despite the function name `GetbyToken`, the actual HTTP method used
  ///       is POST, which is common for secure data fetching with a body.
  /// 3.  **Handle Response:**
  ///     - **If `response.statusCode` is `200` (Success):**
  ///         - `responseData` extracts the body of the successful response.
  ///         - `encryptedResponse` is pulled from `responseData['encryptedResponse']`.
  ///         - `AES.decryptWithAES` is used to decrypt `encryptedResponse`.
  ///           The decryption key is derived from the first 16 characters of the
  ///           session token: `sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16)`.
  ///         - The `decryptedResponse` string is then parsed into a
  ///           `Map<String, dynamic>` using `jsonDecode`.
  ///         - The original HTTP `statusCode` is added to the `decodedResponse`
  ///           map under the key "statusCode", providing context about the HTTP
  ///           transaction within the application's data structure.
  ///         - The enriched `decodedResponse` map is returned.
  ///     - **If `response.statusCode` is not `200` (Error):**
  ///         - A `Map<String, dynamic>` named `reply` is created.
  ///         - It contains the HTTP `statusCode` and a generic "Server Error" message.
  ///         - This `reply` map is returned, indicating that the API request failed
  ///           on the server side.
  ///
  /// @returns A `Future<Map<String, dynamic>?>` resolving to a map containing the decrypted
  ///          API response data and the HTTP status code on success, or an error map on
  ///          failure. Returns `null` if any part of the process fails unexpectedly before
  ///          error map creation.
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

  /// Fetches data from a specified API endpoint using a query string, authenticated and encrypted with a session token.
  ///
  /// This asynchronous function encrypts the provided `body` data using a portion
  /// of the session token, sends it as a "querystring" within a POST request
  /// along with the full session token, and then decrypts the API's response.
  /// This method is suitable for sending complex query parameters securely.
  ///
  /// **Parameters:**
  /// - `body`: A `Map<String, dynamic>` containing the data to be sent as the encrypted query string.
  /// - `API`: A `String` representing the API endpoint to which the request will be sent.
  ///
  /// **Process:**
  /// 1.  **Encrypt Request Body:**
  ///     - The input `body` map is first converted into a JSON string using `jsonEncode`.
  ///     - This JSON string is then encrypted using AES encryption via `AES.encryptWithAES`.
  ///       The encryption key used is the first 16 characters of the current
  ///       session token, retrieved from `sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16)`.
  ///       The result is stored in `encryptedData`.
  /// 2.  **Prepare Form Data:**
  ///     - A `formData` map is constructed to be sent as the request body.
  ///     - It includes the full session token under the key `"STOKEN"`.
  ///     - It includes the `encryptedData` under the key `"querystring"`.
  /// 3.  **Send Request:**
  ///     - `await apiService.postData(API, formData)` sends a POST request
  ///       to the specified `API` endpoint with the prepared `formData`.
  /// 4.  **Handle Response:**
  ///     - **If `response.statusCode` is `200` (Success):**
  ///         - `responseData` extracts the body of the HTTP response.
  ///         - `encryptedResponse` is retrieved from `responseData['encryptedResponse']`.
  ///         - `AES.decryptWithAES` is used to decrypt `encryptedResponse`,
  ///           again using the first 16 characters of the session token as the key.
  ///         - The `decryptedResponse` string is then parsed into a
  ///           `Map<String, dynamic>` using `jsonDecode`.
  ///         - The original HTTP `statusCode` is added to the `decodedResponse`
  ///           map under the key "statusCode", providing the HTTP context alongside the data.
  ///         - The augmented `decodedResponse` map is returned.
  ///     - **If `response.statusCode` is not `200` (Error):**
  ///         - A `Map<String, dynamic>` named `reply` is created.
  ///         - It contains the HTTP `statusCode` and a generic "Server Error" message.
  ///         - This `reply` map is returned, indicating a server-side error.
  ///
  /// @returns A `Future<Map<String, dynamic>?>` that resolves to a map containing the decrypted
  ///          API response data and the HTTP status code on success, or an error map on
  ///          failure. Returns `null` if any critical step (e.g., encryption, decryption) fails unexpectedly
  ///          before an error map can be formed.
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

  /// Sends a multipart HTTP POST request, optionally with a file, authenticated by a session token.
  ///
  /// This asynchronous function facilitates sending data, potentially including
  /// a file, to a specified API endpoint. It constructs a `FormData` object
  /// for multipart submission, attaches a session token for authentication,
  /// and handles the encryption/decryption of the response.
  ///
  /// **Parameters:**
  /// - `file`: A `File` object to be uploaded. It can be `null` if no file is to be attached.
  /// - `API`: A `String` representing the API endpoint to which the multipart request will be sent.
  ///
  /// **Process:**
  /// 1.  **Construct `FormData`:**
  ///     - A `FormData` object is initialized.
  ///     - **Optional File Attachment:** If `file` is not `null`, a `MultipartFile`
  ///       is created from the `file` and its filename is extracted from its path.
  ///       This `MultipartFile` is added to the `FormData` under the key "file".
  ///     - **Session Token:** The session token, retrieved from
  ///       `sessiontokenController.sessiontokenModel.sessiontoken.value`, is added
  ///       to the `FormData` under the key "STOKEN".
  /// 2.  **Send Multipart Request:**
  ///     - `await apiService.postMulter(API, formData)` sends the constructed
  ///       multipart request to the specified `API` endpoint. The `postMulter`
  ///       method likely handles the complexities of multipart/form-data requests.
  /// 3.  **Handle Response:**
  ///     - **If `response.statusCode` is `200` (Success):**
  ///         - `responseData` extracts the body of the successful HTTP response.
  ///         - `encryptedResponse` is retrieved from `responseData['encryptedResponse']`.
  ///         - `AES.decryptWithAES` is used to decrypt `encryptedResponse`. The
  ///           decryption key is derived from the first 16 characters of the
  ///           session token: `sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16)`.
  ///         - The `decryptedResponse` string is then parsed into a
  ///           `Map<String, dynamic>` using `jsonDecode`.
  ///         - The original HTTP `statusCode` is added to the `decodedResponse`
  ///           map under the key "statusCode", providing context about the HTTP
  ///           transaction within the application's data structure.
  ///         - The augmented `decodedResponse` map is returned.
  ///     - **If `response.statusCode` is not `200` (Error):**
  ///         - A `Map<String, dynamic>` named `reply` is created.
  ///         - It contains the HTTP `statusCode` and a generic "Server Error" message.
  ///         - This `reply` map is returned, indicating a server-side error.
  ///
  /// @returns A `Future<Map<String, dynamic>?>` resolving to a map containing the decrypted
  ///          API response data and the HTTP status code on success, or an error map on
  ///          failure. Returns `null` if any critical step (e.g., decryption) fails unexpectedly
  ///          before an error map can be formed.
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

  /// Sends a multipart HTTP POST request with encrypted data and optional files, authenticated by a session token.
  ///
  /// This asynchronous function handles the complex task of preparing and sending
  /// multipart form data to an API. It encrypts a `body` string, attaches it
  /// along with a session token, and optionally includes single or multiple files.
  /// The response from the API is also decrypted.
  ///
  /// **Parameters:**
  /// - `token`: A `String` (though not directly used in the function body, the session token is retrieved internally).
  /// - `body`: A `String` representing the data payload to be encrypted and sent as `querystring`. This typically would be a JSON string of data.
  /// - `files`: An optional `List<File>` containing files to be uploaded. Can be `null` or empty.
  /// - `api`: A `String` representing the target API endpoint.
  ///
  /// **Process:**
  /// 1.  **Retrieve Session Token:**
  ///     - `final sessionToken = sessiontokenController.sessiontokenModel.sessiontoken.value;` retrieves the active session token.
  /// 2.  **Encrypt Body Data:**
  ///     - `final encryptedData = AES.encryptWithAES(sessionToken.substring(0, 16), body);`
  ///       encrypts the provided `body` string using AES. The encryption key is
  ///       derived from the first 16 characters of the `sessionToken`.
  /// 3.  **Prepare Base Form Data:**
  ///     - `final formDataMap = <String, dynamic>{...};` creates a map to hold the
  ///       form fields. It includes:
  ///         - `"STOKEN"`: The full `sessionToken` for authentication.
  ///         - `"querystring"`: The `encryptedData`.
  /// 4.  **Add Files (if provided):**
  ///     - It checks if `files` is not null and not empty.
  ///     - **Single File:** If `files.length` is `1`, the single `File` is added
  ///       to `formDataMap` under the key `"file"` as a `MultipartFile`. The filename
  ///       is extracted from the file's path.
  ///     - **Multiple Files:** If `files.length` is greater than 1, each `File` in
  ///       the list is mapped to a `MultipartFile` (with its filename) and added
  ///       to `formDataMap` under the key `"files"`. This indicates the backend
  ///       expects an array of files.
  /// 5.  **Construct `FormData` Object:**
  ///     - `final formData = FormData(formDataMap);` creates the final `FormData`
  ///       object, which is used for sending multipart/form-data requests.
  /// 6.  **Send Request:**
  ///     - `final response = await apiService.postMulter(api, formData);` sends the
  ///       HTTP POST request with the prepared `formData` to the specified `api`.
  /// 7.  **Handle Response:**
  ///     - **If `response.statusCode` is `200` (Success):**
  ///         - `encryptedResponse` is extracted from the `response.body`.
  ///         - `AES.decryptWithAES` decrypts `encryptedResponse` using the same
  ///           16-character substring of the `sessionToken` as the key.
  ///         - `jsonDecode` parses the `decrypted` response into a `Map<String, dynamic>`.
  ///         - The original HTTP `statusCode` is added to the decoded map for context.
  ///         - The augmented map is returned.
  ///     - **If `response.statusCode` is not `200` (Error):**
  ///         - A default error map `{"statusCode": response.statusCode, "message": "Server Error"}`
  ///           is returned, indicating a problem on the server side.
  ///
  /// @returns A `Future<Map<String, dynamic>>` resolving to a map containing the decrypted
  ///          API response data and the HTTP status code on success, or an error map on
  ///          failure. This function is guaranteed to return a `Map<String, dynamic>`.
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

  /// Sends an encrypted query string to a specified API endpoint via a POST request.
  ///
  /// This asynchronous function encrypts the provided `body` string using a
  /// portion of the active session token and sends it as a "querystring" parameter
  /// along with the full session token. The API's encrypted response is then
  /// decrypted and returned. This is a common pattern for secure data transmission
  /// where the payload is sent as a string parameter rather than direct JSON body.
  ///
  /// **Parameters:**
  /// - `body`: A `String` containing the data payload to be encrypted and sent. This typically represents a JSON string of data.
  /// - `API`: A `String` representing the target API endpoint.
  ///
  /// **Process:**
  /// 1.  **Encrypt Request Body:**
  ///     - `final encryptedData = AES.encryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), body);`
  ///       encrypts the input `body` string using AES. The encryption key is
  ///       derived from the first 16 characters of the current session token,
  ///       retrieved from `sessiontokenController.sessiontokenModel.sessiontoken.value`.
  /// 2.  **Prepare Request Data:**
  ///     - A `requestData` map is constructed for the POST request body.
  ///     - It includes the full session token under the key `"STOKEN"`.
  ///     - It includes the `encryptedData` under the key `"querystring"`.
  /// 3.  **Send POST Request:**
  ///     - `final response = await apiService.post(API, requestData);` sends the
  ///       HTTP POST request to the specified `API` endpoint with the prepared
  ///       `requestData`.
  /// 4.  **Handle Response:**
  ///     - **If `response.statusCode` is `200` (Success):**
  ///         - `final responseData = response.body;` extracts the body of the HTTP response.
  ///         - `String encryptedResponse = responseData['encryptedResponse'];` retrieves the
  ///           encrypted part of the response.
  ///         - `final decryptedResponse = AES.decryptWithAES(sessiontokenController.sessiontokenModel.sessiontoken.value.substring(0, 16), encryptedResponse);`
  ///           decrypts `encryptedResponse` using the same 16-character substring of the
  ///           session token as the key.
  ///         - `Map<String, dynamic> decodedResponse = jsonDecode(decryptedResponse);`
  ///           parses the decrypted string into a `Map<String, dynamic>`.
  ///         - `final result = <String, int>{"statusCode": response.statusCode!};` creates
  ///           a map to hold the HTTP status code.
  ///         - `decodedResponse.addEntries(result.entries.map((e) => MapEntry(e.key, e.value)));`
  ///           adds the HTTP `statusCode` to the `decodedResponse` map, providing
  ///           context about the HTTP transaction.
  ///         - The augmented `decodedResponse` map is returned.
  ///     - **If `response.statusCode` is not `200` (Error):**
  ///         - A `Map<String, dynamic>` named `reply` is created containing the
  ///           HTTP `statusCode` and a generic "Server Error" message.
  ///         - This `reply` map is returned, indicating a server-side error.
  ///
  /// @returns A `Future<Map<String, dynamic>>` resolving to a map containing the decrypted
  ///          API response data and the HTTP status code on success, or an error map on
  ///          failure. This function is guaranteed to return a `Map<String, dynamic>`.
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
}
