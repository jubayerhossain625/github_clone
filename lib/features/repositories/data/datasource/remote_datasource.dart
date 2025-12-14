import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/github_api_service.dart';
import '../models/repository_model.dart';

class RemoteDataSource {
  final GithubApiService apiService;

  RemoteDataSource(this.apiService);

  Future<List<RepositoryModel>> fetchRepositories(int page) async {
    try {
      final data = await apiService.fetchRepositories(page: page);

      return data
          .map<RepositoryModel>((e) => RepositoryModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const NetworkFailure('Connection timeout. Please try again.');
      }

      if (e.response?.statusCode == 403) {
        throw const ServerFailure(
            'GitHub API rate limit exceeded.');
      }

      throw const ServerFailure('Server error occurred.');
    } catch (_) {
      throw const UnknownFailure('Unexpected error occurred.');
    }
  }
}