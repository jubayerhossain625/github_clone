// import '../../../../core/network/github_api_service.dart';
// import '../models/repository_model.dart';
//
// class RemoteDataSource {
//   final GithubApiService api;
//
//   RemoteDataSource(this.api);
//
//   Future<List<RepositoryModel>> fetch() => api.fetchRepositories();
// }

import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/github_api_service.dart';
import '../models/repository_model.dart';

class RemoteDataSource {
  final GithubApiService api;

  RemoteDataSource(this.api);

  Future<List<RepositoryModel>> fetch() async {
    try {
      return await api.fetchRepositories();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure();
      }
      throw const ServerFailure();
    } catch (_) {
      throw const UnknownFailure();
    }
  }
}