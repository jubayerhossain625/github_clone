import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/repository_entity.dart';
import '../../domain/usecases/get_repositories_usecase.dart';
import '../../data/repository/repository_impl.dart';
import '../../data/datasource/remote_datasource.dart';
import '../../../../core/network/github_api_service.dart';

class RepositoryState {
  final List<RepositoryEntity> items;
  final bool isLoading;
  final bool hasMore;
  final int page;

  const RepositoryState({
    required this.items,
    required this.isLoading,
    required this.hasMore,
    required this.page,
  });

  factory RepositoryState.initial() => const RepositoryState(
    items: [],
    isLoading: false,
    hasMore: true,
    page: 1,
  );
}

class RepositoryNotifier extends StateNotifier<RepositoryState> {
  final GetRepositoriesUseCase useCase;

  RepositoryNotifier(this.useCase)
      : super(RepositoryState.initial()) {
    fetchRepositories();
  }

  Future<void> fetchRepositories({bool refresh = false}) async {
    if (state.isLoading || (!state.hasMore && !refresh)) return;

    try {
      state = RepositoryState(
        items: refresh ? [] : state.items,
        isLoading: true,
        hasMore: true,
        page: refresh ? 1 : state.page,
      );

      final data = await useCase.call(page: state.page);

      state = RepositoryState(
        items: [...state.items, ...data],
        isLoading: false,
        hasMore: data.length == 50,
        page: state.page + 1,
      );
    } on Failure catch (f) {
      state = RepositoryState(
        items: state.items,
        isLoading: false,
        hasMore: false,
        page: state.page,
      );

      throw f.message; // UI will show
    }
  }
}

final repositoryProvider =
StateNotifierProvider<RepositoryNotifier, RepositoryState>((ref) {
  final api = GithubApiService();
  final remote = RemoteDataSource(api);
  final repo = RepositoryImpl(remote);
  final usecase = GetRepositoriesUseCase(repo);
  return RepositoryNotifier(usecase);
});