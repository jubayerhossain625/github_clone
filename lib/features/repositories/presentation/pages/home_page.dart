import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/repository_provider.dart';
import '../providers/sort_provider.dart';
import '../widgets/repository_tile.dart';
import '../../../../core/theme/theme_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reposAsync = ref.watch(repositoryProvider);
    final sortState = ref.watch(sortProvider);
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text('Git Repositories'),
        actions: [
          // 🔀 Sort Field (Stars / Updated)
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
            onPressed: () {
              ref.read(sortProvider.notifier).toggleField();
            },
          ),

          // ⬆⬇ Sort Order
          IconButton(
            tooltip: sortState.order == SortOrder.desc
                ? 'Descending'
                : 'Ascending',
            icon: Icon(
              sortState.order == SortOrder.desc
                  ? Icons.arrow_downward
                  : Icons.arrow_upward,
            ),
            onPressed: () {
              ref.read(sortProvider.notifier).toggleOrder();
            },
          ),

          // 🌗 Theme toggle
          IconButton(
            icon: Icon(
              themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              ref.read(themeProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: reposAsync.when(
        data: (list) {
          final sortedList = [...list];

          // 🔄 Apply sorting
          sortedList.sort((a, b) {
            int result;
            if (sortState.field == SortField.stars) {
              result = a.stars.compareTo(b.stars);
            } else {
              result = a.updatedAt.compareTo(b.updatedAt);
            }
            return sortState.order == SortOrder.asc ? result : -result;
          });

          // 🔁 Pull-to-refresh
          return RefreshIndicator(
            onRefresh: () async {
              try {
                await ref.refresh(repositoryProvider.future);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Repositories updated')),
                );
              } catch (_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to update repositories')),
                );
              }
            },
            child: ListView.builder(
              itemCount: sortedList.length,
              itemBuilder: (_, i) => RepositoryTile(repo: sortedList[i]),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
      ),
    );
  }
}