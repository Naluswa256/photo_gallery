import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
class ApiRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://picsum.photos/v2'))..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));
    
  Future<List<Map<String, dynamic>>> fetchImages(
      {int page = 1, int limit = 10}) async {
    try {
      final response = await _dio
          .get('/list', queryParameters: {'page': page, 'limit': limit});

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return List<Map<String, dynamic>>.from(data);
      } else {
        throw Exception('Failed to load images');
      }
    } catch (error) {
      throw Exception('Failed to load images: $error');
    }
  }

}
