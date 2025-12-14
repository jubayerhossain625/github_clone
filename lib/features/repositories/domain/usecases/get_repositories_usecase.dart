import '../entities/repository_entity.dart';
import '../repository/repository.dart';

class GetRepositoriesUseCase {
  final Repository repository;

  GetRepositoriesUseCase(this.repository);

  Future<List<RepositoryEntity>> call({required int page}) {
    return repository.getRepositories(page: page);
  }
}