import '../../domain/entities/repository_entity.dart';
import '../../domain/repository/repository.dart';
import '../datasource/remote_datasource.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;

  RepositoryImpl(this.remoteDataSource);

  @override
  Future<List<RepositoryEntity>> getRepositories({
    required int page,
  }) async {
    return remoteDataSource.fetchRepositories(page);
  }
}