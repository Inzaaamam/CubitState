import 'package:dio/dio.dart';
import 'model.dart';

class Services {
  static const baseurl = 'https://jsonplaceholder.typicode.com/todos';
  static const receiverTimeout = 60;
  static const connectTimeout = 60;
  static Dio? dio;

  static Future init() async {
    dio = Dio(BaseOptions(
      baseUrl: baseurl,
      connectTimeout: const Duration(seconds: connectTimeout),
      receiveTimeout: const Duration(seconds: receiverTimeout),
    ));
  }

  Future<List<dynamic>> getData() async {
    if (dio == null) {
      await init();
    }

    try {
      final response = await dio!.get(baseurl, queryParameters: {
        // '_start': start.toString(),
        // '_limit': limit.toString(),
      });
      // ignore: unnecessary_null_comparison
      if (response != null) {
        List<dynamic> data = response.data;
        return data.map((e) => Model.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
