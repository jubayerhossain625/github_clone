import '../../../../core/local/local_storage_service.dart';
import '../models/repository_model.dart';

class LocalDataSource {
  final LocalStorageService storage;

  LocalDataSource(this.storage);

  Future<void> cache(List<RepositoryModel> repos) async {
    await storage.saveRepositories(
      repos.map((e) => e.toJson()).toList(),
    );
  }

  Future<List<RepositoryModel>> load() async {
    final data = await storage.loadRepositories();
    return data.map(RepositoryModel.fromLocal).toList();
  }
}