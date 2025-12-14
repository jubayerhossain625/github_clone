import '../entities/repository_entity.dart';

abstract class Repository {
  Future<List<RepositoryEntity>> getRepositories();
}