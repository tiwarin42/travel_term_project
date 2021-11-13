import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_term_project/models/api_result.dart';

class Api {
  static const BASE_URL =
      'https://tatapi.tourismthailand.org/tatapi/v5';

  Future<dynamic> fetch(
    String endPoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    String queryString = Uri(queryParameters: queryParams).query;
    var url = Uri.parse('$BASE_URL/$endPoint?$queryString');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept-Language': 'th',
        'Authorization':
            'Bearer GCpUS6h09pyQoJLOfaEhdao(KK5AOBRR8Y8FeFxk0INB7FcOGFDaNTEvuUfUm1Y4w8HzH9NSfOfd24gQqXjnWX0=====2',
      },
    );

    if (response.statusCode == 200) {
      // แปลง text ที่มีรูปแบบเป็น JSON ไปเป็น Dart's data structure (List/Map)
      Map<String, dynamic> jsonBody = json.decode(response.body);

      // print('RESPONSE BODY: $jsonBody');

      // แปลง Dart's data structure ไปเป็น model (POJO)
      var apiResult = ApiResult.fromJson(jsonBody);

      return apiResult.result;

    } else {
      throw 'Server connection failed!';
    }
  }
}
