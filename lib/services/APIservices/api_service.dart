import 'package:get/get.dart';

class ApiService extends GetConnect {
  Future<Response> postData(String url, Map<String, dynamic> body) async {
    try {
      Response response = await post(url, body);
      return response;
    } catch (e) {
      return Response(statusCode: 500, statusText: e.toString());
    }
  }

  Future<Response> postMulter(String url, FormData formData) async {
    try {
      // ✅ Send the request
      Response response = await post(url, formData);
      return response;
    } catch (e) {
      return Response(statusCode: 500, statusText: e.toString());
    }
  }
}
