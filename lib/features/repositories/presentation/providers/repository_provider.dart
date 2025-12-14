import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/github_api_service.dart';
import '../../../../core/local/local_storage_service.dart';
import '../../data/datasource/remote_datasource.dart';
import '../../data/datasource/local_datasource.dart';
import '../../data/repository/repository_impl.dart';
import '../../domain/entities/repository_entity.dart';

final repositoryProvider =
FutureProvider<List<RepositoryEntity>>((ref) async {
  final repo = RepositoryImpl(
    RemoteDataSource(GithubApiService()),
    LocalDataSource(LocalStorageService()),
  );
  return repo.getRepositories();
});