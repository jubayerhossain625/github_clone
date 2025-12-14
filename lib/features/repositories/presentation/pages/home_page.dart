import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/repository_provider.dart';
import '../providers/sort_provider.dart';
import '../widgets/repository_tile.dart';
import '../../../../core/theme/theme_provider.dart';
import '../widgets/rocket_refresh_emoji.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _scrollToTop() async {
    if (!_scrollController.hasClients) return;
    await _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repoState = ref.watch(repositoryProvider);
    final sortState = ref.watch(sortProvider);
    final themeMode = ref.watch(themeProvider);

    final sortedList = [...repoState.items]..sort((a, b) {
      int result;
      if (sortState.field == SortField.stars) {
        result = a.stars.compareTo(b.stars);
      } else {
        result = a.updatedAt.compareTo(b.updatedAt);
      }
      return sortState.order == SortOrder.asc ? result : -result;
    });

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(FontAwesomeIcons.github,size: 38,),
        title: const Text('Repositories'),
        actions: [
          IconButton(
            tooltip: sortState.field == SortField.stars
                ? 'Sort by Last Updated'
                : 'Sort by Stars',
            icon: Icon(
              sortState.field == SortField.stars
                  ? Icons.star
                  : Icons.update,
              color: Colors.green,
            ),
            onPressed: () async {
              ref.read(sortProvider.notifier).toggleField();
              await _scrollToTop();
            },
          ),
          IconButton(
            tooltip: sortState.order == SortOrder.desc
                ? 'Descending'
                : 'Ascending',
            icon: Icon(
              sortState.order == SortOrder.desc
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
            ),
            onPressed: () async {
              ref.read(sortProvider.notifier).toggleOrder();
              await _scrollToTop();
            },
          ),
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () =>
                ref.read(themeProvider.notifier).toggleTheme(),
          ),
        ],
      ),

      body: RocketRefreshEmoji(
        onRefresh: () async {
          await ref
              .read(repositoryProvider.notifier)
              .fetchRepositories(refresh: true);
          await _scrollToTop(); // scroll after refresh
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (scroll) {
            if (scroll.metrics.pixels >=
                scroll.metrics.maxScrollExtent - 200 &&
                !repoState.isLoading &&
                repoState.hasMore) {
              ref
                  .read(repositoryProvider.notifier)
                  .fetchRepositories();
            }
            return false;
          },
          child: repoState.items.isEmpty && repoState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: sortedList.length + (repoState.isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < sortedList.length) {
                return RepositoryTile(repo: sortedList[index]);
              }
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
      ),
    );
  }
}