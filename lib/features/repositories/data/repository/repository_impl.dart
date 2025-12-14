import '../../domain/repository/repository.dart';
import '../../domain/entities/repository_entity.dart';
import '../datasource/remote_datasource.dart';
import '../datasource/local_datasource.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remote;
  final LocalDataSource local;

  RepositoryImpl(this.remote, this.local);

  @override
  Future<List<RepositoryEntity>> getRepositories() async {
    try {
      final data = await remote.fetch();
      await local.cache(data);
      return data;
    } catch (_) {
      return await local.load();
    }
  }
}