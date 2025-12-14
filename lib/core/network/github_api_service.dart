import 'dart:developer';
import 'package:dio/dio.dart';

class GithubApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.github.com',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  Future<List<dynamic>> fetchRepositories({required int page}) async {
    try {
      final response = await _dio.get(
        '/search/repositories',
        queryParameters: {
          'q': 'Flutter',
          'sort': 'stars',
          'order': 'desc',
          'per_page': 50,
          'page': page,
        },
      );

      return response.data['items'];
    } on DioException catch (e) {
      log('Dio error: ${e.message}');
      rethrow;
    } catch (e) {
      log('Unknown error: $e');
      rethrow;
    }
  }
}