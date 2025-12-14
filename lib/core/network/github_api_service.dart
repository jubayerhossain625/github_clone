import 'dart:developer';

import 'package:dio/dio.dart';
import '../../features/repositories/data/models/repository_model.dart';

class GithubApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://api.github.com'),
  );

  Future<List<RepositoryModel>> fetchRepositories() async {
    final response = await _dio.get(
      '/search/repositories',
      queryParameters: {
        'q': 'Flutter',
        'sort': 'stars',
        'order': 'desc',
        'per_page': 50,
      },
    );

    log("${response.data['items']}");
    return (response.data['items'] as List)
        .map((e) => RepositoryModel.fromJson(e))
        .toList();
  }
}