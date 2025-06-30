import 'package:get/get.dart';

class ApiService extends GetConnect {
  ApiService() {
    // ✅ Set timeout for all requests (e.g., 10 seconds)
    httpClient.timeout = const Duration(seconds: 15);
  }

  /// Sends a POST request to the specified [url] with the given [body] data.
  ///
  /// Parameters:
  /// - [url]: The endpoint URL to which the POST request is sent.
  /// - [body]: A map containing the data to be sent in the POST request.
  ///
  /// Returns:
  /// - A [Response] object containing the server's response if successful.
  /// - If an exception occurs during the request, returns a [Response] with
  ///   status code 500 and an error message in [statusText].
  ///
  /// This method handles network or other errors gracefully by returning
  /// an error response instead of throwing.
  Future<Response> postData(String url, Map<String, dynamic> body) async {
    try {
      Response response = await post(url, body);
      return response;
    } catch (e) {
      return Response(statusCode: 500, statusText: 'Error: ${e.toString()}');
    }
  }

  /// Sends a POST request with multipart/form-data to the specified [url].
  ///
  /// Parameters:
  /// - [url]: The endpoint URL to which the POST request is sent.
  /// - [formData]: A [FormData] object containing multipart form data, including files.
  ///
  /// Returns:
  /// - A [Response] object containing the server's response if successful.
  /// - If an exception occurs during the request, returns a [Response] with
  ///   status code 500 and an error message in [statusText].
  ///
  /// This method is used for uploading files or sending complex form data.
  Future<Response> postMulter(String url, FormData formData) async {
    try {
      Response response = await post(url, formData);
      return response;
    } catch (e) {
      return Response(statusCode: 500, statusText: 'Error: ${e.toString()}');
    }
  }
}
